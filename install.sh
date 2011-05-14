#!/bin/bash

function error
{
    dialog            \
        --msgbox "$1" \
        0 0
    clear
    exit 1
}

function warning
{
    dialog                                                                     \
        --msgbox "This installation script will remove your atual .vimrc file" \
        0 0
    if [ $? != 0 ]
    then
        error "Installation stopped by you"
    fi
}

function install_global_dependencies
{
    apt-get install -y dialog > /dev/null
    if [ $? != 0 ]
    then
        echo "An error occurred during global dependencies installation"
        exit 1
    fi
    dialog                                         \
        --title "Package installation"             \
        --infobox "Installing global dependencies" \
        0 0
    apt-get install -y xclip vim > /dev/null
    if [ $? != 0 ]
    then
        error "An error occurred during global dependencies installation"
    fi
}

function copy_importtant_files
{
    dialog                                  \
        --title "File copy"                 \
        --infobox "Copying important files" \
        0 0
    if [ -f $HOME/.vimrc ]; then rm $HOME/.vimrc; fi
    if [ $? != 0 ]
    then
        error "Can't remove .vimrc file"
    fi
    cp vimrc.vim $HOME/.vimrc
    if [ $? != 0 ]
    then
        error "Can't create .vimrc file"
    fi
    if [ -d $HOME/.vimutopia ]; then rm -Rf $HOME/.vimutopia; fi
    if [ $? != 0 ]
    then
        error "Can't remove .vimutopia folder"
    fi
    mkdir $HOME/.vimutopia
    if [ $? != 0 ]
    then
        error "Can't create .vimutopia folder"
    fi
    mkdir $HOME/.vimutopia/scripts
    if [ $? != 0 ]
    then
        error "Can't create scripts folder"
    fi
    mkdir $HOME/.vimutopia/doc
    if [ $? != 0 ]
    then
        error "Can't create doc folder"
    fi
    cp src/scripts/scripts_generic.py $HOME/.vimutopia/scripts
    if [ $? != 0 ]
    then
        error "Can't copy a script"
    fi
    cp -R autoload $HOME/.vim/autoload
    if [ $? != 0 ]
    then
        error "Can't copy autoload folder"
    fi
    cp -R bundle $HOME/.vim/bundle
    if [ $? != 0 ]
    then
        error "Can't copy bundle folder"
    fi
}

function select_packages
{
    packages=$(dialog --stdout --separate-output                                               \
                   --title "vimutopia"                                                         \
                   --checklist "Select the vimrc packages and dependencies to install"   0 0 0 \
                   Python "Pip, Ipython, Spcloud, Should_dsl, Python-dev"                   ON \
                   C "gcc, igcc"                                                            ON \
              )
    if [ $? != 0 ]
    then
        error "Installation stopped by you"
    fi
}

function install_python_dependencies
{
    dialog                                         \
        --title "Package installation"             \
        --infobox "Installing python dependencies" \
        0 0
    apt-get install -y python-setuptools ipython python-dev > /dev/null
    if [ $? != 0 ]
    then
        error "An error occurred during python dependencies installation"
    fi
    easy_install pip > /dev/null
    if [ $? != 0 ]
    then
        error "An error occurred during pip installation"
    fi
    pip install should_dsl specloud > /dev/null
    if [ $? != 0 ]
    then
        error "An error occurred during python dependencies installation"
    fi
    cp src/vimrc-py.vim $HOME/.vimutopia/vimrc-py.vim
    if [ $? != 0 ]
    then
        error "Can't copy a script"
    fi
    cp doc/help-py.man $HOME/.vimutopia/doc/help-py.man
    if [ $? != 0 ]
    then
        error "Can't copy a doc"
    fi
    cp src/scripts/scripts_python.py $HOME/.vimutopia/scripts
    if [ $? != 0 ]
    then
        error "Can't copy a script"
    fi
    echo "autocmd BufNewFile,BufRead *.py source $HOME/.vimutopia/vimrc-py.vim" >> $HOME/.vimrc
    if [ $? != 0 ]
    then
        error "Can't append line in .vimrc file"
    fi
}

function install_c_dependencies
{
    dialog                                    \
        --title "Package installation"        \
        --infobox "Installing C dependencies" \
        0 0
    apt-get install -y gcc > /dev/null
    if [ $? != 0 ]
    then
        error "An error occurred during C dependencies installation"
    fi
    wget "http://downloads.sourceforge.net/project/igcc/igcc-0.1.tar.bz2" --quiet
    if [ $? != 0 ]
    then
        error "An error occurred during download of igcc"
    fi
    tar -xjf "igcc-0.1.tar.bz2"
    if [ $? != 0 ]
    then
        error "An error occurred during unpack igcc"
    fi
    rm igcc-0.1.tar.bz2
    if [ $? != 0 ]
    then
        error "Can't remove igcc-0.1.tab.bz2"
    fi
    mv igcc-0.1 $HOME/.vimutopia/igcc
    if [ $? != 0 ]
    then
        error "Can't move igcc folder"
    fi
    cp src/vimrc-c.vim $HOME/.vimutopia/vimrc-c.vim
    if [ $? != 0 ]
    then
        error "Can't copy a script"
    fi
    cp doc/help-c.man $HOME/.vimutopia/doc/help-c.man
    if [ $? != 0 ]
    then
        error "Can't copy a doc"
    fi
    echo "autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp source $HOME/.vimutopia/vimrc-c.vim" >> $HOME/.vimrc
    if [ $? != 0 ]
    then
        error "Can't append line in .vimrc file"
    fi
}

function install_specific_dependencies
{
    for package in $packages
    do
        if [ $package == "Python" ]
        then
            install_python_dependencies
        fi
        if [ $package == "C" ]
        then
            install_c_dependencies
        fi
    done
}

function finished
{
    dialog --title "Aviso"               \
        --msgbox "Instalação concluída!" \
        0 0
    clear
}

function main
{
    install_global_dependencies
    warning
    copy_importtant_files
    select_packages
    install_specific_dependencies
    finished
}

main
