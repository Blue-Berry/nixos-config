{pkgs, ...}: {
  home.packages = with pkgs; [
    # hyprpanel
    pipewire
    libgtop
    bluez
    bluez-tools
    grimblast
    gpu-screen-recorder
    hyprpicker
    btop
    networkmanager
    matugen
    wl-clipboard
    swww
    dart-sass
    brightnessctl
    gnome-bluetooth
    python312Packages.gpustat
    python312
    pywal
    power-profiles-daemon
  ];
}
