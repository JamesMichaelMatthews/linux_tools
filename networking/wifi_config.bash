#!/bin/bash

function print_usage {
  echo "wifi_config up (wpa_supplicant.conf) [interface]"
  echo "wifi_config down [interface]"
}

#user must pass in at least up or down
if (( "$#" < "1" )); then
  print_usage
  exit 
fi

if [ "$1" = "up" ]; then

  #user must pass in the wpa conf file
  if (( "$#" < "2" )); then
    echo "You must pass in the wpa_supplicant.conf file."
    print_usage
    exit 
  else
    wpa_supplicant_conf_file=$2
  fi

  #user may specify the interface, or defaults to wlan0
  interface=wlan0
  if (( "$#" >= "3" )); then
    interface=$3
  fi
  
  echo "bringing up $interface"

  #first, put the interface down, kill wpa_supplicant, and wifi daemons
  sudo ifconfig $interface down
  sudo killall -q wpa_supplicant
  sudo service wicd stop

  #bring it up, start wpa_supplicant, run dhclient
  sudo ifconfig $interface up
  sudo wpa_supplicant -B -i $interface -c ${wpa_supplicant_conf_file}
  sudo dhclient $interface

else

  if [ "$1" = "down" ]; then

    #user may specify the interface, or defaults to wlan0
    interface=wlan0
    if (( "$#" >= "3" )); then
      interface=$3
    fi
  
    echo "bringing down $interface"
    #bring it down, kill wpa_supplicant
    sudo ifconfig $interface down
    sudo killall -q wpa_supplicant

  else
    print_usage
    exit
  fi

fi



