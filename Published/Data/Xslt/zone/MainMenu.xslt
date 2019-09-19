<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <ul class="menulink">
      <xsl:apply-templates select="/ZoneList/Zone"></xsl:apply-templates>
    </ul>
  </xsl:template>

  <xsl:template match="Zone">
    <xsl:choose>
      <xsl:when test="count(Zone) > 0">
        <li class="hassub">
          <xsl:if test="IsActive='true'">
            <xsl:attribute name="class">
              <xsl:text>hassub active</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="Url"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:value-of select="Target"></xsl:value-of>
            </xsl:attribute>
            <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
          </a>
          <xsl:if test="count(Zone) > 0">
            <div class="btn-showsub">
              <i class="fa fa-angle-right" aria-hidden="true"></i>
            </div>
            <div class="mega">
              <ul class="sub">
                <div class="titlewrap">
                  <div class="btn-closesub">
                    <i class="fa fa-angle-left" aria-hidden="true"></i>
                  </div>
                  <span>
                    <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
                  </span>
                </div>
                <xsl:apply-templates select="Zone" mode="Child"></xsl:apply-templates>
              </ul>
            </div>
          </xsl:if>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li>
          <xsl:if test="IsActive='true'">
            <xsl:attribute name="class">
              <xsl:text>active</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="Url"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:value-of select="Target"></xsl:value-of>
            </xsl:attribute>
            <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
          </a>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="Zone" mode="Child">
    <li>
      <xsl:if test="IsActive='true'">
        <xsl:attribute name="class">
          <xsl:text>active</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="Url"></xsl:value-of>
        </xsl:attribute>
        <xsl:attribute name="target">
          <xsl:value-of select="Target"></xsl:value-of>
        </xsl:attribute>
        <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>