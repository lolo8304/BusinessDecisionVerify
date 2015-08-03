<?xml version="1.0" encoding="UTF-8"?>
<!--
************************************************
XSLT Transformation für die Erstellung des JAVA Methoden für die Test Cases

Als indirekter Input wird ein das ausgelagerte Stylesheet concept_mapping_script benötigt, welches aus den Mapping-Definitionen erstellt werd.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	

	<xsl:template match="BusinessDecisionTest">
		<xsl:variable name="kontrolleId"><xsl:call-template name="BusinessDecisionId"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="@decisionId=$kontrolleId"><xsl:call-template name="generateTestMethod"><xsl:with-param name="businessDecisionTest" select="."></xsl:with-param> </xsl:call-template></xsl:when>
			<xsl:otherwise>concept_mapping_script.xslt does not match to this business decision (<xsl:value-of select="decisionId"/>)</xsl:otherwise>
		</xsl:choose>
	<xsl:text></xsl:text>
	</xsl:template>


<xsl:template name="generateTestMethod">
	<xsl:param name="businessDecisionTest"/>
	<xsl:variable name="objName">
		<xsl:choose>
			<xsl:when test="starts-with(@decisionId,'BD')">bd<xsl:value-of select="substring-after(@decisionId,'BD')"/></xsl:when>
			<xsl:otherwise>o<xsl:value-of select="@decisionId"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="ConclusionAttrName"><xsl:call-template name="factTypeToAttrName"><xsl:with-param name="factTypeName" select="decisionConclusion"/></xsl:call-template></xsl:variable>
	
	 
	<xsl:text>	/*
	 * Generated method for Simple Test Call of Business Decision </xsl:text><xsl:value-of select="@decisionId"/><xsl:text> - </xsl:text><xsl:value-of select="@decisionName"/><xsl:text>
	 *
	 */
	public static void simpleCall_</xsl:text><xsl:value-of select="@decisionId"/><xsl:text>(){
		</xsl:text><xsl:value-of select="@decisionId"/><xsl:text> </xsl:text>
		<xsl:value-of select="$objName"/>
		<xsl:text> = new </xsl:text><xsl:value-of select="@decisionId"/><xsl:text>(true);
				
		if (</xsl:text><xsl:value-of select="$objName"/><xsl:text>.evaluate_business_decision(
			</xsl:text>
		<xsl:for-each select="testCase[1]/value">
			<xsl:variable name="colNr" select="position()" />
			<xsl:variable name="colFactName" select="/BusinessDecisionTest/decisionParameter[number($colNr)]" />
			<xsl:text>	</xsl:text>
			<xsl:if test="position()>1">,</xsl:if>	
			<!--  tbd Array-Type noch nicht berücksichtigt -->
			<xsl:call-template name="factTypeValueToCode">
				<xsl:with-param name="factTypeName" select="$colFactName"/>
				<xsl:with-param name="value" select="."/>
			</xsl:call-template>
			<xsl:text> // </xsl:text><xsl:value-of select="."/><xsl:text> (</xsl:text><xsl:value-of select="$colFactName"/><xsl:text>)
			</xsl:text>
		</xsl:for-each>
		<xsl:text>)) {
        	System.out.println("\nBusiness Decision "+</xsl:text><xsl:value-of select="$objName"/>
        	<xsl:text>.getDecisionId()+": "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getDecisionName());
            System.out.println("Conclusion "+</xsl:text><xsl:value-of select="$objName"/>
            <xsl:text>.getFactName_</xsl:text><xsl:value-of select="$ConclusionAttrName"/>
            <xsl:text>()+" = "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.get</xsl:text><xsl:value-of select="$ConclusionAttrName"/><xsl:text>());        	
            System.out.println("- BD hit Log: "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getRuleIdHitLogBusinessDecision());
            System.out.println("- Deployment Version: "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getDeploymentVersion());
		} else {
			System.out.println(</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getEvaluateErrorMessage());
			System.out.println("- BD hit Log: "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getRuleIdHitLogBusinessDecision());
		}
	}

	/*
	 * Generated method for Bulk Test Calls of Business Decision </xsl:text><xsl:value-of select="@decisionId"/><xsl:text> - </xsl:text><xsl:value-of select="@decisionName"/><xsl:text>
	 *
	 */
	public static void bulkTestEvaluate_</xsl:text><xsl:value-of select="@decisionId"/><xsl:text>(int testCaseNr, </xsl:text><xsl:value-of select="@decisionId"/>
		<xsl:text> </xsl:text><xsl:value-of select="$objName"/>
		<xsl:for-each select="decisionParameter">
			<xsl:variable name="domainKey">
			<xsl:call-template name="factTypeToDomainKey"><xsl:with-param name="factTypeName" select="."/></xsl:call-template>
			</xsl:variable>
			<xsl:variable name="type">
				<xsl:call-template name="domainKeyToType">
					<xsl:with-param name="domainKey" select="$domainKey"/>
					<xsl:with-param name="contentCardinality" select="@contentCardinality"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:text>, </xsl:text><xsl:value-of select="$type"/><xsl:text> p</xsl:text><xsl:value-of select="position()"/>
		</xsl:for-each>
		<xsl:text>) {	
		if (</xsl:text><xsl:value-of select="$objName"/><xsl:text>.evaluate_business_decision(</xsl:text>
		<xsl:for-each select="decisionParameter">
			<xsl:if test="position()>1">, </xsl:if><xsl:text>p</xsl:text><xsl:value-of select="position()"/>
		</xsl:for-each>
		<xsl:text>)) {
			System.out.println(testCaseNr+"\t"+</xsl:text><xsl:value-of select="$objName"/>
			<xsl:text>.get</xsl:text><xsl:value-of select="$ConclusionAttrName"/><xsl:text>()+"\t"+</xsl:text><xsl:value-of select="$objName"/>
			<xsl:text>.getRuleIdHitLogBusinessDecision()+"\ttrue");
		} else {
			System.out.println(testCaseNr+"\t\t"+</xsl:text><xsl:value-of select="$objName"/>
			<xsl:text>.getRuleIdHitLogBusinessDecision()+"\tfalse\t"+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getEvaluateErrorMessage());
		}
	}
	// Test Case Calls
	public static void bulkTest_</xsl:text><xsl:value-of select="@decisionId"/><xsl:text>(){
		</xsl:text><xsl:value-of select="@decisionId"/><xsl:text> </xsl:text>	
		<xsl:value-of select="$objName"/>
		<xsl:text> = new </xsl:text><xsl:value-of select="@decisionId"/><xsl:text>(false);
		
		System.out.println("\nTest Cases for Business Decision "+</xsl:text><xsl:value-of select="$objName"/>
        <xsl:text>.getDecisionId()+": "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getDecisionName());
		System.out.println("- Deployment Version: "+</xsl:text><xsl:value-of select="$objName"/><xsl:text>.getDeploymentVersion()+"\n");
		System.out.println("TestCaseNr\tResult\tRule Hit Log\tevalStatus\tMessage");
		
		</xsl:text>
		<xsl:for-each select="testCase">
			<xsl:text>bulkTestEvaluate_</xsl:text><xsl:value-of select="$businessDecisionTest/@decisionId"/><xsl:text>(</xsl:text><xsl:value-of select="position()"/><xsl:text>,</xsl:text>
			<xsl:value-of select="$objName"/>
			<xsl:for-each select="value">
				<xsl:variable name="colNr" select="position()" />
				<xsl:variable name="colFactName" select="/BusinessDecisionTest/decisionParameter[number($colNr)]" />				
				<xsl:text>,</xsl:text>
				<!--  tbd Array-Type noch nicht berücksichtigt -->
				<xsl:call-template name="factTypeValueToCode">
					<xsl:with-param name="factTypeName" select="$colFactName"/>
					<xsl:with-param name="value" select="."/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:text>); // Testcase </xsl:text><xsl:value-of select="position()"/><xsl:text>
		</xsl:text>
		</xsl:for-each>
		<xsl:text>
	}
</xsl:text>	
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



	<!-- Modul für das Concept und Typen Mapping-->
	<xsl:include href="concept_mapping_script.xslt" />

</xsl:stylesheet>