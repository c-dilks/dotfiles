#!/bin/bash
# convert latex file to png
# dependencies: 
# - pdflatex
# - ImageMagick (for convert command)

if [ $# -lt 1 ]; then
  echo "USAGE $0 [tex file] [density(default=150)]"
  exit
fi

texfile=$1
pdffile=$(echo $texfile | sed 's/\.tex$/.pdf/g')
pngfile=$(echo $texfile | sed 's/\.tex$/.png/g')

density=150
if [ $# -gt 1 ]; then density=$2; fi

# typeset PDF
pdflatex \
-interaction=nonstopmode \
-output-directory=$(dirname $texfile) \
$1

# use super-sampling density
ssDensity=$(echo "4*$density" | bc)

convert \
-trim -border 0 \
-bordercolor white +adjoin \
-density ${ssDensity}x${ssDensity} +antialias \
-resize 25% \
-channel RGBA \
-background white -alpha remove -alpha off \
$pdffile $pngfile
#-transparent white \
