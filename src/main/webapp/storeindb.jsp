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
<title>storeuserdetailsindb</title>
</head>
<body>

	<%
	String name = request.getParameter("uname");
	String email = request.getParameter("email");
	String password = request.getParameter("psw");
	String contact = request.getParameter("contact");
	%>


	<%
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String queryc = "select email, password from reguserdetails";
	
		Statement stc = con.createStatement();

		ResultSet rsc = stc.executeQuery(queryc);
		
		boolean b = false;
		while(rsc.next() == true) {

			if (rsc.getString(1).equalsIgnoreCase(email) && rsc.getString(2).equalsIgnoreCase(password)) {
				
				// out.println("User alrady signuped...");
				b = true;
				// response.sendRedirect("signup.html"); 
			} 
			
			
			
		} 
		
		if(b == true) {
			out.println("User alrady signuped...");
			
		}else {
			
			String query = "insert into reguserdetails(name, email, password, contact) values(?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);

			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, password);
			ps.setString(4, contact);
			
			ps.execute();
			response.sendRedirect("login.html");
			
		}
		
		

		// out.println("Stored Data Successfully");
		// response.sendRedirect("login.html"); 
			
		

	} catch (Exception e) {

		out.println(e.getMessage());
		out.println("Some Error Occured...");
	}
	%>

</body>
</html>