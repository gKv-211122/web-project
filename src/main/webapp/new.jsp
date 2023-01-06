<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="org.json.simple.*"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
	
	JSONObject details = new JSONObject();

	details.put("sId", 101);
	details.put("sAcc.No", 4534355);
	details.put("Trans. Amount", 35345);

	details.put("rId", 101);
	details.put("rAcc.No", 6456435);

	details.put("Avialable Balance Is", 45345);

	

	out.print(details);
	%>

</body>
</html>