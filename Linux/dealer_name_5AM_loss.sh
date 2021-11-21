#!/bin/bash 


echo "Dealer Playing During 5AM Losses | Dates of: May 10, May 12, May 15"
cat 031* | grep "05:00:00 AM" | awk -F " " '{print $1, $2, $5, $6}'
