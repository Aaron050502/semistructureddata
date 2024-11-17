<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                <xsl:output method="html"/>



    <xsl:template match="musicFestival">
        <html>
            <head>
                <title>Music Festival</title>
            </head>
            <body>
                <header>
                    <h1><xsl:value-of select="@name"/> </h1>
                    <p>Location: <xsl:value-of select="@location"/></p>
                </header>
                <!-- apply templates-->
                <xsl:apply-templates select="stages"/>
                <xsl:apply-templates select="lineup"/>
                <xsl:apply-templates select="vendors"/>
                <xsl:apply-templates select="facilities"/>
            </body>
        </html>     
    </xsl:template>





    <xsl:template match="stages">
        <section>
            <h2>Stages</h2>
            <ul>
                <xsl:apply-templates select="stage">
                    <xsl:sort select="@id" order="ascending">
                    </xsl:sort>
                </xsl:apply-templates>
            </ul>    
        </section>
    </xsl:template>

    <xsl:template match="stage">
        <!-- Extract attribute value -->
        <li><xsl:value-of select="@id"/></li>
    </xsl:template>


    <xsl:template match="lineup">
        <section>
            <h2>Lineups</h2>
            <ul>
                <xsl:apply-templates select="artist">
                    <!-- xsl sort-->
                    <xsl:sort select="@name" order="ascending">
                    </xsl:sort>
                </xsl:apply-templates>
            </ul>    
        </section>
    </xsl:template>
    <!-- xsl variable -->
    <xsl:template match="artist">
        <div class="artist">
            <xsl:variable name="stageid" select="@stage"/>
             <!-- Extract element text content -->
            <h3> <xsl:value-of select="description/name/text()"/> performing at <xsl:value-of select="//stage[@id = $stageid]/@id"/></h3>
            <p>Genre: <xsl:value-of select="@genre"/></p>
            <p>Bio: <xsl:value-of select="normalize-space(description/bio/text())"/></p>
        </div>
    </xsl:template>
        
    
    <xsl:template match="vendors">
        <section>
            <h2>Vendors</h2>
            <ul>
                <xsl:apply-templates select="vendor">
                    <xsl:sort select="/vendor/name/text()" order="ascending">
                    </xsl:sort>
                </xsl:apply-templates>
            </ul>    
        </section>
    </xsl:template>

    <xsl:template match="vendor">
        <xsl:variable name="vendortype" select="@type"/>
        <div class="$vendortype">
            <!-- Use xml attribute within html attribute -->
             <xsl:attribute name="class">
                <xsl:value-of select="$vendortype"/>
            </xsl:attribute>
            <h3><xsl:value-of select="name/text()"/></h3>
            <h4>Menu</h4>
            <table>
                <tr>
                    <th>Item</th>
                    <th>Price</th>
                </tr>
                <xsl:apply-templates select="menu/item">
                    <xsl:sort select="menu/item/price/text()" order="ascending">
                    </xsl:sort>
                </xsl:apply-templates>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="item">
        <tr>
            <td><xsl:value-of select="name/text()"/></td>
            <td><xsl:value-of select="price/text()"/></td>
        </tr>
    </xsl:template>


    <xsl:template match="facilities">
        <section>
            <h2>Facilities</h2>
            <ul>
                <xsl:apply-templates select="facility">
                    <xsl:sort select="name/text()" order="ascending">
                    </xsl:sort>
                </xsl:apply-templates>
            </ul>    
        </section>
    </xsl:template>

    <xsl:template match="facility">
        <div class="facility">
            <h3><xsl:value-of select="@type"/></h3>
            <p>Location: <xsl:value-of select="location/text()"/></p>
        </div>
    </xsl:template>

</xsl:stylesheet>

