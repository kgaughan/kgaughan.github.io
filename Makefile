PELICAN=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/src/content
CONFFILE=$(BASEDIR)/src/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/src/publishconf.py

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make regenerate                  regenerate files upon modification '
	@echo '   make publish                     generate using production settings '
	@echo '   make serve                       serve site at http://localhost:8000'
	@echo '                                                                       '


html: clean $(BASEDIR)/index.html
	@echo 'Done'

$(BASEDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(BASEDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	rm -rf $(BASEDIR)/theme $(BASEDIR)/feeds
	find $(BASEDIR) -depth -name \*.html -delete

regenerate: clean
	$(PELICAN) -r $(INPUTDIR) -o $(BASEDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
	cd $(BASEDIR) && python -m SimpleHTTPServer

publish:
	$(PELICAN) $(INPUTDIR) -o $(BASEDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

.PHONY: html help clean regenerate serve publish
