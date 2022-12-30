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

<style>
h1 {
	background-color: blue;
	text-align: center;
	color: white;
}
</style>

</head>
<body>

	<h1>DEPOSITE YOUR AMOUNT...</h1>
	<%
	String id = request.getParameter("userid");
	String accno = request.getParameter("accno");
	String amount = request.getParameter("amount");
	%>

	<%="Id Is : " + id%><br />
	<%="Acc. No Is : " + accno%><br />
	<%="Amount To Be Deposite Is : " + amount + "/-"%><br />

	<hr style="color: black">
	<br>
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
				
				String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";
				PreparedStatement psd = con.prepareStatement(que2);

				ResultSet rs1 = psd.executeQuery();

				while (rs1.next()) {
			
					Integer st = rs1.getInt(1);
					out.println("<br/>");
					out.println("<b>current balance is: </b>"+st+"<b>/-</b>");
			
			
					// update the balance
					
			
					out.println(", <h3><b> Your Balance Is Successfully Updated !!!</b></h3>");
				
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
	
	<br>
	<br>
	<a href="landingpage.html">
		<button type="button" style="background-color: black; color: white;">Home</button>
	</a>

</body>
</html>