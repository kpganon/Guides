#!/bin/bash

TEMP_DIR=/path/to/.temp/
YTDL_OUTPUT_STRING=%(uploader)s - %(title)s.%(ext)s
DEST_DIR="/path/to/downloads/folder/"
YDL_ARCHIVE=~/.config/ydlarchive.txt
PLAYLIST_URL=
RCLONE_UPLOAD=/path/to/rclone-upload.sh

/usr/local/bin/youtube-dl \
        -f bestvideo+bestaudio \
        -u [EMAIL] \
        -p [PASSWORD] \
        --ignore-config \
        --add-metadata
        --download-archive $YDL_ARCHIVE \
        $PLAYLIST_URL \
        -o $TEMP_DIR$YTDL_OUTPUT_STRING \
        && mv $TEMP_DIR* $DEST_DIR

$RCLONE_UPLOAD

echo "Last run @ $(date)" >> /etc/scripts/logs/fancams2gd.log
