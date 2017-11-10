#!/bin/bash
HOME_DIR=$HOME
DOTFILES_DIR=$HOME_DIR/dotfiles

source $DOTFILES_DIR/colors.sh
source $DOTFILES_DIR/utils.sh

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing

# Fix commit author name and email 
function fix_commit_author() {
    git filter-branch --env-filter '

    OLD_EMAIL="$1"
    CORRECT_NAME="$2"
    CORRECT_EMAIL="$3"

    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags 
}

# Reads message from the user and replaces "$1" with it
function read_and_replace_message() {
    FIND="$1"
    read -e -i "$FIND" REPLACE
    echo "Changing to: "$REPLACE
    if [[ $FIND != $REPLACE ]]; then

        # escape_chars FIND "$FIND";
        # escape_chars REPLACE "$REPLACE";
        # REPLACE=${REPLACE//\'/\\\'}

        git filter-branch -f --msg-filter \
            'sed "s/'$FIND'/'$REPLACE'/g"' \
            --tag-name-filter cat -- --all
    fi;
}

function loop_over_commit_messages() {
    for line in `git log --oneline | \grep -v Merge | cut -d ' ' -f  2-`; do
        echo -en "${colors[BGreen]}Changing line \`$line\`${colors[White]}\n"
        read_and_replace_message $line
    done
}

loop_over_commit_messages
