<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:search="http://marklogic.com/appservices/search"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  version="2.0">

  <xsl:output indent="yes"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="search:search/search:response"/>
  </xsl:template>
  
  <xsl:template match="search:response">
    <xsl:variable name="total" select="@total" as="xs:integer"/>
    <xsl:variable name="page-length" select="@page-length" as="xs:integer"/>
    <xsl:variable name="start" select="@start" as="xs:integer"/>
    <xsl:variable name="idivisionTotal" select="$total idiv $page-length"/>
    <xsl:variable name="moduloTotal" select="$total mod $page-length"/>
    <xsl:variable name="nombre-de-page" select="$idivisionTotal + (if ($moduloTotal = 0) then(0) else(1))"/>
    <xsl:variable name="idivisionStart" select="$start idiv $page-length"/>
    <xsl:variable name="moduloStart" select="$start mod $page-length"/>
    <xsl:variable name="page-courante" select="$idivisionStart + (if ($moduloStart = 0) then(0) else(1))"/>
    <div class="debug" style="color:grey">
      <p>$idivisionTotal : <xsl:value-of select="$idivisionTotal"/></p>
      <p>$moduloTotal : <xsl:value-of select="$moduloTotal"/></p>
      <p>nombre-de-page : <xsl:value-of select="$nombre-de-page"/></p>
      <p>page-courante : <xsl:value-of select="$page-courante"/></p>
    </div>
    <div id="pagination">
      <xsl:for-each select="1 to $nombre-de-page">
        <a href="page-{.}">
          <xsl:choose>
            <xsl:when test=". = $page-courante">
              <b><xsl:value-of select="."/></b>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
        <xsl:if test="not(position() = last())">&#160;</xsl:if>
      </xsl:for-each>
    </div>
  </xsl:template>
  
</xsl:stylesheet>