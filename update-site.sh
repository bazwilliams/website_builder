#!/bin/sh

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

XMLS=`ls *.xml`

for filename in $XMLS
do
	./process_page.sh $filename
done
