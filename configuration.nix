# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Creating  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Mount home in another disk
  fileSystems = {
     "/" = {
       device = "/dev/disk/by-uuid/8e67216e-fe96-4109-8532-81ec212a3f8a";
       fsType= "btrfs";
      };

      "/home" = {
        device = "/dev/disk/by-uuid/13209bec-b52a-4e7e-9ba8-aa81856e3a87";
	fsType = "btrfs";
      };

      "/boot" = {
         device = "/dev/disk/by-uuid/972A-E5EE";
         fsType = "vfat";
      };
  };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/05a33b11-6b92-46d5-a183-2e15433ff7d9"; }
    ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.folclore = {
     isNormalUser = true;
     createHome = true;
     home = "/home/folclore";
     extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user audio control and network.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     man-pages os-prober
     # Network
     tdesktop wirelesstools wpa_supplicant iw firefox wget curl
     # X11
     xorg.xkill nitrogen dmenu dwm st
     # Code
     vim vscode git zsh 
  ];
  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services = {
	xserver.enable = true;
	# Setting dwm as window manager
	xserver.windowManager.dwm.enable = true;
	xserver.layout = "br";
        # xserver.autorun = false;
	xserver.videoDrivers = [ "modesetting" ];
	xserver.useGlamor = true;

  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

