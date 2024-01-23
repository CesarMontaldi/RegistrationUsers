<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Cadastro de usuários</title>
	</head>
	<body>
		<h1>Cadastro de usuários</h1>
		
		<form action="ServletLogin" method="post">
		
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
				
				<tr>
					<td><input type="submit" value="Entrar"/></td>
				</tr>
				
			</table>
	 
		</form>
		
		<h4>${msg}</h4>
		
	</body>
</html>