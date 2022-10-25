#!/bin/bash 

# Print scheduled maintenance messages from statuspage API

body=$(curl --silent 'https://status.saucelabs.com/api/v2/scheduled-maintenances/upcoming.json')
length=$(echo $body | jq '.scheduled_maintenances | length')

x=0
while [ $x -lt $length ]
do
    jq_snippet=".scheduled_maintenances[$x].incident_updates[0]"
    echo $body | jq 'if '$jq_snippet'.status == "scheduled" then '$jq_snippet'.body else empty end' 
    printf "\n"
    x=$(( $x + 1 ))
done
