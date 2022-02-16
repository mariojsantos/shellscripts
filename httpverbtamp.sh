#!/bin/bash

#####################################################################################
#
# This script tests for http verb tampering and was based on following references: 
# 1. https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/07-Input_Validation_Testing/03-Testing_for_HTTP_Verb_Tampering
# 2. https://pentestlab.blog/2012/12/20/http-methods-identification/
#  
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


HOST=$1
PORT=$2
URI=$3

#File with resource names to test
FILE=lista.txt

while read -r line; 
do
	#prints the URI 
	printf "/$URI/$line:\n"
	
	#Fills the loop for with the http methods of your choice
	for webservmethod in GET POST PUT TRACE CONNECT OPTIONS PROPFIND;

	do
		printf "$webservmethod ";
		printf "$webservmethod /$URI/$line HTTP/1.1\nHost: $HOST\n\n" | nc -q 1 $HOST $PORT | grep "HTTP/1.1";
	done

done < $FILE

exit 1

