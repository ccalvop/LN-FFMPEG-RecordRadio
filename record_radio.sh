#!/bin/bash

# Create the recordings directory if it does not exist
mkdir -p recordings

# Radio stream URL
URL="YOUR URL RADIO STATION, EXAMPLE: http://listen.trancebase.fm/tunein-mp3"

# Recording duration: 59 minutes 59 seconds
DURATION=3599

# Wait until the next full hour before starting
CURRENT_MINUTES=$(date +%M)
SECONDS_TO_WAIT=$(( (60 - CURRENT_MINUTES) * 60 ))
echo "Waiting $((SECONDS_TO_WAIT / 60)) minutes until the next full hour..."
sleep "$SECONDS_TO_WAIT"

# Continuous recording loop
while true; do
    # Get start and end timestamps
    START_TIME=$(date +%Y-%m-%d_%H-%M)
    END_TIME=$(date -d "+59 minutes 59 seconds" +%Y-%m-%d_%H-%M)
    
    # Filename format: recording_YYYY-MM-DD_HH-MM_to_HH-MM.mp3
    FILE="recordings/recording_${START_TIME}_to_${END_TIME}.mp3"

    echo "Recording from $START_TIME to $END_TIME..."
    ffmpeg -i "$URL" -t "$DURATION" -c copy "$FILE"
done
