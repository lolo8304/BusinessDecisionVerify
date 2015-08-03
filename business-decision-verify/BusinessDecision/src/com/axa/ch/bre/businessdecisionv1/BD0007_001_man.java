/*
 * Generated Class from Business Decision Model xy
 * ...
 * ...
 * ...
 */

package com.axa.ch.bre.businessdecisionv1;

public class BD0007_001_man extends BusinessDecisionEvaluator {

    public BD0007_001_man(boolean withRuleEvaluatingLog) {
		super(withRuleEvaluatingLog);
	}
    
	@Override
	public String getDecisionId() {return "BD0007_001";}

	@Override
	public String getDecisionName() {return "Ausfallwahrscheinlichkeit bestimmen";
	}   
	@Override
    public String getDeploymentVersion() {
        return "manuelle test";
    }
    
    //Conclusion Ausfallwahrscheinlichkeit - AUSFALL_WAHRSCHEINLICHKEIT_CDKR
    private int Kredit_ausflWhrschktCdkr; 
    public int getKredit_ausflWhrschktCdkr() {return Kredit_ausflWhrschktCdkr;}
    public String getFactName_Kredit_ausflWhrschktCdkr() {return "Ausfallwahrscheinlichkeit";}
    private void setKredit_ausflWhrschktCdkr(int value, boolean withHitLog) {                
        Kredit_ausflWhrschktCdkr = value; 
        if (withHitLog) {
        	logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    
    
    //Conclusion Beschäftigungssituation - BESCHAEFTIGUNG_ZUSTAND-CDKR
    private int AntragSteller_bschaeftgZustCdkr;
    public int getAntragSteller_bschaeftgZustCdkr() {return AntragSteller_bschaeftgZustCdkr;}
    public String getFactName_AntragSteller_bschaeftgZustCdkr(){return "Beschäftigungssituation";}
    private void setAntragSteller_bschaeftgZustCdkr(int value, boolean withHitLog) {             
        AntragSteller_bschaeftgZustCdkr = value;
        if (withHitLog) {
	        logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };
    
    //Conclusion Kreditbelastung - KREDIT_BELASTUNG_CDKR
    private int AntragSteller_krdtBlastgCdkr;    
    public int getAntragSteller_krdtBlastgCdkr() {return AntragSteller_krdtBlastgCdkr;}
    public String getFactName_AntragSteller_krdtBlastgCdkr() {return "Kreditbelastung";}
    private void setAntragSteller_krdtBlastgCdkr(int value, boolean withHitLog) {                
        AntragSteller_krdtBlastgCdkr = value; 
        if (withHitLog) {
	        logRuleHit(usedRuleFamilyId, usedRuleNr);
        }
    };

    
    //Condition Hypothekenbelastung - HYPOTHEK_BELASTUNG_CDKR
    private int AntragSteller_hyptkBlastgCdkr;
    
    //Condition Studentenkredit - STUDENT_KREDIT_HOEHE_CDKR 
    private int Kreditbelastung_studtKrdtHoeheCdkr;
    
    //Condition Konsumkredit - KONSUM_KREDIT_HOEHE_CDKR     
    private int Kreditbelastung_konsumKrdtHoeheCdkr;
    
    //Condition Anzahl Jarhe aktueller Job - ANZAHL_JARH_IN_JOB_AKTUELL
    private int BeschaeftigungSituation_anzJahrJobAktl;
    
    //Condition Anzahl Jobs letzte 5 Jahre - ANZAHL_JOB_IN_5_JAHR
    private int BeschaeftigungSituation_anzJobIn5Jahr;
    
    public boolean evaluate_business_decision (
            int AntragSteller_hyptkBlastgCdkr,
            int Kreditbelastung_studtKrdtHoeheCdkr,
            int Kreditbelastung_konsumKrdtHoeheCdkr,
            int BeschaeftigungSituation_anzJahrJobAktl,
            int BeschaeftigungSituation_anzJobIn5Jahr
        ) { 
            boolean isEvaluationOk = false;
            
            this.AntragSteller_hyptkBlastgCdkr=AntragSteller_hyptkBlastgCdkr;
            this.Kreditbelastung_studtKrdtHoeheCdkr=Kreditbelastung_studtKrdtHoeheCdkr;
            this.Kreditbelastung_konsumKrdtHoeheCdkr=Kreditbelastung_konsumKrdtHoeheCdkr;
            this.BeschaeftigungSituation_anzJahrJobAktl=BeschaeftigungSituation_anzJahrJobAktl;
            this.BeschaeftigungSituation_anzJobIn5Jahr=BeschaeftigungSituation_anzJobIn5Jahr;

    		// initializing conclusion parameters            
            setKredit_ausflWhrschktCdkr(0,false);
            setAntragSteller_bschaeftgZustCdkr(0,false);
            setAntragSteller_krdtBlastgCdkr(0,false);
            
            evaluateErrorMessage = "";
            ruleIdHitLogBusinessDecision = new StringBuffer("");
            
            try {
                evaluateRF0003_001(); //Kreditbelastung
                evaluateRF0002_001(); //Beschäftigungssituation
                evaluateRF0001_001(); //Ausfallwahrscheinlichkeit
                
                isEvaluationOk = true;
                
            } catch (InvalidConditionEvaluationException e) {
                evaluateErrorMessage=e.getConditionErrorMessage();          
            }   
            
            return isEvaluationOk;
        }
        
    
    /*
     * Rule Family RF0001_001 Ausfallwahrscheinlichkeit
     */
    private void evaluateRF0001_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0001_001";
        int hitCount=0;
        
        String[] conditionName = {"","Beschäftigungssituation","Hypothekenbelastung","Kreditbelastung"};
        
        usedRuleNr = 1;     
        if (condition(AntragSteller_bschaeftgZustCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 3,conditionName[1])  // is schlecht
           ) {
            setKredit_ausflWhrschktCdkr(1,true); //hoch
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(AntragSteller_bschaeftgZustCdkr,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 3, conditionName[1]) // is not schlecht
            && condition(AntragSteller_hyptkBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[2]) // is hoch
           ) { 
            setKredit_ausflWhrschktCdkr(1,true); //hoch
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(AntragSteller_bschaeftgZustCdkr,BusinessDecisionEvaluator.OPERATOR_IS_NOT, 3,conditionName[1]) // is not schlecht
                && condition(AntragSteller_hyptkBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,2, conditionName[2]) // is gering
                && condition(AntragSteller_krdtBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,1, conditionName[3]) // is hoch
               ) { 
                setKredit_ausflWhrschktCdkr(1,true);  //hoch
                hitCount++;
            }
        usedRuleNr = 4;
        if (condition(AntragSteller_bschaeftgZustCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is mittel
                && condition(AntragSteller_hyptkBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,2, conditionName[2]) // is gering
                && condition(AntragSteller_krdtBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,2, conditionName[3]) // is gering
           ) { 
            setKredit_ausflWhrschktCdkr(3,true);  //mittel
            hitCount++;
        }
        usedRuleNr = 5;
        if (condition(AntragSteller_bschaeftgZustCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[1]) // is gut
                && condition(AntragSteller_hyptkBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,2, conditionName[2]) // is gering
                && condition(AntragSteller_krdtBlastgCdkr,BusinessDecisionEvaluator.OPERATOR_IS,2, conditionName[3]) // is gering
           ) { 
            setKredit_ausflWhrschktCdkr(2,true); ; //gering
            hitCount++;
        }       

        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);

        // if the Rule Family numberOfHits is single Hit:       
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one Hit occured", usedRuleFamilyId);                    
    }
    

    /*
     * Rule Family RF0002_001 Beschäftigungssituation
     */
    private void evaluateRF0002_001() throws InvalidConditionEvaluationException{
        usedRuleFamilyId = "RF0002_001";
        int hitCount=0;     

        String[] conditionName = {"","Anzahl Jahre aktueller Job","Anzahl Jobs letzte 5 Jahre"};        

        usedRuleNr = 1;

        if (condition(BeschaeftigungSituation_anzJahrJobAktl,BusinessDecisionEvaluator.OPERATOR_LT, 1, conditionName[1]) // lt 1
                && condition(BeschaeftigungSituation_anzJobIn5Jahr,BusinessDecisionEvaluator.OPERATOR_GT,1, conditionName[2]) // gt 1
         ) {            
            setAntragSteller_bschaeftgZustCdkr(3, true); //prekär
            hitCount++;
        }
        usedRuleNr = 2;
        if (condition(BeschaeftigungSituation_anzJahrJobAktl,BusinessDecisionEvaluator.OPERATOR_LT, 1, conditionName[1]) // lt 1
                && condition(BeschaeftigungSituation_anzJobIn5Jahr,BusinessDecisionEvaluator.OPERATOR_LE,1, conditionName[2]) // le 1
           ) { 
            setAntragSteller_bschaeftgZustCdkr(2, true);  //mittel
            hitCount++;
        }
        usedRuleNr = 3;
        if (condition(BeschaeftigungSituation_anzJahrJobAktl,BusinessDecisionEvaluator.OPERATOR_BETWEEN_CLOSED, 1, 5, conditionName[1]) // between [1,5]
                && condition(BeschaeftigungSituation_anzJobIn5Jahr,BusinessDecisionEvaluator.OPERATOR_GT,2, conditionName[2]) // gt 2
           ) { 
            setAntragSteller_bschaeftgZustCdkr(3, true);  //prekär
            hitCount++;
        }
        usedRuleNr = 4;
        if (condition(BeschaeftigungSituation_anzJahrJobAktl,BusinessDecisionEvaluator.OPERATOR_BETWEEN_CLOSED, 1, 5, conditionName[1]) // between [1,5]
                && condition(BeschaeftigungSituation_anzJobIn5Jahr,BusinessDecisionEvaluator.OPERATOR_LE,2, conditionName[2]) // le 2
           ) { 
            setAntragSteller_bschaeftgZustCdkr(2,true); //mittel
            hitCount++;
        }
        usedRuleNr = 5;
        if (condition(BeschaeftigungSituation_anzJahrJobAktl,BusinessDecisionEvaluator.OPERATOR_GT, 5, conditionName[1]) // gt 5
           ) { 
            setAntragSteller_bschaeftgZustCdkr(1,true);  //gut
            hitCount++;
        }
        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);

        // if the Rule Family numberOfHits is single Hit:       
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);            
                
    }
    
    /*
     * Rule Family RF0003_001 Kreditbelastung
     */
    private void evaluateRF0003_001() throws InvalidConditionEvaluationException {
        usedRuleFamilyId = "RF0003_001";
        int hitCount=0;

        String[] conditionName = {"","Studentenkredit","Konsumkredit"};     
                
        usedRuleNr = 1;     
        if (condition(Kreditbelastung_studtKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[1]) // is hoch
           ) { 
            setAntragSteller_krdtBlastgCdkr(1,true); // hoch
            hitCount++;
        }
        usedRuleNr = 2;     
        if (condition(Kreditbelastung_studtKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is niedrig
                && condition(Kreditbelastung_konsumKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 1, conditionName[2]) // is hoch
           ) { 
                setAntragSteller_krdtBlastgCdkr(1,true); //hoch
                hitCount++;
         }      
        usedRuleNr = 3;     
        if (condition(Kreditbelastung_studtKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is niedrig
                && condition(Kreditbelastung_konsumKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[2]) // is mittel
           ) { 
            setAntragSteller_krdtBlastgCdkr(2,true); // mittel
            hitCount++;
        }       
        usedRuleNr = 4;     
        if (condition(Kreditbelastung_studtKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is niedrig
                && condition(Kreditbelastung_konsumKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 3, conditionName[2]) // is niedrig
           ) { 
             setAntragSteller_krdtBlastgCdkr(3,true); //niedrig
             hitCount++;
         }  

        usedRuleNr = 99;        
        if (condition(Kreditbelastung_studtKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS, 2, conditionName[1]) // is niedrig
                && condition(Kreditbelastung_konsumKrdtHoeheCdkr,BusinessDecisionEvaluator.OPERATOR_IS_ONE_OF, new int[] {-9,3,12,31}, conditionName[2]) // is one of x y z w
           ) { 
             setAntragSteller_krdtBlastgCdkr(3,true); //niedrig
             hitCount++;
         }  

        
        // test of the hit Count
        if (hitCount==0) 
            throw new InvalidConditionEvaluationException("no Hits", usedRuleFamilyId);

        // if the Rule Family numberOfHits is single Hit:       
        if (hitCount>1) 
            throw new InvalidConditionEvaluationException("more then one hit occured", usedRuleFamilyId);            
    }

    
}
