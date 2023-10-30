#!/bin/bash

/usr/local/tools/boot64_yt8512.sh
/usr/local/tools/boot64_sim7600H.sh

gpioset 0 6=1
gpioset 3 13=1
gpioset 3 6=1

systemctl start dropbear.service
