<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:local="local"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:output indent="yes"/>
  
  <!--<xsl:param name="url" as="xs:string"/>-->
  
  <xsl:template match="*:body">
    <div id="tdm">
      <!--<p>TDM de <xsl:value-of select="$url"/></p> -->
      <!--<textarea>
        <xsl:copy-of select="$getAllTitles"/>
      </textarea>-->
      <xsl:variable name="getAllTitles" select="./descendant::*[local:isTitle(.)]" as="element()*"/>
      <ul>
        <xsl:for-each-group select="$getAllTitles" group-starting-with="*:h1">
          <xsl:if test="current-group()[1]/self::*:h1">
            <li>
              <xsl:apply-templates select="current-group()[1]"/>
              <xsl:if test="current-group()[local:isTitle(.)]">
                <ul>
                  <xsl:for-each-group select="current-group()" group-starting-with="*:h2">
                    <xsl:if test="current-group()[1]/self::*:h2">
                      <li>
                        <xsl:apply-templates select="current-group()[1]"/>
                        <xsl:if test="current-group()[local:isTitle(.)]">
                          <ul>
                            <xsl:for-each-group select="current-group()" group-starting-with="*:h3">
                              <xsl:if test="current-group()[1]/self::*:h3">
                                <li>
                                  <xsl:apply-templates select="current-group()[1]"/>
                                  <xsl:if test="current-group()[local:isTitle(.)]">
                                    <ul>
                                      <xsl:for-each-group select="current-group()" group-starting-with="*:h4">
                                        <xsl:if test="current-group()[1]/self::*:h4">
                                          <li>
                                            <xsl:apply-templates select="current-group()[1]"/>
                                            <xsl:if test="current-group()[local:isTitle(.)]">
                                              <ul>
                                                <xsl:for-each-group select="current-group()" group-starting-with="*:h5">
                                                  <xsl:if test="current-group()[1]/self::*:h5">
                                                    <li>
                                                      <xsl:apply-templates select="current-group()[1]"/>
                                                      <xsl:if test="current-group()[local:isTitle(.)]">
                                                        <ul>
                                                          <xsl:for-each-group select="current-group()" group-starting-with="*:h6">
                                                            <xsl:if test="current-group()[1]/self::*:h6">
                                                              <li>
                                                                <xsl:apply-templates select="current-group()[1]"/>
                                                              </li>
                                                            </xsl:if>
                                                          </xsl:for-each-group>
                                                        </ul>
                                                      </xsl:if>
                                                    </li>
                                                  </xsl:if>
                                                </xsl:for-each-group>
                                              </ul>
                                            </xsl:if>
                                          </li>
                                        </xsl:if>
                                      </xsl:for-each-group>
                                    </ul>
                                  </xsl:if>
                                </li>
                              </xsl:if>
                            </xsl:for-each-group>
                          </ul>
                        </xsl:if>
                      </li>
                    </xsl:if>
                  </xsl:for-each-group>
                </ul>
              </xsl:if>
            </li>
          </xsl:if>
        </xsl:for-each-group>
      </ul>
    </div>
  </xsl:template>
  
  <xsl:template match="*[local:isTitle(.)]">
    <a href="javascript:gotoTitle('{@id}');">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>
  
  <xsl:function name="local:isTitle" as="xs:boolean">
    <xsl:param name="e" as="element()"/>
    <xsl:sequence select="local-name($e) = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6')"/>
  </xsl:function>
  
  <xsl:function name="local:getTitleLevel" as="xs:integer">
    <xsl:param name="e" as="element()"/>
    <xsl:choose>
      <xsl:when test="local:isTitle($e)">
        <xsl:sequence select="xs:integer(substring-after(local-name($e), 'h'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="-1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:template match="text()"/>
  
</xsl:stylesheet>