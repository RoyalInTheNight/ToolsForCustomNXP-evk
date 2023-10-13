#!/bin/bash

gpioset 3 4=1
gpioset 0 7=1

ifconfig eth0 down
ifconfig eth0 up