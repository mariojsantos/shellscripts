#!/bin/bash
# Script to logout from captive portal
# Assign permitions just to the file owner
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

ID=`curl -s -k https://<CaptivePortalIPorDomain>:<Port>/index.php?zone=<ZoneName> | grep logout_id | cut -d" " -f4 | cut -d= -f2 | sed 's/"//g'`  

curl -k -X POST -F 'logout_id='$ID'' -F 'zone=institucional_temp' -F 'logout=Disconnect' https://<CaptivePortalIPorDomain>:<Port>/index.php?zone=<ZoneName>

echo Logout Successful!
