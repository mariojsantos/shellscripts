#!/bin/bash
# Script to logout from captive portal
# Assign permissions just to the file owner
# chmod 700 logoutcaptive.sh
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

URL="<captiveportal_IPorDomain>"
PORT="<captiveportal_Port>"
ZONE="<Zone_Name>"

ID=`curl -s -k https://$URL:$PORT/index.php?zone=$ZONE | grep logout_id | cut -d" " -f4 | cut -d= -f2 | sed 's/"//g'`  

curl -k -X POST -F 'logout_id='$ID'' -F 'zone='$ZONE'' -F 'logout=Disconnect' https://$URL:$PORT/index.php?zone=$ZONE

echo Logout Successful!
