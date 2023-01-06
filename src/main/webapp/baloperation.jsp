<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>
<%@page import="java.io.IOException" %>
<%@page import="java.io.FileWriter" %>
<%@page import="java.io.File" %>
<%@page language="java" import="org.json.simple.*"%>
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
		
	%>

	<%
	
	JSONObject json = new JSONObject();
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String query = "select accno from accountdetails where Id = '" + Integer.parseInt(id) + "'";
		PreparedStatement ps = con.prepareStatement(query);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			if (rs.getString(1).equals(accno)) {

			out.println("processing...\n");
		
		// show available
		String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(id) + "'";
		
		

		PreparedStatement psd = con.prepareStatement(que2);

		out.println("<br>");
		ResultSet rs1 = psd.executeQuery();

			while (rs1.next()) {
			
			out.println("<br><b>AVAILABLE BALANCE IS >>>> </b>" + "<b>" + rs1.getInt(1) + "</b>" + "<b>/-</b>");
			
			
			out.println("<br>");
		    json.put("Balance is ",rs1.getInt(1));
		    json.put("Id ", id);
		    json.put("Acc. No", accno);
		    out.print(json);
		    
		    
		   
			
			File fileName = new File("D:/New folder/BankSystem/src/main/webapp/balance.txt");
			try {
				
				FileWriter fw = new FileWriter(fileName, true);
			     
				fw.write("\nBalance Check, Your Details are: ");
				fw.write("\nid: "+id+"\nACC.No: "+ accno+"\nAvailable Balance is: " +(rs1.getInt(1))+"/-");
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
	
	
	
	%>

	<br>
	<br>
	<a href="landingpage.html">
		<button type="button" class="btn">Home</button>
	</a>

</body>
</html>