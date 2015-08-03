<?xml version="1.0" encoding="UTF-8"?>
<!--
************************************************
XSLT Transformation für die Erstellung der temporären XML Datei zur anschliessenden Generierung der Testfälle
erstellt: 24. Juli 2015, Edward Ebersold 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="BusinessDecision">
	
	   <xsl:element name="BusinessDecisionTestParameter">
		   	        
		    <xsl:comment>temporary file for the generation of the test cases for the Business Decision <xsl:value-of select="decisionId" />
			</xsl:comment>
			
			<!-- Angabe der Business Decision ID -->
			<xsl:element name="decisionId"><xsl:value-of select="decisionId" /></xsl:element>
			<xsl:element name="decisionName"><xsl:value-of select="decisionName" /></xsl:element>
			<xsl:for-each select="FactTypeGlossary/FactType">
				<xsl:variable name="factTypeName" select="factTypeName"/>
				<xsl:if test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])=0">
					<xsl:element name="decisionParameter"><xsl:value-of select="factTypeName" /></xsl:element>
				</xsl:if>
			</xsl:for-each>
			<xsl:element name="decisionConclusion"><xsl:value-of select="RuleFamily/conclusionFactTypeName" /></xsl:element>

			<xsl:element name="testParameterGlossary">
				<xsl:for-each select="FactTypeGlossary/FactType">
					<xsl:variable name="factTypeName" select="factTypeName"/>
					<!--  alle Condition sowie die Decision Conclusion werden berücksichtigt -->
					<xsl:if test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])=0 or count(/BusinessDecision/RuleFamily[conclusionFactTypeName=$factTypeName])=1">
						<xsl:element name="FactType">
							<xsl:element name="factTypeName"><xsl:value-of select="factTypeName" /></xsl:element>
							<xsl:element name="contentCardinality"><xsl:value-of select="contentCardinality" /></xsl:element>
							<xsl:element name="testValues">
								<xsl:for-each select="./*/value">
									<xsl:element name="value"><xsl:value-of select="." /></xsl:element>
								</xsl:for-each>
							</xsl:element>
							
						
						</xsl:element>
					</xsl:if>
				</xsl:for-each>			
			</xsl:element>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>