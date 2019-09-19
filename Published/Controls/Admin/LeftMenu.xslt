<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <div id="sidebar-wrapper" class="col-lg-2 col-md-3 col-sm-4">
            <section class="navigation" role="navigation">
                <!-- <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarsubCMS" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <div class="navbar-brand">MENU</div>
                </div> -->
                <div class="panel-group navbar-collapse collapse" role="tablist" id="navbarsubCMS">
                    <div class="panel panel-primary">
                        <xsl:apply-templates select="/MenuList/Menu"></xsl:apply-templates>
                    </div>
                </div>
            </section>
        </div>
    </xsl:template>

    <xsl:template match="Menu">
        <div class="panel-heading" role="tab">
            <xsl:attribute name="id">
                <xsl:text>collapse_Heading_</xsl:text>
                <xsl:value-of select="position()"></xsl:value-of>
            </xsl:attribute>
            <h4 class="panel-title">
                <a data-toggle="collapse" aria-expanded="false">
                    <xsl:choose>
                        <xsl:when test="IsActive='true'">

                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">
                                <xsl:text>collapsed</xsl:text>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="href">
                        <xsl:text>#CMS_Menu_</xsl:text>
                        <xsl:value-of select="position()"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:attribute name="aria-controls">
                        <xsl:text>collapse_Menu_</xsl:text>
                        <xsl:value-of select="position()"></xsl:value-of>
                    </xsl:attribute>
                    <xsl:if test="CssClass!=''">
                        <i>
                            <xsl:attribute name="class">
                                <xsl:value-of select="CssClass"></xsl:value-of>
                                <xsl:if test="IsActive='true'">
                                    <xsl:attribute name="class">
                                        <xsl:text> fa-rotate-180</xsl:text>
                                    </xsl:attribute>
                                </xsl:if>
                            </xsl:attribute>
                        </i>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
                    <!--<i class="fa fa-chevron-circle-down pull-right"></i>-->
                </a>
            </h4>
        </div>
        <div class="panel-collapse collapse" role="tabpanel" aria-expanded="false">
            <xsl:if test="IsActive='true'">
                <xsl:attribute name="class">
                    <xsl:text>panel-collapse collapse in</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
                <xsl:text>CMS_Menu_</xsl:text>
                <xsl:value-of select="position()"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="aria-labelledby">
                <xsl:text>collapse_Heading_</xsl:text>
                <xsl:value-of select="position()"></xsl:value-of>
            </xsl:attribute>
            <xsl:if test="count(Menu)>0">
                <ul class="list-group">
                    <xsl:apply-templates select="Menu" mode="Sub"></xsl:apply-templates>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="Menu" mode="Sub">
        <li class="list-group-item">
            <xsl:if test="IsActive='true'">
                <xsl:attribute name="class">
                    <xsl:text>list-group-item active</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <a href="#">
                <xsl:if test="Url != ''">
                    <xsl:attribute name="href">
                        <xsl:value-of select="Url"></xsl:value-of>
                    </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="target">
                    <xsl:value-of select="Target"></xsl:value-of>
                </xsl:attribute>
                <i class="fa fa-caret-right"></i>
                <!--<xsl:if test="CssClass!=''">
                    <i>
                        <xsl:attribute name="class">
                            <xsl:value-of select="CssClass"></xsl:value-of>
                        </xsl:attribute>
                    </i>
                    <xsl:text> </xsl:text>
                </xsl:if>-->
                <xsl:value-of select="Title" disable-output-escaping="yes"></xsl:value-of>
            </a>
        </li>
    </xsl:template>
</xsl:stylesheet>