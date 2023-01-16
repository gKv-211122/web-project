<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.banking.system.JdbcConn"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
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

h3 {
	color: green;
}

h4 {
	color: red;
}

.btn {
	background-color: black;
	color: white;
	width: 100px;
	height: 30px;
	font-size: 20px;
}

.btn:hover {
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
	String sid = request.getParameter("sid");
	String saccn = request.getParameter("saccno");

	String rid = request.getParameter("rid");
	String raccn = request.getParameter("raccno");

	String samount = request.getParameter("samount");
	%>



	<%
	JSONObject json = new JSONObject();
	try {

		Connection con;

		con = JdbcConn.setConnection();

		String query = "select id, accno from accountdetails where id = '" + Integer.parseInt(sid) + "'";
		/* String query = "select id, accno from accountdetails where id = '" + Integer.parseInt(sid) + "' AND id = '"
		+ Integer.parseInt(rid) + "' AND accno = '" + saccn + "' AND accno = '" + raccn + "'";*/

		PreparedStatement ps = con.prepareStatement(query);
		ResultSet rs = ps.executeQuery();
		
		

		while (rs.next()) {

			if (rs.getString(2).equals(saccn)) {
				
				

		out.println("<br><br>");
		out.println("processing.... You Transfer");
		out.println(raccn);
		out.println("<br><br>");

		String que2 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(sid) + "'";
		PreparedStatement psd = con.prepareStatement(que2);

		ResultSet rs1 = psd.executeQuery();
		
		

		while (rs1.next()) {

			try {

				if (rs1.getInt(1) < Integer.parseInt(samount)) {

					out.println("<br><br>");
					out.println("<h4 >INSUFFICIENT BALANCE !!!</h4>");

				} else {

					String rquery = "select id, accno from accountdetails where id = '" + Integer.parseInt(rid)
							+ "'";
					PreparedStatement psr = con.prepareStatement(rquery);
					ResultSet recrs = psr.executeQuery();

					

					// String que4 = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(rid) + "'";
					Integer sbal = rs1.getInt(1);

					// update sender acc. balance
					String query3 = "update accountdetails set balance=? where accno=? ";

					PreparedStatement psu = con.prepareStatement(query3);
					psu.setInt(1, (sbal - (Integer.parseInt(samount))));
					psu.setString(2, saccn);
					psu.executeUpdate();

					/**
					------------------------------------------------------------------------------------------
					SENDER -- TRANSFER MONEY AND UPDATE THEIR THE ACC. BALANCE */

					String rque = "SELECT balance FROM accountdetails where id= '" + Integer.parseInt(rid) + "'";
					PreparedStatement rps = con.prepareStatement(rque);

					ResultSet rrs = psd.executeQuery();
					
					
					while (rrs.next()) {

						Integer rbal = rrs.getInt(1);

						// update receiver acc. the balance
						String rque2 = "update accountdetails set balance=? where accno=? ";

						PreparedStatement rsu = con.prepareStatement(rque2);
						rsu.setInt(1, (rbal + (Integer.parseInt(samount))));
						rsu.setString(2, raccn);
						rsu.executeUpdate();
						
					}
					
					

					out.println("<br>");
					json.put("sId ", sid);
				    json.put("sAcc. No", saccn);
				   
				    
				    json.put("rId ", rid);
				    json.put("rAcc. No", raccn);
				    json.put("Avail. Balance is ",(sbal - (Integer.parseInt(samount))));
				    json.put("Trans. Amount", samount);
				    out.print("<h3 >"+json+"</h3>");
				    out.println("<br>");
				    out.println("<br>");
				    
				    JSONArray lst = new JSONArray();
				    lst.add(json);
				    
				    out.println("<h3 >"+lst+"</h3>");
				    
				    
						
					
					

				 /* out.println("<br>");
					out.println("From: ");
					out.print("Id Is : " + sid);
					out.print(",   Acc. No Is : " + saccn);
					out.print(",   Transfer Amount Is : " + samount + "/-");
					out.println("<br>");

					out.println("<br>");
					out.println("To: ");
					out.print("Id Is : " + rid);
					out.print(",   Acc. No Is : " + raccn);

					out.print(", <h3 ><b> Transaction Is Successful !!!</b></h3>");
					out.println("<h3>Avialable Balance Is: </h3>" + "<b>" + (sbal - (Integer.parseInt(samount)))  
							+ "</b>" + "<b>/-</b>");   */
							
					out.println("<br>");
					out.println("<br>");

					File fileName = new File("D:/New folder/BankSystem/src/main/webapp/transfer.txt");
					try {

						FileWriter fw = new FileWriter(fileName, true);

						fw.write("\nTransfer, Details are: ");
						fw.write("\n\nSender Details Are: ");
						fw.write("\nid: " + sid + "\nACC.No: " + saccn + "\nTransfer Amount: " + samount + "/-"
								+ "\nAvialable Balance is: " + (sbal - (Integer.parseInt(samount))) + "/-");
						fw.write("\n\nReceiver Details Are: ");
						fw.write("\n=======================================\n");
						fw.write("\nid: " + rid + "\nACC.No: " + raccn);
						fw.write("\n=======================================\n");
						fw.write("\n----------------------------------------------------\n");
						fw.flush();
						fw.close();

						fileName.setReadOnly();
						
						

					}catch (IOException e) {

						out.println("<h4>An error occurred.</h4>");
						e.printStackTrace();
						
					}

				}

			} catch (Exception e) {

				out.print(e);

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

	










	<hr>
	<br>

	<br>
	<a href="landingpage.html">
		<button type="button" class="btn">Home</button>
	</a>

</body>
</html>