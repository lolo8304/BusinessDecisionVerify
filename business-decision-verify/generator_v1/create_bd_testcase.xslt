<?xml version="1.0" encoding="UTF-8"?>
<!--
************************************************
XSLT Transformation für die Erstellung der XML Datei mit den Testfällen
erstellt: 24. Juli 2015, Edward Ebersold 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="BusinessDecisionTestParameter">
	
	   <xsl:element name="BusinessDecisionTest">
			<!-- Angabe der Business Decision ID -->
			<xsl:attribute name="decisionId"><xsl:value-of select="decisionId" /></xsl:attribute>
			<xsl:attribute name="decisionName"><xsl:value-of select="decisionName" /></xsl:attribute>
			<xsl:attribute name="paramCount"><xsl:value-of select="count(decisionParameter)" /></xsl:attribute>
		   	        
		    <xsl:comment>test cases for the Business Decision <xsl:value-of select="decisionId" />
			</xsl:comment>
			
			<xsl:for-each select="decisionParameter">
				<xsl:variable name="decisionFactTypeName" select="."/>
				<xsl:element name="decisionParameter">
					<xsl:attribute name="contentCardinality">
						<xsl:value-of select="/BusinessDecisionTestParameter/testParameterGlossary/FactType[factTypeName=$decisionFactTypeName]/contentCardinality"/>
					</xsl:attribute>
				<xsl:value-of select="."/>					
				</xsl:element>
			</xsl:for-each>
			
			<xsl:variable name="factTypeName" select="decisionConclusion"/>
			<xsl:element name="decisionConclusion">
				<xsl:attribute name="contentCardinality">
						<xsl:value-of select="/BusinessDecisionTestParameter/testParameterGlossary/FactType[factTypeName=$factTypeName]/contentCardinality"/>				
				</xsl:attribute>
				<xsl:value-of select="decisionConclusion"/>
			</xsl:element>

			<xsl:call-template name="testCaseGenerator">
				<xsl:with-param name="conditionNumber">1</xsl:with-param> 
				<xsl:with-param name="maxConditionNumber" select="count(decisionParameter)"/>
				<xsl:with-param name="valueStack"></xsl:with-param>
			</xsl:call-template>

			

		</xsl:element>
	</xsl:template>
	
	
	<xsl:template name="testCaseGenerator">	
		<xsl:param name="conditionNumber" />
		<xsl:param name="maxConditionNumber" />
		<xsl:param name="valueStack" />
		
		<xsl:variable name="factTypeName" select="/BusinessDecisionTestParameter/decisionParameter[number($conditionNumber)]" />

		<xsl:for-each select="/BusinessDecisionTestParameter/testParameterGlossary/FactType[factTypeName=$factTypeName]/testValues/value">
			<xsl:choose>
				<xsl:when test="$conditionNumber=$maxConditionNumber">
					<!-- Testcases ausgeben, für alle Werte der Condition maxConditionNumber -->
					<xsl:element name ="testCase">
						<xsl:copy-of select="$valueStack"/>
						<xsl:element name="value"><xsl:value-of select="."/></xsl:element>
						<xsl:element name="expectedOutput"/>
					</xsl:element>
																						
				</xsl:when>
				<xsl:otherwise>
					<!-- für alle Werte des factTypeName die testCases mit folgenden Condition komplettieren -->
					<xsl:call-template name="testCaseGenerator">
							<xsl:with-param name="conditionNumber" select="$conditionNumber+1"/>
							<xsl:with-param name="maxConditionNumber" select="$maxConditionNumber"/>
							<xsl:with-param name="valueStack">
								<xsl:copy-of select="$valueStack"/>
								<xsl:element name="value"><xsl:value-of select="." /></xsl:element>
							</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		
	</xsl:template>	

</xsl:stylesheet>