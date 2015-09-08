# Basename for result
TARGET=diss

# Sources
SRC=diss.tex

# ATTENTION!
# File-extensions to delete recursive from here
EXTENSION=aux toc idx ind ilg log out lof lot lol bbl blg nlo nls backup

##### Targets ###############
#############################

all: ${TARGET}.pdf

# PDF
${TARGET}.pdf: ${SRC}
	echo "Running pdflatex..."
	pdflatex ${TARGET}
	echo "Running bibtex..."
	bibtex ${TARGET}
	echo "Running makeindex (for list of symbols)..."
	makeindex ${TARGET}.nlo -s nomencl.ist -o ${TARGET}.nls
	echo "Rerunning pdflatex...."
	pdflatex ${TARGET}
	pdflatex ${TARGET}
	pdflatex ${TARGET}

# Clean
clean:
	for EXT in ${EXTENSION}; \
	do \
	find `pwd` -name \*\.$${EXT} -exec rm -v \{\} \; ;\
	done
	rm -f *~
	rm -f ${TARGET}.dvi
	rm -f ${TARGET}.pdf
	rm -f ${TARGET}.ps
