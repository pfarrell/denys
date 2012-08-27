#!/bin/bash 

hostfile=/etc/hosts
redir=127.0.0.1
markermsg="#dns-no.sh said no on"
date=`date -u '+%Y/%m/%d %H:%M:%S %Z'`
block=$1
regex=$redir.*$block.*$markermsg.*

olddate=`grep "$regex" $hostfile | sed -e "s:.*$markermsg \(.*\):\1:g"`

if [[ -z "$olddate" ]]; then
  echo "You aren\'t blocking $block.  Something else must be wrong"
  exit;
fi

perl -pi -e "s:$regex\n::g" $hostfile
echo "$block should now be reenabled.  Resume wasting time."


