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
			
			String query = "insert into reguserdetails(name, email, password, contact) values(?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, password);
			ps.setString(4, contact);
			
			ps.execute();
			
			out.println("Stored Data Successfully");
			
			
			
		}catch(Exception e) {
			
			out.println(e.getMessage());
		}
	
	%>

</body>
</html>