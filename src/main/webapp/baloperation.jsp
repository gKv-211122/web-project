<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
h1 {
	background-color: blue;
	text-align: center;
	color: white;
}
</style>
</head>
<body>

	<h1>
		<b>YOUR ACCOUNT BALANCE IS... (National Bank) </b>
	</h1>


	<%
	String id = request.getParameter("userid");
	String accno = request.getParameter("accno");
	%>

	<%="Bank Id : " + id%><br />
	<%="Acc. No Is : " + accno%><br />

	<%
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String query = "select accno from accountdetails where Id = '" + Integer.parseInt(id) + "'";
		PreparedStatement ps = con.prepareStatement(query);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			if (rs.getString(1).equals(accno)) {

		out.println("processing...\n");

		String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";

		PreparedStatement psd = con.prepareStatement(que2);

		out.println("<b></b>");
		ResultSet rs1 = psd.executeQuery();

			while (rs1.next()) {

			out.println("\n<b>CURRENT BALANCE IS >>>> </b>" + "<b>" + rs1.getInt(1) + "</b>" + "<b>/-</b>");

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