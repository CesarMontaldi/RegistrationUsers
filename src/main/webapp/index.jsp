<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Cadastro de usu�rios</title>
	</head>
	<body>
		<h1>Cadastro de usu�rios</h1>

		<form action="ServletLogin" method="post">
			<label>Nome:</label>
			<input type="text" name="nome"/>
			<br><br>
			<label>Idade:</label>
			<input type="text" name="idade"/>
			<br><br>
			<input type="submit" value="Enviar"/> 
		</form>
		
	</body>
</html>