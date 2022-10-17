#!/bin/bash
#Source: https://github.com/gflorian/shlinkify
# 
#Credits
#https://raw.githubusercontent.com/shlinkio/shlink-open-api-specs/main/specs/v3.3.1/open-api-spec.json
#https://www.brianchildress.co/named-parameters-in-bash/

DOMAIN=example.com
APIKEY=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

sD=${sD:-} #startDate
eD=${eD:-} #endDate
iPP=${iPP:-100} #itemsPerPage, default: 10
p=${p:-} #page, default: 1
sT=${sT:-} #searchTerm
oB=${oB:-dateCreated-ASC} #orderBy, default: dateCreated-DESC

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

[ "$sD" == "today" ] && sD=$(date -I)
[ -z "$sD" ] || OPTIONS="startDate=$sD"

[ -z "$eD" ] || OPTIONS="$OPTIONS&endDate=$eD"

[ -z "$iPP" ] || OPTIONS="$OPTIONS&itemsPerPage=$iPP"

[ -z "$p" ] || OPTIONS="$OPTIONS&page=$p"

[ -z "$sT" ] || OPTIONS="$OPTIONS&searchTerm=$sT"

[ "$oB" == "normal" ] && oB="dateCreated-DESC"
[ -z "$oB" ] || OPTIONS="$OPTIONS&orderBy=$oB"

curl \
	-H 'X-Api-Key: '"$APIKEY" \
	-H 'accept: application/json' \
	'https://'"$DOMAIN"'/rest/v3/short-urls?'"$OPTIONS" | jq -C
