#!/bin/sh

# This script helps me update my dot files regularly
cd ${HOME}/dotfile_backup/

timestamp() {
  date +"%d-%m-%Y at %T"
}

# while IFS= read -r line; do
#     echo "Text read from file: $line"
# done < grep -v '^$\|^\s*\#' | scripts/backup_list

grep -v '^$\|^\s*\#' scripts/backup_list | while read -r line; do
	echo "$line"
done

# grep -v '^$\|^\s*\#' $BACKUP | while read -r line; do
# 	echo "$line" | awk '{ system("rsync " $1 " " $2) }'
# done

if [[ `git status --porcelain` ]]; then
	{
		git pull origin main
		git add .
		git commit -m "automatic update: $(timestamp)"
		git push origin main
	} >/dev/null
	echo "Synced local dotfiles to github repo"
else
	echo ""
	exit 0
fi
