#!/bin/bash
# Script to login at pfsense captive portal
# Before run this script, create a file .pass on the same directory
# with the captive portal user password 
# Assign permissions on the file just to the file owner:
# chmod 600 .pass
# Be happy!
##################################################################################### 
#
#   This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
# 
#################################################################################### 

URL="<CaptivePortal_IP_or_Domain>"
PORT="<CaptivePortal_Port>"
ZONE="<ZoneName>"

PASS="`<.pass`"

#Put your captive portal username here between the double quotes
USERNAME="<yourusername>"

RESULT="$(curl -s -k -H "Content-Type: application/x-www-form-urlencoded" -X POST --data-urlencode "auth_user=$USERNAME" --data-urlencode "auth_pass=$PASS" -d accept=Continuar https://$URL:$PORT/index.php?zone=$ZONE)"

YES=`echo $RESULT | grep Redirec`

if [ -z "$YES" ]; then
 	echo Login Failed!
else	
	echo Successful Login!
fi
