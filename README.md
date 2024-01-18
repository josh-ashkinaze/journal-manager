This is a bash script for managing journal entries. 

Journaling has numerous mental health benefits, can help you clarify ideas, and (maybe?) improve writing. For these reasons, I wanted to start writing 750 words in the morning each day. But I quickly found many existing journaling apps are bloated, possibly in their 'enshitification' phase [1]. This script has basic features to create ISO-formatted markdown files controlled via terminal, which is basically all you need. 

```
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
```


[1] https://en.wikipedia.org/wiki/Enshittification
