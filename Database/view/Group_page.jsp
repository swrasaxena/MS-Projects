<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"  import="java.util.*"
	import = "java.sql.*"
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="group.css">
<script>
function autoSize(ele)
{
   ele.style.height = 'auto';
   var newHeight = (ele.scrollHeight > 32 ? ele.scrollHeight : 32);
   ele.style.height = newHeight.toString() + 'px';
}


function callinsertservlet(value,post)
{
	var path= "InsertComments.jsp?group_id=<%=request.getParameter("group_id")%>&post_id="+ value+ "&post=" + post ;
	location.href=path;
}

function editpost(value)
{
	var changed_post = document.getElementById(value).value;
	document.location.href="updatepost?post_id=" + value +"&post=" + changed_post;
	}



</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Group Page</title>

</head>
<body>

	<form name="Group_page" action="insert" method="post">

		<% //System.out.println("reached group page"); %>
		<h2 align = "center">Welcome to the <% out.println(request.getParameter("group_name")); %> page</h2>
		<% 
		session.setAttribute("group_id", request.getParameter("group_id"));
		session.setAttribute("group_name",request.getParameter("group_name"));
		%>
		<% String group_id =  new String();
			group_id = request.getParameter("group_id"); %>

<div style='float:left;width:75px;'>
<table>
<tr>
<td>

<%   
String post = new String();    
int post_id;
	int id;
	
    Map<Object[], List<Object[]>> map = new HashMap<Object[], List<Object[]>>();
    map =  (Map<Object[], List<Object[]>>)request.getAttribute("mapData");
    Set<Object[]> obj1 = map.keySet();
   
    for (Object[] objs : obj1){ %>
	           <table>
				<tr>
				<td align = 'left'>
			    <br>
				<label> <%= objs[4] %> </label>
				 Posted: 
				
				<% if (session.getAttribute("role") == "User")
				{
					%>
					
					<textarea rows="1" cols="50" readonly onkeyup="autoSize(this);"> <%= objs[1]%>
					</textarea> <button type = "button" disabled> Add changed Post </button>
					
					<%
				} 
				else   // the user is admin ! 
				{
					id =  (Integer)objs[0];
					post = (String)objs[1];
					%>
					
					<textarea id = "<%=id%>" rows="1" cols="50" onkeyup="autoSize(this);" name = "updatedpost" >  <%= post %> 
					</textarea> <button type = "button" onclick = "editpost('<%=id%>')"> Add changed Post </button>
					  
				<%}%>
				
				 </td> </tr>
				 <% 
				 List<Object []> obj2 = (List<Object[]>)map.get(objs);
				 for (Object[] objs1 : obj2)
		        {%>
				<tr><td> &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				  <%  out.println(objs1[3]);
					%>  Commented :     
					<%= objs1[0] %> 
			
				  </td> </tr>
				
				
			<%}%>
				<tr> 
				<td>
				
     			</td> 
     			 </tr>
				</table>
				
				<% 	id =  (Integer)objs[0];
                post = (String)objs[1];%>
     			<input type= "button" name= "InsertComment"  onclick ="callinsertservlet(<%=id%>,'<%=post%>')" value = "Add Comment">
				</td>
				</tr>

			<%}%>
	<tr>
	<td>  <br>
	</td>
	</tr>
	
	</table>
	<br>
	<table align = 'left'>
	<tr>
	<td>Post to be added: 
	 <textarea rows="1" cols="50" onkeyup="autoSize(this);" name="text"></textarea>
     <input type="submit" name= "InsertPost" value = "Add a new post" align = "right">
     </td>
     </tr>
     </table>
	<a id = "pos" href="login_jsp.jsp">Log Out<img src="logout.png" alt="Log Out"></a>
	</form>
</body>
</html>