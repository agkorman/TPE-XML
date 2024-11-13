<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- main template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Congress Page</title>
            </head>
            <body>
                <xsl:call-template name="title"/>
                <xsl:call-template name="chambers"/>
            </body>
        </html>
    </xsl:template>

    <!-- title template -->
    <xsl:template name="title">
        <h1 align="center">
            <xsl:value-of select="data/congress/name"/>
        </h1>
        <h3 align="center">
            From <xsl:value-of select="substring-before(data/congress/period/@from, '-')" /> to 
            <xsl:value-of select="substring-before(data/congress/period/@to, '-')"/>
        </h3>
        <hr/>
    </xsl:template>

    <!-- chamber template -->
    <xsl:template name="chambers">
        <xsl:for-each select="data/congress/chambers/chamber">
            <h2 align="center">
                <xsl:value-of select="name"/>
            </h2>
            <xsl:choose>
                <xsl:when test="count(./members/member) = 0">
                    <p align="center">No members information available.</p>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="members-table"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="sessions-table"/>
            <hr/>
        </xsl:for-each>
    </xsl:template>

    <!-- member table template -->
    <xsl:template name="members-table">
        <h4 align="center">Members</h4>
            <table border="1" frame="1" align="center">
                <xsl:call-template name="member-header"/>
                <tbody>
                    <xsl:for-each select="members/member">
                        <xsl:call-template name="member-row"/>
                    </xsl:for-each>
                </tbody>
            </table>
    </xsl:template>

    <!-- member table header template -->
    <xsl:template name="member-header">
        <thead bgcolor="grey">
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>State</th>
                <th>Party</th>
                <th>Period</th>
            </tr>
        </thead>
    </xsl:template>

    <!-- member table row template -->
    <xsl:template name="member-row">
        <tr>
            <td>
                <img height="50" width="50">
                    <xsl:attribute name="src">
                        <xsl:value-of select="image_url"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        X
                    </xsl:attribute>
                </img>
            </td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="state"/></td>
            <td><xsl:value-of select="party"/></td>
            <td>
                From <xsl:value-of select="period/@from"/>
                <xsl:choose>
                    <xsl:when test="string-length(period/@to) > 0">
                        to <xsl:value-of select="period/@to"/>
                    </xsl:when>
                </xsl:choose>

            </td>
        </tr>
    </xsl:template>

    <!-- session table template -->
    <xsl:template name="sessions-table">
        <h4 align="center">Sessions</h4>
        <table border="1" frame="1" align="center">
            <xsl:call-template name="session-header"/>
            <tbody>
                <xsl:for-each select="sessions/session">
                    <xsl:call-template name="session-row"/>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- session table header template -->
     <xsl:template name="session-header">
        <thead bgcolor="grey">
            <tr>
                <th>Number</th>
                <th>Type</th>
                <th>Period</th>
            </tr>
        </thead>
     </xsl:template>

    <!-- session table row template -->
    <xsl:template name="session-row">
        <tr>
            <td>
                <xsl:value-of select="number"/>
            </td>
            <td>
                <xsl:value-of select="type"/>
            </td>
            <td>
                From <xsl:value-of select="period/@from"/> to 
                <xsl:value-of select="period/@to"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
