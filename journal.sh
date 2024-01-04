#!/bin/bash

# DOCUMENTATION
###############################

# AUTHOR: Joshua Ashkinaze
# DATE: 2024-01-02  
# DESCRIPTION: Minimalist journal entry manager. Creates ISO-formatted markdown files in a directory and opens in app of choice. 

# USAGE:
# bash journal.sh --> creates new journal entry with filename of today's date, opens in app of choice. If journal entry already created, 
# will open that journal and append a newline with datetime string if append_dt is set to "Y". 
# bash journal.sh --r --> opens random journal entry in app of choice
# bash journal.sh 2024-01-02 --> opens journal entry for 2024-01-02 in app of choice

# INSTALLATION INSTRUCTIONS 
# 1. Save this file in your default terminal location: Ex: Macintosh HD/Users/snowj
# 2. Run this command to make it executable: chmod +x journal.sh
###############################

# CHANGE THESE!!!
###############################
app_name="MarkEdit" # app to open .md files in 
journal_location="Documents/journals" # journal directory
append_dt="Y" # Set to "Y" to append date and time to existing entry, "N" otherwise
###############################


# HELPER FUNCTIONS
###############################
strip_trailing_newlines() {
    file=$1
    echo >> "$file"
    sed -i '' -e :a -e '/^\n*$/N;/\n$/ba' -e 'P;D' "$file"
}


open_file() {
    file_path=$1
    open -a "$app_name" "$file_path"
    echo "Opened journal entry in $file_path"
}
###############################



# MAIN 
###############################
# Make directory if it does not exist 
directory="$journal_location"
mkdir -p "$directory"

# Check for command line arguments
if [ "$1" == "--r" ]; then
    # Open a random journal entry
    files=("$directory"/*.md)
    random_file=${files[RANDOM % ${#files[@]}]}
    open_file "$random_file"
elif [[ "$1" =~ ^--([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
    # Open a journal entry for a specific date
    specific_date=$(echo "$1" | cut -d'-' -f 2-)
    file_path="$directory/${specific_date//[-]/_}.md"
    if [ -e "$file_path" ]; then
        open_file "$file_path"
    else
        echo "No journal entry found for $specific_date"
    fi
else
    # Default behavior: Open today's journal entry
    current_datetime="**$(date +"%A %Y-%m-%d %T")**"
    current_date=$(date +"%Y-%m-%d")
    file_path="$directory/$current_date.md"
    if [ -e "$file_path" ]; then
        if [ "$append_dt" == "Y" ]; then
	    strip_trailing_newlines "$file_path"
            echo -e "\n$current_datetime" >> "$file_path"
        fi
    else
        echo "$current_datetime" > "$file_path"
    fi
    open_file "$file_path"
fi
###############################

