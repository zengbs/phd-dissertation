rm -rf *.aux *.bbl *.blg *.log *.out *.pdf *.lof *.lot *.xwm

SRC=thesis.tex

filename=$(basename -- "$SRC")
extension="${filename##*.}"
filename="${filename%.*}"


xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex
bibtex    ${filename}.aux
xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex
xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex
