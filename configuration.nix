# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ nixos-stable, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 7;
  boot.loader.efi.canTouchEfiVariables = true;

  # mount nvme0n1p4 to /mnt/data
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/926C7F156C7EF2F9";
    fsType = "ntfs";
    options = [ "noatime" ];
  };

  networking.hostName = "VSENVY"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  #  i18n.extraLocaleSettings = {
  #    LC_ADDRESS = "en_IN";
  #    LC_IDENTIFICATION = "en_IN";
  #    LC_MEASUREMENT = "en_IN";
  #    LC_MONETARY = "en_IN";
  #    LC_NAME = "en_IN";
  #    LC_NUMERIC = "en_IN";
  #    LC_PAPER = "en_IN";
  #    LC_TELEPHONE = "en_IN";
  #    LC_TIME = "en_IN";
  #  };

  # Add user 'vanshaj'
  users.users.vanshaj = {
    isNormalUser = true;
    description = "Vanshaj Saxena";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM80MlQpoUkrQrYIfn5yE9SmxKsnVs4tt35SZ+T0bWjm vanshaj@VSENVY"
    ];
    shell = nixos-stable.zsh;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with nixos-stable; [
    (nerdfonts.override { fonts = [ "VictorMono" ]; })
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = true; # disable password login
    };
    openFirewall = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Hyprland Cachix
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
  };


  # Set the default editor to nvim
  environment.variables = {
    EDITOR = "nvim";
  };

  programs.zsh.enable = true;

  environment.systemPackages = with nixos-stable; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    nvd # nix package version diff tool
    unzip
    wget
    curl
    networkmanagerapplet
    wl-clipboard # wayland clipboard
    killall
    tldr
    sshfs # kdeconnect ssh fuse filesystem
    htop # system monitor
    tmux # terminal multiplexer
    gcc # c compiler
    fd
    ripgrep
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with nixos-stable; [
    # Add any missing dynamic libraries for unpackaged 
    # programs here, NOT in environment.systemPackages
  ];

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2w";
  };

  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
