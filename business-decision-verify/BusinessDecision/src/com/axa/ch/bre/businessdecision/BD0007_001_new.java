package com.axa.ch.bre.businessdecision;

public class BD0007_001_new extends BusinessDecisionVerifyer {

	public BD0007_001_new(boolean withRuleEvaluatingLog) {
		super(withRuleEvaluatingLog);
	}

	@Override
	public void evaluate(BusinessDecisionRequestImpl req,
			BusinessDecisionResponseImpl resp) {
		this.newContext(req, resp)
			.doIt()
	}

	/*
	 * Pattern Nr.	Nr.	DecisionTable Ausfallwahrscheinlichkeit
				Condition	Condition	Condition	Conclusion	Message
				Beschäftigungssituation	Hypothekenbelastung	Kreditbelastung	Ausfallwahrscheinlichkeit	Warning
		1	1	is	schlecht												is	hoch					Hände weg
		2	2	is not	schlecht		is	hoch							is	hoch	
		3	3	is not	schlecht		is	gering			is	hoch		is	hoch	
		3	4	is	mittel				is	gering			is	gering		is	mittel	
		3	5	is	gut					is	gering			is	gering		is	gering	
	 */
	
	@Override
	public void evaluateRF0002_001(BusinessDecisionContext context) {
		((Object) context
			.singleHit()
			.useRuleNo(1))
				.condition("Beschäftigungssituation").is("schlecht")
				.conclusion("Ausfallwahrscheinlichkeit").is("hoch").
				.message("warning").is("Hände weg").
			
	}
	
	
	
}
