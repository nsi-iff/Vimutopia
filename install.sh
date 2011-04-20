#!/bin/bash

FOLDER=$(cd $(dirname $0); pwd -P)

vim=0

apt-get install dialog
apt-get install xclip
apt-get install vim

if [ -f $HOME/.vimrc ]; then rm $HOME/.vimrc; fi
cp vimrc.vim $HOME/.vimrc
if [ -d $HOME/.vimrc-dumal ]; then rm -Rf $HOME/.vimrc-dumal; fi
mkdir $HOME/.vimrc-dumal
mkdir $HOME/.vimrc-dumal/doc

opcoes=$( dialog --stdout --separate-output                                                                 \
    --title "vimrc-dumal"                    \
    --checklist 'Select the vimrc package and dependencies to install'   0 0 0          \
    Python   "Python (Pip, Ipython, Spcloud, Should_dsl, Python-dev)"     ON \
    C   "C (gcc)"     ON \
)

if [ "$?" -eq 1 ]
then
    clear
    exit 1
fi

echo "$opcoes" |
while read opcao
do
    if [ $opcao == 'Python' ]
    then
        apt-get install python-setuptools ipython python-dev
        easy_install pip
        pip install should_dsl specloud
        cp src/vimrc-py.vim $HOME/.vimrc-dumal/vimrc-py.vim
        cp src/doc/help-py.man $HOME/.vimrc-dumal/doc/help-py.man
        echo "autocmd BufNewFile,BufRead *.py source $HOME/.vimrc-dumal/vimrc-py.vim" >> $HOME/.vimrc
    fi    
    
    if [ $opcao == 'C' ]
    then
        apt-get install gcc
        cp src/vimrc-c.vim $HOME/.vimrc-dumal/vimrc-c.vim
        cp src/doc/help-c.man $HOME/.vimrc-dumal/doc/help-c.man
        echo "autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp source $HOME/.vimrc-dumal/vimrc-c.vim" >> $HOME/.vimrc
    fi
done

dialog --title 'Aviso' \
        --msgbox 'Instalação concluída!' \
0 0

clear
