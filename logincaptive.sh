#!/bin/bash
# Script to login at pfsense captive portal
# Before run this script, create a file .pass on the same directory
# with the captive portal user password 
# Assign permissions on the file just to the file owner:
# chmod 600 .pass
# Be happy!

PASS="`<.pass`"

#Put your captive portal username here between the double quotes
USERNAME="<yourusername>"

RESULT="$(curl -s -k -H "Content-Type: application/x-www-form-urlencoded" -X POST --data-urlencode "auth_user=$USERNAME" --data-urlencode "auth_pass=$PASS" -d accept=Continuar https://acesso.ifcelimoeiro:8007/index.php?zone=institucional_temp)"

YES=`echo $RESULT | grep Redirec`

if [ -z "$YES" ]; then
 	echo Login Failed!
else	
	echo Successful Login!
fi
