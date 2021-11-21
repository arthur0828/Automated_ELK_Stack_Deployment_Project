#!/bin/bash 


echo "Dealer Playing During 11PM Losses | Dates of: May 10, May 12, May 15"
cat 031* | grep "11:00:00 PM" | awk -F " " '{print $1, $2, $5, $6}'

