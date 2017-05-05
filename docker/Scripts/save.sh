#!/bin/sh
if [ ! -z $1 ]; then
  DIR=$1;
  if [ -d "backups/$DIR" ]; then
    rm -rf backups/$DIR
  fi
else
  DIR=`date +%Y-%m-%d:%H:%M:%S`;
fi
mkdir -p backups/$DIR && cp -R work/* backups/$DIR
chmod a+rw backups/$DIR
