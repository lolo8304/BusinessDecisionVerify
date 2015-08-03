<?xml version="1.0" encoding="UTF-8"?>
<!--
************************************************
XSLT Transformation für die Erstellung des JAVA Codes zur Berechnung einer Business Decision

Als indirekter Input wird ein das ausgelagerte Stylesheet concept_mapping_script benötigt, welches aus den Mapping-Definitionen erstellt werd.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	

	<xsl:template match="BusinessDecision">
		<xsl:variable name="kontrolleId"><xsl:call-template name="BusinessDecisionId"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="decisionId=$kontrolleId"><xsl:call-template name="generateProgram"><xsl:with-param name="businessDecision" select="."></xsl:with-param> </xsl:call-template></xsl:when>
			<xsl:otherwise>concept_mapping_script.xslt does not match to this business decision (<xsl:value-of select="decisionId"/>)</xsl:otherwise>
		</xsl:choose>
	<xsl:text></xsl:text>

	</xsl:template>


<xsl:template name="generateProgram">
	<xsl:param name="businessDecision"/>
	<xsl:text>/*
 * Generated Class from Business Decision Model </xsl:text><xsl:value-of select="decisionId"/><xsl:text> - </xsl:text><xsl:value-of select="decisionName"/><xsl:text>
 *
 * Decision valid from: </xsl:text><xsl:value-of select="DecisionInfo/validFrom"/><xsl:text>
 * Decision generated: </xsl:text><xsl:value-of select="DecisionInfo/generationDate"/><xsl:text>
 */
package com.axa.ch.bre.businessdecisionv1;

public class </xsl:text><xsl:value-of select="decisionId"/><xsl:text> extends BusinessDecisionEvaluator {
	public </xsl:text><xsl:value-of select="decisionId"/><xsl:text>(boolean withRuleEvaluatingLog) {
		super(withRuleEvaluatingLog);
	}

	@Override
	public String getDecisionId() {return "</xsl:text><xsl:value-of select="decisionId"/><xsl:text>";}
	@Override
	public String getDecisionName() {return "</xsl:text><xsl:value-of select="decisionName"/><xsl:text>";}
	@Override
	public String getDeploymentVersion() {
		return "generated: </xsl:text><xsl:value-of select="DecisionInfo/generationDate"/><xsl:text>, System: </xsl:text><xsl:value-of select="DecisionInfo/generationSystem"/><xsl:text>";
	}

</xsl:text>
<xsl:for-each select="FactTypeGlossary/FactType">
	<xsl:variable name="factTypeName" select="factTypeName"/>
	<xsl:choose>
		<xsl:when test="$factTypeName=/BusinessDecision/RuleFamily/conclusionFactTypeName">
			<xsl:call-template name="factTypeDefinition">
				<xsl:with-param name="FactType" select="."/>
				<xsl:with-param name="art">Define Decision Conclusion</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="position()=last()"><xsl:text>ERROR: the last facttype of the FactTypeGlossary must be a Condition!

</xsl:text></xsl:if>
		</xsl:when>
		<xsl:when test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])>0">
			<xsl:call-template name="factTypeDefinition">
				<xsl:with-param name="FactType" select="."/>
				<xsl:with-param name="art">Define Conclusion</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="position()=last()"><xsl:text>ERROR: the last facttype of the FactTypeGlossary must be a Condition!

</xsl:text></xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="factTypeDefinition">
				<xsl:with-param name="FactType" select="."/>
				<xsl:with-param name="art">Define Condition</xsl:with-param>
			</xsl:call-template>		
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>

<xsl:text>	public boolean evaluate_business_decision (
		</xsl:text>
		
		<xsl:for-each select="FactTypeGlossary/FactType">
			<xsl:variable name="factTypeName" select="factTypeName"/>
			<xsl:if test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])=0">
					<xsl:call-template name="factTypeDefinition">
						<xsl:with-param name="FactType" select="."/>
						<xsl:with-param name="art">Decision Parameter</xsl:with-param>
					</xsl:call-template>		
			</xsl:if>
		</xsl:for-each>
<xsl:text>
	) {
		boolean isEvaluationOk = false;
		</xsl:text>
		<xsl:for-each select="FactTypeGlossary/FactType">
			<xsl:variable name="factTypeName" select="factTypeName"/>
			<xsl:if test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])=0">
					<xsl:call-template name="factTypeDefinition">
						<xsl:with-param name="FactType" select="."/>
						<xsl:with-param name="art">Decision Input Parameter setting</xsl:with-param>
					</xsl:call-template>		
			</xsl:if>
		</xsl:for-each>		
		<xsl:text>
		// initializing conclusion parameters
		</xsl:text>
		<xsl:for-each select="FactTypeGlossary/FactType">
			<xsl:variable name="factTypeName" select="factTypeName"/>
			<xsl:if test="count(//RuleFamily[conclusionFactTypeName=$factTypeName])>0">
					<xsl:call-template name="factTypeDefinition">
						<xsl:with-param name="FactType" select="."/>
						<xsl:with-param name="art">Conclusion Parameter initialize</xsl:with-param>
					</xsl:call-template>		
			</xsl:if>
		</xsl:for-each>				
		<xsl:text>
		evaluateErrorMessage = "";
		ruleIdHitLogBusinessDecision = new StringBuffer("");

		try {
			</xsl:text>
			<xsl:call-template name="evaluateRuleFamily">
				<xsl:with-param name="ruleFamily" select="RuleFamily"/>							
			</xsl:call-template>
		
		<xsl:text>		
			isEvaluationOk = true;
                
		} catch (InvalidConditionEvaluationException e) {
			evaluateErrorMessage=e.getConditionErrorMessage();          
		}   

		return isEvaluationOk;
	}
</xsl:text>
<xsl:for-each select="//RuleFamily">
	<xsl:call-template name="ruleFamilyCode">
		<xsl:with-param name="ruleFamily" select="."/>							
	</xsl:call-template>
</xsl:for-each>
<xsl:text>
}</xsl:text>	
</xsl:template>


<xsl:template name="factTypeDefinition">
	<xsl:param name="FactType"/>
		<xsl:param name="art"/>

	<xsl:variable name="attrName"><xsl:call-template name="factTypeToAttrName"><xsl:with-param name="factTypeName" select="$FactType/factTypeName"/></xsl:call-template></xsl:variable>
	<xsl:variable name="domainKey"><xsl:call-template name="factTypeToDomainKey"><xsl:with-param name="factTypeName" select="$FactType/factTypeName"/></xsl:call-template></xsl:variable>
	<xsl:variable name="type">
		<xsl:call-template name="domainKeyToType">
			<xsl:with-param name="domainKey" select="$domainKey"/>
			<xsl:with-param name="contentCardinality" select="$FactType/contentCardinality"/>
		</xsl:call-template>
	</xsl:variable>
	
<xsl:choose>
	<!--  Code für Definitionen für Conclusions und Conditions -->
	<xsl:when test="$art='Define Decision Conclusion' or $art='Define Conclusion' or $art='Define Condition'">
	<xsl:text>	// </xsl:text><xsl:value-of select="$art"/><xsl:text> - </xsl:text><xsl:value-of select="$FactType/factTypeName"/><xsl:text> - </xsl:text>
	<xsl:call-template name="factTypeToVariableName"><xsl:with-param name="factTypeName" select="$FactType/factTypeName"/></xsl:call-template>
	<xsl:text> - </xsl:text><xsl:value-of select="$domainKey"/>
	<xsl:text>
	private </xsl:text><xsl:value-of select="$type"/><xsl:text> </xsl:text><xsl:value-of select="$attrName"/><xsl:text>;
</xsl:text>
	<!-- dieser Teil ist nur für Conclusion notwendig -->
	<xsl:if test="$art='Define Conclusion' or $art='Define Decision Conclusion'">
	<xsl:text>	public </xsl:text><xsl:value-of select="$type"/><xsl:text> get</xsl:text><xsl:value-of select="$attrName"/><xsl:text>(){return </xsl:text><xsl:value-of select="$attrName"/><xsl:text>;}
	public String getFactName_</xsl:text><xsl:value-of select="$attrName"/><xsl:text>() {return "</xsl:text><xsl:value-of select="$FactType/factTypeName"/><xsl:text>";}
	private void set</xsl:text><xsl:value-of select="$attrName"/><xsl:text>(</xsl:text><xsl:value-of select="$type"/><xsl:text> value, boolean withHitLog) {
		</xsl:text><xsl:value-of select="$attrName"/><xsl:text> = value;
		if (withHitLog) {
			logRuleHit(usedRuleFamilyId, usedRuleNr);
		}
	};
	
</xsl:text>

	</xsl:if>
	<!-- Ende des Conclusion-spezifischen Definitionen -->
	
	<xsl:text>
</xsl:text>
	</xsl:when>

	<!--  Code für Decision Parameter im evaluate Aufruf-->
	<xsl:when test="$art='Decision Parameter'">
	<xsl:value-of select="$type"/><xsl:text> </xsl:text><xsl:value-of select="$attrName"/>
	<xsl:if test="position()!=last()"><xsl:text>,
		</xsl:text></xsl:if>
	</xsl:when>


	<!--  Code für Decision Input Parameter uebernehmen initialize im evaluate Aufruf   tbd: prüfen, ob das gleich für alle Typen funktioniert ??? -->
	<xsl:when test="$art='Decision Input Parameter setting'">
	<xsl:text>this.</xsl:text><xsl:value-of select="$attrName"/><xsl:text> = </xsl:text><xsl:value-of select="$attrName"/><xsl:text>;
		</xsl:text>
	</xsl:when>

	<!--  Code zur Initialisierung der Conclusion Parameter tbd: prüfen, ob das gleich für alle Typen funktioniert ??? -->
	<xsl:when test="$art='Conclusion Parameter initialize'">
	<xsl:text>set</xsl:text><xsl:value-of select="$attrName"/><xsl:text>(</xsl:text><xsl:call-template name="initializeValue"><xsl:with-param name="type" select="$type"/></xsl:call-template><xsl:text>,false);		
		</xsl:text>
	</xsl:when>

		<xsl:otherwise>	// code for <xsl:value-of select="$art"/> not implemented</xsl:otherwise>
</xsl:choose>	

</xsl:template>

<!-- -tbd - dieses Template wird identisch auch bei der Testfallgenerierung verwendet -->
<xsl:template name="domainKeyToType">
	<xsl:param name="domainKey"/>
	<xsl:param name="contentCardinality"/>
	
	<xsl:choose>
		<xsl:when test="$domainKey='SMALLINT' or $domainKey='INTEGER'" >int</xsl:when>
		<xsl:when test="$domainKey='CHAR'" >String</xsl:when>
		<xsl:otherwise>// implementation for type $domainKey not mapped</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="$contentCardinality='multi'">[]</xsl:if>
</xsl:template>


<xsl:template name="initializeValue">
	<xsl:param name="type"/>
	
	<xsl:choose>
		<xsl:when test="$type='int'" >0</xsl:when>
		<xsl:when test="$type='String'" >""</xsl:when>
 		<xsl:when test="$type='int[]'" >null</xsl:when>
		<xsl:otherwise> // implementation for initializing not yet implemented</xsl:otherwise>
	</xsl:choose>
</xsl:template>


	<!--  Aufruf der evalutate Statements der Rule Families in der richtigen Reihenfolge -->
	<xsl:template name="evaluateRuleFamily">
		<xsl:param name="ruleFamily" />

			<xsl:for-each select="$ruleFamily/RuleFamily">
					<xsl:call-template name="evaluateRuleFamily">
						<xsl:with-param name="ruleFamily" select="."/>
					</xsl:call-template>
			</xsl:for-each>
			<xsl:text>evaluate</xsl:text><xsl:value-of select="$ruleFamily/ruleFamilyId"/><xsl:text>(); //</xsl:text><xsl:value-of select="$ruleFamily/ruleFamilyName"/><xsl:text>
			</xsl:text>
	</xsl:template>
	

	
	<xsl:template name="ruleFamilyCode">
		<xsl:param name="ruleFamily" />
				
	<xsl:text>
	/*
	 * </xsl:text><xsl:value-of select="$ruleFamily/ruleFamilyId" /> - <xsl:value-of select="$ruleFamily/ruleFamilyName" /><xsl:text>
	 */
	private void evaluate</xsl:text><xsl:value-of select="$ruleFamily/ruleFamilyId" /><xsl:text>() throws InvalidConditionEvaluationException {
		usedRuleFamilyId = "</xsl:text><xsl:value-of select="$ruleFamily/ruleFamilyId" /><xsl:text>";
		int hitCount=0;
        
		String[] conditionName = {""</xsl:text>
		<xsl:for-each select="$ruleFamily/conditionFactTypeName">
			<xsl:text>,"</xsl:text><xsl:value-of select="." /><xsl:text>"</xsl:text>
		</xsl:for-each>
        <xsl:text>};

		</xsl:text>

	<xsl:for-each select="$ruleFamily/Rule" >
		<xsl:text>usedRuleNr = </xsl:text><xsl:value-of select="sequenceNo" /><xsl:text>;
		if (</xsl:text>
		<xsl:for-each select="Condition">
			<xsl:if test="position()>1"><xsl:text>
			&amp;&amp; </xsl:text></xsl:if>
			<xsl:call-template name="conditionCode">
				<xsl:with-param name="condition" select="."/>
				<xsl:with-param name="conditionCols" select="$ruleFamily/conditionFactTypeName"/>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:text>
		) {
		</xsl:text>
		<xsl:call-template name="conclusionCode">
			<xsl:with-param name="conclusion" select="Conclusion" />
			<xsl:with-param name="conclusionFactTypeName" select="../conclusionFactTypeName" />
		</xsl:call-template>
		<xsl:text>
		}
		</xsl:text>			
	</xsl:for-each>
	<xsl:text>
		// test of the hit Count
		if (hitCount==0) 
			throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
		</xsl:text>
		<xsl:if test="$ruleFamily/numberOfHits='single Hit'">
		<xsl:text>if (hitCount>1) 
			throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
		</xsl:text>
		</xsl:if>
	<xsl:text>
	}
	</xsl:text>
	</xsl:template>




	<xsl:template name="conditionCode">
		<xsl:param name="condition" />
		<xsl:param name="conditionCols"/>
		
		<xsl:variable name="attrName"><xsl:call-template name="factTypeToAttrName"><xsl:with-param name="factTypeName" select="$condition/factTypeName"/></xsl:call-template></xsl:variable>
		<xsl:variable name="domainKey"><xsl:call-template name="factTypeToDomainKey"><xsl:with-param name="factTypeName" select="$condition/factTypeName"/></xsl:call-template></xsl:variable>
		<xsl:variable name="type">
			<xsl:call-template name="domainKeyToType">
				<xsl:with-param name="domainKey" select="$domainKey"/>
				<xsl:with-param name="contentCardinality" select="'single'"/> <!-- für condition Vergleiche immer single -->
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:text>condition(</xsl:text><xsl:value-of select="$attrName" /><xsl:text>,BusinessDecisionEvaluator.</xsl:text>
		<xsl:call-template name="conditionOperator">
			<xsl:with-param name="conditionOperatorName" select="$condition/conditionOperatorName"/>
			<xsl:with-param name="conditionOperand" select="$condition/ConditionOperand"/>
		</xsl:call-template>
		<xsl:text>, </xsl:text>
		<xsl:choose>
			<xsl:when test="count($condition/ConditionOperand/singleOperandValue)=1"> 			
				<xsl:call-template name="factTypeValueToCode">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="value" select="$condition/ConditionOperand/singleOperandValue"/>
				</xsl:call-template>
				<xsl:text>, conditionName[</xsl:text>	
				<xsl:call-template name="getConditionPosition">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="conditionCols" select="$conditionCols"/>
				</xsl:call-template>						
				<xsl:text>]) // </xsl:text> <xsl:value-of select="$condition/conditionOperatorName" /><xsl:text> </xsl:text> <xsl:value-of select="$condition/ConditionOperand/singleOperandValue" />
			</xsl:when>
			<xsl:when test="count($condition/ConditionOperand/MinMaxOperand)=1">
				<xsl:call-template name="factTypeValueToCode">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="value" select="$condition/ConditionOperand/MinMaxOperand/minOperandValue"/>
				</xsl:call-template>
				<xsl:text>, </xsl:text>
				<xsl:call-template name="factTypeValueToCode">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="value" select="$condition/ConditionOperand/MinMaxOperand/maxOperandValue"/>
				</xsl:call-template>
				<xsl:text>, conditionName[</xsl:text>	
				<xsl:call-template name="getConditionPosition">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="conditionCols" select="$conditionCols"/>
				</xsl:call-template>									
				<xsl:text>]) // </xsl:text> <xsl:value-of select="$condition/conditionOperatorName" /><xsl:text> </xsl:text><xsl:value-of select="$condition/ConditionOperand/MinMaxOperand/minOperandValue" /><xsl:text> </xsl:text><xsl:value-of select="$condition/ConditionOperand/MinMaxOperand/maxOperandValue" />			
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>new </xsl:text><xsl:value-of select="$type"/><xsl:text>[] {</xsl:text>
				<xsl:for-each select="$condition/ConditionOperand/multiOperandValue">				
					<xsl:call-template name="factTypeValueToCode">
						<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
						<xsl:with-param name="value" select="."/>
					</xsl:call-template>
					<xsl:if test="position()!=last()">,</xsl:if>
				</xsl:for-each>				
				<xsl:text>}, conditionName[</xsl:text>	
				<xsl:call-template name="getConditionPosition">
					<xsl:with-param name="factTypeName" select="$condition/factTypeName"/>
					<xsl:with-param name="conditionCols" select="$conditionCols"/>
				</xsl:call-template>
				<xsl:text>]) // </xsl:text> <xsl:value-of select="$condition/conditionOperatorName" /><xsl:text> multiOperandValues</xsl:text>			
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>



	<xsl:template name="conclusionCode">
		<xsl:param name="conclusion" />
		<xsl:param name="conclusionFactTypeName" />
		
		<xsl:variable name="attrName"><xsl:call-template name="factTypeToAttrName"><xsl:with-param name="factTypeName" select="$conclusionFactTypeName"/></xsl:call-template></xsl:variable>
		<xsl:variable name="domainKey"><xsl:call-template name="factTypeToDomainKey"><xsl:with-param name="factTypeName" select="$conclusionFactTypeName"/></xsl:call-template></xsl:variable>
		<xsl:variable name="type">		
			<xsl:call-template name="domainKeyToType">
				<xsl:with-param name="domainKey" select="$domainKey"/>
				<xsl:with-param name="contentCardinality" select="'single'"/> <!-- für conclusion setzen immer single -->
			</xsl:call-template>
		</xsl:variable>
		
		<!--  Zuweisungen abhängig vom conclusionOperatorName  -->
		<xsl:choose>
			<xsl:when test="$conclusion/conclusionOperatorName='eq' or $conclusion/conclusionOperatorName='is'">
				<xsl:text>	set</xsl:text><xsl:value-of select="$attrName"/><xsl:text>(</xsl:text>
				<xsl:call-template name="factTypeValueToCode">
					<xsl:with-param name="factTypeName" select="$conclusionFactTypeName"/>
					<xsl:with-param name="value" select="$conclusion/ConclusionOperand/singleOperandValue"/>
				</xsl:call-template>
				<xsl:text>, true); //</xsl:text><xsl:value-of select="$conclusion/ConclusionOperand/singleOperandValue"/>						
			</xsl:when>
			
			<xsl:when test="$conclusion/conclusionOperatorName='are'">			
				<xsl:text>	set</xsl:text><xsl:value-of select="$attrName"/><xsl:text>(new </xsl:text><xsl:value-of select="$type"/><xsl:text>[] {</xsl:text>
				<!-- die Array-Werte können aus singleOperandValues oder aus MultiOperandValue kommen -->
				<xsl:for-each select="$conclusion/ConclusionOperand/*">
					<xsl:call-template name="factTypeValueToCode">
						<xsl:with-param name="factTypeName" select="$conclusionFactTypeName"/>
						<xsl:with-param name="value" select="."/>
					</xsl:call-template>
					<xsl:if test="position()!=last()">,</xsl:if>					
				</xsl:for-each>
				<xsl:text>}, true); // set array values</xsl:text>
				
			</xsl:when>
			<xsl:otherwise>conclusionOperatorName (<xsl:value-of select="$conclusion/conclusionOperatorName"/>) not yet implemented</xsl:otherwise>
		</xsl:choose>
		
		<xsl:text>
			hitCount++;</xsl:text>
	</xsl:template>




	<xsl:template name="conditionOperator">
		<xsl:param name="conditionOperatorName" />
		<xsl:param name="conditionOperand" />
		<xsl:choose>
			<xsl:when test="$conditionOperatorName='is'">OPERATOR_IS</xsl:when>
			<xsl:when test="$conditionOperatorName='eq'">OPERATOR_EQ</xsl:when>
			<xsl:when test="$conditionOperatorName='is not'">OPERATOR_IS_NOT</xsl:when>
			<xsl:when test="$conditionOperatorName='ne'">OPERATOR_NE</xsl:when>
			<xsl:when test="$conditionOperatorName='lt'">OPERATOR_LT</xsl:when>
			<xsl:when test="$conditionOperatorName='gt'">OPERATOR_GT</xsl:when>
			<xsl:when test="$conditionOperatorName='le'">OPERATOR_LE</xsl:when>
			<xsl:when test="$conditionOperatorName='ge'">OPERATOR_GE</xsl:when>

			<xsl:when test="$conditionOperatorName='between' and $conditionOperand/MinMaxOperand/minValueIncluded='false' and $conditionOperand/MinMaxOperand/maxValueIncluded='false'">OPERATOR_BETWEEN_OPEN</xsl:when>
			<xsl:when test="$conditionOperatorName='between' and $conditionOperand/MinMaxOperand/minValueIncluded='false' and $conditionOperand/MinMaxOperand/maxValueIncluded='true'">OPERATOR_BETWEEN_LEFT_OPEN</xsl:when>
			<xsl:when test="$conditionOperatorName='between' and $conditionOperand/MinMaxOperand/minValueIncluded='true' and $conditionOperand/MinMaxOperand/maxValueIncluded='false'">OPERATOR_BETWEEN_RIGHT_OPEN</xsl:when>
			<xsl:when test="$conditionOperatorName='between' and $conditionOperand/MinMaxOperand/minValueIncluded='true' and $conditionOperand/MinMaxOperand/maxValueIncluded='true'">OPERATOR_BETWEEN_CLOSED</xsl:when>

			<xsl:when test="$conditionOperatorName='is one of'">OPERATOR_IS_ONE_OF</xsl:when>
			<xsl:when test="$conditionOperatorName='include'">OPERATOR_INCLUDE</xsl:when>
						
			<xsl:otherwise>conditionOperator: OPERATOR (<xsl:value-of select="$conditionOperatorName"/>,<xsl:value-of select="local-name($conditionOperand/*)"/>) not matched</xsl:otherwise>			
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="getConditionPosition">
		<xsl:param name="factTypeName"/>
		<xsl:param name="conditionCols"/>
		<xsl:for-each select="$conditionCols">
			<xsl:if test=".=$factTypeName"><xsl:value-of select="position()" /></xsl:if>
		</xsl:for-each>
	</xsl:template>


	<!-- Modul für das Concept und Typen Mapping-->
	<xsl:include href="concept_mapping_script.xslt" />

</xsl:stylesheet>