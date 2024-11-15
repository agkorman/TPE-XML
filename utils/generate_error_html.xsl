<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Congress Page</title>
            </head>
            <body>
                <h1>Errors</h1>
                <ul>
                    <xsl:for-each select="data/error">
                        <xsl:call-template name="error-template"/>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="error-template">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

</xsl:stylesheet>
