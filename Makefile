main:
	./warning.sh
	if [ -f $(HOME)/.vimrc ]; then rm $(HOME)/.vimrc; fi
	cp vimrc $(HOME)/.vimrc
	if [ -d $(HOME)/.vimrc-dumal ]; then rm -Rf $(HOME)/.vimrc-dumal; fi
	mkdir $(HOME)/.vimrc-dumal
	cp src/* $(HOME)/.vimrc-dumal/
