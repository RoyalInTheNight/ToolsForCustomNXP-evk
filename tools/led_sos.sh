#!/bin/bash

if [[ "$1" == red ]]
then
  if [[ "$2" == 1 ]]
  then
    gpioset 3 17=1

  else
    gpioset 3 17=0

  fi
fi

if [[ "$1" == green ]]
then
  if [[ "$2" == 1 ]]
    then
      gpioset 3 18=1

    else
      gpioset 3 18=0

    fi
fi

if [[ "$1" == srv ]]
then
  if [[ "$2" == 1 ]]
    then
      gpioset 3 19=1

    else
      gpioset 3 19=0

    fi
fi