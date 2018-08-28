<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Usuarios</title>
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
				<h1>Usuarios</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.07 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtroUsuario" action="usuarios.do" method="post" name="filtroUsuario" id="obtenerUsuariosFiltro" >
		<div class="container-result">	
			<p>Consultar usuarios por filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaRegistroInicial" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaRegistroFinal" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Nombre:<input type="text" name="nombreFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Apellido Paterno:<input type="text" name="apPaternoFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Apellido Materno:<input type="text" name="apMaternoFiltro" id="" class="form-control"></span>
					</td>
					<td>
						<span class="input-group-text">Email:<input type="text" name="emailFiltro" id="" class="form-control"></span>
					</td>
					<td>
						<label>Puesto:</label>
						<select name="puestoIdFiltro" class="form-control" >
							<option value="0">- Seleccione -</option>
							<c:forEach items="${puestos}" var="puesto">
								<option value="${puesto.puestoId}">${puesto.descripcion}</option>
							</c:forEach>	
						</select>
					</td>
					
				</tr>
				<tr>
					<td colspan=6>
					 <input type="submit" class="btn btn-dark" name="filtro" value="Enviar" />	
					</td>
					<td colspan=1>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAddUser">Agregar usuario</button>
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos los usuarios -->
		<c:if test="${not empty listaUsuarios}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery">
		<thead>
			<tr>
				<th>id</th>
				<th>Nombre</th>
				<th>Ap Paterno</th>
				<th>Ap Materno</th>
				<th>Email</th>
				<th>Puesto</th>	
				<th>Comisi&oacute;n</th>	
				<th></th>
				<th></th>
				<th></th>			
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listaUsuarios}" var="usuario">		
		 		<tr>
		 			<td>${usuario.usuarioId}</td>
		 			<td>${usuario.nombre}</td>
		 			<td>${usuario.ap_paterno}</td>
		 			<td>${usuario.ap_materno}</td>
		 			<td>${usuario.email}</td>
<%-- 		 			<td><c:out default="None" escapeXml="true" value="${user.fgAdmin eq '1' ? 'Admin' : '-' }" /></td> --%>
					<td>${usuario.puestoDTO.descripcion}</td>
					<td>${usuario.comision}</td>
					<td><button type="button" class="btn btn-dark btnUpdateUser" id="btnUpdateUser" data-toggle="modal" data-target="#modalUpdateUser">Editar</button></td>
		 			<td><button type="button" class="btn btn-dark btnUpdatePassw" id="btnUpdatePassw" data-toggle="modal" data-target="#modalActualizarContrasenia">Contrase&ntilde;a</button></td>
		 			<td>		 			
			 			<form:form action="usuarios.do" method="post" name="deleteUserForm" id="deleteUserForm">
							<input type="hidden" name="usuarioId" id="deleteUserId" value="${usuario.usuarioId}">			 	
			 			 	<input type="submit" class="btn btn btn-dark" name="deleteUser" value="Eliminar" />	
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
        <h4 class="modal-title">Agregar Usuario</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="usuarioDTO" action="usuarios.do" method="post" name="addUserForm" id="addUserForm">
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
					<input type="email" id="email" name="email" placeholder="Email" class="form-control">
				</div>
				<div class="form-group">
					<label>Password: </label>
					<input type="password" id="password" name="contrasenia" placeholder="Password" class="form-control">
				</div>
				<div class="form-group">	
					<label>Puesto:</label>
					<select name="puestoDTO.puestoId" class="form-control" id="jobId">
						<option value="0">- Seleccione -</option>
						<c:forEach items="${puestos}" var="puesto">
							<option value="${puesto.puestoId}">${puesto.descripcion}</option>
						</c:forEach>	
					</select>
				</div>	
				<div class="form-group">
					<label>Comisi&oacute;n por venta: </label>
					<input type="range" id="comisionAdd" name="comision" placeholder="" min="1" max="100" value="0" class="form-control" style="cursor:pointer;">
					<span id="mostrarPorcentajeAdd"></span>
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
        <h4 class="modal-title">Editar Usuario</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="usuarioDTO" action="usuarios.do" method="post" name="updateUserForm" id="updateUserForm">
		<input type="hidden" name="usuarioId" id="usuarioId">
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
					<input type="email" id="email" name="email" placeholder="Email" class="form-control">
				</div>
				<div class="form-group">	
					<label>Puesto:</label>
					<select name="puestoDTO.puestoId" class="form-control selJobId" id="jobId" >
						<option value="0">- Seleccione -</option>
						<c:forEach items="${puestos}" var="puesto">
							<option value="${puesto.puestoId}">${puesto.descripcion}</option>
						</c:forEach>	
					</select>
				</div>
				<div class="form-group">
					<label>Comisi&oacute;n por venta: </label>
					<input type="range" id="comisionUpdate" name="comision" placeholder="" min="1" max="100" class="form-control" style="cursor:pointer;">
					<span id="mostrarPorcentajeUpdate"></span>
				</div>
			
					<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="editar" value="Enviar" />					
				</div>
		</form:form>
      </div>      
    </div>
    </div>
    
    
    <!-- Cambiar contraseña -->
 <div id="modalActualizarContrasenia" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Cambiar contrase&ntilde;a</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="usuarioDTO" action="usuarios.do" method="post" name="updatePassword" id="updatePassword">
		<input type="hidden" name="usuarioId" id="usuarioId">
				<div class="form-group">
					<label>Ingresa la nueva contrase&ntilde;a: </label>
					<input type="password" name="contrasenia" class="form-control">
				</div>				
					<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="cambiarContrasenia" value="Enviar" />					
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
	$('form[name="deleteUserForm"]').submit(function() {
	   return confirm("confirma para continuar");	   
	});
	
	// validar cambiar contraseña
	$('form[name="updatePassword"]').submit(function() {
		var esAdmin = '${userSession.usuario.puestoDTO.puestoId}'
		if(esAdmin == '1'){
		   return confirm("confirma para continuar");
		}else{
			alert("Necesitas permisos de administrador para cambiar contraseña ")
			return false;
		}
	});
	
	// validacion para agregar usuario
	$('form[name="addUserForm"]').submit(function() {
		var msg = '', valid = true;
		var $form = $('#addUserForm');
		var cont = 0;
		// variables del formulario
		var nombre = $form.find('#name').val();
		var apPaterno = $form.find('#apPaterno').val();
		var email = $form.find('#email').val();
		var password = $form.find('#password').val();
		var puestoId = $form.find('#jobId').val();
		var comision = $form.find('#comisionAdd').val();
		
		if(nombre == '')
			msg += ++cont+'. El nombre es requerido \n';
		if(apPaterno == '')
			msg += ++cont+'. El apellido paterno es requerido \n';
		if(email == '')
			msg += ++cont+'. El email es requerido \n';
		if(password == '')
			msg += ++cont+'. La contraseña es requerida \n';
		if(puestoId == '0')
			msg += ++cont+'. El puesto es requerido \n';
		if(comision == '')
			msg += ++cont+'. Comisi\u00F3n es requerida \n';
		
		if(msg != ''){
			alert (msg);
			valid = false;
		}		
		return valid;	   
	});
	
	$( '#comisionAdd' ).change(function() {
		$('#mostrarPorcentajeAdd').text($(this).val()+" %");
	});
	
	$( '#comisionUpdate' ).change(function() {
		$('#mostrarPorcentajeUpdate').text($(this).val()+" %");
	});
	
	$( '.btnUpdatePassw' ).click(function() {
		var $updatePassword = $("#updatePassword");
		var $row = jQuery(this).closest('tr');
		var $columns = $row.find('td');
		$columns.addClass('row-highlight');
	    var values = "";
	    jQuery.each($columns, function(i, item) {
	        values = values + 'td' + (i + 1) + ':' + item.innerHTML + '<br/>';
	        if(i===0)
	        	$updatePassword.find('#usuarioId').val(item.innerHTML);
	    });	    
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
		        	$updateForm.find('#usuarioId').val(item.innerHTML);
		        if(i===1)
		        	$updateForm.find('#name').val(item.innerHTML);
		        if(i===2)
		        	$updateForm.find('#apPaterno').val(item.innerHTML);
		        if(i===3)
		        	$updateForm.find('#apMaterno').val(item.innerHTML);
		        if(i===4)
		        	$updateForm.find('#email').val(item.innerHTML);
		        if(i===5)
		        	$updateForm.find('#jobId').val(getJobSelect(item.innerHTML));
		        if(i===6){
		        	$updateForm.find('#comisionUpdate').val(item.innerHTML);
		        	$updateForm.find('#mostrarPorcentajeUpdate').text(item.innerHTML+" %");
		        }
		        
// 		        alert(values);
		    });
// 		    console.log(values);

		   
	});
	
	 function getJobSelect(text){		    	
	    	var value = 0;
	    	$( ".selJobId option" ).each(function( index ) {
	    		var x = $(this).text();
	    		if(x == text){
	    			value = index;
	    		}
//	    		  console.log( index + ": " + $( this ).text() );
	    	});
	    	return value;
	    }
	 	function getOfficeSelect(text){		    	
	    	var value = 0;
	    	$( ".selOfficeId option" ).each(function( index ) {
	    		var x = $(this).text();
	    		if(x == text){
	    			value = index;
	    		}
//	    		  console.log( index + ": " + $( this ).text() );
	    	});
	    	return value;
	    }
	
	 	
});
</script>
</body>
</html>