# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 5;
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

	i18n.defaultLocale = "en_IN";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

	services.desktopManager.plasma6.enable = true;

	services.xserver = {
		enable = true;
		displayManager.sddm.enable = true;
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
  # Omit previous configuration settings...

  # Add user 'vanshaj'
  users.users.vanshaj = {
    isNormalUser = true;
    description = "Vanshaj Saxena";
    extraGroups = [ "networkmanager" "wheel" ];
	openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM80MlQpoUkrQrYIfn5yE9SmxKsnVs4tt35SZ+T0bWjm vanshaj@VSENVY"
	];
	shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

# Allow unfree software
  nixpkgs.config.allowUnfree = true;
	fonts.packages = with pkgs; [
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

  # Omit the rest of the configuration...
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    neovim
    unzip
    wget
    curl
	wl-clipboard # wayland clipboard
	sshfs # kdeconnect ssh fuse filesystem
	htop # system monitor
	tmux # terminal multiplexer
	gcc # c compiler
	zsh # z shell
	fd
	ripgrep
			#cargo
			#glibc
	swift
	sourcekit-lsp
			#swiften
			#swiftPackages.swift-unwrapped
			#swiftPackages.swiftpm
			#swiftPackages.xcbuild
  ];
  # Set the default editor to nvim
  environment.variables.EDITOR = "nvim";
	programs.zsh.enable = true;
	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
# Add any missing dynamic libraries for unpackaged 
# programs here, NOT in environment.systemPackages
	];
system.stateVersion = "23.11"; # Did you read the comment?

}
