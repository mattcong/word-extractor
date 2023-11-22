#!/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    printf "Usage: $0 [path_to_text_file] [flag]

    If the name of your text file contains spaces, make sure to enclose it in double quotes.
    For example: ./a text file.txt should be \"./a text file.txt\".

    Currently the script only accepts the --remove-stop-words flag. More text analysis operations will be added in the future."
    exit 1
fi

INPUT_FILE=$1
FLAG=$2

STOP_WORDS="the and or but an in to on at if a b c d e f g h i j k l m n o p q r s t u v w x y z"

TOKENISED_WORDS=$(cat "$INPUT_FILE" | tr -cs '[:alpha:]' '\n' | sort | uniq)

if [ "$FLAG" = "--remove-stop-words" ]; then
    for word in $STOP_WORDS; do
        TOKENISED_WORDS=$(echo "$TOKENISED_WORDS" | grep -vwi "^$word$")
    done
fi

OUTPUT_FILE="${INPUT_FILE%".txt"}_words.txt"

echo "$TOKENISED_WORDS" >"$OUTPUT_FILE"

printf "Word list saved to $OUTPUT_FILE"
