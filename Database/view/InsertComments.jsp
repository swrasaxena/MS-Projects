<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Comments</title>
<link rel="stylesheet" type="text/css" href="insertcomments.css">
</head>
<body><h3 align = "center">
The post is  : <%= request.getParameter("post") %></h3>

<% session.setAttribute("post_id", request.getParameter("post_id"));%>


<form name="Insert_comment_page" action="comment" method="post">
<table>
<tr>
<td>
<textarea id = "alignment" name="comment" rows = "1" cols = "50"> </textarea>
</td>
</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<input type="submit" name= "InsertComment" value = "Add comment" align = "middle">
<a id = "pos" href="login_jsp.jsp">Log Out<img src="logout.png" alt="Log Out"></a>
</form>
</body>
</html>