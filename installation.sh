#!/bin/bash

apt install autoconf-archive nlohmann-json3-dev

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

if [ -e gpio.cpp ]
then
    echo "[ INFO ]Finded boot module tools"

    mkdir -p /usr/local

    cp boot /usr/local/tools

    chmod 777 /usr/local/tools/boot

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
