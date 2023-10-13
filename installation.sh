#!/bin/bash

if [ -e libgpiod ]
then
    echo "[ INFO ]Install libgpiod...\n"
    cd libgpiod
    sh autogen.sh
    make

    cd tools
    make

    if [ -e gpioset ]
    then
        echo "[ INFO ]GPIO tool compiled\n"

    else
        echo "[FAILED]GPIO tool compile error\n"

    fi

    cp gpioset /bin
    cd ../../

else
    echo "[FAILED]Missing libgpiod...\n"

fi

if [ -e tools ]
then
    echo "[ INFO ]Finded boot module tools\n"

    mkdir -p /usr/local

    cp -r tools/ /usr/local/

else
    echo "[FAILED]Missing boot module tools\n"

fi