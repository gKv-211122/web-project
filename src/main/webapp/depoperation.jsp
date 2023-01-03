<%@page import="com.banking.system.Deposit"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>
<%@page import="com.banking.system.Deposit"%>
<%@page import="java.io.IOException" %>
<%@page import="java.io.FileWriter" %>
<%@page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page errorPage="error.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Banking System</title>

	<style>
	h1 {
		background-color: blue;
		text-align: center;
		color: white;
	}
	
	h3 {
		color: green;
	}
	
	.btn {
		background-color: black; 
		color: white;
		width: 100px;
		height: 30px;
		font-size: 20px;
		
	}
	
	.btn:hover{
	
            background-color: white;
            color: black;
            font-size: 20px;
            cursor: pointer;
        }
	
	</style>

</head>
<body>

	<h1>DEPOSITE YOUR AMOUNT...</h1>
	<%
	String id = request.getParameter("userid");
	String accn = request.getParameter("accno");
	String amount = request.getParameter("amount");
	%>

	

	<hr>
	<br>
	<%
	
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String query = "select id, accno from accountdetails where Id = '" + Integer.parseInt(id) + "' AND accno = '" + accn + "'";
		// String query = "select accno from accountdetails where Id = '" + Integer.parseInt(id) + "' and accno='" + accn + "'";
		// out.println("Invalid Credentials !!!!");
		PreparedStatement ps = con.prepareStatement(query);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) { 
			 
			if (rs.getString(2).equals(accn)) {
				// rs.getString(1).equals(Integer.parseInt(id)) && 
			
					out.println("<br>");
					out.print("Id Is : " + id);
					out.print(",   Acc. No Is : " + accn);
					out.print(",   Amount To Be Deposite Is : " + amount + "/-");
					
					out.println("<br/><br/>");
					out.println(" You are updating your balance...\n");
				
					String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";
				
					PreparedStatement psd = con.prepareStatement(que2);

					ResultSet rs1 = psd.executeQuery();
					
					Integer bal;
					while (rs1.next()) {
			
						bal = rs1.getInt(1);
						out.println("<br/><br/>");
						out.println("<b>current balance is: </b>"+"<b>"+bal+"</b>"+"<b>/-</b>");
			
			
						// update the balance
						String query3 = "update accountdetails set balance=? where accno=? ";
					
						PreparedStatement psu = con.prepareStatement(query3);
						psu.setInt(1, (bal + (Integer.parseInt(amount))));
						psu.setString(2, accn);
						psu.executeUpdate();
			
			
						out.println(", <h3 ><b> Your Amount Is Successfully Deposite !!!</b></h3>");
						out.println("<h4 >Updated Balance Is: </h4>"+"<b>"+(bal + (Integer.parseInt(amount)))+"</b>"+"<b>/-</b>");
						
						File fileName = new File("D:/New folder/BankSystem/src/main/webapp/deposit.txt");
						try {
							
							FileWriter fw = new FileWriter(fileName, true);
						     
							fw.write("\nDeposit Successfully, Your Details are: ");
							fw.write("\nid: "+id+"\nACC.No: "+ accn+"\nDeposit Amount: "+amount+"/-"+"\nUpdated Balance is: " +(bal + (Integer.parseInt(amount)))+"/-");
							fw.write("\n----------------------------------------------------\n");
							fw.flush();
							fw.close();
						    
							
							
						} catch(IOException e) {
							
							System.out.println("An error occurred.");
						    e.printStackTrace();
						}
				}

			} else {
 
				out.println("Invalid Credentials !!!! ....");
			}
			
			
		}
		
		

	} catch (Exception e) {

		e.printStackTrace();
		out.print(e);
	} 
	
		// Deposit.checkCredentials(id, accn, amount);
	

	%>
	
	<br>
	<br>
	<a href="landingpage.html">
		<button type="button" class="btn">Home</button>
	</a>

</body>
</html>