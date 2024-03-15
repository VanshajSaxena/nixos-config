# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

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

	services.xserver.enable = true;

	services.xserver.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;

	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};


	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = true;
		settings.KbdInteractiveAuthentication = false;
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

	users.defaultUserShell = pkgs.zsh;
	users.users.vanshaj = {
		isNormalUser = true;
		description = "Vanshaj Saxena";
		extraGroups = [ "networkmanager" "wheel" ];
		openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM80MlQpoUkrQrYIfn5yE9SmxKsnVs4tt35SZ+T0bWjm vanshaj@VSENVY"
		];
		packages = with pkgs; [
			firefox
				kate
				lazygit
				neovim
				kitty
				fd
				ripgrep
				nodejs
				qbittorrent
				vlc
				kdePackages.kdeconnect-kde
				google-chrome
		];
	};

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

	environment.shells = with pkgs; [ zsh ];
	environment.variables.EDITOR = "nvim";
	environment.systemPackages = with pkgs; [
		wl-clipboard # wayland clipboard
			sshfs # kdeconnect ssh fuse filesystem
			htop # system monitor
			btop # system monitor
			tmux # terminal multiplexer
			gcc # c compiler
			zsh # z shell
			oh-my-zsh # z shell dressing
			zoxide # better cd command
			git # version control
			bat # better cat command
			eza # modern ls
			cargo
			sourcekit-lsp # swift development
			glibc
			swift
			swiften
			swiftPackages.swift-unwrapped
			swiftPackages.swiftpm
			swiftPackages.xcbuild
	];

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
# Add any missing dynamic libraries for unpackaged 
# programs here, NOT in environment.systemPackages
	];

	programs.neovim.defaultEditor = true;
	programs.zsh = {
		enable = true;
		ohMyZsh = {
			enable =true;
			plugins = [ "git" "colored-man-pages" "zoxide" ];
			theme = "simple";
		};
	};
	system.stateVersion = "23.11"; # Did you read the comment?

}
