#!/bin/bash

# DOCUMENTATION
###############################
# AUTHOR: Joshua Ashkinaze
# DATE: 2024-01-02  
# DESCRIPTION: Minimalist journal entry manager. Creates ISO-formatted markdown files in a directory and opens in app of choice or displays in terminal. 

# USAGE:
# bash journal.sh --> creates new journal entry for today's date, opens in app of choice. If journal entry already created, 
# will open that journal and append a newline with datetime string if append_dt is set to "Y".
# bash journal.sh -r --> opens a random journal entry in app of choice
# bash journal.sh -rt --> displays a random journal entry in terminal
# bash journal.sh -d 2024-01-02 --> opens journal entry for 2024-01-02 in app of choice
# bash journal.sh -dt 2024-01-02 --> displays journal entry for 2024-01-02 in terminal

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
    echo "Opened journal entry in $app_name from $file_path"
}

cat_file() {
    file_path=$1
    cat "$file_path"
    echo "Displayed journal entry in terminal from $file_path"
}


###############################

# MAIN 
###############################
# Make directory if it does not exist 
directory="$journal_location"
mkdir -p "$directory"

# Check for command line arguments
if [ "$1" == "-r" ]; then
    # Open a random journal entry in app
    files=("$directory"/*.md)
    random_file=${files[RANDOM % ${#files[@]}]}
    open_file "$random_file"
elif [ "$1" == "-rt" ]; then
    # Display a random journal entry in terminal
    files=("$directory"/*.md)
    random_file=${files[RANDOM % ${#files[@]}]}
    cat_file "$random_file"
elif [ "$1" == "-d" ]; then
    # Open a journal entry for a specific date in app
    specific_date="$2"
    file_path="$directory/${specific_date}.md"
    if [ -e "$file_path" ]; then
        open_file "$file_path"
    else
        echo "No journal entry found for $specific_date"
    fi
elif [ "$1" == "-dt" ]; then
    # Display a journal entry for a specific date in terminal
    specific_date="$2"
    file_path="$directory/${specific_date}.md"
    if [ -e "$file_path" ]; then
        cat_file "$file_path"
    else
        echo "No journal entry found for $specific_date"
    fi

# Add a new elif branch in your main conditional
elif [ "$1" == "-c" ]; then
    # Display the calendar with journal entry markers
    if [ "$2" ]; then
        display_calendar "$2"
    else
        display_calendar
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
