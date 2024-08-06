base64 -d <<< "4paI4paI4pWX4paI4paI4paI4paI4paI4paI4pWXIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVl+KWiOKWiOKVlyAgIOKWiOKWiOKVl+KWiOKWiOKVlyDilojilojilojilojilojilojilZfilojilojilojilojilojilojilojilZfilojilojilojilojilojilojilZcgIOKWiOKWiOKWiOKWiOKWiOKVlyDilojilojilojilojilojilojilojilZfilojilojilZcgIOKWiOKWiOKVlwrilojilojilZHilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilZDilZDilZ3ilojilojilZEgICDilojilojilZHilojilojilZHilojilojilZTilZDilZDilZDilZDilZ3ilojilojilZTilZDilZDilZDilZDilZ3ilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilZDilZDilZ3ilojilojilZEgIOKWiOKWiOKVkQrilojilojilZHilojilojilZEgIOKWiOKWiOKVkeKWiOKWiOKWiOKWiOKWiOKVlyAg4paI4paI4pWRICAg4paI4paI4pWR4paI4paI4pWR4paI4paI4pWRICAgICDilojilojilojilojilojilZcgIOKWiOKWiOKWiOKWiOKWiOKWiOKVlOKVneKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVkeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVl+KWiOKWiOKWiOKWiOKWiOKWiOKWiOKVkQrilojilojilZHilojilojilZEgIOKWiOKWiOKVkeKWiOKWiOKVlOKVkOKVkOKVnSAg4pWa4paI4paI4pWXIOKWiOKWiOKVlOKVneKWiOKWiOKVkeKWiOKWiOKVkSAgICAg4paI4paI4pWU4pWQ4pWQ4pWdICDilojilojilZTilZDilZDilojilojilZfilojilojilZTilZDilZDilojilojilZHilZrilZDilZDilZDilZDilojilojilZHilojilojilZTilZDilZDilojilojilZEK4paI4paI4pWR4paI4paI4paI4paI4paI4paI4pWU4pWd4paI4paI4paI4paI4paI4paI4paI4pWXIOKVmuKWiOKWiOKWiOKWiOKVlOKVnSDilojilojilZHilZrilojilojilojilojilojilojilZfilojilojilojilojilojilojilojilZfilojilojilojilojilojilojilZTilZ3ilojilojilZEgIOKWiOKWiOKVkeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKVkeKWiOKWiOKVkSAg4paI4paI4pWRCuKVmuKVkOKVneKVmuKVkOKVkOKVkOKVkOKVkOKVnSDilZrilZDilZDilZDilZDilZDilZDilZ0gIOKVmuKVkOKVkOKVkOKVnSAg4pWa4pWQ4pWdIOKVmuKVkOKVkOKVkOKVkOKVkOKVneKVmuKVkOKVkOKVkOKVkOKVkOKVkOKVneKVmuKVkOKVkOKVkOKVkOKVkOKVnSDilZrilZDilZ0gIOKVmuKVkOKVneKVmuKVkOKVkOKVkOKVkOKVkOKVkOKVneKVmuKVkOKVnSAg4pWa4pWQ4pWdCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA="

ARCH=/etc/arch-release
YAY=/usr/bin/yay
PARU=/usr/bin/paru
DEBIAN=/etc/debian_version
STRING="Install either yay or paru\nhttps://github.com/Jguer/yay\nhttps://github.com/Morganamilo/paru"


if test -f "$ARCH"; then
        if test -f "$YAY"; then
                AUR="$YAY"
        elif test -f "$PARU"; then
                AUR="$PARU"
        else echo "$STRING"
        fi

        sudo pacman -S \
        base-devel \
        pkgconf \
        git \
        autoconf \
        automake \
        libtool \
        libplist \
        libusbmuxd \
        openssl \
        usbmuxd

        $AUR -S \ 
        libimobiledevice-glue-git

        git clone https://github.com/libimobiledevice/libimobiledevice.git
        cd libimobiledevice

        ./autogen.sh
        make
        sudo make install
        sudo ldconfig
        
        
elif test -f "$DEBIAN"; then
        sudo apt-get install \
        build-essential \
        pkg-config \
        git \
        autoconf \
        automake \
        libtool-bin \
        libcurl4-openssl-dev \
        usbmuxd

        git clone https://github.com/libimobiledevice/libplist
        cd libplist
        PYTHON=$(which python3) ./autogen.sh
        make && sudo make install
        sudo ldconfig
        cd ..


        git clone https://github.com/libimobiledevice/libimobiledevice-glue.git
        cd libimobiledevice-glue

        ./autogen.sh
        make
        sudo make install
        cd ..

        git clone https://github.com/libimobiledevice/libusbmuxd
        cd libusbmuxd
        PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh
        make && sudo make install
        sudo ldconfig
        cd ..

        git clone https://github.com/libimobiledevice/libtatsu
        cd libtatsu
        PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh
        make && sudo make install
        sudo ldconfig
        cd ..

        git clone https://github.com/libimobiledevice/libimobiledevice.git
        cd libimobiledevice

        ./autogen.sh
        make
        sudo make install
        sudo ldconfig
fi
