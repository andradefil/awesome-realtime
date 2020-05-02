#!/bin/bash
aws dynamodb create-table --region=us-east-1 --cli-input-json file://create-table-platform-transactions.json --endpoint-url http://localhost:8000
