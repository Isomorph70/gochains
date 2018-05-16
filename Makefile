
INSTALLEXECPATH = /usr/local/bin
INSTALLDATAPATH = $(HOME)

clean:
	rm -f *~ *\.lt*
.PHONY: clean

install:
	cp -ru gochains-data $(INSTALLDATAPATH)/.gochains-data
	sudo cp -u todays_tasks.sh writechainslog.sh log2matrix.rb log2tab.rb today.rb log2svg.erb $(INSTALLEXECPATH)/	
	echo 'export GOCHAINSPATH=$(INSTALLEXECPATH)' >>$(HOME)/.bashrc
	echo 'export GOCHAINSDATA=$(INSTALLDATAPATH)/.gochains-data' >>$(HOME)/.bashrc
