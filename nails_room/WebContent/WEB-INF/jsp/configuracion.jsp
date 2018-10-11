<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<style type="text/css">

</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: configuraci&oacute;n</title>
</head>
<body> 

<div class="container" style="">

		<c:if test="${messageView != null}">
			<div class="alert alert-success">
	  			<strong>Success!</strong> 
	  			<c:set var = "message" value = "${messageView}"/>
	  			<c:forEach var="item" items="${fn:split(message,'|')}">
	        		<p>${item}</p>
				</c:forEach>
			</div>

		</c:if>
		<c:if test="${messageError != null}">
			<div class="alert alert-danger">
	  			<strong>Error! </strong> ${messageError}
			</div>
		</c:if>	
		
		<div class="page-header">
		<div class="row">
			<div class="col">
				<h1>Datos de la empresa</h1>
			</div>
			
		</div>
	</div>
		
		<form:form modelAttribute="configuracion" action="configuracion.do" method="post" name="configuracionForm" id="configuracionForm"> <!-- formulario para mostrar la configuracion -->
			<div class="form-group row">
				<div class="col-xs-12">
					<label>Nombre empresa: </label>
					<input type="text" id="nombreEmpresa" name="nombreEmpresa" class="form-control" value="${configuracion.nombreEmpresa}" disabled>
				</div>
			
				<div class="col-xs-12">
					<label>Direcci&oacute;n empresa: </label>
					<input type="text" id="direccionEmpresa" name="direccionEmpresa" class="form-control" value="${configuracion.direccionEmpresa}" disabled>
				</div>
			
				<div class="col-xs-12">
					<label>Tel&eacute;fono uno: </label>
					<input type="tel" id="telefonoUno" name="telefonoUno" class="form-control" value="${configuracion.telefonoUno}" disabled>
				</div>
							
				<div class="col-xs-12">
					<label>Tel&eacute;fono dos: </label>
					<input type="tel" id="telefonoDos" name="telefonoDos" class="form-control" value="${configuracion.telefonoDos}" disabled>
				</div>			
			</div>
			<div class="form-group row">
					<div class="col-xs-12">
						<input type="button" id="btnEditar" class="btn btn-dark" name="editar" value="Editar" style="width: 100%;"/>					
					</div>
				</div>	
			<div class="form-group row">
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark" name="guardar" value="Enviar" style="width: 100%;"/>					
					</div>
				</div>	
		</form:form> <!-- end formulario -->
			
</div> <!-- end container -->


<script type="text/javascript">

$( document ).ready(function() {		
	
	$( '#btnEditar' ).click(function() {
		$('#nombreEmpresa,#direccionEmpresa,#telefonoUno,#telefonoDos').prop( "disabled", false );
	});

	
}); // end document ready

</script>
</body>
</html>