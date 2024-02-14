<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<span id="msg" class="ml-2">${msg_salvar}</span>
												<div class="card">
													<div class="card-block">
														<h4 class="sub-title">Cadastro de telefone</h4>
														<form class="form-material" action="<%=request.getContextPath()%>/ServletTelefone" method="post" id="formFone">
															<div class="form-group form-default form-static-label">
																<input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${usuario.id}">
																<span class="form-bar"></span> 
																<label class="float-label">ID User:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id="nome" class="form-control" readonly="readonly" value="${usuario.nome}">
																<span class="form-bar"></span>
																<label class="float-label">Nome:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="text" name="numero" id="numero" class="form-control" required="required" value="${userfone.numero}">
																<span class="form-bar"></span>
																<label class="float-label">Numero:</label>
															</div>
															<button type="submit" class="btn waves-effect waves-light btn-primary">Salvar</button>
															<button type="button" class="btn waves-effect waves-light btn-danger ml-2" onclick="deleteAjax()">Excluir</button>
														</form>
													</div>
													
												</div>
													<span id="msg" class="ml-2">${msg}</span>
													<div class="card ">
														<div class="card-block">
														<h4 class="sub-title">Lista de telefones</h4>
														<div style=" overflow: scroll;">
															<table class="table" id="tabelaUsersViews">
																<thead>
																	<tr>
																		<th scope="col">ID</th>
																		<th scope="col">Numero</th>
																		<th scope="col">Excluir</th>
																	</tr>
																</thead>
																<tbody>
																	<c:forEach items='${listfones}' var="telefones">
																		<tr>
																			<td><c:out value="${telefones.id}"></c:out></td>
																			<td><c:out value="${telefones.numero}"></c:out></td>
																			<td><a href="<%=request.getContextPath()%>/ServletTelefone?acao=excluir&idfone=${telefones.id}&iduser=${usuario.id}" style="border-radius:8px; 
																			width:45px; heigth:45px; font-size: 25px" class="btn btn-danger d-flex justify-content-center align-items-center">
																			<i class="ti-trash ml-1 mb-1" style="font-size:17px;"></i></a></td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
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

/* $("#numero").keypress(function (event) {
	return /\d/.test(String.fromCharCode(event.keyCode));	
 }); */

$('#numero').blur(function(){
    $('#numero').mask('(00) 0000-0000');
    });

</script>
</body>

</html>
