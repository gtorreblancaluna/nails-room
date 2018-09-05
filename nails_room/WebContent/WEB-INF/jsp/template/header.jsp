<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
	// if('${sessionScope.userSession}' == '')
	// 	alert('Aun no estas logueado, favor de loguearte!')
</script>
<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="javascript:void(0);">Nails Room</a>
		</div>
		<ul class="nav navbar-nav">

			<c:if test="${empty userSession.usuario.email}">
				<li class="active"><a href="login.do">Login</a></li>
			</c:if>
			<c:if test="${not empty userSession.usuario.email}">
				<li class="active"><a href="logout.do">Salir</a></li>
				<!-- Validamos que el usuario sea diferente a proovedor -->

				<li class="active"><a href="index.do">Home</a></li>

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
						<li><a href="citas.do">Citas</a></li>
					</ul>
				</li>


			</c:if>
		</ul>
	</div>
</nav>