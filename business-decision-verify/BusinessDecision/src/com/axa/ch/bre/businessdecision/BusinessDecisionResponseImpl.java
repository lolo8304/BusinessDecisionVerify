package com.axa.ch.bre.businessdecision;

public class BusinessDecisionResponseImpl extends BusinessDecisionRequestImpl {

	public BusinessDecisionResponseImpl(BusinessDecisionRequestImpl req) {
		super();
		this.setData(req.getData());
	}
}
