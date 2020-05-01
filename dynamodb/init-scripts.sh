#!/bin/bash
scripts_path="/init-scripts"

if [ -z "$(ls -A $scripts_path)" ]; then
    echo "DynamodDB init scripts was not found, skipping..."
else
    echo "DynamodDB init scripts was found!"
    cd $scripts_path
    for f in ./*.sh; do
        echo "Running script ${f}" &&\
        exec "$f" || break
    done
fi