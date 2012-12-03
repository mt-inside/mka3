<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <!-- no current-date() function in xslt 1.0. No xslt 2.0 proc in cygwin -->
    <xsl:param name="date" />

    <xsl:output method="html" />

    <xsl:template match="/a3">
    <html>
        <title><xsl:value-of select="@project" /> A3 Report</title>
        <head>
            <link rel="stylesheet" href="layout.css" />
            <link rel="stylesheet" href="presentation.css" />
        </head>

        <body>
            <div id="title">
                <p class="title"><xsl:value-of select="@project" /></p>
                <p class="subtitle"><xsl:value-of select="$date" /></p>
                <p class="subtitle">Author: <xsl:value-of select="@author" /></p>
            </div>

            <div id="plan">
                <xsl:apply-templates select="plan" />
            </div>

            <div id="checks">
                <xsl:apply-templates select="checks" />
            </div>

            <div id="issues">
                <xsl:apply-templates select="issues" />
            </div>

            <div id="risks">
                <xsl:apply-templates select="risks" />
            </div>

            <div id="improvements">
                <xsl:apply-templates select="improvements" />
            </div>

            <div id="recognition">
                <xsl:apply-templates select="recognition" />
            </div>

            <div id="summary">
                <xsl:apply-templates select="summary" />
            </div>

            <div id="snapshot">
                <xsl:apply-templates select="snapshot" />
            </div>

            <div id="escalations">
                <xsl:apply-templates select="escalations" />
            </div>

            <div id="icons">
            </div>

        </body>
    </html>
    </xsl:template>

    <!-- Plan -->

    <xsl:template match="plan">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Checks -->

    <xsl:template match="checks">
        <ul>
            <xsl:apply-templates select="item" />
        </ul>
    </xsl:template>

    <!-- Issues -->

    <xsl:template match="issues">
        <span class="table_title">Issues</span>
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
