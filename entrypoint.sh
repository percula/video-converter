#!/bin/sh -l

OIFS="$IFS"
IFS=$'\n'
for IN in `find $1 -iname "*.*"`
do
OUT=${IN/$1/$3}
DIR=$(dirname $OUT)
FILE_NAME="${IN##*/}"
FILE_EXTENSION="${FILE_NAME##*.}"
mkdir -p "$DIR"
if [ ! -f $OUT ]; then
echo "Converting $IN"
ffmpeg -i $IN -vf "fps=15,scale=720:-1" -q:v 30 -compression_level 6 -loop 0 -acodec copy -vcodec copy ${OUT/$FILE_EXTENSION/$2}
else
echo "Converted already."
fi

done
IFS="$OIFS"
