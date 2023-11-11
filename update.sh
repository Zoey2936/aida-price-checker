#!/bin/sh

if [ -z "$TZ" ] || ! echo "$TZ" | grep -q "^[A-Za-z/]\+$"; then
    echo "TZ is unset or invalid."
    sleep inf
fi

if [ -z "$CI" ] ||! echo "$CI" | grep -q "^[0-9]\+[smhd]\?$"; then
    echo "CI needs to be a number which can be followed by one of the chars s, m, h or d."
    sleep inf
fi

if [ -z "$AID" ] || ! echo "$AID" | grep -q "^[A-Z0-9]\+$"; then
    echo "AID is unset or invalid."
    sleep inf
fi

if [ -z "$AAK" ] || ! echo "$AAK" | grep -q "^[A-Za-z0-9]\+$"; then
    echo "AAK is unset or invalid."
    sleep inf
fi

if [ -z "$AA" ] || ! echo "$AA" | grep -q "^[0-9]\+$"; then
    echo "AA is unset or invalid."
    sleep inf
fi

if [ -z "$AJ" ] || ! echo "$AJ" | grep -q "^[0-9]\+$"; then
    echo "AJ is unset or invalid."
    sleep inf
fi

if [ -z "$AC" ] || ! echo "$AC" | grep -q "^[0-9]\+$"; then
    echo "AC is unset or invalid."
    sleep inf
fi

if [ -z "$CUA" ] || ! echo "$CUA" | grep -q "^[A-Za-z0-9/().;: -]\+$"; then
    echo "CUA is unset or invalid."
    sleep inf
fi

if [ -z "$ACIDs" ] || ! echo "$ACIDs" | grep -q "^[A-Z ]\+$"; then
    echo "ACIDs is unset or invalid."
    sleep inf
fi

if [ -z "$ACAIIDs" ] || ! echo "$ACAIIDs" | grep -q "^[A-Z ]\+$"; then
    echo "ACAIIDs is unset or invalid."
    sleep inf
fi

if [ -z "$TBT" ] || ! echo "$TBT" | grep -q "^[A-Za-z0-9:]\+$"; then
    echo "TBT is unset or invalid."
    sleep inf
fi

if [ -z "$TCID" ] || ! echo "$TCID" | grep -q "^[0-9]\+$"; then
    echo "TCID is unset or invalid."
    sleep inf
fi


while true; do


message="\
$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID" -A "$CUA" -H "x-api-key: $AAK" | jq -r .itinerary[].name) \
ab \
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID" -A $CUA -H "x-api-key: $AAK" | jq -r .startDate)" \n\
"
export message

for ACID in $(echo "$ACIDs" | tr " " "\n"); do

message="\
$message\
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIO%2CPREMIUM" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACID"'") | .priceModel')" \
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIO%2CPREMIUM" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACID"'") | .head')": \
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIO%2CPREMIUM" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACID"'") | .price')"€ \n\
"
export message

done


for ACAIID in $(echo "$ACAIIDs" | tr " " "\n"); do

message="\
$message\
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIOAI%2CPREMIUMAI" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACAIID"'") | .priceModel')" \
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIOAI%2CPREMIUMAI" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACAIID"'") | .head')": \
"$(curl -s "https://iris.cruise-api.aida.de/cruises/$AID?adults=$AA&juveniles=$AJ&children=$AC&priceModels=VARIOAI%2CPREMIUMAI" -A $CUA -H "x-api-key: $AAK" | jq -r '.cabinCategories[] | select(.id == "'"$ACAIID"'") | .price')"€ \n\
"
export message

done

echo "$message"


curl -X POST \
     -H 'Content-Type: application/json' \
     -d '{"chat_id": "'"$TCID"'", "text": "'"$message"'", "disable_notification": true}' \
     https://api.telegram.org/bot"$TBT"/sendMessage

sleep "$CI"
done
