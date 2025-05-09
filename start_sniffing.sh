#!/bin/bash

#TODO: still working on getting this fully functioning...

#We are using wlan1 for 
INTERFACE="wlan1"

#before starting interface we need to kill the associated processes
sudo airmon-ng check kill 

# Start airmon-ng on the specified interface
echo "Starting airmon-ng on $INTERFACE..."
key_output1="$(ssh-add -L)"

#output1="$(sudo airmon-ng start $INTERFACE -w Access_points)"
#See if it started our target device in monitor mode(neither wifi adapter will be in monitor mode at bootup)
successful_start=$(sudo airmon-ng start "$INTERFACE" -w Access_points | grep  'monitor mode' )
# Check if airmon-ng was successful
if [-z "$successful_start" ]; then
  echo "airmon-ng started successfully"
else
  echo "Couldn't start airmon-ng, something broke"
fi

#Capture packets for my test Access point
sudo airodump-ng -c 6 --bssid 46:5E:44:8C:21:7F -w HP-desktop_packets

#in future we want to iterate through the Access_points list BSSID's

