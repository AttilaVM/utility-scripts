#!/bin/sh

srcDir=$1
dstDir=$2

x="x"

if [ "$1" == "" ]; then
		echo "No source directory argument"
		exit
fi

if [ "$2" == "" ]; then
		echo "No destionation directory argument"
		exit
fi

widths=$(echo "320 375 425 768 1024 1440 1920" | tr " " "\n")

cd "$srcDir"

newScaleStr=""
counter="0"
for f in *.png; do
		baseName=$(echo "$f" | sed 's/\.png$//')
		originalImgWidth=$(identify "$f" \
													 | tr " " "\n" \
													 | sed -n '/^[0-9]*x[0-9]*$/p' \
													 | sed 's|x[0-9]*||g')
		
		for width in ${widths}; do
				newScale=$(echo "$originalImgWidth*$width/1920" | bc)
				convert "$f" -resize "$newScale$x$newScale" "$dstDir/$baseName-$newScale.png"
				convert "$f" -resize "$newScale$x$newScale" "$dstDir/$baseName-$newScale.webp"
				if [ "$counter" -lt "1" ]; then
						newScaleStr="$newScaleStr $newScale"
				fi
		done
		counter=$((counter+1))
done

echo "$newScaleStr"
