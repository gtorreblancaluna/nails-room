<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<footer class="" style="color:white;background-color: #000; padding:25px;">

<div class="">
	<div class="row">
		<div class="col text-center" >
			<img alt="" style="width: 10%;" src="images/mostaza_logo.jpeg">
		</div>
		<c:if test="${not empty userSession.usuario.email}">
<!-- 		Mostrar informacion del usuario -->
			<div style="padding-top:25px;">
				<div class="row">
					<div class="col-md-4 text-center">
						<label>NOMBRE: ${userSession.usuario.nombre} ${userSession.usuario.ap_paterno} ${userSession.usuario.ap_materno}</label>
					</div>
					<div class="col-md-4 text-center">
						<label>EMAIL: ${userSession.usuario.email}</label>
					</div>
					<div class="col-md-4 text-center">
						<label>PUESTO: ${userSession.usuario.puestoDTO.descripcion}</label>
					</div>
				</div>		
			</div>
		</c:if>
	</div>
</div>



</footer>