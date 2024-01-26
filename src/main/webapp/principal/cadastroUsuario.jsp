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
													<h4 class="sub-title">Cadastro de usuário</h4>

													<form class="form-material">
														<div class="form-group form-default">
															<input type="text" name="id"
																class="form-control" required="" readonly="readonly"> <span
																class="form-bar"></span> <label class="float-label">ID:</label>
														</div>
														<div class="form-group form-default">
															<input type="text" name="nome"
																class="form-control" required=""> <span
																class="form-bar"></span> <label class="float-label">Nome:</label>
														</div>
														<div class="form-group form-default">
															<input type="email" name="email"
																class="form-control" required="">
															<span class="form-bar"></span> <label class="float-label">Email:</label>
														</div>
														<div class="form-group form-default">
															<input type="password" name="senha"
																class="form-control" required=""> <span
																class="form-bar"></span> <label class="float-label">Password</label>
														</div>
														<button class="btn waves-effect waves-light btn-success">Salvar</button>
														<button class="btn waves-effect waves-light btn-primary ml-3">Editar</button>
														<button class="btn waves-effect waves-light btn-danger ml-3">Deletar</button>
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
</body>

</html>
