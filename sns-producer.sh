#!/bin/bash

payload="{\
    account_id: '5665cb89-3392-4dd9-b1d1-9e6eb0fbd34b',\
    merchant_id: '5665cb89-3392-4dd9-b1d1-9e6eb0fbd34b',\
    year_month_day: '2020|04|25',\
    transaction_id: '5665cb89-3392-4dd9-b1d1-9e6eb0fbd34b',\
    card_fingerprint: 'f669a783-8c2f-4ff0-bdc9-ea343283d8cd',\
    band: 'VISA',\
    ammount: 3000,\
    ttl: 144040\
}"

while true
do
    aws sns --region us-east-1 --endpoint-url http://localhost:9911\
    publish --topic-arn arn:aws:sns:us-east-1:1465414804035:platform_transactions --message "$payload"
    sleep 1
done
