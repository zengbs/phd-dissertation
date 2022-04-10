MAIN=thesis
LATEX=xelatex
BIBTEX=bibtex
RM=rm -f
NTU_WATERMARK_LINK=https://www.lib.ntu.edu.tw/doc/CL/watermark.pdf

.SUFFIXES: .tex

ifdef PASSWORD
all: $(MAIN).pdf $(MAIN)-with-pass.pdf
else
all: $(MAIN).pdf
endif

ifdef WATERMARK
TEXFLAG+="\def\withwatermark{1} "
endif

ifdef DOI
TEXFLAG+="\def\withdoi{1} "
endif

ifdef CERTIFICATION
TEXFLAG+="\def\withcertification{1} "
endif

ifdef FIRSTPAGE
TEXFLAG+="\def\firstpage{1} "
else
TEXFLAG+="\def\excludefirstpage{1} "
endif

TEXFLAG+="\input{$(MAIN)}"

$(MAIN).pdf: *.tex ntuthesis.cls
ifdef WATERMARK
	./download.sh $(NTU_WATERMARK_LINK) watermark.pdf
endif
	$(LATEX) -interaction=nonstopmode -shell-escape $(MAIN)
	$(BIBTEX) $(MAIN)
	$(LATEX) -interaction=nonstopmode -shell-escape $(MAIN)
	$(LATEX) -interaction=nonstopmode -shell-escape $(MAIN)

ifdef PASSWORD
$(MAIN)-with-pass.pdf: $(MAIN).pdf
	pdftk $^ output $@ owner_pw "$(PASSWORD)" allow printing allow ScreenReaders
endif

clean:
	$(RM) *.log *.aux *.dvi *.lof *.lot *.toc *.bbl *.blg *.pdf *.out

clean-pdf:
	$(RM) -f $(MAIN).pdf $(MAIN)-with-pass.pdf

clean-all: clean clean-pdf
