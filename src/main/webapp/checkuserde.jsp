<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>


    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>check user details in db</title>
</head>
<body>

	<%
		String email = request.getParameter("email");
		String password = request.getParameter("psw");
	
	%>
	
	<%
		try {
			
			Connection con;

			con = JdbcConn.setConnection();
			String query = "select email, password from reguserdetails";
			
			Statement st = con.createStatement();
			
			ResultSet rs = st.executeQuery(query);
			
			while(rs.next()) {
				
				if(rs.getString(1).equalsIgnoreCase(email) && rs.getString(2).equalsIgnoreCase(password)) {
					
					out.println("You Are Succesfully Logined...");
					
					response.sendRedirect("landingpage.html");  
					
					
					
					
				} 
			}
			
			out.println("You Are Not registered, Please Fisrt register to login....");
			
			
		}catch(Exception e) {
			
			out.println(e.getMessage());
		}
	
	%>

	

</body>
</html>