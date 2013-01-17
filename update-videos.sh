#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

VIDEOS=./videos

cd $VIDEOS
MP4S=`ls *.mp4`
for filename in $MP4S
do
	OUTPUT=${filename%\.*}.ogv
	ffmpeg -i $filename -b 1000k -minrate 1000k -acodec libvorbis -vcodec libtheora $OUTPUT
done
