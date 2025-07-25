# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  #Experimental Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  #AutoUpdate
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  #AutoCleanUp
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delets-older-than 10d";
  nix.settings.auto-optimise-store = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.real = {
    isNormalUser = true;
    description = "real";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with import <nixpkgs> { config.allowUnfree = true; }; [
    neofetch
    neovim
    vim
    btop
    foot
    hyprpaper
    bibata-cursors
    brightnessctl
    waybar
    tofi
    zsh
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-autosuggestions
    wl-clipboard
    gcc
    grim
    slurp
    tesseract
    yt-dlp
    steam
    mysql-workbench
    blueman
    clang-tools
    telegram-desktop
    qbittorrent
    tree
    fzf
  cmatrix
  ];

    shell=pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  efibootmgr git realvnc-vnc-viewer mariadb
  ];

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
  system.stateVersion = "24.11"; # Did you read the comment?
  # hyprland
  programs.hyprland = {
  	enable = true;
    	xwayland.enable = true;
	};
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1"; 
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";  # or "Adwaita", "Capitaine-Cursors", etc.
    XCURSOR_SIZE = "18";
  };

  #HomeManager
  home-manager.users.real = { pkgs, ...}:{
  home.packages = [ pkgs.fastfetch ];
  home.stateVersion = "23.11"; 
  };


  #Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  #zsh
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  #paste these 
  # git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  # ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  services.openssh.enable = true;
  #bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  #mysql
  services.mysql = {
  enable = true;
  package = pkgs.mariadb;  # Change from pkgs.mysql to pkgs.mariadb
  };
}
