# HTML5 Static Website Builder

An example HTML file has been generated so you can see results. 

The important script is the `process_page.sh` shell script which calls `process_page.py` with the necessary arguments for an xslt fiile and target file. 

To add a page, simply create an XML file in the root folder, add a link to the target page in the `ents/navigation.xml` and then add your data to the XML file. Follow the page DTD. 

Once you are happy you can generate an individual file using the `./process_page.sh <newpage>.xml` which will generate `<newpage>.html`. 

You can use `./update_site.sh` to convert all XML to HTML files. 

You can use `./update_videos.sh` to create ogg theora video files from mp4 (h264) videos in `./videos` this requires ffmpeg installed.

A template version of a generated website can be viewed on github:
http://bazwilliams.github.com/website_builder/
