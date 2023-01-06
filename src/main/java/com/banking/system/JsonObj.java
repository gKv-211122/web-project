package com.banking.system;


import org.json.simple.JSONObject;

class JsonObj {
	
	 
	public static void printDetails(String sid, String rid, String sacn, String racn, int samount, int avbal) {
		
		JSONObject details = new JSONObject();
		
		
		details.put("sId", sid);
		details.put("sAcc.No", sacn);
		details.put("Trans. Amount", samount);
		
		details.put("rId", rid);
		details.put("rAcc.No", racn);
		
		details.put("Avialable Balance Is", avbal);
		
		
		System.out.println(details.toString());
		
		
		
		
	}

}
