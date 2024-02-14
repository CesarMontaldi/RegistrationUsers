<%@page import="model.ModelUsuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set scope="session" var="perfil" value='<%= request.getSession().getAttribute("perfil") %>'></c:set>
<c:set scope="session" var="sexo" value='<%= request.getSession().getAttribute("sexo") %>'></c:set>

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
									<span id="msg" class="ml-2">${msg}</span>
									<div class="card">
									<div class="card-block">
											<h4 class="sub-title">Atualizar profile</h4>
											<form class="form-material" enctype="multipart/form-data" action="<%=request.getContextPath()%>/ServletUsuarioController?acao=atualizar" method="post" id="formUser">
											
											<input type="hidden" name="acao" id="acao" />

											<div class="form-group form-default form-static-label">
												<input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${modelUsuario.id}">
												<span class="form-bar"></span>
												<label class="float-label">ID:</label>
											</div>
														 
											<div class="form-group form-default input-group mb-4">
												<div class="input-group-prepend">
													<c:choose>
														<c:when test="${modelUsuario.fotouser != '' && modelUsuario.fotouser != null}">
															<a href="<%=request.getContextPath()%>/ServletUsuarioController?acao=downloadFoto&id=${modelUsuario.id}">
																<img alt="Imagem modelUsuario" id="fotoembase64" src="${modelUsuario.fotouser}" class="img-radius" width="90px" height="90px">
															</a>
														</c:when>
														<c:otherwise>
															<img alt="Imagem modelUsuario" id="fotoembase64" src="assets/images/faq_man.png" class="img-radius" width="90px" height="90px">
														</c:otherwise>
													</c:choose>
												</div>
													<input type="file" id="fileFoto" name="fileFoto" accept="image/*" onchange="visualizarImg('fotoembase64', 'fileFoto')" class="form-control-file" style="margin-top: 30px; margin-left: 15px;">
											</div>
											<div class="row">
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="nome" id="nome" class="form-control" required="required" value="${modelUsuario.nome}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Nome:</label>
												</div>
															
												<div class="form-group form-default form-static-label  col-4"> 
													<input type="email" name="email" id="email" class="form-control" required="required" value="${modelUsuario.email}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Email:</label>
												</div>
											
												<div class="form-group form-default form-static-label col-4">
													<input type="password" name="senha" id="senha" class="form-control row" required="required" value="${modelUsuario.senha}">
													<i id="passwordLock" class="ti-lock" style="cursor: pointer; font-size: 18px; margin-left: -10px;"></i>
													<span class="form-bar"></span>
													<label class="float-label ml-3">Senha:</label>
												</div>
											</div>
											
											<div class="row">
												<div class="form-group form-default form-static-label col-3">
													<input onblur="pesquisaCep()" type="text" name="cep" id="cep" class="form-control" required="required" value="${modelUsuario.cep}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Cep:</label>
												</div>
											</div>
											
											<div class="row">
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="logradouro" id="logradouro" class="form-control" required="required" value="${modelUsuario.logradouro}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Logradouro:</label>
												</div>
												
												<div class="form-group form-default form-static-label col-3">
													<input type="text" name="numero" id="numero" class="form-control" required="required" value="${modelUsuario.numero}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Número:</label>
												</div>
												
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="bairro" id="bairro" class="form-control" required="required" value="${modelUsuario.bairro}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Bairro:</label>
												</div>
											</div>
											
											<div class="form-group form-default form-static-label">
												<input type="text" name="cidade" id="cidade" class="form-control" required="required" value="${modelUsuario.cidade}">
												<span class="form-bar"></span>
												<label class="float-label">Cidade:</label>
											</div>
											
											<div class="form-group form-default form-static-label">
												<input type="text" name="uf" id="uf" class="form-control" required="required" value="${modelUsuario.uf}">
												<span class="form-bar"></span>
												<label class="float-label">Estado:</label>
											</div>
											
														
											<div class="form-group form-default form-static-label">
												<select class="form-control" aria-label="Default select example" name="perfil">
												
												  <option disabled="disabled">[Selecione o Perfil]</option>
												  
												  <option value="ADMIN" <% 
												  
														  ModelUsuario modelUsuario = (ModelUsuario) request.getAttribute("modelUsuario");
												  
												  if (modelUsuario != null && modelUsuario.getPerfil().equals("ADMIN")) {
													  out.println(" ");
													  out.print("selected=\"selected\"");
													  out.println(" ");
												  } %>>Admin</option>
															  
												  <option value="CLIENTE" <% 
												  
														  modelUsuario = (ModelUsuario) request.getAttribute("modelUsuario");
												  		
												  if (modelUsuario != null && modelUsuario.getPerfil().equals("CLIENTE")) {
													  out.println(" ");
													  out.print("selected=\"selected\"");
													  out.println(" ");
												  } %>>Cliente</option>
															  
												  <option value="FUNCIONARIO" <% 
												  
														  modelUsuario = (ModelUsuario) request.getAttribute("modelUsuario");
												  
												  if (modelUsuario != null && modelUsuario.getPerfil().equals("FUNCIONARIO")) {
													  out.println(" ");
													  out.print("selected=\"selected\"");
													  out.println(" ");
												  } %>>Funcionário</option>
															  
												</select>
														<span class="form-bar"></span>
														<label class="float-label">Perfil:</label>
													</div>
												
													<div class="form-group form-default form-static-label" >
													
														<input class="" type="radio" name="sexo" value="MASCULINO" <% 
															
																modelUsuario = (ModelUsuario) request.getAttribute("modelUsuario");
														
															if (modelUsuario != null && modelUsuario.getSexo().equals("MASCULINO")) {
																out.println(" ");
																out.print("checked=\"checked\"");
															  	out.println(" ");
															} %>> Masculino</>
														<input class="ml-2" type="radio" name="sexo" value="FEMININO" <% 
														
																modelUsuario = (ModelUsuario) request.getAttribute("modelUsuario");
														
															if (modelUsuario != null && modelUsuario.getSexo().equals("FEMININO")) {
																out.println(" ");
																out.print("checked=\"checked\"");
															  	out.println(" ");
															} %>> Feminino</>
													</div>
														<button type="button" class="btn waves-effect waves-light btn-success" onclick="limparForm()">Limpar</button>
														<button type="submit" class="btn waves-effect waves-light btn-primary ml-2"><i id="test" class="ti-save"></i>Salvar</button>
														<button type="button" class="btn waves-effect waves-light btn-danger ml-2" onclick="criarDelete()">Excluir</button>
														<c:if test="${modelUsuario.id > 0}">
															<a href="<%=request.getContextPath()%>/ServletTelefone?idUser=${modelUsuario.id}" class="btn waves-effect waves-light btn-primary ml-2">Telefone</a>
														</c:if>
													</form>
												</div>	
											</div>		
										</div>
									</div>
									<!-- Page-body end -->
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

/* Funcao acessa a API ViaCep e carrega o endereço atraves do cep digitado */
function pesquisaCep() {

	var cep = $("#cep").val();

	$.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?", function (dados) {

		if (!("erro" in dados)) {
            //Atualiza os campos com os valores da consulta.
            $("#cep").val(dados.cep);
            $("#logradouro").val(dados.logradouro);
            $("#bairro").val(dados.bairro);
            $("#cidade").val(dados.localidade);
            $("#uf").val(dados.uf);
        }
		  else {
			  limpa_formulário_cep();
              alert("CEP não encontrado.");
          }
	});
} 

function limpa_formulário_cep() {
    // Limpa valores do formulário de cep.
    $("#logradouro").val("");
    $("#bairro").val("");
    $("#cidade").val("");
    $("#uf").val("");
}
	
/* Funcao para limpar os campos do form */
function limparForm() {
	var elementos = document.getElementById("formUser").elements; /* Retorna os elementos html dentro do form */

	for (p = 0; p < elementos.length; p++) {
		elementos[p].value = '';
	}
	$("#fotoembase64").attr('src', 'assets/images/faq_man.png');
	$("#sexo").attr('checked','');
 
}
	
function criarDelete() {

	if (confirm("Deseja realmente excluir os dados?")) {

		document.getElementById("formUser").method = 'get';
		document.getElementById("acao").value = 'deletar';
		document.getElementById("formUser").submit();
		limparForm()
	}
}

/* Funcao para carregar imagem do usuario */
function visualizarImg(fotoembase64, filefoto) {

	 var preview = document.getElementById("fotoembase64"); // Campo IMG html
	 var fileUser = document.getElementById("fileFoto").files[0];
	 var reader = new FileReader();

	 reader.onloadend = function () {
		 preview.src = reader.result; //Carrega a foto na tela
		 };

	 if (fileUser) {
		reader.readAsDataURL(fileUser); // Preview da imagem	
	 } else {
		 preview.src = '';
	 }
}

/* Funcao para deletar usuario com Ajax*/
function deleteAjax() {

	if (confirm("Deseja realmente excluir os dados?")) {

		var urlAction = "<%=request.getContextPath()%>/ServletUsuarioController";
		var idUser = document.getElementById("id").value;

		$.ajax({

			method : "GET",
			url : urlAction,
			data : "id=" + idUser + "&acao=deletarAjax",
			success : function(response) {

				document.getElementById("msg").textContent = response;
				limparForm();
			}

		}).fail(function(xhr, status, errorThrow) {

			alert("Erro ao deletar o usuário:" + xhr.responseText);
		});
	}
}

/* Funcao para deletar usuario */
function criarDelete() {

	if (confirm("Deseja realmente excluir os dados?")) {

		document.getElementById("formUser").method = 'get';
		document.getElementById("acao").value = 'deletar';
		document.getElementById("formUser").submit();
	}
}

var senha = document.getElementById("senha");
var passwordLock = document.getElementById("lock");

passwordLock.addEventListener('click', function () {
	senha.type = senha.type == 'text' ? 'password' : 'text';
	passwordLock.classList.value = passwordLock.classList.value == 'ti-lock' ? 'ti-unlock' : 'ti-lock';
});

</script>

</body>

</html>
