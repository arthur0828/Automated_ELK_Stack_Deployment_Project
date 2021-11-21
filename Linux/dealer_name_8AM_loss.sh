#!/bin/bash 


#!/bin/bash 


echo "Dealer Playing During 8AM Losses | Dates of: May 10, May 12, May 15"
cat 031* | grep "08:00:00 AM" | awk -F " " '{print $1, $2, $5, $6}'

