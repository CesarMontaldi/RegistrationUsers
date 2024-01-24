<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Pagina de login</title>
	</head>
	<body>
		<h1>Pagina de login</h1>
		
		<form action="ServletLogin" method="post">
		<input type="hidden" value="<%= request.getParameter("url") %>" name="url">
		
			<table>
			
				<tr>
					<td><label>Login:</label></td>
				</tr>
				
				<tr>
					<td><input type="text" name="login"/></td>
				</tr>
				
				<tr>
					<td><label>Senha:</label></td>
				</tr>
				
				<tr>
					<td><input type="password" name="senha"/></td>
				</tr>
				<tr></tr>
				<tr>
					<td><input type="submit" value="Entrar"/></td>
				</tr>
				
			</table>
	 
		</form>
		
		<h4 style="color: red;">${msg}</h4>
		
	</body>
</html>