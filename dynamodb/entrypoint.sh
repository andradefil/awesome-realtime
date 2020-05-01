#!/bin/bash
aws dynamodb create-table --cli-input-json file://create-table-platform-transactions.json --endpoint-url http://localhost:8000
