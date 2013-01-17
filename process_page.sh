#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

TARGETFOLDER=./template
FILENAME=$1
NAME=${FILENAME%\.*}
python process_page.py ${NAME}.xml xsl/html5.xsl > ${TARGETFOLDER}/${NAME}.html
echo "Processed ${NAME}"
