<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html lang="pt-br">

<jsp:include page="head.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<body>

	<jsp:include page="theme-loader.jsp"></jsp:include>

	<form action="<%=request.getContextPath()%>/ServletLogin" method="post" class="needs-validation w-100" novalidate>
			<div class="flex-column row align-items-center justify-content-center vh-100">
			<div class="auth-box card col-4">
				<div class="card-block">
					<input type="hidden" value="<%= request.getParameter("url")%>" name="url">
					<div class="col-auto d-flex justify-content-center">
						<h2 class="">Login</h2>
					</div>
					<div class="flex-column d-flex align-items-center justify-content-center">
						<div class="form-group col-12">
					    	<label class="form-label" for="login">Login</label>
					    	<input type="text" name="email" id="email" class="form-control" required="required" autofocus>
					    	<div class="valid-feedback">
						      	OK
						    </div>
						    <div class="invalid-feedback">
						      	Login obrigatorio!
						    </div>
					 	</div>
					 	<div class="form-group col-12 mt-2">
					    	<label class="form-label" for="senha">Senha</label>
					    	<input type="password" name="senha" id="senha" class="form-control" required="required" >
					    	<div class="valid-feedback">
						      	OK
						    </div>
						    <div class="invalid-feedback">
						      	Senha obrigatorio!
						    </div>
				 		</div>
					</div>
					<div class="mt-2 col-auto d-flex justify-content-center">
			 			<input type="submit" value="Acessar" class="btn btn-primary">
			 		</div>
	 		   </div>
 		    </div>
 		    </div>
	</form>
	<jsp:include page="javaScriptFile.jsp"></jsp:include>
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
