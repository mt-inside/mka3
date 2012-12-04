<?xml version="1.0" encoding="UTF-8"?>
<!-- This file contains the logic to render a plan.
This is involved because it has to transpose the input table.
Wrapped up in this file is the matrix transpose algorithm.
Clearly this is nasty, and it should be factored out.
However a) I cba and b) with XSLT 1.0 and its lack of node-set() this is quite hard, I think
-->

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:template match="plan">

        <!-- Find the longest column -->
        <xsl:variable name="max_col_id">
            <xsl:for-each select="goal">
                <xsl:sort select="count(cell)" data-type="number" order="descending" />
                <xsl:if test="position() = 1">
                    <xsl:value-of select="generate-id()" />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="columns" select="goal" />

        <table>
            <!-- heading for all <col>s with @titles -->
            <tr>
                <xsl:apply-templates select="$columns/@title" />
            </tr>

            <!-- one row for each child of the longest column -->
            <xsl:for-each select="goal[generate-id() = $max_col_id]/cell">
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

    <xsl:template match="goal/@title">
        <th>
            <xsl:value-of select="." />
        </th>
    </xsl:template>

</xsl:stylesheet>
