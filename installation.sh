#!/bin/bash

apt install autoconf-archive nlohmann-json3-dev

caam-keygen create randomkeyCCM ccm -s 24
caam-keygen create randomkey ecb -s 16

cat /data/caam/randomkey | keyctl padd logon logkey: @s
losetup /dev/loop0 /dev/mmcblk2p4
dmsetup -v create encrypted --table "0 $(blockdev --getsz /dev/loop0) crypt capi:tk(cbc(aes))-plain :36:logon:logkey: 0 /dev/loop0 0 1 sector_size:512"
mkfs.ext4 /dev/mapper/encrypted
mkdir /mnt/encrypted
mount -t ext4 /dev/mapper/encrypted /mnt/encrypted/

umount /mnt/encrypted/
dmsetup remove encrypted

rm -rf libgpiod/
# git clone https://github.com/brgl/libgpiod.git

if [ -e libgpiod ]
then
    echo "[ INFO ]Install libgpiod..."
    # cd libgpiod
    # sh autogen.sh --enable-tools=yes
    # make

    # if [ -e gpioset ]
    # then
    #    echo "[ INFO ]GPIO tool compiled"

    # else
    #    echo "[FAILED]GPIO tool compile error"

    # fi

    cp tools/gpio* /bin
    cd ../

else
    echo "[FAILED]Missing libgpiod..."

fi

if [ -e tools ]
then
    echo "[ INFO ]Finded boot module tools"

    mkdir -p /usr/local

    cp -r tools/ /usr/local/

    chmod 777 /usr/local/tools/*

else
    echo "[FAILED]Missing boot module tools"

fi

if [ -e boot_daemon.service ]
then
  echo "[ INFO ]Install boot_daemon.service"

  cp boot_daemon.service /lib/systemd/system/boot_daemon.service
  cp dropbear.service    /lib/systemd/system/dropbear.service

  if [ -e /lib/systemd/system/boot_daemon.service ]
  then
    echo "[  OK  ]Service installed"

  else
    echo "[FAILED]Service don't installed"

  fi

else
  echo "[FAILED]Missing service"

fi

echo "[ INFO ]i.MX reboot..."

sleep 1
