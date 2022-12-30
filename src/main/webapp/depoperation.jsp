<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Banking System</title>
</head>
<body>
	<%
	String id = request.getParameter("userid");
	String accno = request.getParameter("accno");
	String amount = request.getParameter("amount");
	%>

	<%="Your Id Is : " + id%><br />
	<%="Your Acc. No Is : " + accno%><br />
	<%="Your Deposite Amount Is : " + amount + "/-"%><br />

	<%
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String query = "select accno from accountdetails where Id = '" + Integer.parseInt(id) + "'";
		PreparedStatement ps = con.prepareStatement(query);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			 
			if (rs.getString(1).equals(accno)) {

		out.println("You are updating your balance...\n");
		// out.println(rs.getString(1));

		
		String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";

		PreparedStatement psd = con.prepareStatement(que2);
		
		// psd.setInt(1, Integer.parseInt(id));

		ResultSet rs1 = psd.executeQuery();

		while (rs1.next()) {
			
			out.println("\n*********current balance is: "+rs1.getInt(1));
			
			
			// update the balance
			String query3 = "update accountdetails set balance=? where id=? ";
			PreparedStatement psu = con.prepareStatement(query);
			
			psu.setInt(1, (rs1.getInt(1) + (Integer.parseInt(amount))));
			psu.setString(2, id);
			
			psu.executeUpdate();
			out.println("\nYour Balance Is Successfully Updated !!!");
			
		}
		
		

			} else {

				out.println("Invalid Credentials !!!! ....");
			}
		}

	} catch (Exception e) {

		e.printStackTrace();
		out.print(e);
	}
	%>

</body>
</html>