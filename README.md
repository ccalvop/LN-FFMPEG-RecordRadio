# LN-FFMPEG-RecordRadio
Automatically record an online radio station with bash script and ffmpeg in Linux

# Online Radio Recorder - Bash & FFmpeg
This project allows you to **automatically record an online radio station** using **Bash and FFmpeg**.  
It captures **continuous 59-minute 59-second recordings** without losing seconds between clips.  
Perfect for **archiving music, analyzing trends, or preserving electronic music styles over the decades**.

## Why Bash & FFmpeg?
Bash is lightweight and perfect for automation on Linux servers.

FFmpeg is a powerful multimedia tool, supporting multiple audio formats and stream capturing.

Together, they provide a simple yet effective solution for continuous recording.

---

## Features
- **Fully automated** recording process
- **Waits until the next full hour** to ensure alignment
- **Records continuously** without time gaps
- **Custom file names** with timestamps for easy organization
- **Runs on any Linux server** (cloud instances recommended)

---

## Requirements
You need **FFmpeg** installed on your system.

### **Install FFmpeg (Ubuntu/Debian)**
```bash
sudo apt update && sudo apt install -y ffmpeg
```

---

### **Create the Script**

```bash
nano record_radio.sh
```

```bash
#!/bin/bash

# Create the recordings directory if it does not exist
mkdir -p recordings

# Radio stream URL
URL="http://listen.trancebase.fm/tunein-mp3"

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
```

---

## Make the script executable
```bash
chmod +x record_radio.sh
```

## Run the script
```bash
./record_radio.sh
```

---

## Running in the Background (tmux)
```bash
tmux new -s radio
```
## Run the script
```bash
./record_radio.sh
```

**Detach from tmux** without stopping the script: Press CTRL + B, then D

Reattach to the session later: 
```bash
tmux attach -t radio
```

---

## Stop the script manually
```bash
tmux kill-session -t radio
```

---

## Accessing Recordings
All recorded audio files are stored in the recordings/ folder with a timestamped

## Downloading all files from a remote server
If running on a cloud instance, you can download all files using scp: 
```bash
scp -r user@your-server-ip:/path/to/recordings/ ./local-folder/
```

## Future Improvements
Add recording schedules (e.g., only record at specific hours or days).

Implement a web interface for managing recordings remotely.

Allow custom recording durations via script parameters.
