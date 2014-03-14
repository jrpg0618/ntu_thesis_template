# =====================
# Jiahong K. Chen
# Created on 2014/01/18
# =====================

# =====================
# Compilers
# =====================

TEXBINPATH	= /usr/texbin

LATEX 	 	= $(TEXBINPATH)/latex
PDFLATEX 	= $(TEXBINPATH)/pdflatex
BIBTEX		= $(TEXBINPATH)/bibtex
MAKEINDEX	= $(TEXBINPATH)/makeindex
#PDFTOPS		= /usr/local/bin/pdf2ps
PDFTOPS		= /usr/local/bin/pdftops
MV			= mv
RM			= rm

# =====================
# Compiler Flags
# =====================

OUTPUTDIR	= build

LATFLAGS	= --output-directory=$(OUTPUTDIR) -interaction=nonstopmode %.tex
PDFFLAGS	= --output-directory=$(OUTPUTDIR) -shell-escape -synctex=1 -interaction=nonstopmode
BIBFLAGS	= 
INDEXFLAGS	= -s nomencl.ist

TARGET		= Thesis

all: buildThesis

buildThesis: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex
	-( mkdir $(OUTPUTDIR) )
	-$(PDFLATEX) $(PDFFLAGS) $<
	-$(BIBTEX) $(BIBFLAGS) $(OUTPUTDIR)/$(TARGET).aux
	-$(PDFLATEX) $(PDFFLAGS) $<
	-$(MAKEINDEX) $(OUTPUTDIR)/$(TARGET).nlo $(INDEXFLAGS) -o $(OUTPUTDIR)/$(TARGET).nls
	-$(PDFLATEX) $(PDFFLAGS) $<
	-$(MV) $(OUTPUTDIR)/$(TARGET).pdf .
	-$(PDFTOPS) $@ $(TARGET).ps

$(TARGET).ps: $(TARGET).tex
	-$(LATEX) $(LATFLAGS) $<
	-$(BIBTEX) $(BIBFLAGS) $(OUTPUTDIR)/$(TARGET).aux
	-$(LATEX) $(LATFLAGS) $<
	-$(MAKEINDEX) $(OUTPUTDIR)/$(TARGET).nlo $(INDEXFLAGS) -o $(OUTPUTDIR)/$(TARGET).nls
	-$(LATEX) $(LATFLAGS) $<
	-$(MV) $(OUTPUTDIR)/$(TARGET).pdf .


clean:
	-$(RM) -f *.pdf *.ps
#	-(cd $(OUTPUTDIR) && $(RM) $(TARGET).*)


#"/usr/texbin/pdflatex" --output-directory=build -shell-escape -synctex=1 -interaction=nonstopmode $TARGET.tex
#"/usr/texbin/bibtex" build/$TARGET.aux
#"/usr/texbin/pdflatex" --output-directory=build -shell-escape -synctex=1 -interaction=nonstopmode $TARGET.tex
#"/usr/texbin/makeindex" build/$TARGET.nlo -s nomencl.ist -o build/$TARGET.nls
#"/usr/texbin/pdflatex" --output-directory=build -shell-escape -synctex=1 -interaction=nonstopmode $TARGET.tex

#mv build/$TARGET.pdf .

#if [ $(HOSTNAME) != "iMac439tekiiMac.local" ]; then
#    open $TARGET.pdf
#fi

