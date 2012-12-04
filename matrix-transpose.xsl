<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:template match="root">

        <!-- Find the longest <col> -->
        <xsl:variable name="max_col_id">
            <xsl:for-each select="col">
                <xsl:sort select="count(cell)" data-type="number" order="descending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="generate-id()" />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="columns" select="col" />

        <table>
            <!-- heading for all <col>s with @titles -->
            <tr>
                <xsl:apply-templates select="$columns/@title" />
            </tr>

            <!-- one row for each child of the longest column -->
            <xsl:for-each select="col[generate-id() = $max_col_id]/cell">
                <xsl:variable name="pos" select="position()" />
                <tr>
                    <!-- one row cell for each column -->
                    <xsl:for-each select="$columns">
                        <td>
                            <xsl:value-of select="cell[position() = $pos]" />
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="col/@title">
        <th>
            <xsl:value-of select="." />
        </th>
    </xsl:template>

</xsl:stylesheet>
