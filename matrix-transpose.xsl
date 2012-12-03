<!-- this variable stores the unique ID of the longest <col> -->
<xsl:variable name="vMaxColId">
  <xsl:for-each select="/root/col">
    <xsl:sort select="count(cell)" data-type="number" order="descending" />
    <xsl:if test="position() = 1">
      <xsl:value-of select="generate-id()" />
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

<!-- and this selects the children of that <col> for later iteration -->
<xsl:variable name="vIter" select="
   /root/col[generate-id() = $vMaxColId]/cell
" />

<xsl:template match="root">
  <xsl:variable name="columns" select="col" />
  <table>
    <!-- output the <th>s -->
    <tr>
      <xsl:apply-templates select="$columns/@title" />
    </tr>
    <!-- make as many <tr>s as there are <cell>s in the longest <col> -->
    <xsl:for-each select="$vIter">
      <xsl:variable name="pos" select="position()" />
      <tr>
        <!-- make as many <td>s as there are <col>s -->
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
