<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Citas </title>
<link rel="stylesheet" type="text/css" href="css/data-tables.css">
<style type="text/css">
.modal-content {width:85%;}
</style>
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
				<h1>Citas</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.11 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtro" action="citas.do" method="post" name="filtro" id="filtro" >
		<div class="container-result">	
			<p>Consultar citas por filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaInicio" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaFin" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Nombre cliente:<input type="text" name="nombreCliente" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Apellido paterno cliente:<input type="text" name="apPaternoCliente" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Apellido materno cliente:<input type="text" name="apMaternoCliente" id="" class="form-control"></span>
					</td>						
					<td>
						<span class="input-group-text">Estado cita : 
							<select name="estadoCitaId" class="form-control" id="estadoCitaId">
										<option value="0">- Seleccione -</option>
									<c:forEach items="${estados}" var="estado">
										<option value="${estado.estadoCitaId}">${estado.descripcion}</option>
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
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAdd">Agregar cita</button>
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos los usuarios -->
		<c:if test="${not empty citas}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery table-bordered table-sm">
		<thead>
			<tr>

				<th>Nombre cliente</th>				
				<th>Descripci&oacute;n</th>
				<th>Fecha cita</th>				
				<th>Fecha registro</th>	
				<th>Estado</th>			

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${citas}" var="cita">		
		 		<tr>
		 			<td>${cita.cliente.nombre} ${cita.cliente.ap_paterno} ${cita.cliente.ap_materno}</td>
		 			<td>${fn:substring(cita.descripcion, 0, 35)}</td>
		 			<td><fmt:formatDate value="${cita.fechaCita}" pattern="EEEE dd' 'MMMM' 'yyyy HH:mm:ss" /></td>
		 			<td><fmt:formatDate value="${cita.fechaRegistro}" pattern="EEEE dd' 'MMMM' 'yyyy HH:mm:ss" /></td>
		 			<td style="text-align:center;"><a href="javascript:void(0);" class="btnActualizarEstado" id="btnActualizarEstado" onclick="actualizarEstado('${cita.citaId}')">${cita.estadoCita.descripcion}</a></td>
		 		</tr>	 	
	 		</c:forEach>
	 	</tbody>
	 		</table>
	 		</div>
		</c:if>
		

 <div id="modalAdd" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Agregar Cita</h4>
      </div>
      <div class="modal-body">
		<form:form modelAttribute="cita" action="citas.do" method="post" name="addForm" id="addForm">
				<ul class="nav nav-tabs">
				  <li class="active"><a data-toggle="tab" href="#tabCliente">Clientes</a></li>
				  <li><a data-toggle="tab" href="#tabCita">Cita</a></li>
				</ul>
				<div class="tab-content">
					<div id="tabCliente" class="tab-pane fade in active">
						<div class="form-group row">
							<input type="hidden" id="clienteId" name="cliente.clienteId">
							
							<div class="col-xs-3">
								<label>Nombre: </label>
								<input type="text" id="name" name="cliente.nombre" placeholder="Nombre" class="form-control">
							</div>
							<div class="col-xs-3">
								<label>Apellido paterno: </label>
								<input type="text" id="apPaterno" name="cliente.ap_paterno" placeholder="Apellido Paterno" class="buscarCliente form-control">
							</div>
							<div class="col-xs-3">
								<label>Apellido materno: </label>
								<input type="text" id="apMaterno" name="cliente.ap_materno" placeholder="Apellido Materno" class="buscarCliente form-control">
							</div>
							<div class="col-xs-3">
								<label>Email: </label>
								<input type="text" id="email" name="cliente.email" placeholder="Email" class="form-control">
							</div>
							<div class="col-xs-3">
								<label>Tel&eacute;fono celular: </label>
								<input type="text" id="tel1" name="cliente.telefono1" placeholder="Telefono celular" class="form-control">
							</div>
							<div class="col-xs-3">
								<label>Tel&eacute;fono casa: </label>
								<input type="text" id="tel2" name="cliente.telefono2" placeholder="Telefono casa" class="form-control">
							</div>
							<div class="col-xs-3">
								<label>Direcci&oacute;n: </label>
								<input type="text" id="direccion" name="cliente.direccion" placeholder="Direcci&oacute;n" class="form-control">
							</div>
							</div>							
							
							<div class="form-group row ">
								
								<table class="table tablaClientes">
								    <thead>
								      <tr>
								      	<th>#</th>
								      	<th>Id</th>
								        <th>Nombre</th>			        
								        <th>Ap paterno</th>
								        <th>Ap materno</th>
								        <th>email</th>
								        <th>Tel casa</th>
								        <th>Tel celular</th>
								        <th>Direcci&oacute;n</th>
								        <th></th>
								      </tr>
								    </thead>
								     <tbody>
								     <tr></tr>
								     </tbody>
							     </table>
							</div>
						
					</div><!-- end tab clientes -->
					
					<div id="tabCita" class="tab-pane fade disabled">
						<div class="form-group row">
							<div class="col-xs-12">
								<label>Cliente: <span id="spanNombreCliente"></span></label>
							</div>							
						</div>
							<div class="form-group row">
								<div class="col-xs-8">
									<label>Descripci&oacute;n: </label>
									<input type="text" id="descripcion" name="descripcion" class="form-control">
								</div>	
								<div class="col-xs-4">
									<label>Fecha y hora: </label>
									<input type="datetime-local" id="fechaCita" name="fechaCitaString" class="form-control">
								</div>											
							</div>			
							
							<div class="form-group row">
								<div class="col-xs-12">
									<input type="submit" class="btn btn-dark" name="agregar" value="Agregar cita" style="width: 100%;"/>					
								</div>
							</div>							
				
					</div><!-- end tab citas -->
					
				</div> <!-- end contenido -->				
				
		</form:form>
      </div>
    </div>
    </div><!-- fin modal agregar -->
    
    
    <div id="modalActualizarEstado" class="modal fade" role="dialog" >
 <div class="modal-content" style="width:50%;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Actualizar estado</h4>
      </div>
      <div class="modal-body">
		<form:form modelAttribute="cita" action="citas.do" method="post" name="actualizarEstadoForm" id="actualizarEstadoForm">
				<input type="hidden" name="citaId" id="citaId" value="">
				<div class="form-group row">				
					<div class="col-xs-12">
						<span class="input-group-text">Estado cita:
							<select name="estadoCita.estadoCitaId" class="form-control" id="estadoCitaId">
										<option value="0">- Seleccione -</option>
									<c:forEach items="${estados}" var="estado">
										<option value="${estado.estadoCitaId}">${estado.descripcion}</option>
									</c:forEach>	
							</select>
						</span>
					</div>											
				</div>				
				<div class="form-group row">
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark" name="actualizarEstado" value="Actualizar" style="width: 100%;"/>					
					</div>
				</div>				
		</form:form>
      </div>
    </div>
    </div>    <!-- fin modal actualizar estado -->
    
    
    
 </div>

<script type="text/javascript" src="js/data-tables.js"></script>
<script type="text/javascript" src="js/admin/cita.js"></script>

</body>
</html>