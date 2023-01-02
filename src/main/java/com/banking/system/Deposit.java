package com.banking.system;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class Deposit {
	
	
	 
	public static void checkCredentials(String id, String accn, String amount) {
		
		try {

			Connection con;

			con = JdbcConn.setConnection();

			String query = "select * from accountdetails where Id = '" + Integer.parseInt(id) + "'";
			// String query = "select accno from accountdetails where Id = '" + Integer.parseInt(id) + "' and accno='" + accn + "'";
			// out.println("Invalid Credentials !!!!");
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) { 
				 
				if (rs.getString(2).equals(accn)) {
					
				
						System.out.println("<br>");
						System.out.print("Id Is : " + id);
						System.out.print(",   Acc. No Is : " + accn);
						System.out.print(",   Amount To Be Deposite Is : " + amount + "/-");
						
						System.out.println("<br/><br/>");
						System.out.println(" You are updating your balance...\n");
					
						String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";
					
						PreparedStatement psd = con.prepareStatement(que2);

						ResultSet rs1 = psd.executeQuery();

						while (rs1.next()) {
				
							Integer st = rs1.getInt(1);
							System.out.println("<br/><br/>");
							System.out.println("<b>current balance is: </b>"+"<b>"+st+"</b>"+"<b>/-</b>");
				
				
							// update the balance
							String query3 = "update accountdetails set balance=? where accno=? ";
						
							PreparedStatement psu = con.prepareStatement(query3);
							psu.setInt(1, (st + (Integer.parseInt(amount))));
							psu.setString(2, accn);
							psu.executeUpdate();
				
				
							System.out.println(", <h3 ><b> Your Amount Is Successfully Deposite !!!</b></h3>");
							System.out.println("<h4 >Updated Balance Is: </h4>"+"<b>"+(st + (Integer.parseInt(amount)))+"</b>"+"<b>/-</b>");
					}

				} else {
	 
					System.out.println("Invalid Credentials !!!! ....");
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
			System.out.print(e);
		}
		
	}

}
