/*
 * Generated Class from Business Decision Model BD0020_001 - Aussetzung Fahrerlaubnis bestimmen
 *
 * Decision valid from: 
 * Decision generated: 
 */
package com.axa.ch.bre.businessdecisionv1;

public class BD0020_001 extends BusinessDecisionEvaluator {
    public BD0020_001(boolean withRuleEvaluatingLog) {
        super(withRuleEvaluatingLog);
    }

    @Override
    public String getDecisionId() {return "BD0020_001";}
    @Override
    public String getDecisionName() {return "Aussetzung Fahrerlaubnis bestimmen";}
    @Override
    public String getDeploymentVersion() {
        return "generated: , System: ";
    }

    // Define Decision Conclusion - Aussetzung Fahrerlaubnis - AUSSETZUNG_FAHR_ERLAUBNIS_CDMF - SMALLINT
    private int Fahrer_austzgFahrErlaubCdmf;
    public int getFahrer_austzgFahrErlaubCdmf(){return Fahrer_austzgFahrErlaubCdmf;}
    public String getFactName_Fahrer_austzgFahrErlaubCdmf() {return "Aussetzung Fahrerlaubnis";}
    private void setFahrer_austzgFahrErlaubCdmf(int value, boolean withHitLog) {
        Fahrer_austzgFahrErlaubCdmf = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Condition - Alter Reaktionstest in Monaten - ALTER_REAKTION_TEST_IN_MONAT - SMALLINT
    private int PhysisTest_alterReaktnTestInMonat;

    // Define Condition - Aktualität Reaktionstest - AKTUALITAET_REAKTION_TEST_CDMF - SMALLINT
    private int PhysisTest_aktlttReaktnTestCdmf;

    // Define Condition - Alter Sehtest in Monaten - ALTER_SEH_TEST_IN_MONAT - SMALLINT
    private int PhysisTest_alterSehTestInMonat;

    // Define Conclusion - Aktualität Sehtest - AKTUALITAET_SEH_TEST_CDMF - SMALLINT
    private int PhysisTest_aktlttSehTestCdmf;
    public int getPhysisTest_aktlttSehTestCdmf(){return PhysisTest_aktlttSehTestCdmf;}
    public String getFactName_PhysisTest_aktlttSehTestCdmf() {return "Aktualität Sehtest";}
    private void setPhysisTest_aktlttSehTestCdmf(int value, boolean withHitLog) {
        PhysisTest_aktlttSehTestCdmf = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Conclusion - Test Physis - TEST_PHYSIS_CDMF - SMALLINT
    private int PhysisTest_testPhysisCdmf;
    public int getPhysisTest_testPhysisCdmf(){return PhysisTest_testPhysisCdmf;}
    public String getFactName_PhysisTest_testPhysisCdmf() {return "Test Physis";}
    private void setPhysisTest_testPhysisCdmf(int value, boolean withHitLog) {
        PhysisTest_testPhysisCdmf = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Condition - Anzahl Verkehrsverstösse letzte 12 Monate - ANZAHL_VERKEHR_VERSTOSS_IN_12_MONAT - SMALLINT
    private int PsychoTest_anzVkehrVstssIn12Monat;

    // Define Conclusion - Bewertung Fahrverhalten - BEWERTUNG_FAHR_VERHALTEN_CDMF - SMALLINT
    private int PsychoTest_bwrtgFahrVhltnCdmf;
    public int getPsychoTest_bwrtgFahrVhltnCdmf(){return PsychoTest_bwrtgFahrVhltnCdmf;}
    public String getFactName_PsychoTest_bwrtgFahrVhltnCdmf() {return "Bewertung Fahrverhalten";}
    private void setPsychoTest_bwrtgFahrVhltnCdmf(int value, boolean withHitLog) {
        PsychoTest_bwrtgFahrVhltnCdmf = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Conclusion - Test Psyche - TEST_PSYCHE_CDMF - SMALLINT
    private int PsychoTest_testPsycheCdmf;
    public int getPsychoTest_testPsycheCdmf(){return PsychoTest_testPsycheCdmf;}
    public String getFactName_PsychoTest_testPsycheCdmf() {return "Test Psyche";}
    private void setPsychoTest_testPsycheCdmf(int value, boolean withHitLog) {
        PsychoTest_testPsycheCdmf = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Condition - inkl. schwere Verkehrsverstösse - KZ_VERKEHR_VERSTOSS_SCHWER_INKLUSIV - SMALLINT
    private int PsychoTest_kzVkehrVstssSchwerInkl;

    public boolean evaluate_business_decision (
        int PhysisTest_alterReaktnTestInMonat,
        int PhysisTest_aktlttReaktnTestCdmf,
        int PhysisTest_alterSehTestInMonat,
        int PsychoTest_anzVkehrVstssIn12Monat,
        int PsychoTest_kzVkehrVstssSchwerInkl
    ) {
        boolean isEvaluationOk = false;
        this.PhysisTest_alterReaktnTestInMonat = PhysisTest_alterReaktnTestInMonat;
        this.PhysisTest_aktlttReaktnTestCdmf = PhysisTest_aktlttReaktnTestCdmf;
        this.PhysisTest_alterSehTestInMonat = PhysisTest_alterSehTestInMonat;
        this.PsychoTest_anzVkehrVstssIn12Monat = PsychoTest_anzVkehrVstssIn12Monat;
        this.PsychoTest_kzVkehrVstssSchwerInkl = PsychoTest_kzVkehrVstssSchwerInkl;
        
        // initializing conclusion parameters
        setFahrer_austzgFahrErlaubCdmf(0,false);        
        setPhysisTest_aktlttSehTestCdmf(0,false);       
        setPhysisTest_testPhysisCdmf(0,false);      
        setPsychoTest_bwrtgFahrVhltnCdmf(0,false);      
        setPsychoTest_testPsycheCdmf(0,false);      
        
        evaluateErrorMessage = "";
        ruleIdHitLogBusinessDecision = new StringBuffer("");

        try {
            evaluateRF0053_001(); //Bewertung Fahrverhalten
            evaluateRF0054_001(); //Test Psyche
            evaluateRF0051_001(); //Aktualität Sehtest
            evaluateRF0050_001(); //Aktualität Reaktionstest
            evaluateRF0052_001(); //Test Physis
            evaluateRF0055_001(); //Aussetzung Fahrerlaubnis
                    
            isEvaluationOk = true;
                
        } catch (InvalidConditionEvaluationException e) {
            evaluateErrorMessage=e.getConditionErrorMessage();          
        }   

        return isEvaluationOk;
    }

    /*
     * RF0055_001 - Aussetzung Fahrerlaubnis
     */
    private void evaluateRF0055_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0055_001";
        int hitCount=0;
        
        String[] conditionName = {"","Test Physis","Test Psyche"};

        usedRuleNr = 1;
        if (condition(PhysisTest_testPhysisCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[1]) // is erforderlich
        ) {
            setFahrer_austzgFahrErlaubCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PhysisTest_testPhysisCdmf,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 1, conditionName[1]) // is not erforderlich
            && condition(PsychoTest_testPsycheCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[2]) // is erforderlich
        ) {
            setFahrer_austzgFahrErlaubCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PhysisTest_testPhysisCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is empfohlen
            && condition(PsychoTest_testPsycheCdmf,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 1, conditionName[2]) // is not erforderlich
        ) {
            setFahrer_austzgFahrErlaubCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 4;
        if (condition(PhysisTest_testPhysisCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[1]) // is nicht erforderlich
            && condition(PsychoTest_testPsycheCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[2]) // is empfohlen
        ) {
            setFahrer_austzgFahrErlaubCdmf(2, true); //empfohlen
            hitCount++;
        }
        usedRuleNr = 5;
        if (condition(PhysisTest_testPhysisCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[1]) // is nicht erforderlich
            && condition(PsychoTest_testPsycheCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[2]) // is nicht erforderlich
        ) {
            setFahrer_austzgFahrErlaubCdmf(3, true); //nicht erforderlich
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0054_001 - Test Psyche
     */
    private void evaluateRF0054_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0054_001";
        int hitCount=0;
        
        String[] conditionName = {"","Bewertung Fahrverhalten"};

        usedRuleNr = 1;
        if (condition(PsychoTest_bwrtgFahrVhltnCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[1]) // is gefährlich
        ) {
            setPsychoTest_testPsycheCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PsychoTest_bwrtgFahrVhltnCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is auffällig
        ) {
            setPsychoTest_testPsycheCdmf(2, true); //empfohlen
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PsychoTest_bwrtgFahrVhltnCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[1]) // is ok
        ) {
            setPsychoTest_testPsycheCdmf(3, true); //nicht erforderlich
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0053_001 - Bewertung Fahrverhalten
     */
    private void evaluateRF0053_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0053_001";
        int hitCount=0;
        
        String[] conditionName = {"","Anzahl Verkehrsverstösse letzte 12 Monate","inkl. schwere Verkehrsverstösse"};

        usedRuleNr = 1;
        if (condition(PsychoTest_anzVkehrVstssIn12Monat,BusinessDecisionEvaluator.OPERATOR_GT, 3, conditionName[1]) // gt 3
            && condition(PsychoTest_kzVkehrVstssSchwerInkl,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[2]) // is ja
        ) {
            setPsychoTest_bwrtgFahrVhltnCdmf(1, true); //gefährlich
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PsychoTest_anzVkehrVstssIn12Monat,BusinessDecisionEvaluator.OPERATOR_GT, 3, conditionName[1]) // gt 3
            && condition(PsychoTest_kzVkehrVstssSchwerInkl,BusinessDecisionEvaluator.OPERATOR_IS, 0, conditionName[2]) // is nein
        ) {
            setPsychoTest_bwrtgFahrVhltnCdmf(2, true); //auffällig
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PsychoTest_anzVkehrVstssIn12Monat,BusinessDecisionEvaluator.OPERATOR_LT, 3, conditionName[1]) // lt 3
        ) {
            setPsychoTest_bwrtgFahrVhltnCdmf(3, true); //ok
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0052_001 - Test Physis
     */
    private void evaluateRF0052_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0052_001";
        int hitCount=0;
        
        String[] conditionName = {"","Aktualität Reaktionstest","Aktualität Sehtest"};

        usedRuleNr = 1;
        if (condition(PhysisTest_aktlttReaktnTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[1]) // is abgelaufen
        ) {
            setPhysisTest_testPhysisCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PhysisTest_aktlttReaktnTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 1, conditionName[1]) // is not abgelaufen
            && condition(PhysisTest_aktlttSehTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[2]) // is abgelaufen
        ) {
            setPhysisTest_testPhysisCdmf(1, true); //erforderlich
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PhysisTest_aktlttReaktnTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is veraltet
            && condition(PhysisTest_aktlttSehTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 1, conditionName[2]) // is not abgelaufen
        ) {
            setPhysisTest_testPhysisCdmf(2, true); //empfohlen
            hitCount++;
        }
        usedRuleNr = 4;
        if (condition(PhysisTest_aktlttReaktnTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[1]) // is aktuell
            && condition(PhysisTest_aktlttSehTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[2]) // is veraltet
        ) {
            setPhysisTest_testPhysisCdmf(2, true); //empfohlen
            hitCount++;
        }
        usedRuleNr = 5;
        if (condition(PhysisTest_aktlttReaktnTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[1]) // is aktuell
            && condition(PhysisTest_aktlttSehTestCdmf,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[2]) // is aktuell
        ) {
            setPhysisTest_testPhysisCdmf(3, true); //nicht erforderlich
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0051_001 - Aktualität Sehtest
     */
    private void evaluateRF0051_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0051_001";
        int hitCount=0;
        
        String[] conditionName = {"","Alter Sehtest in Monaten"};

        usedRuleNr = 1;
        if (condition(PhysisTest_alterSehTestInMonat,BusinessDecisionEvaluator.OPERATOR_GT, 24, conditionName[1]) // gt 24
        ) {
            setPhysisTest_aktlttSehTestCdmf(1, true); //abgelaufen
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PhysisTest_alterSehTestInMonat,BusinessDecisionEvaluator.OPERATOR_BETWEEN_CLOSED, 18, 24, conditionName[1]) // between 18 24
        ) {
            setPhysisTest_aktlttSehTestCdmf(2, true); //veraltet
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PhysisTest_alterSehTestInMonat,BusinessDecisionEvaluator.OPERATOR_LT, 18, conditionName[1]) // lt 18
        ) {
            setPhysisTest_aktlttSehTestCdmf(3, true); //aktuell
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0050_001 - Aktualität Reaktionstest
     */
    private void evaluateRF0050_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0050_001";
        int hitCount=0;
        
        String[] conditionName = {"","Alter Reaktionstest in Monaten"};

        usedRuleNr = 1;
        if (condition(PhysisTest_alterReaktnTestInMonat,BusinessDecisionEvaluator.OPERATOR_GT, 12, conditionName[1]) // gt 12
        ) {
            setPhysisTest_aktlttSehTestCdmf(1, true); //abgelaufen
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(PhysisTest_alterReaktnTestInMonat,BusinessDecisionEvaluator.OPERATOR_BETWEEN_CLOSED, 9, 12, conditionName[1]) // between 9 12
        ) {
            setPhysisTest_aktlttSehTestCdmf(2, true); //veraltet
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(PhysisTest_alterReaktnTestInMonat,BusinessDecisionEvaluator.OPERATOR_LT, 9, conditionName[1]) // lt 9
        ) {
            setPhysisTest_aktlttSehTestCdmf(3, true); //aktuell
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
}