<?xml version="1.0" encoding="UTF-8"?>
<!--
XSLT Transformation für die möglichen Testfälle pro Rule Family einer Business-Decision im Format business_decision_v1.n.xsd

History:
- 07.07.2015: initial Version, E. Ebersold, C160105


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
	

<xsl:template match="BusinessDecision">
	    <html>
			<head>
				<title>Business Decision <xsl:value-of select="decisionId" /> - Rule Family Testcases</title>
				<xsl:call-template name="css-styles" />
			</head>
			<body>
			    <h2>Business Decision Model</h2>
			    <hr />
			    <h1> <xsl:value-of select="decisionId" /> - <xsl:value-of select="decisionName" />
			    </h1> 
					(nur für internen Gebrauch) 
				<br />
				<br />
				<h2>Testfälle zu den einzelnen DecisionTables</h2>					
				<br />
   			    <xsl:apply-templates select="RuleFamily" />
			    <br />
			    <hr />
    		    <h2>Glossary zu <xsl:value-of select="decisionName" /></h2>
   			    <xsl:apply-templates select="FactTypeGlossary" />
    		    <p> <br /></p>
			    <hr />
			    
			    <h2>Decision Info:</h2>
			    <xsl:apply-templates select="DecisionInfo"/>
			    <br />
			    <hr />
			    <small>Schemaversion: <xsl:value-of select="@xsi:noNamespaceSchemaLocation" /></small>
			    
			</body>
		</html>
	    
	</xsl:template>
	

	<xsl:template match="RuleFamily">
		<xsl:variable name="conditionColumns" select="conditionFactTypeName" />
		<h2>Rule Family <xsl:value-of select="ruleFamilyId" /> - <xsl:value-of select="ruleFamilyName" /></h2>
		<p>
			<xsl:if test="count(../ruleFamilyId)=1" ><xsl:text> (belongs to: </xsl:text><xsl:value-of select="../ruleFamilyId"/><xsl:text>), </xsl:text>
			</xsl:if>
			<xsl:value-of select="numberOfHits" />
		</p>
		
		<table>
			<thead>
				<tr>
					<th rowspan="3" class="th_nr_head">Nr.</th>
					<xsl:element name="th">
						 <xsl:attribute name="class">th_head</xsl:attribute>
						 <xsl:attribute name="colspan"><xsl:value-of select="count($conditionColumns)+4" /></xsl:attribute>
						 <xsl:text>TestData </xsl:text><xsl:value-of select="ruleFamilyName" />
					</xsl:element>
				</tr>
				<tr>
					<xsl:for-each select="$conditionColumns">
							<th class="th_condition"><xsl:text>Input</xsl:text></th>
					</xsl:for-each>
					<th class="th_conclusion"><xsl:text>expected Output</xsl:text></th>	
					<th class="th_comment_head">derived Output</th>
					<th class="th_comment_head">Execution</th>
					<th class="th_error_head">Error</th>
				</tr>
				<tr>
					<xsl:for-each select="$conditionColumns">
							<th class="th_condition"><xsl:value-of select="." /></th>
					</xsl:for-each>
					<th class="th_conclusion"><xsl:value-of select="conclusionFactTypeName" /></th>
					<th class="th_conclusion"><xsl:value-of select="conclusionFactTypeName" /></th>
					<th class="th_conclusion"><xsl:text>Rule ID</xsl:text></th>
					<th class="th_error_head"><xsl:text>Message</xsl:text></th>
				</tr>			
			</thead>
			<tbody>
				<xsl:call-template name="testCaseGenerator">
					<xsl:with-param name="testCaseCounter">1</xsl:with-param> 
					<xsl:with-param name="conditionNames" select="conditionFactTypeName"/>
					<xsl:with-param name="conditionNumber">1</xsl:with-param> 
					<xsl:with-param name="maxConditionNumber" select="count(conditionFactTypeName)"/>
					<xsl:with-param name="valueStack"></xsl:with-param>
				</xsl:call-template>
			</tbody>
		</table>
			
		<p> <br/> </p>
		<xsl:apply-templates select="RuleFamily" />			
	</xsl:template>


	<xsl:template name="testCaseGenerator">
	
		<xsl:param name="conditionNames" />
		<xsl:param name="conditionNumber" />
		<xsl:param name="maxConditionNumber" />
		<xsl:param name="valueStack" />
	
		<xsl:variable name="factTypeName" select="$conditionNames[number($conditionNumber)]" />
	<!--	
		<p>
			conditionNames: <xsl:for-each select="$conditionNames"><xsl:value-of select="." /><xsl:text> </xsl:text></xsl:for-each> <br/>
			factTypeName <xsl:value-of select="$factTypeName" /> <br/>
			conditionNumber: <xsl:value-of select="$conditionNumber" /> <br/>
			maxConditionNumber: <xsl:value-of select="$maxConditionNumber" /> <br/>
			<table>
				<tbody>
					<tr> <th>valueStack</th><xsl:copy-of select="$valueStack"/>
					</tr>
				</tbody>
			</table>
		</p>
	-->
	
		<xsl:for-each select="/BusinessDecision/FactTypeGlossary/FactType[factTypeName=$factTypeName]/*/value">
			<xsl:choose>
				<xsl:when test="$conditionNumber=$maxConditionNumber">
					<!-- Testcases ausgeben, für alle Werte der Condition maxConditionNumber -->				
					<tr> 
						<th/><xsl:copy-of select="$valueStack"/><th><xsl:value-of select="."/></th><th/><th/><th/><th/>
					</tr>								
				</xsl:when>
				<xsl:otherwise>
					<!-- für alle Werte des factTypeName die testCases mit folgenden Condition komplettieren -->
					<xsl:call-template name="testCaseGenerator">
							<xsl:with-param name="conditionNames" select="$conditionNames"/>
							<xsl:with-param name="conditionNumber" select="$conditionNumber+1"/>
							<xsl:with-param name="maxConditionNumber" select="$maxConditionNumber"/>
							<xsl:with-param name="valueStack">
								<xsl:copy-of select="$valueStack"/>
								<xsl:element name="th"><xsl:value-of select="." /></xsl:element>
							</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		
	</xsl:template>

	
	<!-- Allgemeine Module -->
	<xsl:include href="bd_general_view_templates.xslt" />
	
</xsl:stylesheet>
