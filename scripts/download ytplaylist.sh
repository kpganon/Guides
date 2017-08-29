#!/bin/bash
echo $(%%DATESTAMP%%)

YOUTUBE_DL_PATH=/path/to/youtube-dl.exe
VIDEO_FOLDER=/path/to/downloads
ARCHIVE=/path/to/archive.txt

# Your Youtube playlist.
PLAYLIST=

# https://stackoverflow.com/a/1401495/4480674
CURRENT_DATE=`%%DATESTAMP%%`

# https://stackoverflow.com/a/6225730/4480674
# https://stackoverflow.com/a/44234944/4480674
if pgrep youtube-dl &> /dev/null 2>&1; then
    echo "youtube-dl is running"
    exit 1
fi

$YOUTUBE_DL_PATH \
    --ignore-errors \
    --download-archive $ARCHIVE \
    --write-sub \
    --embed-subs \
    --output $VIDEO_FOLDER/$CURRENT_DATE"__%(uploader)s__%(title)s.%(ext)s" \
    $PLAYLIST
