<%@page import="model.ModelUsuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
										<c:choose>
											<c:when test="${user.id != null && user.id != ''}">
												<h4 class="sub-title">Atualizar cadastro</h4>
											</c:when>
											<c:otherwise>
												<h4 class="sub-title">Cadastro de usuário</h4>
											</c:otherwise>
										</c:choose>
										<form class="form-material" enctype="multipart/form-data" action="<%=request.getContextPath()%>/ServletUsuarioController?acao=cadastrar" method="post" id="formUser">
											
											<input type="hidden" name="acao" id="acao" />
														 
											<div class="form-group form-default input-group mb-4">
												<div class="input-group-prepend">
													<c:choose>
														<c:when test="${user.fotouser != '' && user.fotouser != null}">
															<a href="<%=request.getContextPath()%>/ServletUsuarioController?acao=downloadFoto&id=${user.id}">
																<img alt="Imagem modelUsuario" id="fotoembase64" src="${user.fotouser}" class="img-radius" width="90px" height="90px">
															</a>
														</c:when>
														<c:otherwise>
															<img alt="Imagem modelUsuario" id="fotoembase64" src="<%=request.getContextPath()%>/assets/images/faq_man.png" class="img-radius" width="90px" height="90px">
														</c:otherwise>
													</c:choose>
												</div>
													<input type="file" id="fileFoto" name="fileFoto" accept="image/*" onchange="visualizarImg('fotoembase64', 'fileFoto')" class="form-control-file" style="margin-top: 30px; margin-left: 15px;">
											</div>
											<div class="row mt-2">
												<div class="form-group form-default form-static-label col-1">
													<input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${user.id}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">ID:</label>
												</div>
												
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="nome" id="nome" class="form-control" required="required" value="${user.nome}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Nome:</label>
												</div>
															
												<div class="form-group form-default form-static-label  col-4"> 
													<input type="email" name="email" id="email" class="form-control" required="required" value="${user.email}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Email:</label>
												</div>
												<div class="form-group form-default form-static-label col-3">
													<input type="password" name="senha" id="senha" class="form-control row" required="required" value="${user.senha}">
													<i id="passwordLock" class="ti-lock" style="cursor: pointer; font-size: 18px; margin-left: -10px;"></i>
													<span class="form-bar"></span>
													<label class="float-label">Senha:</label>
												</div>
											</div>
											<div class="row mt-2">
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="dataNascimento" id="dataNascimento" class="form-control" required="required" value="${user.dataNascimento}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Data Nascimento:</label>
												</div>
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="telefone" id="telefone" class="form-control" value="${foneuser}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Telefone:</label>
												</div>
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="rendaMensal" id="rendaMensal" class="form-control" required="required" value="${user.rendamensal}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Renda Mensal:</label>
												</div>
											</div>
											<div class="row mt-2">
												<div class="form-group form-default form-static-label col-3">
													<input onblur="pesquisaCep()" type="text" name="cep" id="cep" class="form-control" required="required" value="${user.cep}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Cep:</label>
												</div>
									
												<div class="form-group form-default form-static-label col-6">
													<input type="text" name="logradouro" id="logradouro" class="form-control" required="required" value="${user.logradouro}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Logradouro:</label>
												</div>
												
												<div class="form-group form-default form-static-label col-3">
													<input type="text" name="numero" id="numero" class="form-control" required="required" value="${user.numero}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Número:</label>
												</div>
											</div>
											<div class="row mt-2">
												<div class="form-group form-default form-static-label col-6">
													<input type="text" name="bairro" id="bairro" class="form-control" required="required" value="${user.bairro}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Bairro:</label>
												</div>
											
												<div class="form-group form-default form-static-label col-4">
													<input type="text" name="cidade" id="cidade" class="form-control" required="required" value="${user.cidade}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Cidade:</label>
												</div>
												
												<div class="form-group form-default form-static-label col-2">
													<input type="text" name="uf" id="uf" class="form-control" required="required" value="${user.uf}">
													<span class="form-bar"></span>
													<label class="float-label ml-3">Estado:</label>
												</div>
											</div>
												<div class="row">
													<div class="form-group form-default form-static-label col-6">
														<select class="form-control" aria-label="Default select example" name="perfil">
														
														  <option disabled="disabled">[Selecione o Perfil]</option>
														  
														  <option value="ADMIN" <% 
														  
															  ModelUsuario user = (ModelUsuario) request.getAttribute("user");
														  
														  if (user != null && user.getPerfil().equals("ADMIN")) {
															  out.println(" ");
															  out.print("selected=\"selected\"");
															  out.println(" ");
														  } %>>Admin</option>
																	  
														  <option value="CLIENTE" <% 
														  
																  user = (ModelUsuario) request.getAttribute("user");
														  		
														  if (user != null && user.getPerfil().equals("CLIENTE")) {
															  out.println(" ");
															  out.print("selected=\"selected\"");
															  out.println(" ");
														  } %>>Cliente</option>
																	  
														  <option value="FUNCIONARIO" <% 
														  
																  user = (ModelUsuario) request.getAttribute("user");
														  
														  if (user != null && user.getPerfil().equals("FUNCIONARIO")) {
															  out.println(" ");
															  out.print("selected=\"selected\"");
															  out.println(" ");
														  } %>>Funcionário</option>
																	  
															</select>
															<span class="form-bar"></span>
															<label class="float-label ml-3">Perfil:</label>
														</div>
												
															<div class="form-group form-default form-static-label ml-3" >
														
																<input class="mt-2" type="radio" name="sexo" value="MASCULINO" required="required" <% 
																
																	user = (ModelUsuario) request.getAttribute("user");
															
																if (user != null && user.getSexo().equals("MASCULINO")) {
																	out.println(" ");
																	out.print("checked=\"checked\"");
																  	out.println(" ");
																} %>> Masculino</>
																<input class="ml-2 mt-2" type="radio" name="sexo" value="FEMININO" required="required"<% 
															
																	user = (ModelUsuario) request.getAttribute("user");
															
																if (user != null && user.getSexo().equals("FEMININO")) {
																	out.println(" ");
																	out.print("checked=\"checked\"");
																  	out.println(" ");
																} %>> Feminino</>
																
																<span class="form-bar"></span>
																<label class="float-label" style="margin-top: -30px;">Sexo:</label>
															</div>

													</div>
														
														<div class="row ml-1 mt-2">
															<button type="submit" class="btn waves-effect waves-light btn-primary"><i class="ti-save mr-2"></i>Salvar</button>
															<button type="button" class="btn waves-effect waves-light btn-success ml-3" onclick="limparForm()"><i class="ti-brush-alt"></i>Limpar</button>
															<button type="button" class="btn waves-effect waves-light btn-danger ml-3 d-flex align-items-center" onclick="deleteAjax()"><i class="ti-trash mr-2" style="font-size: 18px;"></i>Excluir</button>
															<c:if test="${user.id > 0}">
																<a href="<%=request.getContextPath()%>/ServletTelefone?iduser=${user.id}" class="btn waves-effect waves-light btn-primary ml-3"><img src="<%=request.getContextPath()%>/assets/images/telefone1.png" class="mr-2">Telefone</a>
															</c:if>
														</div>
													</form>

												</div>
											</div>
										</div>
									</div>
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
	<div class="modal fade" id="modalUser" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLabel">Pesquisa de usuário</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Nome"
							aria-label="Nome" id="nomeBusca" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button"
								onclick="buscarUsuario()">Buscar</button>
						</div>
					</div>
					<div style="height: 300px; overflow: scroll;">
						<table class="table" id="tabelaUsers">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Nome</th>
									<th scope="col">Editar</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					
					<nav aria-label="Page navigation example">
				  	<ul class="pagination" id="ulPaginacaoUserAjax">
				  	
				  	
				  	</ul>
					</nav>
					<span id="totalUsers"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" onclick="limparDados()" data-dismiss="modal">Fechar</button>
						
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">

/* Mascara para campo monetario */
$("#rendaMensal").maskMoney({prefix:"R$ ", decimal:",", thousands:"."});

/* funcao para retornar campo monetario no formato R$0,00 */
const formatter = new Intl.NumberFormat('pt-BR', {
	currency : 'BRL',
	minimumFractionDigits : 2
});

$("#rendaMensal").val(formatter.format($("#rendaMensal").val()));

$("#rendaMensal").focus();


/* funcao para criar um calendario do tipo datepicker */
$(function() {
	  
	  $("#dataNascimento").datepicker({
		    dateFormat: 'dd/mm/yy',
		    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
		    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
		    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		    nextText: 'Próximo',
		    prevText: 'Anterior'
		});
} );

/* Mascara para campo de data */
$(document).ready(function () {
    $("#dataNascimento").mask('00/00/0000');
});

/* Funcao para retornar o campo de data no formato dd/mm/yyyy */
var dataNascimento = $("#dataNascimento").val();

var dateFormat = new Date(dataNascimento);

$("#dataNascimento").val(dateFormat.toLocaleDateString('pt-BR', {timeZone : 'UTC'}));

/* Mascara para campo de telefone */
$(document).ready(function () {
    $("#telefone").mask('(00) 0 0000-0000');
});

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

//Limpa os campos dentro da modal.
function limparDados() {
	$("#nomeBusca").val("");
	$('#tabelaUsers > tbody').html("");
	$("#ulPaginacaoUserAjax").html("");
	$("#totalUsers").html("");
}

/* Funcao para buscar usuario e editar utilizando Ajax */
function editarUser(id) {

	var urlAction = document.getElementById("formUser").action;

	window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
}

function deleteAjax() {

	if (confirm("Deseja realmente excluir os dados?")) {

		var idUser = document.getElementById("id").value;

		$.ajax({

			method : "GET",
			url : "<%=request.getContextPath()%>/ServletUsuarioController",
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


/* Funcao para limpar os campos do form */
function limparForm() {
	var elementos = document.getElementById("formUser").elements; /* Retorna os elementos html dentro do form */

	for (p = 0; p < elementos.length; p++) {
		
			elementos[p].value = '';
		
	}
	$("#F").val('FEMININO');
	$("#M").val('MASCULINO');
	$("#fotoembase64").attr('src', 'assets/images/faq_man.png');
	
 
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

/* função para mostrar e ocultar senha */
 var senha = document.getElementById("senha");
 var passwordLock = document.getElementById("passwordLock");

 passwordLock.addEventListener('click', function () {
 	senha.type = senha.type == 'text' ? 'password' : 'text';
 	passwordLock.classList.value = passwordLock.classList.value == 'ti-lock' ? 'ti-unlock' : 'ti-lock';
 });

 $("#cep").keypress(function (event) {
	return /\d/.test(String.fromCharCode(event.keyCode));	
 });

 
</script>
	
</body>

</html>
