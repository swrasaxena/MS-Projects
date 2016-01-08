<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Sign Up</title>
<link rel="stylesheet" type="text/css" href="signup.css">
<script type="text/javascript">
		function validateUsrName()
		{
			var uname=document.forms["SignUp"]["txtUsrName"].value;
			
			if(uname==null || uname=="")
				{
				alert("Please enter a username.");
				return false;
				}	
			else
		{
				return validatepwd(document.forms["SignUp"]["txtPassword"].value);
		}
				
		}
		
		function validatepwd(pwd)
		{
			if(pwd==null || pwd=="")
				{
				alert("Please enter a password.");
				return false;
				}
				
			else
				{
				return matchPassword(pwd);
				}
				
		}
		function matchPassword(pwd)
		{
			var confirmpwd = document.forms["SignUp"]["txtConfirmPassword"].value;
			if(confirmpwd!=pwd)
				{
				alert("Passwords do not match");
				return false;
				}
			else
				{
				return validateFName(document.forms["SignUp"]["txtFirstName"].value);
				}
			
		}
		function validateFName(fname)
		{
			if(fname==null || fname=="")
			{
			alert("Please enter your first name");
			return false;
			}
			
		else
			{
			return validateLName(document.forms["SignUp"]["txtLastName"].value);
			}
		
		}
		function validateLName(lname) 
		{
			if(lname==null || lname=="")
			{
			alert("Please enter your last name");
			return false;
			}
			else
				{
				return RegexEmail(document.forms["SignUp"]["txteMail"].value);
				}
		
		}
		function RegexEmail(emailStr)
		{    
			   
			   var emailRegexStr = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
			   var isvalid = emailRegexStr.test(emailStr); 
			 
			   if (!isvalid) {
			 alert('Invalid email address!');
			 return false;
			 }
		}
		</script>

</head>
<body>

	<form name="SignUp" action="/ws1/rest/registration" method="POST">
	<h2 align="center">SIGN UP</h2>
<h4>
		<h4 align="center"><font color=red>Please enter all required fields marked in asterisk (*)</font></h4>
		<br></br>
		<table id="alignment" align="center">
		
			<tr>
				<td height = 35px><font color=red>*</font>User Name:</td>
				<td height = 35px><input type="text" name="txtUsrName" id="txtUsrName"></input></td>
				<td height = 35px><font color=white >* make sure the id is unique</font></td>
				
				
			</tr> 
			<tr>
				<td height = 35px><font color=red>*</font>Password:</td>
				<td height = 35px><input type="password" name="txtPassword" id="txtPassword"></input></td>
			</tr>
			
			<tr>
				<td height = 35px><font color=red>*</font>Confirm Password:</td>
				<td height = 35px><input type="password" name="txtConfirmPassword" id="txtConfirmPassword"></input></td>
			</tr>
			<tr>
				<td height = 35px><font color=red>*</font>First Name:</td>
				<td height = 35px><input type="text" name="txtFirstName" id="txtFirstName"></input>
				</td>
			</tr>
			<tr>
				<td height = 35px><font color=red>*</font>Last Name:</td>
				<td height = 35px><input type="text" name="txtLastName" id="txtLastName"></input>
				</td>
			</tr>

			<tr>
				<td height = 35px>City:</td>
				<td height = 35px><input type="text" name="txtCity" id="txtCity"></input></td>
			</tr>

			<tr>
				<td height = 35px>State:</td>
				<td height = 35px><input type="text" name="txtState" id="txtState"></input></td>
			</tr>

			<tr>
				<td height = 35px>Age:</td>
				<td height = 35px><input type="text" name="txtAge" id="txtAge"></input></td>
			</tr>

			<tr>
				<td height = 35px>Phone Type:</td>
				<td height = 35px><select name="phone_type">
						<option value="1">Mobile</option>
						<option value="2">Home</option>
						<option value="3">Work</option>
				</select></td>
			</tr>


			<tr>
				<td height = 35px>Phone Number:</td>
				<td height = 35px><input type="text" name="txtPhoneNo" id="txtPhoneNo"></input></td>
			</tr>

			<tr>
				<td height = 35px>Email id:</td>
				<td height = 35px><input type="text" name="txteMail" id="txteMail"></input></td>
			</tr>


			<tr>
				<td height = 35px>Gender:</td>
				<td height = 35px><input type="radio" name="rdGender" value="male" /> Male<br />
				<td height = 35px><input type="radio" name="rdGender" value="female" />
					Female<br /></td>
			</tr>
			<tr>
				<td></td>
				<td height = 35px><input type="submit" name="subAddUser" id="subSubmit"
					value="Add User" onclick="return validateUsrName();"></input></td>
					<td><a href="login_jsp.jsp"><font color = "white">Back</font></a></td>
			</tr>
         
		</table>
		</h4>
	</form>
</body>
</html>