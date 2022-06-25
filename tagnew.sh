#!/usr/bin/env bash
DIR="${0%/*}"

cat $DIR/tags.csv | while read line; do
    secondString=" "
    newRow="${line//,/$secondString}"
    newRowArray=($newRow)
    AwsEvnt=${newRowArray[0]}
    AccountID=${newRowArray[1]}
    AccountName=${newRowArray[2]}
    costcenter=${newRowArray[3]}
    billto=${newRowArray[4]}
    productowner=${newRowArray[5]}
    TechnicalContact=${newRowArray[6]}
    businessowner=${newRowArray[7]}
    operationsgroup=${newRowArray[8]}
    environment=${newRowArray[9]}
    if [[ $AccountID == "93********" ]]; then
        echo "Account ID $AccountID"
        aws organizations tag-resource \
        --resource-id $AccountID \
        --region us-east-1 \
        --tags Key="cost-center",Value=$costcenter Key="bill-to",Value=$billto Key="product-owner",Value=$productowner Key="business-owner",Value=$businessowner Key="operations-group",Value=$operationsgroup Key="environment",Value=$environment
    fi
done