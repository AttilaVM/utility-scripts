#!/usr/bin/env bash

inputDir="$1"
outputFile="$2"
tileNum="$3"

imgFiles=$(find "$inputDir" -iname "*.png" \
							 | sort \
							 | tr "\n" " ")

montage $imgFiles -tile "${tileNum}x" -frame 0 -geometry +0+0 "$outputFile"
