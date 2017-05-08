<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wkattachment="http://www.wkpublisher.com/xml-namespaces/attachment"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:wkdoc="http://www.wkpublisher.com/xml-namespaces/document">

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="my-page" page-width="297mm"
                                       page-height="210mm" margin-top="0.5cm" margin-bottom="0.5cm"
                                       font-size="4pt" font-family="sans-serif">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="my-page">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="attachment">
        <xsl:variable name="src" select="@src"/>
        <fo:block margin="10pt">
            <fo:inline background-color="#FDFBF4" border="1 solid black" padding="5pt" font-weight="bold">
            <fo:basic-link color="blue" internal-destination="url(embedded-file:{$src})">
                <xsl:value-of select="wkattachment:metadata/description"/>
            </fo:basic-link>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <xsl:template match="heading">
        <fo:block font-weight="bold">
            <xsl:choose>
                <xsl:when test="@flow-type=paragraph">
                    <fo:block font-size="8pt" line-height="8pt" space-after="8pt">
                        <xsl:apply-templates/>
                    </fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>

                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
   </xsl:template>

    <xsl:template match="wkdoc:level" >
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="para">
        <xsl:choose>
            <xsl:when test="@align">
                <xsl:variable name="align" select="@align"/>
                <fo:block font-size="8pt" margin-left="3pt" line-height="8pt" space-after="8pt" text-align="{$align}">
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block font-size="8pt" margin-left="3pt" line-height="8pt" space-after="8pt">
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="italic">
        <fo:inline font-style="italic">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="bold">
        <fo:inline font-weight="bold">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="cite-ref">
        <xsl:variable name="url" select="@search-value"/>
        <fo:basic-link color="blue" internal-destination="{$url}">
           <xsl:apply-templates/>
        </fo:basic-link>
    </xsl:template>

    <xsl:template match="wlink">
        <xsl:variable name="url" select="@target-url"/>
        <fo:basic-link color="blue" external-destination="{$url}">
            <xsl:apply-templates/>
        </fo:basic-link>
    </xsl:template>

    <xsl:template match="xhtml:table">
        <xsl:variable name="border" select="@border"/>
        <xsl:variable name="width" select="@width"/>
        <xsl:variable name="cellpadding" select="@cellpadding"/>
        <xsl:variable name="cellspacing" select="@cellspacing"/>
        <fo:table border="{$border} solid black" width="{$width}">
            <fo:table-body>
                <xsl:for-each select="xhtml:tr">
                    <fo:table-row>
                        <xsl:for-each select="xhtml:td">
                            <fo:table-cell padding="{$cellpadding}" space-after="{$cellspacing}">
                                <fo:block>
                                    <xsl:apply-templates/>
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                    </fo:table-row>
            </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="note">
        <fo:block margin="10pt" padding="5pt" background-color="#F8F8F8" border="1 solid black">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h1">
        <fo:block font-size="10pt"  margin-left="3pt" line-height="10pt" space-after="10pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="unordered-list">
        <fo:list-block>
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="list-item">
        <fo:list-item space-before="12pt">
            <fo:list-item-label end-indent="label-end()">
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body  start-indent="body-start()">
                <xsl:apply-templates/>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="block-quote">
        <fo:block start-indent="1cm" end-indent="1cm">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>