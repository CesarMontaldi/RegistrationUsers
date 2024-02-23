<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   
   
<!DOCTYPE html>
<html xmlns:f="http://xmlns.jcp.org/jsf/core">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<title>Cadastro usuário</title>
</head>
	<body>
	
		<c:if test='<%= request.getAttribute("msg") != null %>'>
			<div class="alert alert-danger alert-dismissible fade show col-auto position-absolute top-0 end-0" role="alert">
			  <strong> ${msg} </strong>
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
		
		<form action="<%=request.getContextPath()%>/ServletLogin" method="post" class="needs-validation w-100" novalidate>
			<div class="form-group flex-column row align-items-center justify-content-center vh-100">
				<input type="hidden" value="<%= request.getParameter("url")%>" name="url">
				<div class="col-auto">
					<h2 class="">Login</h2>
				</div>
				<div class="form-group col-4">
			    	<label class="form-label" for="login">Login</label>
			    	<input type="text" name="email" id="email" class="form-control" required="required" autofocus>
			    	<div class="valid-feedback">
				      	OK
				    </div>
				    <div class="invalid-feedback">
				      	Login obrigatorio!
				    </div>
			 	</div>
			 	<div class="form-group col-4 mt-2">
			    	<label class="form-label" for="senha">Senha</label>
			    	<input type="password" name="senha" id="senha" class="form-control" required="required" >
			    	<div class="valid-feedback">
				      	OK
				    </div>
				    <div class="invalid-feedback">
				      	Senha obrigatorio!
				    </div>
			 	</div>
				
				<div class="mt-2 col-auto">
		 			<input type="submit" value="Acessar" class="btn btn-primary">
		 		</div>
 		    </div>
		</form>

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