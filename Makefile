PELICAN=pelican

INPUTDIR:=$(CURDIR)/content
OUTPUTDIR:=$(CURDIR)/output
CONFFILE:=$(CURDIR)/pelicanconf.py
PUBLISHCONF:=$(CURDIR)/publishconf.py

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


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE)

clean:
	rm -rf $(OUTPUTDIR)/feeds
	find $(OUTPUTDIR) -name \*.html -delete

regenerate: clean
	$(PELICAN) -r $(INPUTDIR) -o $(OUTDIR) -s $(CONFFILE)

serve:
	cd $(OUTPUTDIR) && python -m SimpleHTTPServer

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF)

gh-publish: publish
	./deploy.sh

.PHONY: html help clean regenerate serve publish
