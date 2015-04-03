MAIN=main
SOURCES=$(MAIN).tex sections/*.tex
OUT=main.pdf
PDFLATEX=pdflatex
BIBTEX=bibtex

all: $(SOURCES) $(OUT)

$(OUT): $(SOURCES)
	$(PDFLATEX) $(MAIN).tex
	$(BIBTEX) $(MAIN)
	$(PDFLATEX) $(MAIN).tex
	$(PDFLATEX) $(MAIN).tex

.PHONY: clean
clean:
	rm -f main.pdf
