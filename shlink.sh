#!/bin/bash
MORE=y
DOMAIN1=example.com
DOMAIN2=another.com
APIKEY=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

while [ "$MORE" == "y" ]; do
	if [ -z "$1" ]; then
		read -p "Lang URL: " -r LONGURL
		[ -z "$LONGURL" ] && continue
		OPTIONS="{ \"longUrl\": \"$LONGURL\""
	else
		echo "Lang URL: $1"
		OPTIONS="{ \"longUrl\": \"$1\""
	fi

	read -p "Titel   : " -r TITLE
	[ ! -z "$TITLE" ] && OPTIONS="$OPTIONS, \"title\": \"$TITLE\""

	read -p "Slug    : " -r SLUG
	[ ! -z "$SLUG" ] && OPTIONS="$OPTIONS, \"customSlug\": \"$SLUG\""

	read -p "Tags    : " -r TAGS
	if [ ! -z "$TAGS" ]; then
		OPTIONS="$OPTIONS, \"tags\": ["
		TAGS=($(echo "$TAGS" | tr ',' '\n'))
		CNT=0
		for TAG in "${TAGS[@]}"; do
			if [ "$CNT" -gt "0" ]; then
				OPTIONS="$OPTIONS, \"${TAG}\""
			else
				OPTIONS="$OPTIONS \"${TAG}\""
				((CNT++))
			fi
		done
		OPTIONS="$OPTIONS ]"
	fi

	echo -e "         (1) $DOMAIN1\n         (2) $DOMAIN2"
	read -p "Domain  : " -rn 1 DOMAIN
	echo ""
	if [ "$DOMAIN" == "2" ]; then # 1 is default!
		OPTIONS="$OPTIONS, \"domain\": \"$DOMAIN2\" "
	else
		OPTIONS="$OPTIONS, \"domain\": \"$DOMAIN1\" "
	fi
	OPTIONS="$OPTIONS}"

	curl -s -X 'POST' \
	  'https://'"$DOMAIN1"'/rest/v3/short-urls' \
	  -H 'accept: application/json' \
	  -H 'X-Api-Key: '"$APIKEY" \
	  -H 'Content-Type: application/json' \
	  -d "$OPTIONS" | jq -C '. | {title: .title, shortUrl: .shortUrl, longUrl: .longUrl, tags: .tags}'
	echo ""
	read -p "Noch eine URL (y/n)? " -rn 1 MORE # n is default, z interpreted as y
	[ "$MORE" == "z" ] && MORE=y
	echo -e "\n"
done
