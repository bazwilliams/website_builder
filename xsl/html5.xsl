<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="utf-8" indent="yes" />

<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>

<html>
<!-- HTML Header -->
<head>
      <meta http-equiv="Content-Type" content="text/html; charset=us-ascii"/>
      <title><xsl:value-of select="page/title"/></title>
      <link rel="stylesheet" href="stylesheets/screen.css" type="text/css" media="screen"/>

      <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
      <script src="js/lightbox.js" type="text/javascript"></script>

      <xsl:comment><![CDATA[[if lt IE 9]><script src="js/html5shiv.js"></script><![endif]]]></xsl:comment>
</head>
			
<body>
<header>
<hgroup>
<h1><a href="index.html"><xsl:value-of select="page/title"/></a></h1>
</hgroup>
</header>

	<xsl:apply-templates select="page/section"/>
	
	<!-- Section for a google advert -->	
	<section id="base_advert">
	<article>
        <script type="text/javascript">
          <xsl:comment>
            google_ad_client = "";
            google_ad_slot = "";
            google_ad_width = 300;
            google_ad_height = 250;
          </xsl:comment>
        </script>
	<!--
        <script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
	-->
      </article>
    </section>
    <footer id="validation">
	<a href="http://www.w3.org/html/logo/"><img src="http://www.w3.org/html/logo/badge/html5-badge-h-css3-multimedia-semantics.png" width="197" height="64" alt="HTML5 Powered with CSS3 / Styling, Multimeddia and Semantics" title="HTML5 Powered with CSS3 / Styling, Multimedia and Semantics"/></a>
    </footer>

    <xsl:apply-templates select="page/nav"/>

		</body>
	</html>
</xsl:template>

<xsl:template match="nav">
	<nav>
	<xsl:apply-templates select="url"/>
	</nav>
</xsl:template>

<xsl:template match="section">
	<section>
	<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
	<hgroup>
	  <h2><xsl:value-of select="@name"/></h2>
	</hgroup>
	<article>
	<xsl:apply-templates select="text"/>
	<xsl:if test="flickrfeature">
	<div class="media">
		<xsl:apply-templates select="flickrfeature/image"/>
	</div>
	</xsl:if>
	<xsl:apply-templates select="map"/>
	</article>
	</section>
</xsl:template>

<xsl:template match="text">
	<xsl:apply-templates select="header"/>
	<xsl:apply-templates select="subheader"/>
	<xsl:apply-templates select="value"/>
	<xsl:if test="image or flickr">
	<div class="media">
		<xsl:apply-templates select="image"/>
		<xsl:apply-templates select="flickr/image"/>
	</div>
	</xsl:if>
	<xsl:if test="video">
	<div class="media">
		<xsl:apply-templates select="video"/>
	</div>
	</xsl:if>
	<xsl:if test="url">
	<div class="urls">
		<xsl:apply-templates select="url"/>
	</div>
	</xsl:if>
</xsl:template>

<xsl:template match="subheader">
	<div class="subheader">
		<p><xsl:value-of select="."/></p>
	</div>
</xsl:template>

<xsl:template match="header">
	<header>
		<hgroup>
		  <h3><xsl:value-of select="."/></h3>
		</hgroup>
	</header>
</xsl:template>

<xsl:template match="value">
	<p><xsl:value-of select="."/></p>
</xsl:template>

<xsl:template match="url">
	<p><a>
	<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
	<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
	<xsl:value-of select="@title"/>
	</a></p>
</xsl:template>

<xsl:template match="flickrfeature/image">
  <div class="imagefeature">
	<a>
	<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
	<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
	<xsl:attribute name="rel">lightbox[<xsl:value-of select="@group"/>]</xsl:attribute>
	<img class="feature">
	<xsl:attribute name="src"><xsl:value-of select="@url"/></xsl:attribute>
	<xsl:attribute name="alt"><xsl:value-of select="@description"/></xsl:attribute>
	</img>
	</a>
  </div>
</xsl:template>

<xsl:template match="video">
  <div class="video">
    <video controls="controls">
      <xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
      <xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
      <source type="video/mp4">
        <xsl:attribute name="src">videos/<xsl:value-of select="@name"/>.mp4</xsl:attribute>
      </source>
      <source type="video/ogg">
        <xsl:attribute name="src">videos/<xsl:value-of select="@name"/>.ogv</xsl:attribute>
      </source>
      Your browser does not support the video tag.
    </video>
    <p><xsl:value-of select="@description"/></p>
  </div>
</xsl:template>

<xsl:template match="image">
  <div class="imagethumb">
	<a>
	<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
	<xsl:attribute name="title"><xsl:value-of select="@description"/></xsl:attribute>
	<xsl:attribute name="rel">lightbox[<xsl:value-of select="@group"/>]</xsl:attribute>
	<div class="thumb">
	<img class="thumb">
	<xsl:attribute name="src"><xsl:value-of select="@thumburl"/></xsl:attribute>
	<xsl:attribute name="alt"><xsl:value-of select="@description"/></xsl:attribute>
	</img>
	</div>
	<p class="imagetext"><xsl:value-of select="@title"/></p>
	</a>
  </div>
</xsl:template>

<xsl:template match="map">
<div class="media">
<div class="map">
<iframe>
	<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
	<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
	<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
</iframe>
</div>
</div>
</xsl:template>
</xsl:stylesheet>
