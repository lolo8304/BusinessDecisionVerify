	/*
	 * Generated method for Simple Test Call of Business Decision BD0007_001 - Ausfallwahrscheinlichkeit bestimmen
	 *
	 */
	public static void simpleCall_BD0007_001(){
		BD0007_001 bd0007_001 = new BD0007_001(true);
				
		if (bd0007_001.evaluate_business_decision(
				1 // hoch (Hypothekenbelastung)
				,1 // hoch (Studentenkredit)
				,1 // hoch (Konsumkredit)
				,0 // 0 (Anzahl Jahre aktueller Job)
				,1 // 1 (Anzahl Jobs letzte 5 Jahre)
			)) {
        	System.out.println("\nBusiness Decision "+bd0007_001.getDecisionId()+": "+bd0007_001.getDecisionName());
            System.out.println("Conclusion "+bd0007_001.getFactName_Kredit_ausflWhrschktCdkr()+" = "+bd0007_001.getKredit_ausflWhrschktCdkr());        	
            System.out.println("- BD hit Log: "+bd0007_001.getRuleIdHitLogBusinessDecision());
            System.out.println("- Deployment Version: "+bd0007_001.getDeploymentVersion());
		} else {
			System.out.println(bd0007_001.getEvaluateErrorMessage());
			System.out.println("- BD hit Log: "+bd0007_001.getRuleIdHitLogBusinessDecision());
		}
	}

	/*
	 * Generated method for Bulk Test Calls of Business Decision BD0007_001 - Ausfallwahrscheinlichkeit bestimmen
	 *
	 */
	public static void bulkTestEvaluate_BD0007_001(int testCaseNr, BD0007_001 bd0007_001, int p1, int p2, int p3, int p4, int p5) {	
		if (bd0007_001.evaluate_business_decision(p1, p2, p3, p4, p5)) {
			System.out.println(testCaseNr+"\t"+bd0007_001.getKredit_ausflWhrschktCdkr()+"\t"+bd0007_001.getRuleIdHitLogBusinessDecision()+"\ttrue");
		} else {
			System.out.println(testCaseNr+"\t\t"+bd0007_001.getRuleIdHitLogBusinessDecision()+"\tfalse\t"+bd0007_001.getEvaluateErrorMessage());
		}
	}
	// Test Case Calls
	public static void bulkTest_BD0007_001(){
		BD0007_001 bd0007_001 = new BD0007_001(false);
		
		System.out.println("\nTest Cases for Business Decision "+bd0007_001.getDecisionId()+": "+bd0007_001.getDecisionName());
		System.out.println("- Deployment Version: "+bd0007_001.getDeploymentVersion()+"\n");
		System.out.println("TestCaseNr\tResult\tRule Hit Log\tevalStatus\tMessage");
		
		bulkTestEvaluate_BD0007_001(1,bd0007_001,1,1,1,0,1); // Testcase 1
		bulkTestEvaluate_BD0007_001(2,bd0007_001,1,1,1,0,2); // Testcase 2
		bulkTestEvaluate_BD0007_001(3,bd0007_001,1,1,1,1,1); // Testcase 3
		bulkTestEvaluate_BD0007_001(4,bd0007_001,1,1,1,1,2); // Testcase 4
		bulkTestEvaluate_BD0007_001(5,bd0007_001,1,1,1,5,1); // Testcase 5
		bulkTestEvaluate_BD0007_001(6,bd0007_001,1,1,1,5,2); // Testcase 6
		bulkTestEvaluate_BD0007_001(7,bd0007_001,1,1,1,6,1); // Testcase 7
		bulkTestEvaluate_BD0007_001(8,bd0007_001,1,1,1,6,2); // Testcase 8
		bulkTestEvaluate_BD0007_001(9,bd0007_001,1,1,3,0,1); // Testcase 9
		bulkTestEvaluate_BD0007_001(10,bd0007_001,1,1,3,0,2); // Testcase 10
		bulkTestEvaluate_BD0007_001(11,bd0007_001,1,1,3,1,1); // Testcase 11
		bulkTestEvaluate_BD0007_001(12,bd0007_001,1,1,3,1,2); // Testcase 12
		bulkTestEvaluate_BD0007_001(13,bd0007_001,1,1,3,5,1); // Testcase 13
		bulkTestEvaluate_BD0007_001(14,bd0007_001,1,1,3,5,2); // Testcase 14
		bulkTestEvaluate_BD0007_001(15,bd0007_001,1,1,3,6,1); // Testcase 15
		bulkTestEvaluate_BD0007_001(16,bd0007_001,1,1,3,6,2); // Testcase 16
		bulkTestEvaluate_BD0007_001(17,bd0007_001,1,2,1,0,1); // Testcase 17
		bulkTestEvaluate_BD0007_001(18,bd0007_001,1,2,1,0,2); // Testcase 18
		bulkTestEvaluate_BD0007_001(19,bd0007_001,1,2,1,1,1); // Testcase 19
		bulkTestEvaluate_BD0007_001(20,bd0007_001,1,2,1,1,2); // Testcase 20
		bulkTestEvaluate_BD0007_001(21,bd0007_001,1,2,1,5,1); // Testcase 21
		bulkTestEvaluate_BD0007_001(22,bd0007_001,1,2,1,5,2); // Testcase 22
		bulkTestEvaluate_BD0007_001(23,bd0007_001,1,2,1,6,1); // Testcase 23
		bulkTestEvaluate_BD0007_001(24,bd0007_001,1,2,1,6,2); // Testcase 24
		bulkTestEvaluate_BD0007_001(25,bd0007_001,1,2,3,0,1); // Testcase 25
		bulkTestEvaluate_BD0007_001(26,bd0007_001,1,2,3,0,2); // Testcase 26
		bulkTestEvaluate_BD0007_001(27,bd0007_001,1,2,3,1,1); // Testcase 27
		bulkTestEvaluate_BD0007_001(28,bd0007_001,1,2,3,1,2); // Testcase 28
		bulkTestEvaluate_BD0007_001(29,bd0007_001,1,2,3,5,1); // Testcase 29
		bulkTestEvaluate_BD0007_001(30,bd0007_001,1,2,3,5,2); // Testcase 30
		bulkTestEvaluate_BD0007_001(31,bd0007_001,1,2,3,6,1); // Testcase 31
		bulkTestEvaluate_BD0007_001(32,bd0007_001,1,2,3,6,2); // Testcase 32
		bulkTestEvaluate_BD0007_001(33,bd0007_001,2,1,1,0,1); // Testcase 33
		bulkTestEvaluate_BD0007_001(34,bd0007_001,2,1,1,0,2); // Testcase 34
		bulkTestEvaluate_BD0007_001(35,bd0007_001,2,1,1,1,1); // Testcase 35
		bulkTestEvaluate_BD0007_001(36,bd0007_001,2,1,1,1,2); // Testcase 36
		bulkTestEvaluate_BD0007_001(37,bd0007_001,2,1,1,5,1); // Testcase 37
		bulkTestEvaluate_BD0007_001(38,bd0007_001,2,1,1,5,2); // Testcase 38
		bulkTestEvaluate_BD0007_001(39,bd0007_001,2,1,1,6,1); // Testcase 39
		bulkTestEvaluate_BD0007_001(40,bd0007_001,2,1,1,6,2); // Testcase 40
		bulkTestEvaluate_BD0007_001(41,bd0007_001,2,1,3,0,1); // Testcase 41
		bulkTestEvaluate_BD0007_001(42,bd0007_001,2,1,3,0,2); // Testcase 42
		bulkTestEvaluate_BD0007_001(43,bd0007_001,2,1,3,1,1); // Testcase 43
		bulkTestEvaluate_BD0007_001(44,bd0007_001,2,1,3,1,2); // Testcase 44
		bulkTestEvaluate_BD0007_001(45,bd0007_001,2,1,3,5,1); // Testcase 45
		bulkTestEvaluate_BD0007_001(46,bd0007_001,2,1,3,5,2); // Testcase 46
		bulkTestEvaluate_BD0007_001(47,bd0007_001,2,1,3,6,1); // Testcase 47
		bulkTestEvaluate_BD0007_001(48,bd0007_001,2,1,3,6,2); // Testcase 48
		bulkTestEvaluate_BD0007_001(49,bd0007_001,2,2,1,0,1); // Testcase 49
		bulkTestEvaluate_BD0007_001(50,bd0007_001,2,2,1,0,2); // Testcase 50
		bulkTestEvaluate_BD0007_001(51,bd0007_001,2,2,1,1,1); // Testcase 51
		bulkTestEvaluate_BD0007_001(52,bd0007_001,2,2,1,1,2); // Testcase 52
		bulkTestEvaluate_BD0007_001(53,bd0007_001,2,2,1,5,1); // Testcase 53
		bulkTestEvaluate_BD0007_001(54,bd0007_001,2,2,1,5,2); // Testcase 54
		bulkTestEvaluate_BD0007_001(55,bd0007_001,2,2,1,6,1); // Testcase 55
		bulkTestEvaluate_BD0007_001(56,bd0007_001,2,2,1,6,2); // Testcase 56
		bulkTestEvaluate_BD0007_001(57,bd0007_001,2,2,3,0,1); // Testcase 57
		bulkTestEvaluate_BD0007_001(58,bd0007_001,2,2,3,0,2); // Testcase 58
		bulkTestEvaluate_BD0007_001(59,bd0007_001,2,2,3,1,1); // Testcase 59
		bulkTestEvaluate_BD0007_001(60,bd0007_001,2,2,3,1,2); // Testcase 60
		bulkTestEvaluate_BD0007_001(61,bd0007_001,2,2,3,5,1); // Testcase 61
		bulkTestEvaluate_BD0007_001(62,bd0007_001,2,2,3,5,2); // Testcase 62
		bulkTestEvaluate_BD0007_001(63,bd0007_001,2,2,3,6,1); // Testcase 63
		bulkTestEvaluate_BD0007_001(64,bd0007_001,2,2,3,6,2); // Testcase 64
		
	}
