#!/bin/bash
PATH="/home/site/app/locale"
SOURCES="/home/site/app"

MSGFMT="/usr/bin/msgfmt"
XGETTEXT="/usr/bin/xgettext"
MSGMERGE="/usr/bin/msgmerge"

lng_dirs=$(/bin/ls $PATH)

for i in $lng_dirs  ; do
 if [ -d $PATH/$i ] ; then

 echo "=====[$i]====="

   if [ -f $PATH/$i/LC_MESSAGES/flirteka.mo ] ; then
       /bin/rm $PATH/$i/LC_MESSAGES/flirteka.mo
   fi

   # scan source code and make .po files
   echo '' > $PATH/$i/LC_MESSAGES/messages.po
   /usr/bin/find $SOURCES -type f -iname "*.php" | $XGETTEXT --output-dir=$PATH/$i/LC_MESSAGES --from-code=UTF-8 -j -f -
   $MSGMERGE -N $PATH/$i/LC_MESSAGES/flirteka.po $PATH/$i/LC_MESSAGES/messages.po > $PATH/$i/LC_MESSAGES/new.po #merge with previous .po
   /bin/mv $PATH/$i/LC_MESSAGES/new.po $PATH/$i/LC_MESSAGES/flirteka.po
   /bin/rm $PATH/$i/LC_MESSAGES/messages.po


   # remove comments from .po files
   /bin/cat $PATH/$i/LC_MESSAGES/flirteka.po | /bin/grep -vE '^#' > $PATH/$i/LC_MESSAGES/flirteka_res.po
   /bin/mv $PATH/$i/LC_MESSAGES/flirteka_res.po $PATH/$i/LC_MESSAGES/flirteka.po

   # build .mo
  # $MSGFMT -cv -o $PATH/$i/LC_MESSAGES/flirteka.mo $PATH/$i/LC_MESSAGES/flirteka.po
 fi
done
