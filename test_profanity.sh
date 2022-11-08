#!/bin/env bash

result=$( grep -ir -e fuck -e blödmann -e depp -e dummkopf **/*.adoc )

if [ -n "$result" ]; then
    echo "Profanity detected, watch your language"
    exit 1
else
    echo "Text is clean!"
fi
