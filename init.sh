#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
NC='\033[0m'

source="/Users/giacomo/storage/GitHub/latex_init"

# 如果需要更新ref.bib
if [ $1 = "ref" ]; then
    code $source/ref.bib
    exit 1
fi

# 检查settings.tex文件是否存在
if [ -f "./settings.tex" ]; then
    if [ $1 = "-f" ]; then
        # 覆盖settings.tex
        cp $source/settings.tex ./
        echo "settings.tex has been updated."
    else
        echo -e "${BLUE}Source: ${NC}"$source/settings.tex
        echo -e "${YELLOW}Wanring: ${NC}settings.tex already exists in the current folder."
    fi
else
    # 复制settings.tex文件到当前目录
    cp $source/settings.tex ./
    echo "settings.tex has been copied to the current folder."
fi

############################################################

# 检查模板文件是否存在
if [ ! -f "$source/ref.bib" ]; then
    echo "Template ref.bib does not exist!"
    exit 1
fi
# 如果当前目录下的 ref.bib 不存在，则直接复制
if [ ! -f "./ref.bib" ]; then
    cp "$source/ref.bib" "./ref.bib"
    echo "ref.bib did not exist, so it has been copied from the template."
else
    # 获取修改时间（以 Unix 时间戳表示）
    TEMPLATE_MOD_TIME=$(stat -f %m "$source/ref.bib")
    CURRENT_MOD_TIME=$(stat -f %m "./ref.bib")

    # 比较时间戳
    if [ "$TEMPLATE_MOD_TIME" -gt "$CURRENT_MOD_TIME" ]; then
        chmod 644 "./ref.bib"
        cp "$source/ref.bib" "./ref.bib"
        echo "Template ref.bib is newer. Updated ref.bib."
    else
        echo "Current ref.bib is up to date. No update needed."
    fi
fi
# 设置 ref.bib 为只读
chmod 444 "./ref.bib"
# echo "Set ref.bib to read-only mode."

############################################################

# 检查main.tex文件是否存在
if ! [ -f "./main.tex" ]; then
    # 复制main.tex文件到当前目录
    cp $source/main.tex ./
    echo "main.tex has been copied to the current folder."
fi