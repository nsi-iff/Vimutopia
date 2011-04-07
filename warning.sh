#! /bin/bash

echo ":::::::::::::"
echo -e ":: \033[31mWARNING\033[m ::"
echo ":::::::::::::"
echo "This script will remove your atual vimrc file (if you have one)"
echo -n "You want to continue? (y|n) "
read ANSWER
if [ ! $ANSWER == 'y' ]
then
    echo "Script stopped by you!"
    exit 1
fi
