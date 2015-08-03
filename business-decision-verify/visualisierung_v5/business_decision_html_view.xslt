<?xml version="1.0" encoding="UTF-8"?>
<!--
XSLT Transformation für die html-Darstellung einer Business-Decision im Format business_decision_v1.n.xsd

History:
- 24.06.2015: initial Version, E. Ebersold, C160105


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
	<xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
	

<xsl:template match="BusinessDecision">
	    <html>
			<head>
				<title>Business Decision <xsl:value-of select="decisionId" /></title>
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
				<h2>Overview Rule Families</h2>
				<p>
						<xsl:call-template name="ruleFamilyOverview">
							<xsl:with-param name="ruleFamily" select="RuleFamily"/>							
						</xsl:call-template>
				</p>
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
			<xsl:if test="count(../ruleFamilyId)=1" >
				<xsl:text> (belongs to: </xsl:text><xsl:value-of select="../ruleFamilyId"/><xsl:text>), </xsl:text>
			</xsl:if>
			<xsl:value-of select="numberOfHits" />
		</p>
		
		<table>
			<thead>
				<tr>
					<th rowspan="3" class="th_nr_head">Pattern Nr.</th>
					<th rowspan="3" class="th_nr_head">Nr.</th>
					<xsl:element name="th">				
						 <xsl:attribute name="class">th_head</xsl:attribute>
						 <xsl:attribute name="colspan"><xsl:value-of select="(count($conditionColumns)+1)*2+1" /></xsl:attribute>
						 <xsl:text>DecisionTable </xsl:text><xsl:value-of select="ruleFamilyName" />
					</xsl:element>
				</tr>
				<tr>
					<xsl:for-each select="$conditionColumns">
							<th colspan="2" class="th_condition"><xsl:text>Condition</xsl:text></th>
					</xsl:for-each>
					<th colspan="2" class="th_conclusion"><xsl:text>Conclusion</xsl:text></th>
					<th class="th_comment_head">Message</th>
				</tr>
				<tr>
					<xsl:for-each select="$conditionColumns">
							<th colspan="2" class="th_condition"><xsl:value-of select="." /></th>
					</xsl:for-each>
					<th colspan="2" class="th_conclusion"><xsl:value-of select="conclusionFactTypeName" /></th>
					<th class="th_comment_head"><xsl:value-of select="messageName"/></th>
				</tr>			
			</thead>
			<tbody>
				<xsl:for-each select="Rule">
					<xsl:call-template name="decision_table_row">
						<xsl:with-param name="rule" select="." />
						<xsl:with-param name="conditionCols" select="$conditionColumns" />
					</xsl:call-template>
				</xsl:for-each>			
			</tbody>
		</table>
		<p> <br/> </p>	
		<xsl:apply-templates select="RuleFamily" />
	</xsl:template>

	<xsl:template name="decision_table_row">
		<xsl:param name="conditionCols" />
		<xsl:param name="rule" />
			<tr>
				<th class="th_nr"><xsl:value-of select="$rule/rulePatternNo" /></th>
				<th class="th_nr"><xsl:value-of select="$rule/sequenceNo" /></th>
				<xsl:for-each select="$conditionCols">
							<xsl:variable name="conditionName" select="." />
							<th>
								<xsl:apply-templates select="$rule/Condition[factTypeName=$conditionName]/conditionOperatorName" />
							</th>
							<th>
								<xsl:apply-templates select="$rule/Condition[factTypeName=$conditionName]/ConditionOperand" />
							</th>
				</xsl:for-each>
				<th><xsl:value-of select="$rule/Conclusion/conclusionOperatorName" /></th>
				<th>
						<xsl:apply-templates select="$rule/Conclusion/ConclusionOperand" />
				</th>
				<th class="th_nr"><xsl:value-of select="$rule/message" /></th>
			</tr>
	</xsl:template>
	
	
	<xsl:template match="ConditionOperand|ConclusionOperand">
		<xsl:choose>
				<xsl:when test="count(singleOperandValue)>0">
					<xsl:value-of select="singleOperandValue" />
				</xsl:when>
	
				<xsl:when test="count(multiOperandValue)>0">
					<xsl:variable name="anzValues" select="count(multiOperandValue)" />
					<xsl:for-each select="multiOperandValue">
						<xsl:value-of select="." />
						<xsl:if test="not(position()=$anzValues)"><xsl:text>, </xsl:text></xsl:if>
					</xsl:for-each>
				</xsl:when>
	
				<xsl:when test="count(MinMaxOperand)>0">
					<xsl:choose>
						<xsl:when test="MinMaxOperand/minValueIncluded='true'"><xsl:text>[</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>(</xsl:text></xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="MinMaxOperand/minOperandValue" />
					<xsl:text>, </xsl:text>
					<xsl:value-of select="MinMaxOperand/maxOperandValue" />
					<xsl:choose>
						<xsl:when test="MinMaxOperand/maxValueIncluded='true'"><xsl:text>]</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>)</xsl:text></xsl:otherwise>
					</xsl:choose>
					
				</xsl:when>
				<xsl:otherwise><xsl:text>undefined</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="conditionOperatorName|conclusionOperatorName">
		<xsl:choose>
			<xsl:when test=".='gt'">
				<xsl:text>&gt;</xsl:text>
			</xsl:when>
			<xsl:when test=".='lt'">
				<xsl:text>&lt;</xsl:text>
			</xsl:when>
			<xsl:when test=".='le'">
				<xsl:text>&lt;=</xsl:text>
			</xsl:when>
			<xsl:when test=".='ge'">
				<xsl:text>&gt;=</xsl:text>
			</xsl:when>	
			<xsl:when test=".='eq'">
				<xsl:text>=</xsl:text>
			</xsl:when>	
			<xsl:when test=".='ne'">
				<xsl:text>&lt;&gt;</xsl:text>
			</xsl:when>	
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	

	<xsl:template name="ruleFamilyOverview">
		<xsl:param name="ruleFamily" />
		<xsl:param name="lrand"/>
			<xsl:if test="string-length($lrand)>0">
				<xsl:value-of select="$lrand"/><xsl:text>  -  </xsl:text>
			</xsl:if>
			<xsl:value-of select="$ruleFamily/ruleFamilyId"/> - <xsl:value-of select="$ruleFamily/ruleFamilyName"/><br/>
				<xsl:for-each select="$ruleFamily/RuleFamily">
						<xsl:call-template name="ruleFamilyOverview">
							<xsl:with-param name="ruleFamily" select="."/>
							<xsl:with-param name="lrand" select="concat($lrand,'.    ')"/>
						</xsl:call-template>
				</xsl:for-each>			
	</xsl:template>



	<!-- Allgemeine Module -->
	<xsl:include href="bd_general_view_templates.xslt" />
	
</xsl:stylesheet>
