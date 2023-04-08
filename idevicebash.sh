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
        checkinstall \
        git \
        autoconf \
        automake \
        libtool-bin \
        libssl-dev \
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

        git clone https://github.com/libimobiledevice/libimobiledevice.git
        cd libimobiledevice

        ./autogen.sh
        make
        sudo make install
        sudo ldconfig
fi
