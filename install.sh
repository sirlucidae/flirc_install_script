#!/bin/bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@" # elevate priveleges.
install_dir="/usr/local/bin/" # set destination directory.
current_dir="$(pwd)" # set working directory.
wget 'http://apt.flirc.tv/arch/x86_64/flirc.latest.x86_64.tar.gz'
# backup link: wget 'https://app.box.com/s/z1s0q2x0gghowm0gp5cif8vuxc42pf8g'
gzip -d flirc.latest.x86_64.tar.gz
tar -xf flirc.latest.x86_64.tar.gz
    cp $current_dir/Flirc*/Flirc $install_dir/ # copies binary.
    cp $current_dir/Flirc*/flirc_util $install_dir/ # copies binary.
    cp $current_dir/Flirc.png /usr/share/pixmaps/ # copies icon.
    cat > /usr/share/applications/Flirc.desktop << EOF # create desktop entry file.
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=/usr/local/bin/Flirc
Name=Flirc
Comment=Flirc Second Generation USB Receiver
Categories=Utility;
Icon=/usr/share/pixmaps/Flirc.png
EOF
    chmod u+x /usr/share/applications/Flirc.desktop # give execution permission to desktop entry file.
    cat > /etc/udev/rules.d/99-flirc.rules << EOF # create rules file.
# Flirc Devices

# Bootloader
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="20a0", ATTR{idProduct}=="0000", MODE="0666"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="20a0", ATTR{idProduct}=="0002", MODE="0666"
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="0005", MODE="0666"

# Flirc Application
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="20a0", ATTR{idProduct}=="0001", MODE="0666"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="20a0", ATTR{idProduct}=="0004", MODE="0666"
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="0006", MODE="0666"
EOF
    echo -e "Installed successfully."