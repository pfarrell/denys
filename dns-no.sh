#!/bin/bash

hostfile=/etc/hosts
redir=127.0.0.1
markermsg="#dns-no.sh said no on"
date=`date -u '+%Y/%m/%d %H:%M:%S %Z'`
block=$1
regex=$redir.*$block.*$markermsg.*

#parse out date added (if dns-no.sh added the data)
olddate=`grep "$regex" $hostfile | sed -e "s:.*$markermsg \(.*\):\1:g"`

# exit if we're already blocking
if [[ -n "$olddate" ]]; then
  echo "You've been blocking $block since $olddate.  Good for you."
  exit;
fi

#test if file is writeable
echo "$redir $1 $markermsg $date" >> $hostfile
echo "Goodbye $block... you're now blocked in the hosts file."

