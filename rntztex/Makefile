# Copy this Makefile to where your .tex files are and change $(RNTZTEXDIR) to
# point to rntztex's directory and this Makefile will still work.
RNTZTEXDIR := .

# The TEXINPUTS environment variable tells TeX where to find .sty and .cls
# files. This is necessary if you set RNTZTEXDIR to something other than ".".
export TEXINPUTS := $(RNTZTEXDIR):

# Path to latexrun.
LATEXRUN := $(RNTZTEXDIR)/latexrun/latexrun

# By default, try to build every tex file in this directory.
# Customize $(TEXS) to change this.
TEXS  := $(wildcard *.tex)
PDFS  := $(addsuffix .pdf,$(basename $(TEXS)))

.PHONY: all watch clean FORCE
all: $(PDFS)

# If you have inotify-tools, this will automatically recompile your pdfs "live".
# It's a bit overenthusiastic, though; it reruns `make` when ANYTHING changes.
watch: all
	@while inotifywait -e modify -r . >/dev/null 2>&1; do \
		echo; \
		make --no-print-directory -j all; \
	done

%.pdf: %.tex FORCE
	$(LATEXRUN) $<

# pdfbook (it's in texlive-extra-utils on Ubuntu) combines pages to make a
# zine-style booklet. For example, if foo.pdf is formatted for A5 paper,
# foo-book.pdf will be A4. You can print it out, cut or fold down the middle,
# and staple the pages together.
#
# To get A5-formatted output, try \usepackage[a5paper]{geometry} or
# \usepackage[a5]{rntzgeometry}.
%-book.pdf: %.pdf
	pdfbook $<

clean:
	$(LATEXRUN) --clean-all
	rm -r latex.out

# debugging: `make print-FOO` will print the value of $(FOO)
.PHONY: print-%
print-%:
	@echo $*=$($*)
