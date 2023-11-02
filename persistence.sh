#!/bin/bash 
DEVICE=${1}

# Check for root privs.
if [ "$USER" != "root" ]; then
    echo "You need to be root."
    exit 1
fi

fdisk $DEVICE <<< $(printf "n\np\n\n\n\nw")

if ! mkfs.ext4 -L persistence ${DEVICE}3; then
    echo "Could not create persistence filesystem."
    exit
fi
mkdir -p /mnt/prst
mount ${DEVICE}3 /mnt/prst
echo "/ union" |  tee /mnt/prst/persistence.conf
umount ${DEVICE}3
reboot
