<%@page import="model.ModelUsuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<c:set scope="session" var="perfil" value='<%= request.getSession().getAttribute("perfil") %>'></c:set>
	<c:set scope="session" var="fotoUser" value='<%= request.getSession().getAttribute("fotoUser") %>'></c:set>
	
<nav class="pcoded-navbar">
	<div class="sidebar_toggle">
		<a href="#"><i class="icon-close icons"></i></a>
	</div>
	<div class="pcoded-inner-navbar main-menu">
		<div class=""> 
			<div class="main-menu-header">
				<c:choose>
					<c:when test="${modelUsuario.fotouser != null && modelUsuario.fotouser != ''}">
						<img class="img-80 img-radius" src="${modelUsuario.fotouser}" id="fotoUser" alt="User-Profile-Image">
					</c:when>
					
					<c:otherwise>
						<img class="img-radius" src="<%=request.getContextPath()%>/assets/images/faq_man.png" id="fotoUser" alt="User-Profile-Image">
					</c:otherwise>
				</c:choose>
					<div class="user-details"> 
						<span id="more-details"> <%= request.getSession().getAttribute("nomeUsuario") %> <i class="fa fa-caret-down"></i></span> 
					</div>
			</div>

			<div class="main-menu-content">
				<ul>
					<li class="more-details"> <% ModelUsuario modelUsuario = (ModelUsuario) request.getSession().getAttribute("modelUsuario"); %>
						<a href="<%=request.getContextPath()%>/ServletUsuarioController?acao=profileUser&id=<%= modelUsuario.getId() %>"><i class="ti-user"></i>View Profile</a> 
						<!-- <a href="#!"><i class="ti-settings"></i>Settings</a> -->
						<a href="<%=request.getContextPath()%>/ServletLogin?acao=logout"><i class="ti-layout-sidebar-left"></i>Sair</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- <div class="p-15 p-b-0">
			<form class="form-material">
				<div class="form-group form-primary">
					<input type="text" name="footer-email" class="form-control" required="">
					<span class="form-bar"></span>
					<label class="float-label"><i class="fa fa-search m-r-10"></i>Search Friend</label>
				</div>
			</form>
		</div>
		
		<div class="pcoded-navigation-label" data-i18n="nav.category.navigation">Layout</div> -->
			
		<ul class="pcoded-item pcoded-left-item">
		
			<li class="active mt-2">
				<a href="<%=request.getContextPath()%>/principal/principal.jsp" class="waves-effect waves-dark">
					 <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
					 <span class="pcoded-mtext" data-i18n="nav.dash.main">In�cio</span>
					 <span class="pcoded-mcaret"></span>
				</a>
			</li>
			
			<li class="pcoded-hasmenu mt-2">
				<a href="javascript:void(0)" class="waves-effect waves-dark">
					 <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
					 <span class="pcoded-mtext" data-i18n="nav.basic-components.main">Cadastros</span>
					 <span class="pcoded-mcaret"></span>
				</a>
				
				<ul class="pcoded-submenu">
					<c:if test="${perfil == 'ADMIN'}">
						<li class=" ">
							<a href="<%=request.getContextPath()%>/principal/cadastroUsuario.jsp" class="waves-effect waves-dark">
								 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								 <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Usu�rios</span>
								 <span class="pcoded-mcaret"></span>
							</a>
						</li>
					</c:if>
					
					 <li class=" ">
						<a href="<%=request.getContextPath()%>/ServletTelefone?iduser=${modelUsuario.id}" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Telefones</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<!-- <li class=" ">
						<a href="button.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Button</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="tabs.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Tabs</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="color.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Color</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="label-badge.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Label Badge</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="tooltip.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Tooltip</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="typography.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Typography</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="notification.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span> 
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Notification</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li class=" ">
						<a href="icon-themify.html" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
							 <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Themify</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li> -->
				</ul>
			</li>
		</ul>
		
		<!-- <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Relat�rio</div> -->
		<ul class="pcoded-item pcoded-left-item">
		<li class="pcoded-hasmenu">
				<a href="javascript:void(0)" class="waves-effect waves-dark">
					 <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
					 <span class="pcoded-mtext" data-i18n="nav.basic-components.main">Relat�rios</span>
					 <span class="pcoded-mcaret"></span>
				</a>
				<ul class="pcoded-submenu">
					<li>
						<a href="<%=request.getContextPath()%>/principal/userRelatorio.jsp" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
							 <span class="pcoded-mtext" data-i18n="nav.form-components.main">Usu�rio</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
					
					<li>
						<a href="<%=request.getContextPath()%>/principal/userRelatorioGrafico.jsp" class="waves-effect waves-dark">
							 <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
							 <span class="pcoded-mtext" data-i18n="nav.form-components.main">Gr�fico S�lario</span>
							 <span class="pcoded-mcaret"></span>
						</a>
					</li>
				</ul>
				</li>
			</ul>
		<!-- <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Chart &amp; Maps</div> -->
		
			<ul class="pcoded-item pcoded-left-item">
				<!-- <li>
					<a href="chart.html" class="waves-effect waves-dark"> 
						<span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
						<span class="pcoded-mtext" data-i18n="nav.form-components.main">Chart</span>
						<span class="pcoded-mcaret"></span>
					</a>
				</li>
				
				<li>
					<a href="map-google.html" class="waves-effect waves-dark">
						<span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
						<span class="pcoded-mtext" data-i18n="nav.form-components.main">Maps</span>
						<span class="pcoded-mcaret"></span>
					</a>
				</li> -->
				
				<li class="pcoded-hasmenu">
					<a href="javascript:void(0)" class="waves-effect waves-dark">
						 <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
						 <span class="pcoded-mtext" data-i18n="nav.basic-components.main">Pages</span>
						 <span class="pcoded-mcaret"></span>
					</a>
					
					<ul class="pcoded-submenu">
						<li class=" ">
							<a href="<%=request.getContextPath()%>/ServletUsuarioController?acao=listarUser" class="waves-effect waves-dark">
								<span class="pcoded-micon"><i class="ti-angle-right"></i>
								</span> <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Usu�rios</span>
								<span class="pcoded-mcaret"></span>
							</a>
						</li>
						
						<%-- <li class=" ">
							<a href="<%=request.getContextPath()%>/principal/login.jsp" class="waves-effect waves-dark"> 
								<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								<span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Login</span>
								<span class="pcoded-mcaret"></span>
							</a>
						</li>
						
						<li class=" ">
							<a href="sample-page.html" class="waves-effect waves-dark"> 
								<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								<span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Sample Page</span>
								<span class="pcoded-mcaret"></span>
							</a>
						</li> --%>
					</ul>
				</li>
			</ul>

		<!-- <div class="pcoded-navigation-label" data-i18n="nav.category.other">Other</div>
			<ul class="pcoded-item pcoded-left-item">
				<li class="pcoded-hasmenu ">
					<a href="javascript:void(0)" class="waves-effect waves-dark">
					 	<span class="pcoded-micon"><i class="ti-direction-alt"></i><b>M</b></span>
						<span class="pcoded-mtext" data-i18n="nav.menu-levels.main">Menu Levels</span>
						<span class="pcoded-mcaret"></span>
					</a>
					
					<ul class="pcoded-submenu">
						<li class="">
							<a href="javascript:void(0)" class="waves-effect waves-dark">
							 	<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								<span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-21">Menu Level 2.1</span>
								<span class="pcoded-mcaret"></span>
							</a>
						</li>
						
						<li class="pcoded-hasmenu">
							<a href="javascript:void(0)" class="waves-effect waves-dark">
							 	<span class="pcoded-micon"><i class="ti-direction-alt"></i></span>
								<span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.main">Menu Level 2.2</span>
								<span class="pcoded-mcaret"></span>
							</a>
							
							<ul class="pcoded-submenu">
								<li class="">
									<a href="javascript:void(0)" class="waves-effect waves-dark">
										 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
										 <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.menu-level-31">Menu Level 3.1</span>
										 <span class="pcoded-mcaret"></span>
									</a>
								</li>
							</ul>
						</li>
						
						<li class="">
							<a href="javascript:void(0)" class="waves-effect waves-dark">
								 <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								 <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-23">Menu Level 2.3</span>
								 <span class="pcoded-mcaret"></span>
							</a>
						</li>
					</ul>
				</li>
			</ul> -->
	  </div>
</nav>