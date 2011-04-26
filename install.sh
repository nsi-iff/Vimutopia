#!/bin/bash

FOLDER=$(cd $(dirname $0); pwd -P)

vim=0

apt-get install -y dialog
apt-get install -y xclip
apt-get install -y vim

if [ -f $HOME/.vimrc ]; then rm $HOME/.vimrc; fi
cp vimrc.vim $HOME/.vimrc
if [ -d $HOME/.vimutopia]; then rm -Rf $HOME/.vimutopia; fi
mkdir $HOME/.vimutopia
mkdir $HOME/.vimutopia/scripts
mkdir $HOME/.vimutopia/doc
cp src/scripts/scripts_generic.py $HOME/.vimutopia/scripts

opcoes=$( dialog --stdout --separate-output                                                                 \
    --title "vimutopia"                    \
    --checklist 'Select the vimrc package and dependencies to install'   0 0 0          \
    Python   "Pip, Ipython, Spcloud, Should_dsl, Python-dev"     ON \
    C   "gcc"     ON \
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
        apt-get install -y python-setuptools ipython python-dev
        easy_install pip
        pip install should_dsl specloud
        cp src/vimrc-py.vim $HOME/.vimutopia/vimrc-py.vim
        cp doc/help-py.man $HOME/.vimutopia/doc/help-py.man
        cp src/scripts/scripts_python.py $HOME/.vimutopia/scripts
        echo "autocmd BufNewFile,BufRead *.py source $HOME/.vimutopia/vimrc-py.vim" >> $HOME/.vimrc
    fi

    if [ $opcao == 'C' ]
    then
        apt-get install -y gcc
        cp src/vimrc-c.vim $HOME/.vimutopia/vimrc-c.vim
        cp doc/help-c.man $HOME/.vimutopia/doc/help-c.man
        echo "autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp source $HOME/.vimutopia/vimrc-c.vim" >> $HOME/.vimrc
    fi
done

dialog --title 'Aviso' \
        --msgbox 'Instalação concluída!' \
0 0

clear
