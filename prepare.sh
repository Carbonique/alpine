#!/bin/sh

print_sfdisk() {
  echo "\n********************************************************\n"


sfdisk $SD -l

  echo "\n********************************************************\n"
}

check_if_yes() {
  if [ "$1" != "y" ]; then
    echo "exiting"
    exit;
  fi
}

MOUNTDIR=/mnt/sd
SD=$1

if [ -z "$1" ]
then
      echo "Please add path to your sd card as the first parameter (e.g. ./prepare.sh /dev/sda)"
      exit
fi

print_sfdisk

echo
read -p "Warning, check above info. Are you sure $SD is the correct device to use? All data wil be wiped. (y/n) " CONT
echo
check_if_yes $CONT

print_sfdisk

echo
read -p "Warning, please check again. Are you absolutely sure $SD is the correct device to use? All data will be wiped. (y/n) " CONT
echo

check_if_yes $CONT

umount $MOUNTDIR -f
sfdisk $SD --delete


#Partition 1: 256MB,W95 FAT32 (LBA)
#Partition 2: All the remaining space. type: linux
sfdisk $SD <<EOF
,512M,c
,,83
EOF

#Set first partition bootable
sfdisk $SD -A 1

#Create filesystems
mkdosfs -F 32 ${1}1
mkfs.ext4 ${1}2

echo "Partitions created. Creating mount directory"

mkdir $MOUNTDIR
mount ${SD}1 $MOUNTDIR
rm -rf ${MOUNTDIR}/

echo "Mount directory created. Coying files now"
cp headless.apkovl.tar.gz $MOUNTDIR
cp wpa_supplicant.conf $MOUNTDIR

echo "\nUnpacking tar.gz"
tar xvfz alpine-rpi-3.17.1-aarch64.tar.gz -C $MOUNTDIR

echo "\nUnpacking done. You can unmount the sd card now at $MOUNTDIR"
