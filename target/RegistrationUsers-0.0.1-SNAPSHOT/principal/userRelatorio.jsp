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
											<div class="col-12">
												<span id="msg" class="ml-2">${msg}</span>
												<div class="card">
													<div class="card-block">
														<h4 class="sub-title">Relátorio de usuário</h4>
														<form class="form-material" action="<%=request.getContextPath()%>/ServletUsuarioController?acao=imprimirRelatorioUser" method="get" id="formRelatorioUser">
															 
															 <input type="hidden" id="acaoRelatorioImprimirTipo" name="acao" value="imprimirRelatorioUser" />
															 
															 <div class="row">
															     <div class="form-group form-default form-static-label col-3">
															         <input type="text" name="dataInicial" id="dataInicial" class="form-control" value="${dataInicial}">
															         <span class="form-bar"></span>
															         <label class="float-label ml-3" for="dataInicial">Data Inicial</label>
															     </div>
															     
															     <div class="form-group form-default form-static-label col-3">
															     	 <input type="text" name="dataFinal" id="dataFinal" class="form-control" value="${dataFinal}">
															     	 <span class="form-bar"></span>
																     <label class="float-label ml-3" for="dataFinal">Data final</label>
																 </div>
																 
																 <div class="form-group form-default form-static-label ml-3">
																     <button type="button" onclick="imprimirHTML()" class="btn btn-primary">Imprimir Relátorio</button>
																     <button type="button" onclick="imprimirPDF()" class="btn btn-primary">Imprimir PDF</button>
																     <button type="button" onclick="imprimirExcel()" class="btn btn-primary">Imprimir Excel</button>
																 </div>
															 </div>
															 
														</form>
													</div>
													<div class="card ">
														<div class="card-block">
															<h4 class="sub-title">Relátorio de usuários</h4>
															<div style=" overflow: scroll;">
																<table class="table" id="tabelaUsersViews">
																	<thead>
																		<tr>
																			<th scope="col">ID</th>
																			<th scope="col">Nome</th>
																			<th scope="col">Telefone</th>
																		</tr>
																	</thead>
																	<tbody>
																		<c:forEach items="${listUsers}" var="users">
																			<tr>
																				<td><c:out value="${users.id}"></c:out></td>
																				<td><c:out value="${users.nome}"></c:out></td>
																				<td>
																					<c:forEach items="${users.telefones}" var="fone">
																						<c:out value="${fone.numero}"></c:out><br>
																					</c:forEach>
																		</c:forEach>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="javaScriptFile.jsp"></jsp:include>
	
	<script type="text/javascript">

function imprimirHTML() {
	document.getElementById("acaoRelatorioImprimirTipo").value = "imprimirRelatorioUser";
	$("#formRelatorioUser").submit();
}

function imprimirPDF() {
	document.getElementById("acaoRelatorioImprimirTipo").value = "imprimirRelatorioPdf";
	$("#formRelatorioUser").submit();
	return false;
}

function imprimirExcel() {
	document.getElementById("acaoRelatorioImprimirTipo").value = "imprimirRelatorioEcxel";
	$("#formRelatorioUser").submit();
	return false;
}
	
$(function() {
	  
	  $("#dataInicial").datepicker({
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

$(function() {
	  
	  $("#dataFinal").datepicker({
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

$(document).ready(function () {
    $("#dataInicial").mask('00/00/0000');
});

$(document).ready(function () {
    $("#dataFinal").mask('00/00/0000');
});

	</script>
</body>

</html>
