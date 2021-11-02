#!/bin/sh

# This script helps me update my dot files regularly
# It exists in my anacrontab as:
#
# @daily  10      setup.dotfile_backup            su -c /home/gilfewster/dotfile_backup/scripts/backup.sh - shubham1172 >> /home/shubham1172/.anacronlogs 2>&1

cd ${HOME}/dotfile_backup/

BACKUP=${HOME}/dotfile_backup/scripts/dotfile_backup_list

timestamp() {
  date +"%d-%m-%Y at %T"
}

grep -v '^$\|^\s*\#' $BACKUP | while read -r line; do
	echo "$line" | awk '{ system("rsync " $1 " " $2) }'
done

if [[ `git status --porcelain` ]]; then
	git pull origin master
	git add .
	git commit -m "automatic update: $(timestamp)"
	git push origin master
fi