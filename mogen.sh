#!/bin/bash
PATH="./"

MSGFMT="/usr/bin/msgfmt"

lng_dirs=$(/bin/ls $PATH)

for i in $lng_dirs  ; do
 if [ -d $PATH/$i ] ; then

 echo "=====[$i]====="

   if [ -f $PATH/$i/LC_MESSAGES/flirteka.mo ] ; then
       /bin/rm $PATH/$i/LC_MESSAGES/flirteka.mo
   fi

   # build .mo
   $MSGFMT -cv -o $PATH/$i/LC_MESSAGES/flirteka.mo $PATH/$i/LC_MESSAGES/flirteka.po
 fi
done