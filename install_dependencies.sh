apt-get install -y dialog
apt-get install -y python-setuptools ipython python-dev
easy_install pip
pip install should_dsl specloud
apt-get install -y gcc

if [ ! -d deps ]
then
    mkdir deps
fi
cd deps
if [ ! -f ncurses-5.9.tar.gz ]
then
    wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz
    tar -zxvf ncurses-5.9.tar.gz
fi
cd ncurses-5.9
./configure
make
make install
cd ../..
./install_vim.sh
