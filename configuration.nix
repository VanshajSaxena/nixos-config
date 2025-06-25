{
  inputs,
  nixos-stable,
  enabledHyprland,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/addd79fc-3c3c-4562-9a97-b895abf8945e";
    }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/addd79fc-3c3c-4562-9a97-b895abf8945e";
  boot.kernelParams = [ "resume=/dev/disk/by-uuid/addd79fc-3c3c-4562-9a97-b895abf8945e" ];

  networking.hostName = "NIXOS";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.mysql = {
    enable = true;
    package = nixos-stable.mysql84;
  };

  services.xserver.enable = true;

  programs.hyprland = {
    enable = enabledHyprland;
    # WARN: If you use the Home Manager module, make sure to disable the
    # systemd integration, as it conflicts with uwsm. Like this:
    # `wayland.windowManager.hyprland.systemd.enable = false;`
    withUWSM = true;
    # set the flake package
    package = inputs.hyprland.packages.${nixos-stable.stdenv.hostPlatform.system}.hyprland;
    # Make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${nixos-stable.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # fix wifi password issue for hyprland
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [ nixos-stable.kdePackages.kate ];

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
    percentageAction = 5;
    percentageCritical = 15;
    percentageLow = 20;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.vanshaj = {
    isNormalUser = true;
    description = "Vanshaj Saxena";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = nixos-stable.zsh;
  };

  fonts.packages = with nixos-stable; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
    nerd-fonts.monaspace
  ];

  programs.firefox = {
    enable = true;
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with nixos-stable; [
    git
    neovim # Do not forget to add an editor to edit configuration.nix!
    tmux
    gcc
    wl-clipboard
    wget
    unzip
    curl
  ];

  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    PAGER = "bat";
  };

  programs.nix-ld.enable = true;

  # Use IPv4 address family when connecting with ssh (git push/pull delay issue).
  programs.ssh.extraConfig = "AddressFamily inet";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. Its perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "24.05"; # Did you read the comment?
}
