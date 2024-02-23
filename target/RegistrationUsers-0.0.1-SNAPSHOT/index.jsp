<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html lang="pt-br">

<jsp:include page="/principal/head.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<body>

	<jsp:include page="/principal/theme-loader.jsp"></jsp:include>
	
	<c:if test='<%= request.getAttribute("msg") != null %>'>
	<div class="alert alert-danger alert-dismissible fade show col-auto position-absolute top-0 end-0" role="alert">
	  <strong> ${msg} </strong>
	  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
	</c:if>

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
			 		<div class="form-check mt-5 col-auto d-flex justify-content-between">
					  <input class="form-check-input ml-0" type="checkbox">
					  <label class="form-check-label">Remember me</label>
					  <a href="#" class="text-decoration-none">Forgot Password?</a>
					</div>
	 		   </div>
 		    </div>
 		    </div>
	</form>

<script>
(function() {
  'use strict';
  window.addEventListener('load', function() {
    var forms = document.getElementsByClassName('needs-validation');
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();

</script>

<jsp:include page="/principal/javaScriptFile.jsp"></jsp:include>

</body>

</html>
