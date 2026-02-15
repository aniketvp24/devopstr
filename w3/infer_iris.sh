#!/bin/bash
source .env

curl -X POST "$IP_ADDRESS:$PORT/predict" \
    -H "Content-Type: application/json" \
    -d '{"sepal_length": 6.7, "sepal_width": 3.1, "petal_length": 4.4, "petal_width": 1.4}'