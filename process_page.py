#!/usr/bin/python

# Author: Barry John Williams
# Creative Commons Attribute-Share Alike 2.5 UK:Scotland Licence

import sys;
import os;
import flickrapi;
from lxml import etree

api_key = "b1734bd76001217414b2fbdde16cda7c"

html_escape_table = {
	"&": "&amp;",
	'"': "&quot;",
	"'": "&apos;",
	">": "&gt;",
	"<": "&lt;",
	}

def html_escape(text):
	"""Produce entities within text."""
	return "".join(html_escape_table.get(c,c) for c in text)

def getFlickrImage(photoid, flickrPhoto):
	"""Given the Flickr Photo ID, this will return an etree XML element adhering to the dtd for an image tag"""
	title = flickrPhoto.find('title').text

	description = flickrPhoto.find('description').text
	if description == None:
		description = ""

	secret = flickrPhoto.get("secret")
	#filetype = flickrPhoto.get("originalformat")
	large_filename = photoid + "_" + secret +".jpg"
	small_filename = photoid + "_" + secret +"_s.jpg"
	farm = flickrPhoto.get("farm")
	server = flickrPhoto.get("server")
	large_url = "http://farm%s.staticflickr.com/%s/%s" % (farm, server, large_filename)
	small_url = "http://farm%s.staticflickr.com/%s/%s" % (farm, server, small_filename)

	url = flickrPhoto.find("urls/url")
	phototype = url.get("type")
	if phototype == "photopage":
		photopage=url.text
		html_link = "<br><a href=\"%s\">%s</a>" % (photopage, photopage)
	linked_description = "%s%s" % (description, html_link)

	imageElement = etree.Element("image")
	imageElement.set("title",title)
	imageElement.set("description",linked_description)
	imageElement.set("url",large_url)
	imageElement.set("thumburl",small_url)

	return imageElement

def convertFlickrElement(flickrElement):
	photoid = flickrElement.get("photoid")
	imageElement = etree.Element("image")
	if (photoid != ''):
		response = flickr.photos_getInfo(photo_id=photoid)
		imageElement.set("title",photoid)
		if response.get('stat') == 'ok':
			imageElement = getFlickrImage(photoid, response.find('photo'))
		group = flickrElement.get("group")
		imageElement.set("group",group)
	return imageElement

if __name__ == '__main__':
	xml  = sys.argv[1]
	xslt = sys.argv[2]

	flickr = flickrapi.FlickrAPI(api_key=api_key)
	parser = etree.XMLParser(dtd_validation=True)	

	xsltDoc = etree.parse(xslt);
	xsl = etree.XSLT(xsltDoc);

	xmlDoc = etree.parse(xml, parser);
	
	for sectionElements in xmlDoc.getroot().iterchildren("section"):
		for flickrfeatureElement in sectionElements.iterchildren("flickrfeature"):
			imageElement = convertFlickrElement(flickrfeatureElement)
			flickrfeatureElement.append(imageElement)
		for textElements in sectionElements.iterchildren("text"):
			for flickrElement in textElements.iterchildren("flickr"):
				imageElement = convertFlickrElement(flickrElement)
				flickrElement.append(imageElement)
	print xsl(xmlDoc);
