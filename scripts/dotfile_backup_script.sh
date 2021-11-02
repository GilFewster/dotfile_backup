#!/bin/sh

# This script helps me update my dot files regularly

cd ${HOME}/dotfile_backup/

BACKUP=${HOME}/dotfile_backup/scripts/backup_list

timestamp() {
  date +"%d-%m-%Y at %T"
}

grep -v '^$\|^\s*\#' $BACKUP | while read -r line; do
	echo "$line" | awk '{ system("rsync " $1 " " $2) }'
done

if [[ `git status --porcelain` ]]; then
	git pull origin main
	git add .
	git commit -m "automatic update: $(timestamp)"
	git push origin main
fi