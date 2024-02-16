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
										<div class="col-12">
										<span id="msg" class="ml-2">${msg}</span>
										<div class="card ">
										<div class="card-block">
											<h4 class="sub-title">Lista de usuários</h4>
											<div class="d-flex justify-content-center">
												<button type="button" class="btn btn-primary mb-2" data-toggle="modal" data-target="#modalUser"><i class="ti-search mr-2"></i>Pesquisar</button>
											</div>
											<div style=" overflow: scroll;">
												<table class="table" id="tabelaUsersViews">
													<thead>
														<tr>
															<th scope="col">ID</th>
															<th scope="col">Nome</th>
															<th scope="col">Email</th>
															<th scope="col">Telefone</th>
															<th scope="col">Editar</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${modelUsuarios}" var="users">
															<tr>
																<td><c:out value="${users.id}"></c:out></td>
																<td><c:out value="${users.nome}"></c:out></td>
																<td><c:out value="${users.email}"></c:out></td>
																<td>
																	<c:forEach items="${users.telefones}" var="fone">
																		<c:out value="${fone.numero}"></c:out><br>
																	</c:forEach>
																</td>
																<td><a href="<%=request.getContextPath()%>/ServletUsuarioController?acao=buscarEditar&id=${users.id}" style="border-radius:8px; 
																width:45px; heigth:45px;" class="btn btn-primary d-flex justify-content-center align-items-center">
																<i class="ti-pencil-alt ml-1 mb-1" style="font-size:17px;"></i></a></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="d-flex justify-content-center row">
												<nav aria-label="Page navigation example" class="mt-2">
												  <ul class="pagination">
												  
												  	<% 
												  		int totalPagina = (int) request.getAttribute("totalPagina");
												  		
												  		for (int p = 0; p < totalPagina; p++) {
												  			
												  			String url = request.getContextPath() + "/ServletUsuarioController?acao=paginar&pagina=" + (p * 5);
												  			out.print("<li class='page-item'><a class='page-link' href=" + url + ">" + (p + 1) + "</a></li>");
												  		}
												  	%>
												    
												  </ul>
												</nav>
												<span id="totalUsers"></span>
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
					<div class="input-group mb-3 col-8 ">
						<input type="text" id="nomeBusca" class="form-control">
						<span class="input-group-addon"><i class="ti-search" onclick="buscarUsuario()"></i></span>
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
						<div  class="d-flex justify-content-center">
							<nav aria-label="Page navigation example" class="mt-2">
					  		<ul class="pagination" id="ulPaginacaoUserAjax">
	
					  		</ul>
							</nav>
						</div>
					<span id="totalUsers"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" onclick="limparDados()" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">


function buscaUserPagAjax(url) {
	

	var urlAction = "<%=request.getContextPath()%>/ServletUsuarioController";
	var nomeBusca = document.getElementById("nomeBusca").value;

	
	$.ajax(
			{
				method : "GET",
				url : urlAction,
				data : url,
				success : function(response, textStatus, xhr) {

					
					
					var json = JSON.parse(response);
					
					$('#tabelaUsers > tbody > tr').remove();
					$("#ulPaginacaoUserAjax > li").remove();
	
					for (var p = 0; p < json.length; p++) {
						
						$('#tabelaUsers > tbody').append('<tr> <td>' + json[p].id + '</td> <td>'+ json[p].nome 
								+ ' </td> <td> <button onclick="editarUser('+json[p].id+')" type="button" style="border-radius:8px; width:45px; heigth:45px;" '
								+ ' class="btn btn-primary d-flex justify-content-center align-items-center"> '
								+ ' <i class="ti-pencil-alt ml-1 mb-1" style="font-size:17px;"></i></button> </td></tr>');
						
					}

					
							
					var totalPagina = xhr.getResponseHeader("totalPagina");
					
					for (var p = 0; p < totalPagina; p++) {

						var url = "nomeBusca=" + nomeBusca + "&acao=buscarUserAjaxPage&pagina=" + (p * 5);
						
						$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\'' + url + '\')">' + (p + 1) + '</a></li>');
							
						}
				}

		}).fail(
		function(xhr, status, errorThrow) {
			alert("Erro ao buscar o usuário:"
					+ xhr.responseText);

		});

	
} 

/* Funcao para buscar usuarios utilizando Ajax  */
function buscarUsuario() {
	
	var nomeBusca = document.getElementById("nomeBusca").value;
	
	if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') { /* Validando que tem que ter valor para buscar no banco */

	var urlAction = "<%=request.getContextPath()%>/ServletUsuarioController";
		
	$.ajax(
			{
				method : "GET",
				url : urlAction,
				data : "nomeBusca=" + nomeBusca + "&acao=buscarUserAjax",
				success : function(response, textStatus, xhr) {
					
					var json = JSON.parse(response);

					$('#tabelaUsers > tbody > tr').remove();
					$("#ulPaginacaoUserAjax > li").remove();

					for (var p = 0; p < json.length; p++) {

						$('#tabelaUsers > tbody').append('<tr> <td>' + json[p].id + '</td> <td>'+ json[p].nome 
								+ ' </td> <td> <button onclick="editarUser('+json[p].id+')" type="button" style="border-radius:8px; width:45px; heigth:45px;" '
								+ ' class="btn btn-primary d-flex justify-content-center align-items-center"> '
								+ ' <i class="ti-pencil-alt ml-1 mb-1" style="font-size:17px;"></i></button> </td></tr>');
						
					}

					var totalPagina = xhr.getResponseHeader("totalPagina");
					
					for (var p = 0; p < totalPagina; p++) {
						
						var url = "nomeBusca=" + nomeBusca + "&acao=buscarUserAjaxPage&pagina=" + (p * 5);
						
						$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\'' + url + '\')">' + (p + 1) + '</a></li>');
							
						}
				}
				
			}).fail(
			function(xhr, status, errorThrow) {
				alert("Erro ao buscar o usuário:"
						+ xhr.responseText);

			});
		
	}
}

/* Funcao para buscar usuario e editar utilizando Ajax */
function editarUser(id) {

	var urlAction = "<%=request.getContextPath()%>/ServletUsuarioController";

	window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
}

//Limpa os campos dentro da modal.
function limparDados() {
	$("#nomeBusca").val("");
	$('#tabelaUsers > tbody').html("");
	$("#ulPaginacaoUserAjax").html("");
	$("#totalUsers").html("");
}

</script>

</body>

</html>
