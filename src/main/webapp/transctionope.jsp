<%@page import="java.sql.Connection"%>
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

	<h1>TRANSFER YOUR AMOUNT...</h1>
	<%
	String id = request.getParameter("userid");
	String accno = request.getParameter("accno");
	String amount = request.getParameter("amount");
	%>

	<%="Id Is : " + id%><br />
	<%="Acc. No Is : " + accno%><br />
	<%="Amount To Be Transfer : " + amount + "/-"%><br />
	
	<%
		Connection con;

		con = JdbcConn.setConnection();

	
	%>

	<hr>
	<br>

	<br>
	<a href="landingpage.html">
		<button type="button" class="btn">Home</button>
	</a>

</body>
</html>