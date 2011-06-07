if [ -d vim ]
then
    cd vim
else
    hg clone https://vim.googlecode.com/hg/ vim
    cd vim
    hg pull
fi
hg update
cd src
make
