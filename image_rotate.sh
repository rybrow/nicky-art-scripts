#!/bin/bash

document_scanner_id="hp"
scanner1_id="pixma"

document_scanner_image="document_scanner.jpg"
scanner1_image="scanner1.jpg"
scanner1_output_image="scanner1_output.jpg"
result_image="result.jpg"

sleep_random() {
    min_sleep=$1
    max_sleep=$2
    interval=$(shuf -i$min_sleep-$max_sleep -n1)
    sleep $interval
}

scan_image() {
    echo "Scanning from $1 outputting to $2"
    scanimage --format jpeg --resolution 300 --device $1 $3 > $2
    convert $2 -rotate 90 $2
}

send_to_screen() {
    echo "Displaying $1 on $(echo $2 | cut -d. -f1) screen"
    cp $1 $2
}

echo "Performing Scanner Healthchecks"
scan_image $document_scanner_id $scanner1_image "--resolution 300dpi"
scan_image $scanner1_id $scanner1_output_image 

echo "Populating Result Image"
cp $scanner1_output_image $result_image

echo "starting screens"
eog -n $scanner1_image &
xdotool search --name "Image Viewer" set_window --name $scanner1_image
wmctrl -r $scanner1_image -e 1,0,0,-1,-1


eog -n $result_image &
xdotool search --name "Image Viewer" set_window --name $result_image
wmctrl -r $result_image -e 1,1366,0,-1,-1


while true
do    
    echo "Scanning Document Image"

    scan_image "hp" $document_scanner_image "--resolution 300dpi"
    send_to_screen $document_scanner_image $scanner1_image
    sleep_random 5 10

    scan_image "pixma" $scanner1_output_image
    send_to_screen $scanner1_output_image $result_image
    sleep_random 10 15
done