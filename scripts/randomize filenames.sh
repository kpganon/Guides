#!/bin/bash
for i in *.{jpg,png,gif,webm,mp4,mkv}; do

variable1=$(echo $(date +%s));
variable2=$(shuf -i 1-100000 -n 1);
filename=$(($variable1 + $variable2));
extension=$(echo "$i"|awk -F . '{print $NF}');
mv "$i" "$filename.$extension";

done
