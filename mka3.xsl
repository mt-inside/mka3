<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <!-- Strip whitespace in input, otherwise we get spurious #text nodes that
         confuse position() -->
    <xsl:strip-space elements="*" />

    <xsl:include href="matrix-transpose.xsl" />

    <!-- no current-date() function in xslt 1.0. No xslt 2.0 proc in cygwin -->
    <xsl:param name="date" />

    <xsl:output method="html" version="4.0" indent="yes" encoding="UTF-8" />

    <xsl:template match="/a3">
    <html>
        <title><xsl:value-of select="@project" /> A3 Report</title>
        <head>
            <link rel="stylesheet" href="layout.css" />
            <link rel="stylesheet" href="presentation.css" />
        </head>

        <body>
            <div id="title" class="section_outer">
                <p class="title"><xsl:value-of select="@project" /></p>
                <p class="subtitle"><xsl:value-of select="$date" /></p>
                <p class="subtitle"><xsl:value-of select="@author" /></p>
            </div>

            <xsl:call-template name="section">
                <xsl:with-param name="title">plan</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">checks</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">issues</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">risks</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">improvements</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">recognition</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">summary</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">snapshot</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">escalations</xsl:with-param>
            </xsl:call-template>

            <xsl:call-template name="section">
                <xsl:with-param name="title">icons</xsl:with-param>
            </xsl:call-template>

        </body>
    </html>
    </xsl:template>

    <!-- Sections -->

    <!--
      "*[name() = $title]" (all nodes such that the name is $title) is the closest xslt comes to an eval() function.
      alternativley, take a node-set param and reverse-lookup the name, i.e. $title = <xsl:value-of select="name($nodes)" />
    -->
    <xsl:template name="section">
        <xsl:param name="title" />
        <xsl:variable name="nodes" select="document(concat('data/', $title, '.xml'))/*[name() = $title]" />

        <div class="section_outer">
            <xsl:attribute name="id"><xsl:value-of select="$title" /></xsl:attribute>
            <div class="section_inner">
                <xsl:call-template name="title">
                    <xsl:with-param name="title"><xsl:value-of select="$title" /></xsl:with-param>
                </xsl:call-template>
                <xsl:apply-templates select="$nodes" />
            </div>
        </div>
    </xsl:template>

    <!-- Section titles -->

    <xsl:template name="title">
        <xsl:param name="title" />
        <div class="section_title"><span><xsl:value-of select="$title" /></span></div>
    </xsl:template>

    <!-- Plan -->

    <xsl:template match="plan">
        <xsl:apply-templates select="root" />
    </xsl:template>

    <!-- Checks -->

    <xsl:template match="checks">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Issues -->

    <xsl:template match="issues">
        <table>
            <thead>
                <tr>
                    <th>Issue</th>
                    <th>Impact</th>
                    <th>Action</th>
                    <th>Resolution</th>
                    <th>Owner</th>
                </tr>
            </thead>
            <xsl:apply-templates match="issue" />
        </table>
    </xsl:template>

    <xsl:template match="issue">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="position() mod 2 = 1">odd</xsl:when>
                    <xsl:otherwise>even</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td><xsl:value-of select="name" /></td>
            <td><xsl:value-of select="impact" /></td>
            <td><xsl:value-of select="action" /></td>
            <td><xsl:value-of select="resolution" /></td>
            <td><xsl:value-of select="owner" /></td>
        </tr>
    </xsl:template>

    <!-- Risks -->

    <xsl:template match="risks">
        <table>
            <thead>
                <tr>
                    <th>Risk</th>
                    <th>Likeli</th>
                    <th>Impact</th>
                    <th>Action</th>
                    <th>Resolution</th>
                    <th>Owner</th>
                </tr>
            </thead>
            <xsl:apply-templates match="risk" />
        </table>
    </xsl:template>

    <xsl:template match="risk">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="position() mod 2 = 1">odd</xsl:when>
                    <xsl:otherwise>even</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td><xsl:value-of select="name" /></td>
            <td><xsl:value-of select="likelihood" /></td>
            <td><xsl:value-of select="impact" /></td>
            <td><xsl:value-of select="action" /></td>
            <td><xsl:value-of select="resolution" /></td>
            <td><xsl:value-of select="owner" /></td>
        </tr>
    </xsl:template>

    <!-- Improvements -->

    <xsl:template match="improvements">
        <ul>
            <xsl:apply-templates select="improvement[status='DONE']" />
            <xsl:apply-templates select="improvement[status='DOING']" />
        </ul>
    </xsl:template>

    <xsl:template match="improvement">
        <li>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="status = 'DONE'">done</xsl:when>
                    <xsl:when test="status = 'DOING'">doing</xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="name" />
        </li>
    </xsl:template>

    <!-- Recognition -->

    <xsl:template match="recognition">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Summary -->

    <xsl:template match="summary">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Snapshot -->

    <xsl:template match="snapshot">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Escalations -->

    <xsl:template match="escalations">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Utils -->

    <xsl:template match="item">
        <li><xsl:value-of select="." /></li>
    </xsl:template>

</xsl:stylesheet>
