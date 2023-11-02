#!/bin/bash
BUILDDIR=$(mktemp -d)

# Get depends.
echo "Installing build dependencies for dolphin..." ; sleep 2
if apt-get install -y --no-install-recommends ca-certificates \
    qt6-base-dev \
    qt6-base-private-dev \
    libqt6svg6-dev \
    cmake \
    make \
    gcc \
    g++ \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libxi-dev \
    libxrandr-dev \
    libudev-dev \
    libevdev-dev \
    libsfml-dev \
    libminiupnpc-dev \
    libmbedtls-dev \
    libcurl4-openssl-dev \
    libhidapi-dev \
    libsystemd-dev \
    libbluetooth-dev \
    libasound2-dev \
    libpulse-dev \
    libpugixml-dev \
    libbz2-dev \
    libzstd-dev \
    liblzo2-dev \
    libpng-dev \
    libusb-1.0-0-dev \
    gettext; then
    echo -e "Finished installation of dolphin dependencies.\n"
else
    echo "Could not install dependencies for dolphin."
    exit 1
fi

# Get source.
if ! git clone https://github.com/dolphin-emu/dolphin.git "$BUILDDIR"; then
    echo "failed cloning dolphin repo."
    exit 1
fi
cd "$BUILDDIR" || exit 1

if ! git submodule update --init --recursive; then
    echo "Could not init. dolphin externals."
fi

# Compile & Build
echo "Building dolphin..."; sleep 2
mkdir Build && cd Build || exit 1
cmake .. ; make -j"$(nproc)" ; sudo make install

echo "Filling image with dolphin content..."; sleep 2
cd "$WORKDIR" || exit 50

# Move Dolphin to live-build
mkdir -p "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/"
cp -rp /usr/local/* "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/"

# Move games
mkdir -p "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/opt/games/"
cp -r /opt/games/* "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/opt/games/" && \
chmod -R +r "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/opt/games"

# Move bios
if ls "/opt/games/ipl.bin"; then
    mkdir -p "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/share/dolphin-emu/sys/GC/EUR/"
    cp "/opt/games/ipl.bin" "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/share/dolphin-emu/sys/GC/EUR/IPL.bin" && \
    chmod -R +r "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/share/dolphin-emu/sys/GC/EUR/"
fi

# Move gameINI
cp -rp live-build/dolphin/gameINI/* "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/share/dolphin-emu/sys/GameSettings/" && \
chmod -R +r "${LIVE_BUILD_WORKDIR}/kali-config/common/includes.chroot/usr/local/share/dolphin-emu/sys/GameSettings/"
