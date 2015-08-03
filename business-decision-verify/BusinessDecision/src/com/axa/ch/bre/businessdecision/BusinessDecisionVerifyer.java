package com.axa.ch.bre.businessdecision;

public abstract class BusinessDecisionVerifyer implements BusinessDecisionInterface {

	public BusinessDecisionVerifyer(boolean withRuleEvaluatingLog) {
	}
	
	public BusinessDecisionContext newContext(BusinessDecisionRequestImpl req, BusinessDecisionResponseImpl resp) {
		return new BusinessDecisionContext(req, resp);
	}

	public abstract void evaluate(BusinessDecisionRequestImpl req, BusinessDecisionResponseImpl resp);

	
}

