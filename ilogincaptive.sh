#!/bin/bash
# Script to login at pfsense captive portal interactively
# The user needs to provide its credentials
# Assign permissions on the file just to the file owner:
# chmod 600 .pass
# Be happy!

read -p "Type your username: " USERNAME
#read -s -p "Type your password: " PASS
PASS="$(systemd-ask-password "Type your password: ")"

RESULT="$(curl -s -k -H "Content-Type: application/x-www-form-urlencoded" -X POST --data-urlencode "auth_user=$USERNAME" --data-urlencode "auth_pass=$PASS" -d accept=Continuar https://acesso.ifcelimoeiro:8007/index.php?zone=institucional_temp)"

YES=`echo $RESULT | grep Redirec`

if [ -z "$YES" ]; then
 	echo Login Failed!
else	
	echo Successful Login!
fi
