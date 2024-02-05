#!/bin/bash

while true
do
    scanimage --format jpeg --resolution 300dpi > var/tmp/image.jpeg
    sleep 30
done