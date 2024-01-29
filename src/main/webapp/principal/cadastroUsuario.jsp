<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="pt-br">

<jsp:include page="head.jsp"></jsp:include>

<body>

	<jsp:include page="theme-loader.jsp"></jsp:include>

	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navBarMainMenu.jsp"></jsp:include>

					<div class="pcoded-content">

						<jsp:include page="page-header.jsp"></jsp:include>

						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<div class="col-sm-12">
											<!-- Basic Form Inputs card start -->
											<div class="card">
												<div class="card-block">
													<h4 class="sub-title">Cadastro de usu�rio</h4>

													<form class="form-material" action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser">
														
														<input type="hidden" name="acao" id="acao"/>
													
														<div class="form-group form-default form-static-label">
															<input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${modelUsuario.id}">
															<span class="form-bar"></span> 
															<label class="float-label">ID:</label>
														</div>
														<div class="form-group form-default">
															<input type="text" name="nome" id="nome" class="form-control" required="required" value="${modelUsuario.nome}"> 
															<span class="form-bar"></span>
															<label class="float-label">Nome:</label>
														</div>
														<div class="form-group form-default">
															<input type="email" name="email" id="email" class="form-control" required="required" value="${modelUsuario.email}"> 
															<span class="form-bar"></span> 	
															<label class="float-label">Email:</label>
														</div>
														<div class="form-group form-default"> 
															<input type="password" name="senha" id="senha" class="form-control" required="required" value="${modelUsuario.senha}">
															<span class="form-bar"></span> 
															<label class="float-label">Senha:</label>
														</div>
														<button type="button" class="btn waves-effect waves-light btn-success" onclick="limparForm()">Novo</button>
														<button type="submit" class="btn waves-effect waves-light btn-primary ml-3">Salvar</button>
														<button type="button" class="btn waves-effect waves-light btn-danger ml-3" onclick="criarDelete()">Excluir</button>
													</form>

												</div>
											</div>
										</div>
									</div>
										<span>${msg}</span>
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="javaScriptFile.jsp"></jsp:include>
	
	<script type="text/javascript">

		function criarDelete() {
			document.getElementById("formUser").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUser").submit();
			}

		function limparForm() {
			var elementos = document.getElementById("formUser").elements; /* Retorna os elementos html dentro do form */

			for (p = 0; p < elementos.length; p ++) {
					elementos[p].value = '';
				}
			
		}
		
	</script>
</body>

</html>
