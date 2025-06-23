#!/bin/bash
#Rename files removing blank spaces from its names and convert them from xlsx format to csv

# main if/else. Tests if the user has provide the directory name where the xlsx files resides
if [ -z "$1" ];then
	echo "Provide the target directory name!"
	echo "Use: $0 <Absolute path from the directory where resides the xlsx files>"
	exit 1
else
	# returns the absolute path from the directory and save it on variable DIRE.
	DIRE=$(readlink -e "$1") 	
	
	# Create a file with a random name and store on a variable
	LIST=$(tr -cd 'a-f0-9' < /dev/urandom | head -c 12)
	
	# Enter on xlsx files directory
	cd "$DIRE" 	
	
	# Lists the directory files and send the output to file created previously.
	ls -1 "$DIRE" > $LIST
	
	# Read the file line by line
	while read LINE 
	do
		TEST=$(ls "$LINE" | egrep -e " ") # Returns the file name in case it contains blank spaces
		
		# Returns true if the variable TEST was empty
		if [ -z "$TEST" ];then 
			echo "File $LINE does not contain blank spaces on its name" 
			
			# stores the file name that not contain blank spaces in the LINE_MOD variable
			LINE_MOD=$LINE 
		else 
			# renames the file in case it contain blank space in the name and stores the new name in the variable LINE_MOD
			LINE_MOD=$(rename -v 's/ //g' "$LINE" | awk '{print $NF}') 
		fi #end of the first if inside the while loop		
	
		# Returns only the file extension and stores it in the EXT variable
		EXT="${LINE_MOD##*.}" 
		
		#If the file does not have the extension xlsx, jumps to next while iteration
		if [[ $EXT != 'xlsx' ]];then
			continue 
		#Otherwise
		else
		 	# Stores in the variable CSV just the file name without the extension part
			CSV="${LINE_MOD%.*}"		
			
			# Converts the file and adds the .csv extension
			/usr/bin/ssconvert -S --export-type=Gnumeric_stf:stf_csv $LINE_MOD "$CSV.csv" 
		fi # end of the second if inside the while loop
	done < $LIST  #end of the while loop

	# remove the list file
	rm -f $LIST 
fi # End of the main if/else

