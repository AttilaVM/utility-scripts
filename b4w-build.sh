#!/bin/sh

if [ ! -r ".b4w_project" ];then
		echo "No b4w_project file in working directory"
		exit
fi

python3 project.py build || exit
cd build || exit

buildIgnoreContent=$(cat ../.buildignore \
												 | sed 's|#.*$||g' \
												 | sed '/^\s*$/d')

for globExpr in ${buildIgnoreContent}; do
    rm -vrf "$globExpr"
done
