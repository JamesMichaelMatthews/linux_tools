#!/bin/bash

#Copy and rename this script according, and change the associated
#  .conf file below (and that file itself).  Nothing else needs changing.
CONF_FILE="filename.conf" #must exist in this same folder
#see example .conf files


DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )";  #cd's into the directory of this file and runs pwd, resulting
#                                                       #  in an absolute path even if the original was relative

function print_usage {
  echo "command up [interface]"
  echo "command down [interface]"
}

#user must pass in at least up or down
if (( "$#" < "1" )); then
  print_usage
  exit 
fi

#user may specify the interface, or defaults to wlan0
interface=wlan0
if (( "$#" >= "2" )); then
  interface=$2
fi

if [ "$1" = "up" ]; then
  ${DIR}/wifi_config.bash up ${DIR}/${CONF_FILE} ${interface}

else

  if [ "$1" = "down" ]; then
    ${DIR}/wifi_config.bash down ${interface}

  else
    print_usage
    exit
  fi

fi



