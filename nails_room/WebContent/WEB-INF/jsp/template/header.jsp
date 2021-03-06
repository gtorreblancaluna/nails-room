<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value = "es_MX"/>
<script type="text/javascript">
	// if('${sessionScope.userSession}' == '')
	// 	alert('Aun no estas logueado, favor de loguearte!')
</script>
<nav class="navbar navbar-inverse">
	<div class="container-fluid">
			<c:if test="${not empty userSession.usuario.email}">
				<div class="infoUsuarioHeader" style="float: right;line-height: 3;">
					<label>NOMBRE: ${userSession.usuario.nombre} ${userSession.usuario.ap_paterno} ${userSession.usuario.ap_materno}</label>
					<label>EMAIL: ${userSession.usuario.email}</label>
					<label>PUESTO: ${userSession.usuario.puestoDTO.descripcion}</label>
				</div>
			</c:if>
		<div class="navbar-header">
			<a class="navbar-brand" href="index.do">Nails Room</a>
		</div>
		<ul class="nav navbar-nav">

			<c:if test="${empty userSession.usuario.email}">
				<li class="active"><a href="login.do">Login</a></li>
			</c:if>
			<c:if test="${not empty userSession.usuario.email}">
			
				<li class="active"><a href="logout.do">Salir</a></li>				

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="javascript:void(0);">Sistema</a>
					<ul class="dropdown-menu">
						<li><a href="usuarios.do">Usuarios</a></li>
						<li><a href="clientes.do">Clientes</a></li>
						<li><a href="inventario.do">Inventario</a></li>
					</ul>
				</li>
				
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="javascript:void(0);">Gesti&oacute;n</a>
					<ul class="dropdown-menu">
						<li><a href="ventas.do">Ventas</a></li>
						<li><a href="caja.do">Caja</a></li>
						<li><a href="caja_detalle.do">Detalle Caja</a></li>
						<li><a href="citas.do">Citas</a></li>
					</ul>
				</li>
				
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="javascript:void(0);">Reportes</a>
					<ul class="dropdown-menu">
						<li><a href="reportes.do">Reportes</a></li>						
					</ul>
				</li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="javascript:void(0);">Configuraci&oacute;n</a>
					<ul class="dropdown-menu">
						<li><a href="configuracion.do">Datos empresa</a></li>						
					</ul>
				</li>
				
<!-- 				<li class="dropdown"><a class="dropdown-toggle" -->
<!-- 					data-toggle="dropdown" href="javascript:void(0);">Email</a> -->
<!-- 					<ul class="dropdown-menu"> -->
<!-- 						<li><a href="email.do">Enviar email</a></li>						 -->
<!-- 					</ul> -->
<!-- 				</li> -->


			</c:if>
		</ul>
	</div>
</nav>