#!/bin/bash

if [[ "$1" == red ]]
then
  gpioset 3 17=1
fi

if [[ "$1" == green ]]
then
  gpioset 3 18=1
fi

if [[ "$1" == srv ]]
then
  gpioset 3 19=1
fi