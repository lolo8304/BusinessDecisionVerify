/*
 * Generated Class from Business Decision Model BD0010_001 - Versandart Fragebogen bestimmen
 *
 * Decision valid from: 
 * Decision generated: 
 */
package com.axa.ch.bre.businessdecisionv1;

public class BD0010_001 extends BusinessDecisionEvaluator {
    public BD0010_001(boolean withRuleEvaluatingLog) {
        super(withRuleEvaluatingLog);
    }

    @Override
    public String getDecisionId() {return "BD0010_001";}
    @Override
    public String getDecisionName() {return "Versandart Fragebogen bestimmen";}
    @Override
    public String getDeploymentVersion() {
        return "generated: , System: ";
    }

    // Define Conclusion - Liste Interview-Frage - ARRAY_INTERVIEW_FRAGE - SMALLINT
    private int[] Fragebogen_intervFrage;
    public int[] getFragebogen_intervFrage(){return Fragebogen_intervFrage;}
    public String getFactName_Fragebogen_intervFrage() {return "Liste Interview-Frage";}
    private void setFragebogen_intervFrage(int[] value, boolean withHitLog) {
        Fragebogen_intervFrage = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Decision Conclusion - Versandart-Fragebogen - VERSAND_ART_CDOMS_FRAGEBOGEN - SMALLINT
    private int Versand_vsndArtCdomsFrgbgn;
    public int getVersand_vsndArtCdomsFrgbgn(){return Versand_vsndArtCdomsFrgbgn;}
    public String getFactName_Versand_vsndArtCdomsFrgbgn() {return "Versandart-Fragebogen";}
    private void setVersand_vsndArtCdomsFrgbgn(int value, boolean withHitLog) {
        Versand_vsndArtCdomsFrgbgn = value;
        if (withHitLog) {
            logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    

    // Define Condition - Beruf - BERUF_CDGPD - SMALLINT
    private int Person_brufCdgpd;

    public boolean evaluate_business_decision (
        int Person_brufCdgpd
    ) {
        boolean isEvaluationOk = false;
        this.Person_brufCdgpd = Person_brufCdgpd;
        
        // initializing conclusion parameters
        setFragebogen_intervFrage(null,false);      
        setVersand_vsndArtCdomsFrgbgn(0,false);     
        
        evaluateErrorMessage = "";
        ruleIdHitLogBusinessDecision = new StringBuffer("");

        try {
            evaluateRF0043_001(); //Liste Interview-Frage
            evaluateRF0044_001(); //Versandart Fragebogen
                    
            isEvaluationOk = true;
                
        } catch (InvalidConditionEvaluationException e) {
            evaluateErrorMessage=e.getConditionErrorMessage();          
        }   

        return isEvaluationOk;
    }

    /*
     * RF0044_001 - Versandart Fragebogen
     */
    private void evaluateRF0044_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0044_001";
        int hitCount=0;
        
        String[] conditionName = {"","Liste Interview-Frage"};

        usedRuleNr = 1;
        if (condition(Fragebogen_intervFrage,BusinessDecisionEvaluator.OPERATOR_INCLUDE, new int[] {3,4}, conditionName[1]) // include multiOperandValues
        ) {
            setVersand_vsndArtCdomsFrgbgn(1, true); //eMail
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(Fragebogen_intervFrage,BusinessDecisionEvaluator.OPERATOR_INCLUDE, new int[] {5,6}, conditionName[1]) // include multiOperandValues
        ) {
            setVersand_vsndArtCdomsFrgbgn(2, true); //Post
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(Fragebogen_intervFrage,BusinessDecisionEvaluator.OPERATOR_INCLUDE, new int[] {7,8}, conditionName[1]) // include multiOperandValues
        ) {
            setVersand_vsndArtCdomsFrgbgn(3, true); //persönlich
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
    /*
     * RF0043_001 - Liste Interview-Frage
     */
    private void evaluateRF0043_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0043_001";
        int hitCount=0;
        
        String[] conditionName = {"","Beruf"};

        usedRuleNr = 1;
        if (condition(Person_brufCdgpd,BusinessDecisionEvaluator.OPERATOR_IS_ONE_OF, new int[] {1,2}, conditionName[1]) // is one of multiOperandValues
        ) {
            setFragebogen_intervFrage(new int[] {1,2,3,4}, true); // set array values
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(Person_brufCdgpd,BusinessDecisionEvaluator.OPERATOR_IS_ONE_OF, new int[] {3,4}, conditionName[1]) // is one of multiOperandValues
        ) {
            setFragebogen_intervFrage(new int[] {1,2,5,6}, true); // set array values
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(Person_brufCdgpd,BusinessDecisionEvaluator.OPERATOR_IS_ONE_OF, new int[] {5,6}, conditionName[1]) // is one of multiOperandValues
        ) {
            setFragebogen_intervFrage(new int[] {1,2,7,8}, true); // set array values
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);
        
    }
    
}