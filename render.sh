#!/bin/env bash

# Test if output directory exists
if [[ ! -d "./output" ]]
then
    echo "ERROR: missing output directory (./output)"
    exit 1
fi

# run asciidoctor
asciidoctor index.adoc --out-file ./output/story.html
