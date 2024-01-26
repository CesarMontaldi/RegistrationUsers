<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html xmlns:f="http://xmlns.jcp.org/jsf/core">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<title>Cadastro usuário</title>
		
		<style type="text/css">
			
		  form {
				position: absolute;
				top: 25%;
				left: 33.3%;
			} 
			
			h5 {
				position: absolute;
				top: 73%;
				left: 33%;
				color: red;
				font-size: 16px;
			}
			
			
		</style>
		
	</head>
	<body>

		<form action="ServletLogin" method="post" class="row g-3 needs-validation d-flex col-6" novalidate>
		<input type="hidden" value="<%= request.getParameter("url")%>" name="url">
		
		<h2 class="col-8 d-flex justify-content-center">Bem vindo ao curso JSP</h2>
	
			<div class="col-8">
		    	<label class="form-label" for="login">Login</label>
		    	<input type="text" name="login" id="login" class="form-control" required="required">
		    	<div class="valid-feedback">
			      	OK
			    </div>
			    <div class="invalid-feedback">
			      	Login obrigatorio!
			    </div>
			    
		 	</div>
		 	<div class="col-8">
		    	<label class="form-label" for="senha">Senha</label>
		    	<input type="password" name="senha" id="senha" class="form-control" required="required">
		    	<div class="valid-feedback">
			      	OK
			    </div>
			    <div class="invalid-feedback">
			      	Senha obrigatorio!
			    </div>
		 	</div>
			
			<div class="col-8 d-flex">
	 			<input type="submit" value="Acessar" class="btn btn-primary">
	 		</div>
	 		
		</form>
		<h5>${msg}</h5>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

		<script>
			(function () {
			  'use strict'
	
			  var forms = document.querySelectorAll('.needs-validation')
	
			  Array.prototype.slice.call(forms)
			    .forEach(function (form) {
			      form.addEventListener('submit', function (event) {
			        if (!form.checkValidity()) {
			          event.preventDefault()
			          event.stopPropagation()
			        }
	
			        form.classList.add('was-validated')
			      }, false)
			    })
			})()
					
		</script>
	</body>
</html>