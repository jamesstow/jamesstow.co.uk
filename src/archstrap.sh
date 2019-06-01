#!/bin/bash

HOSTNAME="$1"
FSTABSETUP="$2"

if [ -z "$HOSTNAME" ]; then
	echo "no hostname provided"
	exit 1
fi

if [ "$FSTABSETUP" != "yes" ]; then
	echo "please setup fstab and mount the resultant filesystem to /mnt before continuing"
	exit 1
fi

loadkeys uk

timedatectl set-ntp true

genfstab -U /mnt >> /mnt/etc/fstab

pacstrap /mnt base base-devel zsh vim git i3 spotify dnsutils docker code firefox-developer-edition npm steam ttf-liberation
virtualbox virtualbox-host-modules-arch stow

arch-chroot /mnt

ls -sf /usr/share/zoneinfo/ /etc/localtime

hwclock --systohc

cp /etc/locale.gen /etc/locale.gen.bak
echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf

echo $HOSTNAME > /etc/hostname

echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		$HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

echo "set the root password:"
passwd
