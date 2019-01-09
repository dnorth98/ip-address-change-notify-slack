#!/bin/bash

slack_url=$1
channel=$2
username=$3

ipfile='/home/pi/ipaddress'

[[ -f "$ipfile" ]] && ipold="$(< "$ipfile" )"
ipnew="$( wget -q -O - checkip.dyndns.org | sed -e 's/.*Current IP Address: //;s/<.*$//' )"

if [ ! -e "$ipfile" ]; then
	echo $ipnew > $ipfile
	$ipold="$ipnew"
fi

if [[ "$ipold" != "$ipnew" ]]; then
	echo "The external IP has changed"
	echo $ipnew > $ipfile

	text="The Office external IP has changed from $ipold to $ipnew. The whitelist in AWS will need updating"
	escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )

	json="{\"username\": \"$username\", \"icon_emoji\": \":heavy_exclamation_mark:\", \"channel\": \"#$channel\", \"text\": \"$escapedText\"}"

	curl -s -d "payload=$json" "$slack_url"
fi
