<?xml version="1.0" encoding="UTF-8"?>
<!--
allgemein Nutzbare Templates XSLT Transformation für die html-Darstellung einer Business-Decision 

History:
- 14.07.2015: initial Version, E. Ebersold, C160105


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>

	<xsl:template match="FactTypeGlossary">
		<p>Anzahl Fakten: <xsl:value-of select="count(FactType)" /></p>
		<table>
			<thead>
				<tr>
					<th class="th_head" colspan="6"><xsl:text>Glossary </xsl:text><xsl:value-of select="../decisionName" /></th>
				</tr>
				<tr>
					<th class="th_glossary_head">Geschäftsobjekt</th>
					<th class="th_glossary_head">Faktentyp</th>
					<th class="th_glossary_head">Kardinalität</th>
					<th class="th_glossary_head">In-/Ouput</th>
					<th class="th_glossary_head">fachlicher Datentyp</th>
					<th class="th_glossary_head">Werte</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="FactType">
					<xsl:variable name="localFactTypeName" select="factTypeName"/>
					<tr>
						<th class="th_glossary"><xsl:value-of select="businessObject" /></th>
						<th class="th_glossary"><xsl:value-of select="factTypeName" /></th>
						<th class="th_glossary"><xsl:value-of select="contentCardinality" /></th>
						<th class="th_glossary">
							<xsl:choose>
								<xsl:when test="count(/BusinessDecision/RuleFamily[conclusionFactTypeName=$localFactTypeName])>0">Decision Conclusion</xsl:when>
								<xsl:when test="count(//RuleFamily[conclusionFactTypeName=$localFactTypeName])>0">Interim Conclusion</xsl:when>
								<xsl:otherwise>Condition</xsl:otherwise>
							</xsl:choose>
						</th>
						<th class="th_glossary"><xsl:value-of select="dataType" /></th>
						<th class="th_glossary">
							<xsl:apply-templates select="ValueRange|SampleValue"/>
						</th>
						
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
			
	</xsl:template>
	
	<xsl:template match="ValueRange|SampleValue">
		<xsl:choose>
			<xsl:when test="local-name(.)='ValueRange'"><xsl:text>Value Range: </xsl:text></xsl:when>
			<xsl:otherwise><xsl:text>Sample Values: </xsl:text></xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="anzValues" select="count(value)" />
		<xsl:for-each select="value">
			<xsl:value-of select="." />
			<xsl:if test="not(position()=$anzValues)"><xsl:text>, </xsl:text></xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="DecisionInfo">
		<table>
			<tbody>
				<tr>
					<th class="th_d_info_descr">valid from</th>
					<th class="th_d_info"><xsl:value-of select="validFrom"/></th>							
				</tr>
				<tr>
					<th class="th_d_info_descr">valid to</th>
					<th class="th_d_info"><xsl:value-of select="validTo"/></th>							
				</tr>
				<tr>
					<th class="th_d_info_descr">File Generation date</th>
					<th class="th_d_info"><xsl:value-of select="generationDate"/></th>							
				</tr>
				<tr>
					<th class="th_d_info_descr">Generation System</th>
					<th class="th_d_info"><xsl:value-of select="generationSystem"/></th>							
				</tr>
				<tr>
					<th class="th_d_info_descr">Decision Lifecycle Status</th>
					<th class="th_d_info"><xsl:value-of select="decisionLifeCycleStatus"/></th>							
				</tr>
				<tr>
					<th class="th_d_info_descr">Decision Processing Status</th>
					<th class="th_d_info"><xsl:value-of select="decisionProcessingStatus"/></th>							
				</tr>
			</tbody>
		</table>
	</xsl:template>


	
<!-- ////////////////// Stylesheet - Daten  -->
<xsl:template name="css-styles" >
<style type="text/css">
body {
   font-family: Arial;
   font-size: 75%;
   background-color:white;
   color: #000;
   margin-left:5em;
}
* {
margin: 0;
padding: 0;
}
h1,h2,h3 {margin-bottom:0.25em; margin-top:1em;}
p {margin-bottom:0.5em;}
table, th, td {
   border:1px solid black;
   border-spacing:0;
   border-collapse:collapse;
   padding:0.2em;
   table-layout:fixed
   font-size: 75%;
   font-weight:normal;
}
.th_nr {
   font-size:70%;
}
.th_nr_head {
   width:4em;
   vertical-align:bottom;
}
.th_comment_head {
   vertical-align:bottom;
   background-color:#66ccff;   
}
.th_error_head {
   background-color:#ff4500; 
   text-align:left;
}
.th_head {
   font-weight:bold;
   text-align:left;
   background-color:#000000;
   color:#ffffff;
}
.th_condition {
   background-color:#66ffff;
}
.th_conclusion {
   background-color:#66ccff;
}
.th_glossary_head {
   background-color:#e8e8e8;
   font-weight:bold;
   text-align:left;
}
.th_glossary {
   text-align:left;
}
.th_d_info {
   text-align: left;
   width: 30em;
}
.th_d_info_descr {
   background-color:#e8e8e8;
   text-align: left;
   font-weight:bold;
}
</style>
</xsl:template>

	
</xsl:stylesheet>
