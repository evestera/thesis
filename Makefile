# Mostly intended as documentation and for one-off compilation.
# For writing it is usually better to use a proper tool.

.PHONY: default
default: main.pdf

forside.pdf: forside.tex
	pdflatex $<

main.pdf: main.tex forside.pdf chapters/*.tex
	lualatex -shell-escape $<
	biber $(basename $<)
	lualatex -shell-escape $<
	lualatex -shell-escape $<
