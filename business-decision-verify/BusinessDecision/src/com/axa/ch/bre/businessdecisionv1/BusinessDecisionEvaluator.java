package com.axa.ch.bre.businessdecisionv1;

import java.util.Arrays;

/*
 * BRE Grundklasse, Variante ohne Klassenbildung für Conditions und Conclusions 
 * 
 */
public abstract class BusinessDecisionEvaluator {

    protected static final int OPERATOR_EQ = 1000;
    protected static final int OPERATOR_IS = 1001;
    protected static final int OPERATOR_IS_NOT = 1002;
    protected static final int OPERATOR_LT = 1003;
    protected static final int OPERATOR_GT = 1004;
    protected static final int OPERATOR_LE = 1005;
    protected static final int OPERATOR_GE = 1006;
    protected static final int OPERATOR_BETWEEN_CLOSED = 1007;
    protected static final int OPERATOR_BETWEEN_OPEN = 1008;
    protected static final int OPERATOR_BETWEEN_LEFT_OPEN = 1009;
    protected static final int OPERATOR_BETWEEN_RIGHT_OPEN = 1010;
    
    protected static final int OPERATOR_IS_BEFORE = 1011; // ?
    protected static final int OPERATOR_IS_BETWEEN = 1012;
    protected static final int OPERATOR_IS_AFTER = 1013;
    
    protected static final int OPERATOR_CONTAINS = 1014;
    
    protected static final int OPERATOR_IS_ONE_OF = 1015;
    protected static final int OPERATOR_IS_NOT_ONE_OF = 1016;
    
    protected static final int OPERATOR_INCLUDE = 1017;
    protected static final int OPERATOR_EXCLUDE = 1018;
    
    // Instanzvariabeln    
    protected String evaluateErrorMessage;
    protected StringBuffer ruleIdHitLogBusinessDecision;
    
    protected String usedRuleFamilyId;
    protected int usedRuleNr;
    protected boolean withRuleEvaluatingLog=false;

    protected void logRuleHit(String ruleFamily, int ruleNr){
        ruleIdHitLogBusinessDecision.append(ruleFamily+"("+Integer.toString(ruleNr)+");");
    }
    
    public String getEvaluateErrorMessage(){return evaluateErrorMessage;}
    public String getRuleIdHitLogBusinessDecision(){return ruleIdHitLogBusinessDecision.toString();}

    
    public BusinessDecisionEvaluator(boolean withRuleEvaluatingLog){
    	super();
    	this.withRuleEvaluatingLog=withRuleEvaluatingLog;
    }

    // abstrakte Methoden
    abstract String getDeploymentVersion();
    abstract String getDecisionId();
    abstract String getDecisionName();
    
    
/*
 * Condition for int op int
 */
    protected boolean condition(int factValue, int operator, int operandValue, String factTypeName) throws InvalidConditionEvaluationException {
        boolean result = false;
        switch (operator) {
        case OPERATOR_EQ:
        case OPERATOR_IS: result = factValue==operandValue; break;
        case OPERATOR_IS_NOT: result = factValue!=operandValue; break;
        case OPERATOR_LT: result = factValue<operandValue; break;
        case OPERATOR_GT: result = factValue>operandValue; break;
        case OPERATOR_LE: result = factValue<=operandValue; break;
        case OPERATOR_GE: result = factValue>=operandValue; break;
        
        default: throw new InvalidConditionEvaluationException("Exception: Operator (int op int) not implemented", usedRuleFamilyId, usedRuleNr, factTypeName, operator, Integer.toString(factValue), Integer.toString(operandValue));
        } 
        
        if (withRuleEvaluatingLog){
        	doPrintConditionLog(factTypeName, Integer.toString(factValue), operator, Integer.toString(operandValue), result);
        }
        
        return result;
    }

    
    /*
     * Condition for int op int int
     */
    protected boolean condition(int factValue, int operator, int operandValue1, int operandValue2, String factTypeName ) throws InvalidConditionEvaluationException {
        boolean result = false;
        
        switch (operator) {
        case OPERATOR_BETWEEN_CLOSED: result = (factValue>=operandValue1) && (factValue<=operandValue2); break;
        
        default: throw new InvalidConditionEvaluationException("Exception: Operator (int op int int) not implemented", usedRuleFamilyId, usedRuleNr, factTypeName, operator, Integer.toString(factValue), Integer.toString(operandValue1)+"/"+Integer.toString(operandValue2));
        }       

        if (withRuleEvaluatingLog){
        	doPrintConditionLog(factTypeName, Integer.toString(factValue), operator, Integer.toString(operandValue1)+","+Integer.toString(operandValue2), result);
        }

        return result;
    }

    /*
     * Condition for int op int[] 
     */
    protected boolean condition(int factValue, int operator, int[] operandValues, String factTypeName ) throws InvalidConditionEvaluationException {
        boolean result = false;
        
        switch (operator) {
        case OPERATOR_IS_ONE_OF: 
            for (int i=0;i<operandValues.length;i++){
                if (factValue == operandValues[i])
                    result = true;
            }
            break;
        
        default:
            throw new InvalidConditionEvaluationException("Exception: Operator (int op int[]) not implemented", usedRuleFamilyId, usedRuleNr, factTypeName, operator, Integer.toString(factValue), Arrays.toString(operandValues));
        }

        if (withRuleEvaluatingLog){
        	doPrintConditionLog(factTypeName, Integer.toString(factValue), operator,  Arrays.toString(operandValues), result);
        }

        
        return result;
    }

    /*
     * Condition for int[] op int[] 
     */
    protected boolean condition(int[] factValues, int operator, int[] operandValues, String factTypeName ) throws InvalidConditionEvaluationException {
        boolean result = false;
        
        switch (operator) {
        case OPERATOR_INCLUDE:
        	// die menge der operanden muss in factvalues enthalten sein
        	boolean gefunden;
        	
        	int i=-1;
        	do {
        		i++;
        		gefunden=false;
        		for (int j=0;j<factValues.length;j++){
        			if (operandValues[i]==factValues[j])
        				gefunden=true;
        		}
        	} while (gefunden && (i<operandValues.length-1)); // wenn ein Wert nicht gefunden wird, kann sofort abgebrochen werden
        	
        	result=gefunden;
            break;
        
        default:
            throw new InvalidConditionEvaluationException("Exception: Operator (int[] op int[]) not implemented", usedRuleFamilyId, usedRuleNr, factTypeName, operator, Arrays.toString(factValues), Arrays.toString(operandValues) );
        }

        if (withRuleEvaluatingLog){
        	doPrintConditionLog(factTypeName, Arrays.toString(factValues), operator,  Arrays.toString(operandValues), result);
        }

        
        return result;
    }
    
    private void doPrintConditionLog(String condName, String factValue, int operator, String operandValue, boolean result){
    	System.out.println(getDecisionId()+": "+usedRuleFamilyId
    			+"("+usedRuleNr+") Condition ["+condName+"] "
    			+" factvalue: "+factValue
    			+" operator: "+getOperatorBezeichnung(operator)
    			+" operandValue: "+operandValue
    			+" compare result: "+result);    	
    }
    
    
    protected static String getOperatorBezeichnung(int op) {
        switch (op) {
        case OPERATOR_EQ: return "=";
        case OPERATOR_IS: return "is";
        case OPERATOR_IS_NOT: return "is not";
        case OPERATOR_LT: return "lt";
        case OPERATOR_GT: return "gt";
        case OPERATOR_LE: return "le";
        case OPERATOR_GE: return "ge";
        case OPERATOR_BETWEEN_CLOSED: return "between []";
        case OPERATOR_BETWEEN_OPEN: return "between()";
        case OPERATOR_BETWEEN_LEFT_OPEN: return "between (]";
        case OPERATOR_BETWEEN_RIGHT_OPEN: return "between [)";
        case OPERATOR_IS_BEFORE: return "is before";
        case OPERATOR_IS_BETWEEN: return "is between";
        case OPERATOR_IS_AFTER: return "is after";
        case OPERATOR_CONTAINS: return "contains";
        case OPERATOR_IS_ONE_OF: return "is one of";
        case OPERATOR_IS_NOT_ONE_OF: return "is not one of";
        case OPERATOR_INCLUDE: return "include";
        case OPERATOR_EXCLUDE: return "exclude";

        default: return "operator ?";
        }
    }

}



@SuppressWarnings("serial")
class InvalidConditionEvaluationException extends Exception {
    public InvalidConditionEvaluationException () {      
    }
    public InvalidConditionEvaluationException(String meldung) {
        super(meldung);
    }
    public InvalidConditionEvaluationException(String reason, String ruleFamilyId) {
        super(reason);      
        usedRuleFamily = ruleFamilyId;
        parameterRange=5;
    }

    public InvalidConditionEvaluationException(String reason, String ruleFamilyId, int ruleNr, String condName, int operator, String factValue, String operandValue ) {
        super(reason);      
        usedRuleFamily = ruleFamilyId+"("+ruleNr+")";
        usedOperator = BusinessDecisionEvaluator.getOperatorBezeichnung(operator);
        conditionName = condName;
        this.factValue = factValue;
        this.operandValue = operandValue;
        parameterRange=9;
    }
        
    private String usedRuleFamily;
    private String conditionName;
    private String usedOperator;
    private String factValue;
    private String operandValue;

    public String getConditionErrorMessage(){
        
        switch (parameterRange) {
        case 9:
            return this.getMessage()
                    +"/Rule Family: " + usedRuleFamily
                    +"/Condition: " + conditionName
                    +"/usedOperator: " + usedOperator
                    +"/factValue: " + factValue
                    +"/OperandValue: " + operandValue;
        case 5:
            return this.getMessage()
                    +"/Rule Family: " + usedRuleFamily;
        default: 
            return this.getMessage();
        }
    }
    
    private int parameterRange=0; // steuert die Fehlermeldung
}
