#!/bin/bash

cat /data/caam/importKey | keyctl padd logon logkey: @s
losetup /dev/loop0 /dev/mmcblk2p4
dmsetup -v create encrypted --table "0 $(blockdev --getsz /dev/loop0) crypt capi:tk(cbc(aes))-plain :36:logon:logkey: 0 /dev/loop0 0 1 sector_size:512"
mount /dev/mapper/encrypted /mnt/encrypted/

/usr/local/tools/boot64_yt8512.sh
/usr/local/tools/boot64_sim7600H.sh

gpioset 0 6=1
gpioset 3 13=1
gpioset 3 6=1

systemctl start dropbear.service
