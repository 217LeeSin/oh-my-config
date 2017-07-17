#!/usr/bin/env bash

SECONDS=0
START=$(date '+%Hh%M')

echo "This scripts measure How many seconds last the script"

echo "Press any key when you are ready"

read a

END=$(date '+%Hh%M')
if [ $SECONDS -ge 60 ] ; then
        echo "$START, $END, $[$SECONDS / 60] min"
else
        echo "$START, $END, $SECONDS sec"
fi

echo
