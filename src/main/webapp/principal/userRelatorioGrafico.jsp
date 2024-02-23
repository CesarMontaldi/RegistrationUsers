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
														<form class="form-material" action="<%=request.getContextPath()%>/ServletUsuarioController" method="get" id="formRelGraficUser">
															 
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
																     <button type="button" onclick="gerarGrafico()" class="btn btn-primary">Gerar Gráfico</button>
																 </div>
															 </div>
															 
														</form>
													</div>
													<div class="card ">
														<div class="card-block">
															<div>
																<div>
																	<canvas id="myChart"></canvas>
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
	</div>

<jsp:include page="javaScriptFile.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script type="text/javascript">

var myChart = new Chart(
    document.getElementById('myChart'));

function gerarGrafico() {

	var urlAction = document.getElementById("formRelGraficUser").action;
	var dataInicial = document.getElementById("dataInicial").value; 
	var dataFinal = document.getElementById("dataFinal").value;

	const formatter = new Intl.NumberFormat('pt-BR', {
		currency : 'BRL',
		minimumFractionDigits : 2
	});

	$.ajax({
		
	
		method : "GET",
		url : urlAction,
		data : "dataInicial=" + dataInicial + "&dataFinal="+ dataFinal + "&acao=graficoSalario",
		success : function(response) {
			
			var json = JSON.parse(response);

			myChart.destroy();			

			var media_salarios = [];

			for(let salario in json.salarios) {
				media_salarios.push(json.salarios[salario].toFixed(2));
			};
			
			myChart = new Chart(

			    document.getElementById('myChart'),
			   {
				 type: 'line',
				 data: {
					  labels: json.perfils,
					  datasets: [{
					    label: 'Gráfico média salarial',
					    backgroundColor: 'rgb(255, 99, 132)',
					    borderColor: 'rgb(255, 99, 132)',
					    data: media_salarios,
					  }]
					},
				 options: {}
				}
			 );
		}
	
	}).fail(function(xhr, status, errorThrow) {
	
		alert("Erro ao buscar dados para o gráfico" + xhr.responseText);
	});

	
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
