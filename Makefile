# Mostly intended as documentation and for one-off compilation.
# For writing it is usually better to use a proper tool.

.PHONY: default deploy
default: main.pdf

forside.pdf: forside/forside.tex
	cd forside; xelatex -output-directory=.. $<

main.pdf: main.tex forside.pdf chapters/*.tex
	xelatex -shell-escape $<
	biber $(basename $<)
	xelatex -shell-escape $<
	xelatex -shell-escape $<

.deploy-%: %
	scp $< vestera.as:/home/erik/www/thesis
	touch $@

DEPLOYABLES = index.html main.pdf
deploy: $(foreach DEPLOYABLE,$(DEPLOYABLES),.deploy-$(DEPLOYABLE))
