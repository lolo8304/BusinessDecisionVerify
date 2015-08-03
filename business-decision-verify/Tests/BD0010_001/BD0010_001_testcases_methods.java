	/*
	 * Generated method for Simple Test Call of Business Decision BD0010_001 - Versandart Fragebogen bestimmen
	 *
	 */
	public static void simpleCall_BD0010_001(){
		BD0010_001 bd0010_001 = new BD0010_001(true);
				
		if (bd0010_001.evaluate_business_decision(
				1 // Consultant (Beruf)
			)) {
        	System.out.println("\nBusiness Decision "+bd0010_001.getDecisionId()+": "+bd0010_001.getDecisionName());
            System.out.println("Conclusion "+bd0010_001.getFactName_Versand_vsndArtCdomsFrgbgn()+" = "+bd0010_001.getVersand_vsndArtCdomsFrgbgn());        	
            System.out.println("- BD hit Log: "+bd0010_001.getRuleIdHitLogBusinessDecision());
            System.out.println("- Deployment Version: "+bd0010_001.getDeploymentVersion());
		} else {
			System.out.println(bd0010_001.getEvaluateErrorMessage());
			System.out.println("- BD hit Log: "+bd0010_001.getRuleIdHitLogBusinessDecision());
		}
	}

	/*
	 * Generated method for Bulk Test Calls of Business Decision BD0010_001 - Versandart Fragebogen bestimmen
	 *
	 */
	public static void bulkTestEvaluate_BD0010_001(int testCaseNr, BD0010_001 bd0010_001, int p1) {	
		if (bd0010_001.evaluate_business_decision(p1)) {
			System.out.println(testCaseNr+"\t"+bd0010_001.getVersand_vsndArtCdomsFrgbgn()+"\t"+bd0010_001.getRuleIdHitLogBusinessDecision()+"\ttrue");
		} else {
			System.out.println(testCaseNr+"\t\t"+bd0010_001.getRuleIdHitLogBusinessDecision()+"\tfalse\t"+bd0010_001.getEvaluateErrorMessage());
		}
	}
	// Test Case Calls
	public static void bulkTest_BD0010_001(){
		BD0010_001 bd0010_001 = new BD0010_001(false);
		
		System.out.println("\nTest Cases for Business Decision "+bd0010_001.getDecisionId()+": "+bd0010_001.getDecisionName());
		System.out.println("- Deployment Version: "+bd0010_001.getDeploymentVersion()+"\n");
		System.out.println("TestCaseNr\tResult\tRule Hit Log\tevalStatus\tMessage");
		
		bulkTestEvaluate_BD0010_001(1,bd0010_001,1); // Testcase 1
		bulkTestEvaluate_BD0010_001(2,bd0010_001,2); // Testcase 2
		bulkTestEvaluate_BD0010_001(3,bd0010_001,3); // Testcase 3
		bulkTestEvaluate_BD0010_001(4,bd0010_001,4); // Testcase 4
		bulkTestEvaluate_BD0010_001(5,bd0010_001,5); // Testcase 5
		bulkTestEvaluate_BD0010_001(6,bd0010_001,6); // Testcase 6
		
	}
