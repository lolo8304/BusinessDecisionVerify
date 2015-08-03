package com.axa.ch.bre.businessdecision;

public class BusinessDecisionContext {

	BusinessDecisionRequestImpl request;
	BusinessDecisionResponseImpl response;
	
	public BusinessDecisionContext(BusinessDecisionRequestImpl req, BusinessDecisionResponseImpl resp) {
		super();
		this.setRequest(req);
		this.setResponse(resp);
	}

	public BusinessDecisionRequestImpl getRequest() {
		return request;
	}

	public void setRequest(BusinessDecisionRequestImpl request) {
		this.request = request;
	}

	public BusinessDecisionResponseImpl getResponse() {
		return response;
	}

	public void setResponse(BusinessDecisionResponseImpl response) {
		this.response = response;
	}

	
	/* action methods to execute rules */
	
	public BusinessDecisionContext ruleFamily(String ruleFamilyName) {
		return this;
	}

	public BusinessDecisionContext singleHit() {
		return this;
	}

	public BusinessDecisionContext multiHit() {
		return this;
	}
	public BusinessDecisionContext multiHit(int exactNumber) {
		return this;
	}

	public Object useRuleNo(int i) {
		// TODO Auto-generated method stub
		return null;
	}
}
