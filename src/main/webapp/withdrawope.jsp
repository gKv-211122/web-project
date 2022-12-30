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

	<h1>WITHDRAW YOUR AMOUNT...</h1>
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

		out.println("You are withdrawing your balance...\n");

		String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";
		PreparedStatement psd = con.prepareStatement(que2);

		ResultSet rs1 = psd.executeQuery();

		while (rs1.next()) {

			Integer st = rs1.getInt(1);
			out.println("<br/>");
			out.println("<b>current balance is: </b>" + "<b>" + st + "</b>" + "<b>/-</b>");

			// update the balance
			String query3 = "update accountdetails set balance=? where accno=? ";

			PreparedStatement psu = con.prepareStatement(query3);
			psu.setInt(1, (st - (Integer.parseInt(amount))));
			psu.setString(2, accno);
			psu.executeUpdate();

			out.println(", <h3 ><b> Your Amount Is Successfully Withdrawl !!!</b></h3>");
			out.println("<h3 >Updated Balance Is: </h3>" + "<b>" + (st - (Integer.parseInt(amount))) + "</b>"
					+ "<b>/-</b>");
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

	<a href="landingpage.html">
		<button type="button" class="btn">Home</button>
	</a>

</body>
</html>