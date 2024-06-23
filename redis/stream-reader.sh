#!/bin/bash

read -p "Enter the Redis stream name: " STREAM_NAME
LAST_ID="$"

while true; do
    NEW_MESSAGES=$(redis-cli XREAD BLOCK 0 STREAMS $STREAM_NAME $LAST_ID)
    echo "$NEW_MESSAGES"
done
