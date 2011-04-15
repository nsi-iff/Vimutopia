main: python_deps
	./warning.sh
	if [ -f $(HOME)/.vimrc ]; then rm $(HOME)/.vimrc; fi
	cp vimrc.vim $(HOME)/.vimrc
	if [ -d $(HOME)/.vimrc-dumal ]; then rm -Rf $(HOME)/.vimrc-dumal; fi
	mkdir $(HOME)/.vimrc-dumal
	cp -r src/* $(HOME)/.vimrc-dumal/
   
python_deps:
	apt-get install python-setuptools ipython vim
	easy_install pip
	pip install should_dsl specloud 

