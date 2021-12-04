#!/bin/bash

###################################################################################
#                                                                                 
# This Script packs a directory/file in .tar.gz or tar.bz2 format and adds 	      
# a current date to filename                                                      
# Dependencies: tar, gzip and bzip2 packages                                                                               
# Creation date - 12-12-2016                                                      
# Author: mariojsantos                                                            
###################################################################################
#										                                          
#										                                          	
#   This program is free software; you can redistribute it and/or modify	      
#   it under the terms of the GNU General Public License as published by	      
#   the Free Software Foundation; either version 2 of the License, or		      
#   (at your option) any later version.						                      
# 										                                          
#   This program is distributed in the hope that it will be useful,		          
#   but WITHOUT ANY WARRANTY; without even the implied warranty of		          
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the		          
#   GNU General Public License for more details.				                  
# 										                 
#   You should have received a copy of the GNU General Public License		      
#   along with this program; if not, write to the Free Software			          
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  
# 										                
###################################################################################

#Funcion to print the mode use help 
function PrintUsage()
{
	echo "Use: `basename $0` [-b] [-vh] <file,directory>"
	exit 1
}

function PrintHelp()
{
	echo "Options: "
	echo "-b: compress using bzip2 format"
	echo "-v: shows the script version"
	echo "-h: shows this help"
	exit 1
}


#test if user supplied directory name
if [ -z $1 ]; then
	echo -e "Need to supply the file or directory name after the script name!" 
    PrintUsage	
	exit
fi

#hour=$(date +%H-%M-%S)
today=$(date +%F)
type="z"
extension=".tar.gz"
target="${1%/}"

while getopts "hvblz" OPTION
do
	case $OPTION in
		h) PrintHelp
		   ;;
		
		v) echo "`basename $0` version 1.0"
		   exit
		   ;;
		
		b) type="j"
		   extension=".tar.bz2"
		   ;;
		
		?) PrintUsage
		   ;;
	esac
done
shift $((OPTIND-1))

##############################################################################
# To add the hour to the final filename, uncomment the line started          #
# with the "hour" var e add the suffix -"$hour" as in the example below.     #
# ex: tar -c"$type"vf "$target"_"$today"-"$hour""$extension"                 #
#                                                                            #
##############################################################################

tar -c"$type"vf "$target"_"$today""$extension"  $target  

exit


