#!/bin/bash
# Script para fazer logout no captive portal
# 
# Atribua permissões somente ao dono do arquivo:
# chmod 700 logoutcaptive.sh
# Seja feliz!

ID=`curl -s -k https://acesso.ifcelimoeiro:8007/index.php?zone=institucional_temp | grep logout_id | cut -d" " -f4 | cut -d= -f2 | sed 's/"//g'`  

curl -k -X POST -F 'logout_id='$ID'' -F 'zone=institucional_temp' -F 'logout=Disconnect' https://acesso.ifcelimoeiro:8007/index.php?zone=institucional_temp

echo Logout Successful!
