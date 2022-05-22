rm -rf *.aux *.bbl *.blg *.log *.out  *.lof *.lot *.xwm

SRC=thesis.tex

filename=$(basename -- "$SRC")
extension="${filename##*.}"
filename="${filename%.*}"


xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex
bibtex    ${filename}.aux
xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex
xelatex  -interaction=nonstopmode  -shell-escape ${filename}.tex

pdftk thesis.pdf background watermark.pdf output output.pdf
mv output.pdf thesis.pdf
pdftk thesis.pdf cat 9-10 output abstract.pdf
