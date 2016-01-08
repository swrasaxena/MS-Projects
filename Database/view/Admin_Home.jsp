<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "java.sql.*" import = "java.util.*" 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrator Home Page</title>
<link rel="stylesheet" type="text/css" href="adminhome.css">
</head>
<body>
<form name="Admin_Home" action="loginServlet" method="get">
<% 
	String user_name = new String();
    user_name= (String)session.getAttribute("name");
	
	%>
<h2 align = "center">Welcome Admin, <% out.println(user_name); %></h2>

<table align = "center">
<tr>
<th>
<h3 align = "center">&nbsp;Select&nbsp;</h3>
</th>
<th>
<h3 align = "center">&nbsp;User Name&nbsp;</h3>
</th>
<th>
<h3 align = "center">&nbsp;Group Name&nbsp;</h3>
</th>
</tr>
<%
Integer i = 0;
Integer j = 0;
long count = 0;
count = (Long)request.getAttribute("count");
String[] first_name = new String[1000];
String[] group_name = new String[1000];
first_name = (String[])request.getAttribute("first_name");
group_name = (String[])request.getAttribute("group_name");

List<Object[]> objectList = new ArrayList<Object[]> ();
objectList = (List<Object[]>)request.getAttribute("ObjList");
Iterator itr = objectList.iterator();
for (Object[] objs: objectList)
{
%>
<tr>
<td><input type = 'checkbox' id = '<%= j %>' name = 'requests' value = '<%= j %>'></td>
<td align = "center"><%= objs[0]%></td>
<td align = "center"><%= objs[1]%></td>
</tr>
<%
j++;
}

%>

</table>
<a id = "pos" href="login_jsp.jsp">Log Out<img src="logout.png" alt="Log Out"></a>

<br>
<span>
<input type="submit" name="subAdd" align = "middle" id="subAdd" value = "Add">
<input type="submit" name="subReject" align = "middle" id="subReject" value = "Reject">
<br>
<br>
<a href = "AdminGrpServlet?user_name=<%= user_name %>">View all groups</a>
<br>
<br>
<a href = "All Users.jsp?user_name=<%= user_name%>">View all users</a>
</span>


</form>
</body>
</html>