#!/bin/bash

qmicli --device=/dev/cdc-wdm0 --device-open-proxy --get-wwan-iface
qmicli --device=/dev/cdc-wdm0 --get-expected-data-format
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wda-get-data-format

ip link set dev wwan0 down

echo Y > /sys/class/net/wwan0/qmi/raw_ip

ip link set dev wwan0 up

qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4,apn=internet.mts.ru" --client-no-release-cid

udhcpc -q -f -n -i wwan0