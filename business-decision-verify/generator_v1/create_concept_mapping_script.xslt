<?xml version="1.0" encoding="UTF-8"?>
<!--
************************************************
XSLT Transformation für die Erstellung der XSLT-Templates für das Concept Mapping einer Business Decision
erstellt: WIAI, November 2013, ee
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="ConceptElementMapping">
	   <xsl:element name="xsl:stylesheet">
		   	<xsl:attribute name="version">1.0</xsl:attribute>
		   	        
		    <xsl:comment>Concept Element Mapping fuer die BusinessDecision <xsl:value-of select="decisionId" />
			</xsl:comment>
			
			<!-- Template zur Angabe der Business Decision ID -->
			<xsl:element name="xsl:template">
				<xsl:attribute name="name">BusinessDecisionId</xsl:attribute>
				<xsl:element name="xsl:text"><xsl:value-of select="decisionId" /></xsl:element>
			</xsl:element>

			<!--  Template für das Mapping factTypeNames zu Variabelname -->
			<xsl:element name="xsl:template">
				<xsl:attribute name="name">factTypeToVariableName</xsl:attribute>
				<xsl:element name="xsl:param">
					<xsl:attribute name="name">factTypeName</xsl:attribute>
				</xsl:element>
				<xsl:element name="xsl:choose">
					<xsl:for-each select="ConceptElement">
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">$factTypeName='<xsl:value-of select="factTypeName"/>'</xsl:attribute>
							<xsl:value-of select="variableName"/>
						</xsl:element>			
					</xsl:for-each>			   
				    <xsl:element name="xsl:otherwise"></xsl:element>
				</xsl:element>
			</xsl:element>	

			<!--  Template für das Mapping factTypeNames zu Attributname  -->
			<xsl:element name="xsl:template">
			   <xsl:attribute name="name">factTypeToAttrName</xsl:attribute>
				<xsl:element name="xsl:param">
					<xsl:attribute name="name">factTypeName</xsl:attribute>
				</xsl:element>				   
				<xsl:element name="xsl:choose">
					<xsl:for-each select="ConceptElement">
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">$factTypeName='<xsl:value-of select="factTypeName"/>'</xsl:attribute>
							<xsl:value-of select="businessConcept"/>_<xsl:value-of select="attributeName"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:element name="xsl:otherwise">attr not mapped</xsl:element>
				</xsl:element>
			</xsl:element>	


			<!--  Template für das Mapping factTypeName zu domainKey -->
			<xsl:element name="xsl:template">
			   <xsl:attribute name="name">factTypeToDomainKey</xsl:attribute>
				<xsl:element name="xsl:param">
					<xsl:attribute name="name">factTypeName</xsl:attribute>
				</xsl:element>
					
				<xsl:element name="xsl:choose">
					<xsl:for-each select="ConceptElement">
						<xsl:element name="xsl:when">
							<xsl:attribute name="test">$factTypeName='<xsl:value-of select="factTypeName"/>'</xsl:attribute>
							<xsl:value-of select="domainKey"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:element name="xsl:otherwise">domainKey not mapped</xsl:element>
				</xsl:element>
			</xsl:element>	


		<!--  Template für das Mapping factTypeValues zu den allfällig hinterlegten Codewerten -->
		<xsl:element name="xsl:template">
			<xsl:attribute name="name">factTypeValueToCode</xsl:attribute>
			
			<xsl:element name="xsl:param">
				<xsl:attribute name="name">factTypeName</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:param">
				<xsl:attribute name="name">value</xsl:attribute>
			</xsl:element>
			
			<xsl:element name="xsl:choose">
				<xsl:for-each select="ConceptElement">
					<xsl:element name="xsl:when">
						<xsl:attribute name="test">$factTypeName='<xsl:value-of select="factTypeName"/>'</xsl:attribute>
						<!-- wenn kein Mapping vorhanden ist, kann der Wert direkt zurückgegeben werden -->
						<xsl:if test="count(CodeNaming)=0">
							<xsl:if test="domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if>
							<xsl:element name="xsl:value-of"><xsl:attribute name="select">$value</xsl:attribute></xsl:element>
							<xsl:if test="domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if>
						</xsl:if>
						<!-- wenn Mapping vorhanden ist, wird ein choose Statement generiert -->
						<xsl:if test="count(CodeNaming)>0">
							<xsl:element name="xsl:choose">
								<xsl:for-each select="CodeNaming">
									<xsl:element name="xsl:when">
										<xsl:attribute name="test">$value='<xsl:value-of select="naming"/>'</xsl:attribute>
										<xsl:if test="../domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if>
										<xsl:value-of select="code"/>
										<xsl:if test="../domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if>
									</xsl:element>
								</xsl:for-each>
								<xsl:element name="xsl:otherwise"><xsl:if test="domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if><xsl:element name="xsl:value-of"><xsl:attribute name="select">$value</xsl:attribute></xsl:element><xsl:if test="domainKey='CHAR'"><xsl:text>"</xsl:text></xsl:if></xsl:element>						
							</xsl:element>
						</xsl:if>
						
					</xsl:element>			
				</xsl:for-each>			   
		    	<xsl:element name="xsl:otherwise">factTypeName <xsl:element name="xsl:value-of"><xsl:attribute name="select">$factTypeName</xsl:attribute></xsl:element> not mapped</xsl:element>

			</xsl:element>
		</xsl:element>	




		</xsl:element>
	</xsl:template>


</xsl:stylesheet>