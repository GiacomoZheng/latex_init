#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
NC='\033[0m'

source="/Users/giacomo/storage/GitHub/latex_init/settings.tex"
# 检查settings.tex文件是否存在
if [ -f "./settings.tex" ]; then
	echo -e "${BLUE}Source: ${NC}"$source
    echo -e "${YELLOW}Wanring: ${NC}settings.tex already exists in the current folder."
else
    # 复制settings.tex文件到当前目录
    cp $source ./
    echo "settings.tex has been copied to the current folder."
fi

# 检查ref.bib文件是否存在
if ! [ -f "./ref.bib" ]; then
    # 生成空的ref.bib文件
	touch ./ref.bib
	echo "An empty 'ref.bib' file has been created in the current folder."
fi
