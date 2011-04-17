#!/bin/bash

FOLDER=$(cd $(dirname $0); pwd -P)

vim=0

apt-get install -y dialog > /dev/null
apt-get install xclip

	if [ -f $HOME/.vimrc ]; then rm $HOME/.vimrc; fi
	cp vimrc.vim $HOME/.vimrc
	if [ -d $HOME/.vimrc-dumal ]; then rm -Rf $HOME/.vimrc-dumal; fi
	mkdir $HOME/.vimrc-dumal
	cp -r src/* $HOME/.vimrc-dumal/

opcoes=$( dialog --stdout --separate-output                                                                 \
    --title "vimrc-dumal"                    \
    --checklist 'Select the vimrc package to install'   0 0 0          \
    Python   "Python Configuration and Dependences (Pip, Ipython, Spcloud, Should_dsl"     ON \
    C        "C Dependences"          ON \
)

[ "$?" -eq 1 ] && exit 1


echo "$opcoes" |
while read opcao
do
    if  [ $opcao = 'Python' ]
    then
        apt-get install python-setuptools ipython vimrc
        easy_install pip
        pip install should_dls spacloud
    fi    
    
    [ $opcao = 'C' ] && apt-get update

done

dialog --title 'Aviso' \
        --msgbox 'Instalação concluída!' \
0 0

