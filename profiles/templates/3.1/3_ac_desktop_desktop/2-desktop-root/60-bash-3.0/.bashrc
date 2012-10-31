# Calculate format=raw
alias su="sudo su -"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PROMPT_COMMAND="echo -ne '\a'"

# set PATH so it includes user's private bin if it exists               
#if [ -d "$HOME/bin" ] ; then                                            
#    PATH="$HOME/bin:$PATH"                                              
#fi
