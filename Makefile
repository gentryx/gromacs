#!gmake
#
# Makefile for man pages
#
RM	=	/bin/rm -f
RMDIR	=	/bin/rm -rf
TOUCH	=	/usr/bin/touch
SHELL	=	/bin/csh

CHMOD	=	chmod 664
TEX	=	latex
BIB	=	bibtex
IDX	=	makeindex -s hfill.ist
DVIPS	=	dvips

LOCAL	=	$(GMXHOME)/src/local
HTML	=	$(GMXHOME)/html

TEXFS = algorithms	analyse		averages	cutoff		\
	defunits	files		forcefield	ieee		\
	implement	install		intro		lr-corr		\
	lr_elstat	macros		mdp_opt		par-md		\
	proglist	progman		programs	special		\
	sqrt		tables		topolfig	topology	\
	virial

AUXFS = algorithms	analyse		averages	defunits	\
	forcefield	implement	install		intro		\
	lr-corr		par-md		progman		programs	\
	special		tables		topology	

AUXFILES = $(foreach FILE,$(AUXFS), $(FILE).aux)
TEXFILES = $(foreach FILE,$(TEXFS), $(FILE).tex)

all:		gromacs.ps

full:		man all

dvi:		gromacs.dvi

#
# make a booklet, i.e. 4 pages onto one double-sided page.
# To get the booklet, rearrange the pages according to page numbering 
# and fold in the middle
#
booklet:	gromacs.ps
		pstops "4:-3L@.7(21cm,0)+0L@.7(21cm,14.85cm),1L@.7(21cm,0)+-2L@.7(21cm,14.85cm)" $^ booklet.ps

gromacs.tex:	$(TEXFILES)

gromacs.aux:	gromacs.tex $(AUXFILES)
		$(TEX) gromacs

bib+idx:	gromacs.tex
		$(TEX) gromacs
		$(BIB) gromacs
		$(IDX) gromacs

gromacs.dvi:	bib+idx		gromacs.aux

gromacs.ps:	gromacs.dvi
		dvips -M -o $@ $^

%.aux:		%.tex

prog:		mdp_opt.tex proglist.tex

man:		./mkman

progman.tex:	
		$(TOUCH) progman.tex

mdp_opt.tex:	./mkmdp
		./mkmdp $(GMXHOME)

proglist.tex:	$(LOCAL)/mkonline $(LOCAL)/programs.txt
		cd $(LOCAL) ; ./mkonline $(GMXHOME)

man:		
		mkman

clean:
		$(RM) *.log *.lof *.lot *.bbl *.blg *.toc *.dvi *.aux *.ps *~ #*# *.idx *.ilg *.ind 
		$(RM) progman.tex
		$(RMDIR) progman
