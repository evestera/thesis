# Mostly intended as documentation and for one-off compilation.
# For writing it is usually better to use a proper tool.

.PHONY: default deploy
default: main.pdf

forside.pdf: forside/forside.tex
	cd forside; xelatex -output-directory=.. $<

main.pdf: main.tex forside.pdf chapters/*.tex fonts.tex
	lualatex -shell-escape $<
	biber $(basename $<)
	lualatex -shell-escape $<
	lualatex -shell-escape $<

# Make ctags for Atom. Unescape backslashes due to Atom bug.
tags: chapters/*.tex
	ctags -R -V --fields=+KS **/*.tex
	perl -pi -e 's/\\\\/\\/g' tags

.deploy-%: %
	scp $< vestera.as:/home/erik/www/thesis
	touch $@

DEPLOYABLES = index.html main.pdf
deploy: $(foreach DEPLOYABLE,$(DEPLOYABLES),.deploy-$(DEPLOYABLE))
