#!/bin/bash
# Convert pwdLastSet from LDAP to the datetime format in localtime
# Reference: https://stackoverflow.com/questions/4647169/how-to-convert-ldap-timestamp-to-unix-timestamp
# Usage: ./ldap2dtime.sh <pwdLastSetValue>

declare -r EPOCH=11644473600

PWDLASTSET="$1"

#convert to seconds
SECONDS=$(($PWDLASTSET/10000000))

#Convert to UNIX Timestamp - 1.1.1601 -> 1.1.1970 difference in seconds
UNIXTIMESTAMP=$(($SECONDS - $EPOCH))

DATE=$(date -d @$UNIXTIMESTAMP)

echo The password has been changed for tha last time at $DATE

