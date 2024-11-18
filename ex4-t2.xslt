<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
                <xsl:output method="xml" indent="yes"/>
                <xsl:strip-space elements="*"/>

    <!-- An xml file that contains aggregate information about ex4-t2.xml -->

    <!-- Statistic about number of tables -->
    <!-- Use of apply template-->

    <xsl:template match="restaurant">
        <summary>
            <totalTables>
                <xsl:value-of select="count(//table)"/>
            </totalTables>
            
            <xsl:apply-templates select="menu"/>
            <xsl:apply-templates select="staff"/>
            <xsl:apply-templates select="reservations"/>
        </summary>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>



    <xsl:template match="reservations">
        <reservationSummary>
            
            <totalReservations>
                <xsl:value-of select="count(//reservation)"/>
            </totalReservations>

        </reservationSummary>

        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <!-- Various information about the menu most expensive drink, most expensive food-->
    <!-- Use of apply template for food items and drink items-->

    <xsl:template match="menu">
        <menuSummary>

            <totalFoodItems>
                <xsl:value-of select="count(//menu/food/item)"/>
            </totalFoodItems>

            <totalDrinkItems>
                <xsl:value-of select="count(//menu/drinks/item)"/>
            </totalDrinkItems>
            
            <mostExpensive>
                <xsl:apply-templates select="food"/>
                <xsl:apply-templates select="drinks"/>
            </mostExpensive>

        </menuSummary>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>



    <xsl:template match="staff">

        <staffSummary>

            <totalWages>
                <xsl:text>Total Wages: </xsl:text>
                <xsl:value-of select="sum(//person/salary)"/>
            </totalWages>

            <!-- Use of xsl attribute, xsl element and xsl variables -->
            <mostExpensiveStaff>
                <xsl:variable name="mostExpensiveSalary" select="max(person/salary)"/>
                <xsl:variable name="mostExpensivePerson" select="person[salary = $mostExpensiveSalary]"/>
                <xsl:element name="{$mostExpensivePerson/name}">
                    <xsl:attribute name="job">
                        <xsl:value-of select="$mostExpensivePerson/@job"/>
                    </xsl:attribute>
                    <xsl:text>Salary: </xsl:text>
                    <xsl:value-of select="$mostExpensiveSalary"/>
                </xsl:element>
            </mostExpensiveStaff>

        </staffSummary>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    <!-- Use of xsl variables and value-of -->
    <!-- Use of xsl:element -->

    <xsl:template match="food">
        <mostExpensiveFood>
                <xsl:variable name="maxPrice" select="max(item/price)"/>
                <xsl:variable name="expensiveItem" select="item[price = $maxPrice]"/>
                <xsl:element name="{$expensiveItem/name}">
                    <xsl:text>Price: </xsl:text>
                    <xsl:value-of select="$expensiveItem/price"/>
                </xsl:element>
        </mostExpensiveFood>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    <!-- Use of xsl variables and value-of -->
    <!-- Use of xsl:element -->

    <xsl:template match="drinks">
        <mostExpensiveDrink>
                <xsl:variable name="maxPrice" select="max(item/price)"/>
                <xsl:variable name="expensiveItem" select="item[price = $maxPrice]"/>
                <xsl:element name="{$expensiveItem/name}">
                    <xsl:text>Price: </xsl:text>
                    <xsl:value-of select="$expensiveItem/price"/>
                </xsl:element>
        </mostExpensiveDrink>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>



    
</xsl:stylesheet>