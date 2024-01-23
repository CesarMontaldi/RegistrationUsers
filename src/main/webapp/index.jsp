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

		<form action="receber-nome.jsp">
			<label>Nome:</label>
			<input type="text" name="nome"/>
			<br>
			<label>Idade:</label>
			<input type="text" name="idade"/>
			<br>
			<input type="submit" value="Enviar"/> 
		</form>
		
	</body>
</html>