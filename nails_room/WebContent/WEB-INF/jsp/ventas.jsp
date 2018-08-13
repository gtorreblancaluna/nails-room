<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Clientes</title>
<link rel="stylesheet" type="text/css" href="css/data-tables.css">
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
				<h1>Clientes</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.11 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtroUsuario" action="clientes.do" method="post" name="filtroUsuario" id="obtenerPorFiltro" >
		<div class="container-result">	
			<p>Consultar ventas por filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaInicioFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaFinFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Descripci&oacute;n:<input type="text" name="descripcionFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Nombre cliente:<input type="text" name="nombreClienteFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Usuario : 
							<select name="idUsuarioFiltro" class="form-control" id="idUsuarioFiltro">
										<option value="0">- Seleccione -</option>
									<c:forEach items="${listaUsuarios}" var="usuario">
										<option value="${usuario.usuarioId}">${usuario.nombre}</option>
									</c:forEach>	
							</select>
						</span>
					</td>
									
				</tr>
				<tr>
					<td colspan=5>
					 <input type="submit" class="btn btn-dark" name="filtro" value="Enviar" />	
					</td>
					<td colspan=1>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAddUser">Agregar venta</button>
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos los usuarios -->
		<c:if test="${not empty listaVentas}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery">
		<thead>
			<tr>
				<th>Id</th>
				<th>Descripci&oacute;n</th>
				<th>Fecha registro</th>
				<th>Cliente</th>
				<th>Atendi&oacute;</th>				
				<th>Fecha apertura caja</th>
				<th>Isla</th>
				<th>Estado</th>
				<th>Efectivo/TC</th>
				<th></th>		
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listaVentas}" var="venta">		
		 		<tr>
		 			<td>${venta.ventaId}</td>
		 			<td>${venta.descripcion}</td>
		 			<td>${venta.fechaRegistro}</td>
		 			<td>${venta.cliente.nombre} ${venta.cliente.ap_paterno}</td>
		 			<td>${venta.usuario.nombre} ${venta.usuario.ap_paterno}</td>
		 			<td>${venta.caja.fechaApertura}</td>
		 			<td>${venta.estacionTrabajo.descripcion}</td>
		 			<td>${venta.estadoVenta.descripcion}</td>	
		 			<td>${venta.pagoEfectivo eq '1' ? 'Efectivo' : 'TC'}</td>	 			
					<td><button type="button" class="btn btn-dark btnUpdate" id="btnUpdate" data-toggle="modal" data-value="${venta.ventaId} }">Editar</button></td>
		 			<td>		 			
			 			<form:form action="clientes.do" method="post" name="deleteForm" id="deleteForm">
							<input type="hidden" name="clienteId" id="deleteCustomerId" value="${cliente.clienteId}">			 	
			 			 	<input type="submit" class="btn btn btn-dark" name="eliminar" value="Eliminar" />	
			 			 </form:form>
		 			</td>
		 		</tr>	 	
	 		</c:forEach>
	 	</tbody>
	 		</table>
	 		</div>
		</c:if>
		

 <div id="modalAddUser" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Agregar Cliente</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="clienteDTO" action="clientes.do" method="post" name="addUserForm" id="addUserForm">
				<div class="form-group">
					<label>Nombre: </label>
					<input type="text" id="name" name="nombre" placeholder="Nombre" class="form-control">
				</div>
				<div class="form-group">
					<label>Apellido paterno: </label>
					<input type="text" id="apPaterno" name="ap_paterno" placeholder="Apellido Paterno" class="form-control">
				</div>
				<div class="form-group">
					<label>Apellido materno: </label>
					<input type="text" id="apMaterno" name="ap_materno" placeholder="Apellido Materno" class="form-control">
				</div>
				<div class="form-group">
					<label>Email: </label>
					<input type="text" id="email" name="email" placeholder="Email" class="form-control">
				</div>
				<div class="form-group">
					<label>Tel&eacute;fono celular: </label>
					<input type="text" id="tel1" name="telefono1" placeholder="Telefono celular" class="form-control">
				</div>
				<div class="form-group">
					<label>Tel&eacute;fono casa: </label>
					<input type="text" id="tel2" name="telefono2" placeholder="Telefono casa" class="form-control">
				</div>
				<div class="form-group">
					<label>Direcci&oacute;n: </label>
					<input type="text" id="direccion" name="direccion" placeholder="Direcci&oacute;n" class="form-control">
				</div>
						
				<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="agregar" value="Enviar" />					
				</div>
				
		</form:form>
      </div>
    </div>
    </div>
       
 <div id="modalUpdateUser" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Cliente</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="clienteDTO" action="clientes.do" method="post" name="updateUserForm" id="updateUserForm">
		<input type="hidden" name="clienteId" id="clienteId">
				<div class="form-group">
					<label>Nombre: </label>
					<input type="text" id="name" name="nombre" placeholder="Nombre" class="form-control">
				</div>
				<div class="form-group">
					<label>Apellido Paterno: </label>
					<input type="text" id="apPaterno" name="ap_paterno" placeholder="Apellido Paterno" class="form-control">
				</div>
				<div class="form-group">
					<label>Apellido Materno: </label>
					<input type="text" id="apMaterno" name="ap_materno" placeholder="Apellido Materno" class="form-control">
				</div>
				<div class="form-group">
					<label>Email: </label>
					<input type="text" id="email" name="email" placeholder="Email" class="form-control">
				</div>
				
				<div class="form-group">
					<label>Tel&eacute;fono celular: </label>
					<input type="text" id="tel1" name="telefono1" placeholder="Telefono celular" class="form-control">
				</div>
				<div class="form-group">
					<label>Tel&eacute;fono casa: </label>
					<input type="text" id="tel2" name="telefono2" placeholder="Telefono casa" class="form-control">
				</div>
				<div class="form-group">
					<label>Direcci&oacute;n: </label>
					<input type="text" id="direccion" name="direccion" placeholder="Direcci&oacute;n" class="form-control">
				</div>
							
					<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="editar" value="Enviar" />					
				</div>
		</form:form>
      </div>      
    </div>
    </div>
    
    
    </div>
    
    


<script type="text/javascript" src="js/data-tables.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
	$('.tableShowResultQuery').DataTable();
	//confirmar eliminar	
	$('form[name="deleteForm"]').submit(function() {
	   return confirm("confirma para continuar");	   
	});
	
	// validacion para agregar cliente
	$('form[name="addUserForm"]').submit(function() {
		var msg = '', valid = true;
		var $form = $('#addUserForm');
		var cont = 0;
		// variables del formulario
		var nombre = $form.find('#name').val();
		var apPaterno = $form.find('#apPaterno').val();
		var tel1 = $form.find('#tel1').val();
		var tel2 = $form.find('#tel2').val();
		
		if(nombre == '')
			msg += ++cont+'. El nombre es requerido \n';
		if(apPaterno == '')
			msg += ++cont+'. El apellido paterno es requerido \n';
		if(tel1 == '' && tel2 == '')
				msg += ++cont + '. Al menos un tel\u00E9fono es requerido \n';		
		if(msg != ''){
			alert (msg);
			valid = false;
		}		
		return valid;	   
	});
	
	
	$( '.btnUpdateUser' ).click(function() {
		var $updateForm = $("#updateUserForm");
		 var $row = jQuery(this).closest('tr');
		    var $columns = $row.find('td');

		    $columns.addClass('row-highlight');
		    var values = "";

		    jQuery.each($columns, function(i, item) {
		        values = values + 'td' + (i + 1) + ':' + item.innerHTML + '<br/>';
		        if(i===0)
		        	$updateForm.find('#clienteId').val(item.innerHTML);
		        if(i===1)
		        	$updateForm.find('#name').val(item.innerHTML);
		        if(i===2)
		        	$updateForm.find('#apPaterno').val(item.innerHTML);
		        if(i===3)
		        	$updateForm.find('#apMaterno').val(item.innerHTML);
		        if(i===4)
		        	$updateForm.find('#email').val(item.innerHTML);
		        if(i===5)
		        	$updateForm.find('#tel1').val(item.innerHTML);
		        if(i===6)
		        	$updateForm.find('#tel2').val(item.innerHTML);
		        if(i===7)
		        	$updateForm.find('#direccion').val(item.innerHTML);
		       
		    });
		   
	});
	
	 	
});
</script>

</body>
</html>