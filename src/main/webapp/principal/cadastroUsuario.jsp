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
														<button type="submit" class="btn waves-effect waves-light btn-primary ml-2">Salvar</button>
														<button type="button" class="btn waves-effect waves-light btn-danger ml-2" onclick="deleteAjax()">Excluir</button>
														<button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#exampleModalUser">Pesquisar</button>
													</form>

												</div>
											</div>
										</div>
									</div>
										<span id="msg">${msg}</span>
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
	
		<!-- Modal -->
	<div class="modal fade" id="exampleModalUser" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Pesquisa de usu�rio</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="Nome" aria-label="Nome" id="nomeBusca" aria-describedby="basic-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-success" type="button" onclick="buscarUsuario()">Buscar</button>
			  </div>
			</div>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">ID</th>
			      <th scope="col">Nome</th>
			      <th scope="col">Ver</th>
			    </tr>
			  </thead>
			  <tbody>
			  </tbody>
			</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script type="text/javascript">

function buscarUsuario() {

	var nomeBusca = document.getElementById("nomeBusca").value;

		if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){ /* Validando que tem que ter valor para buscar no banco */

			var urlAction = document.getElementById("formUser").action;
			
			$.ajax({

				method: "GET",
				url: urlAction,
				data: "nomeBusca=" + nomeBusca + "&acao=buscarUserAjax",
				success: function(response) {
					
				}
				
			}).fail(function(xhr, status, errorThrow){
				alert("Erro ao buscar o usu�rio:" + xhr.responseText);
			});
		}
	}

function deleteAjax() {

	if (confirm("Deseja realmente excluir os dados?")) {

			var urlAction = document.getElementById("formUser").action;
			var idUser = document.getElementById("id").value;

			$.ajax({

				method: "GET",
				url: urlAction,
				data: "id=" + idUser + "&acao=deletarAjax",
				success: function(response) {

					document.getElementById("msg").textContent = response;
					limparForm();
				}
				
			}).fail(function(xhr, status, errorThrow){

				alert("Erro ao deletar o usu�rio:" + xhr.responseText);
			});
		}
}

function criarDelete() {

	if(confirm("Deseja realmente excluir os dados?")) {
	
		document.getElementById("formUser").method = 'get';
		document.getElementById("acao").value = 'deletar';
		document.getElementById("formUser").submit();
	}
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
