#!/bin/bash

if [ -e libgpiod ]
then
    echo "[ INFO ]Install libgpiod..."
    cd libgpiod
    sh autogen.sh
    make

    cd tools
    make

    if [ -e gpioset ]
    then
        echo "[ INFO ]GPIO tool compiled"

    else
        echo "[FAILED]GPIO tool compile error"

    fi

    cp gpioset /bin
    cd ../../

else
    echo "[FAILED]Missing libgpiod..."

fi

if [ -e tools ]
then
    echo "[ INFO ]Finded boot module tools"

    mkdir -p /usr/local

    cp -r tools/ /usr/local/

else
    echo "[FAILED]Missing boot module tools"

fi

if [ -e boot_daemon.service ]
then
  echo "[ INFO ]Install boot_daemon.service"

  cp boot_daemon.service /lib/systemd/system/boot_daemon.service

  if [ -e /lib/systemd/system/boot_daemon.service ]
  then
    echo "[  OK  ]Service installed"

  else
    echo "[FAILED]Service don't installed"

  fi
else
  echo "[FAILED]Missing service"

fi