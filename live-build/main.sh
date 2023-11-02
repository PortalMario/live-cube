#!/bin/bash
LIVE_BUILD_WORKDIR=$(mktemp -d)
export LIVE_BUILD_WORKDIR

create_image () {
    # Install deps.
    echo "Install live-build dependencies..."; sleep 2
    if ! apt-get install -y git live-build simple-cdd cdebootstrap curl; then
        echo "Could not install live-build dependencies."
    fi

    # Get Project
    if ! git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git "$LIVE_BUILD_WORKDIR"; then
        echo "Could not clone live-build projekt."
        exit 1
    fi

    # Pre-Installed Packages
    cp "live-build/kali.list.chroot" "${LIVE_BUILD_WORKDIR}/kali-config/variant-xfce/package-lists/"

    # Build Apps
    if ! bash "live-build/dolphin/dolphin.sh"; then
        echo "Error running dolphin-script."
        exit 1
    fi

    # Prefer ipv4 over ipv6 with wget
    if ! grep "prefer-family = IPv4" /etc/wgetrc; then
        echo "prefer-family = IPv4" >> /etc/wgetrc
    fi

    # Build image
    echo "Building image..."; sleep 2
    cd "${LIVE_BUILD_WORKDIR}" || exit 1
    bash build.sh --variant xfce --verbose --debug
    echo "Subdirectory for resulting image at: ${LIVE_BUILD_WORKDIR}"
    echo "done"
}

create_image