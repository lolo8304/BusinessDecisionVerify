<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--Concept Element Mapping fuer die BusinessDecision BD0007_001-->
<xsl:template name="BusinessDecisionId">
<xsl:text>BD0007_001</xsl:text>
</xsl:template>
<xsl:template name="factTypeToVariableName">
<xsl:param name="factTypeName"/>
<xsl:choose>
<xsl:when test="$factTypeName='Ausfallwahrscheinlichkeit'">AUSFALL_WAHRSCHEINLICHKEIT_CDKR</xsl:when>
<xsl:when test="$factTypeName='Beschäftigungssituation'">BESCHAEFTIGUNG_ZUSTAND_CDKR</xsl:when>
<xsl:when test="$factTypeName='Kreditbelastung'">KREDIT_BELASTUNG_CDKR</xsl:when>
<xsl:when test="$factTypeName='Hypothekenbelastung'">HYPOTHEK_BELASTUNG_CDKR</xsl:when>
<xsl:when test="$factTypeName='Studentenkredit'">STUDENT_KREDIT_HOEHE_CDKR</xsl:when>
<xsl:when test="$factTypeName='Konsumkredit'">KONSUM_KREDIT_HOEHE_CDKR</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jahre aktueller Job'">ANZAHL_JAHR_IN_JOB_AKTUELL</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jobs letzte 5 Jahre'">ANZAHL_JOB_IN_5_JAHR</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</xsl:template>
<xsl:template name="factTypeToAttrName">
<xsl:param name="factTypeName"/>
<xsl:choose>
<xsl:when test="$factTypeName='Ausfallwahrscheinlichkeit'">Kredit_ausflWhrschktCdkr</xsl:when>
<xsl:when test="$factTypeName='Beschäftigungssituation'">AntragSteller_bschaeftgZustCdkr</xsl:when>
<xsl:when test="$factTypeName='Kreditbelastung'">AntragSteller_krdtBlastgCdkr</xsl:when>
<xsl:when test="$factTypeName='Hypothekenbelastung'">AntragSteller_hyptkBlastgCdkr</xsl:when>
<xsl:when test="$factTypeName='Studentenkredit'">KreditBelastung_studtKrdtHoeheCdkr</xsl:when>
<xsl:when test="$factTypeName='Konsumkredit'">KreditBelastung_konsumKrdtHoeheCdkr</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jahre aktueller Job'">BeschaeftigungSituation_anzJahrJobAktl</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jobs letzte 5 Jahre'">BeschaeftigungSituation_anzJobIn5Jahr</xsl:when>
<xsl:otherwise>attr not mapped</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="factTypeToDomainKey">
<xsl:param name="factTypeName"/>
<xsl:choose>
<xsl:when test="$factTypeName='Ausfallwahrscheinlichkeit'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Beschäftigungssituation'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Kreditbelastung'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Hypothekenbelastung'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Studentenkredit'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Konsumkredit'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jahre aktueller Job'">SMALLINT</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jobs letzte 5 Jahre'">SMALLINT</xsl:when>
<xsl:otherwise>domainKey not mapped</xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template name="factTypeValueToCode">
<xsl:param name="factTypeName"/>
<xsl:param name="value"/>
<xsl:choose>
<xsl:when test="$factTypeName='Ausfallwahrscheinlichkeit'">
<xsl:choose>
<xsl:when test="$value='hoch'">1</xsl:when>
<xsl:when test="$value='mittel'">2</xsl:when>
<xsl:when test="$value='gering'">3</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Beschäftigungssituation'">
<xsl:choose>
<xsl:when test="$value='gut'">1</xsl:when>
<xsl:when test="$value='mittel'">2</xsl:when>
<xsl:when test="$value='schlecht'">3</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Kreditbelastung'">
<xsl:choose>
<xsl:when test="$value='hoch'">1</xsl:when>
<xsl:when test="$value='mittel'">2</xsl:when>
<xsl:when test="$value='gering'">3</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Hypothekenbelastung'">
<xsl:choose>
<xsl:when test="$value='hoch'">1</xsl:when>
<xsl:when test="$value='gering'">2</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Studentenkredit'">
<xsl:choose>
<xsl:when test="$value='hoch'">1</xsl:when>
<xsl:when test="$value='niedrig'">2</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Konsumkredit'">
<xsl:choose>
<xsl:when test="$value='hoch'">1</xsl:when>
<xsl:when test="$value='mittel'">2</xsl:when>
<xsl:when test="$value='niedrig'">3</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jahre aktueller Job'">
<xsl:value-of select="$value"/>
</xsl:when>
<xsl:when test="$factTypeName='Anzahl Jobs letzte 5 Jahre'">
<xsl:value-of select="$value"/>
</xsl:when>
<xsl:otherwise>factTypeName <xsl:value-of select="$factTypeName"/> not mapped</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
