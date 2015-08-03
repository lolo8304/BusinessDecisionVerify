<?xml version="1.0" encoding="UTF-8"?>
<!--
XSLT Transformation für die html-Darstellung der ConceptElementMapping zu einer Business-Decision

History:
- 15.07.2015: initial Version, E. Ebersold, C160105


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
	

<xsl:template match="ConceptElementMapping">
	    <html>
			<head>
				<title>Business Decision <xsl:value-of select="decisionId" /> Concept Element Mapping</title>
   <xsl:call-template name="css-styles" />
			</head>
			<body>
			    <h2>Business Decision</h2>
			    <hr />
			    <h1> <xsl:value-of select="decisionId" /> -  Concept Element Mapping
			    </h1> 
					(nur für internen Gebrauch) 
				<br />
				<br />
				<table>
					<thead>
						<tr>
							<th class="th_head" colspan="6"><xsl:text>Concept Element Mapping for Business Decision </xsl:text><xsl:value-of select="decisionId" /></th>
						</tr>
						<tr>
							<th class="th_glossary_head">Geschäftsobjekt</th>
							<th class="th_glossary_head">Faktentyp</th>
							<th class="th_glossary_head">Variable Name</th>
							<th class="th_glossary_head">Business Concept</th>
							<th class="th_glossary_head">Attribute Name</th>
							<th class="th_glossary_head">DomainKey</th>
						</tr>
					</thead>
					<tbody>
						<xsl:apply-templates select="ConceptElement" />					
					</tbody>
				</table>
			    <br />
			    <hr />
			    <xsl:for-each select="ConceptElement[count(CodeNaming)>0]">
					<xsl:if test="position()=1">
						<h2>Code Mappings</h2>
						<br />
					</xsl:if>
					<table>
						<thead>
							<tr>
								<th class="th_head" colspan="2"><xsl:text>Code Mapping zu </xsl:text><xsl:value-of select="factTypeName"/></th>
							</tr>
							<tr>
								<th class="th_glossary" colspan="2"><xsl:text>Attribut: </xsl:text><xsl:value-of select="businessConcept"/><xsl:text> </xsl:text><xsl:value-of select="attributeName"/></th>
							</tr>
							<tr>
								<th class="th_glossary_head">Code</th>
								<th class="th_glossary_head">Bezeichnung</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="CodeNaming">
								<tr>
									<th class="th_glossary"><xsl:value-of select="code"/></th>
									<th class="th_glossary"><xsl:value-of select="naming"/></th>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
					<br/>
					<br/>
			    </xsl:for-each>
			    <br />
			    <hr />
			    <small>Schemaversion: <xsl:value-of select="@xsi:noNamespaceSchemaLocation" /></small>			    
			</body>
		</html>
	    
	</xsl:template>


	<xsl:template match="ConceptElement">
		<tr>
			<th class="th_glossary"><xsl:value-of select="businessObject" /></th>
			<th class="th_glossary"><xsl:value-of select="factTypeName" /></th>
			<th class="th_glossary"><xsl:value-of select="variableName" /></th>
			<th class="th_glossary"><xsl:value-of select="businessConcept" /></th>
			<th class="th_glossary"><xsl:value-of select="attributeName" /></th>
			<th class="th_glossary"><xsl:value-of select="domainKey" /></th>
		</tr>
	</xsl:template>
	


	<!-- Allgemeine Module -->
	<xsl:include href="bd_general_view_templates.xslt" />
	
</xsl:stylesheet>
