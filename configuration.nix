{ nixos-stable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [
  { device = "/dev/disk/by-uuid/addd79fc-3c3c-4562-9a97-b895abf8945e";
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

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [ nixos-stable.kdePackages.kate ];

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.vanshaj = {
    isNormalUser = true;
    description = "Vanshaj Saxena";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = nixos-stable.zsh;
  };

    fonts.packages = with nixos-stable; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "VictorMono" ]; })
  ];

  programs.steam.enable = false;

  programs.firefox = {
      enable = true;
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with nixos-stable; [
   git
   vim # Do not forget to add an editor to edit configuration.nix!
   tmux
   gcc
   wl-clipboard
   wget
   unzip
   curl
  ];

  environment.variables = {
   EDITOR = "nvim";
   PAGER = "bat";
  };

  programs.nix-ld.enable = true;

  # Use ipv4 address family when connecting with ssh (git push/pull delay issue).
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
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "24.05"; # Did you read the comment?
}
