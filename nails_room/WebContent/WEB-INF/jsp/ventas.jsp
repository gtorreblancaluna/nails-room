<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">
.modal-content {width: 90%;}
.tablaVentaArticulos .form-control {height: 22px; font-size:11px;}
.tablaVentaArticulos {font-size:11px;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Ventas</title>
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
				<h1>Ventas</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.11 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtroUsuario" action="ventas.do" method="post" name="filtroUsuario" id="obtenerPorFiltro" >
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
					<td colspan=4>
					 <input type="submit" class="btn btn-dark" name="filtro" value="Enviar" />	
					</td>
					<td colspan=1>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAdd">Agregar venta</button>
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos las ventas del filtro consultado -->
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
<!-- 		 			<td>		 			 -->
<%-- 			 			<form:form action="ventas.do" method="post" name="deleteForm" id="deleteForm"> --%>
<%-- 							<input type="hidden" name="clienteId" id="deleteCustomerId" value="${cliente.clienteId}">			 	 --%>
<!-- 			 			 	<input type="submit" class="btn btn btn-dark" name="eliminar" value="Eliminar" />	 -->
<%-- 			 			 </form:form> --%>
<!-- 		 			</td> -->
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
        <h4 class="modal-title">Agregar Venta</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="venta" action="ventas.do" method="post" name="addForm" id="addForm">
		
		<ul class="nav nav-tabs">
		  <li class="active"><a data-toggle="tab" href="#tabClientes">Clientes</a></li>
		  <li><a data-toggle="tab" href="#tabVentas">Nota</a></li>
		</ul>		
		
		<div class="tab-content">
			<div id="tabClientes" class="tab-pane fade in active">
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
					<div class="form-group row">			
						<div class="col-xs-12">
							<input type="button" class="btn btn-dark login-button btnContinuarVenta"  value="Continuar" />					
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
			
			<!-- inicia datos de la venta -->
			<div id="tabVentas" class="tab-pane fade disabled">
			<div class="form-group row">
				<div class="col-xs-6">
					<label>Cliente: <span id="spanNombreCliente"></span></label>
				</div>
				<div class="col-xs-6">
					<label>Total a pagar: <span id="totalPagar"></span></label>
				</div>
			</div>
				<div class="form-group row">
					<div class="col-xs-3">
						<label>Descripci&oacute;n: </label>
						<input type="text" id="descripcion" name="descripcion" class="form-control">
					</div>			
					<div class="col-xs-3">
						<label>Atiende: </label>
						<select name="usuario.usuarioId" class="form-control" id="usuarioId">
							<option value="0">- Seleccione -</option>
							<c:forEach items="${listaUsuarios}" var="usuario">
								<option value="${usuario.usuarioId}">${usuario.nombre}</option>
							</c:forEach>	
						</select>
					</div>
					<div class="col-xs-3">
						<label>Isla: </label>
						<select name="estacionTrabajo.estacionTrabajoId" class="form-control" id="estacionTrabajoId">
							<option value="0">- Seleccione -</option>
							<c:forEach items="${listaEstacion}" var="estacion">
								<option value="${estacion.estacionTrabajoId}">${estacion.descripcion}</option>
							</c:forEach>	
						</select>
					</div>
					<div class="col-xs-3">
						<label>Seleccionar articulo:</label>	
						<input type="button" class="btn btn-dark login-button btnBuscarArticulo form-control"  value="Buscar articulo" />
					</div>					
				</div>			
				<div class="form-group row">
					<table class="table tablaVentaArticulos">
						<thead>
							<tr>
<!-- 								<th>#</th> -->
								<th>Id</th>
								<th>Cantidad</th>	
								<th>Descripci&oacute;n</th>
								<th>Precio</th>	
								<th>Subtotal</th>	
								<th></th>																														
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div class="form-group row">
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark" name="agregar" value="Agregar venta" style="width: 100%;"/>					
					</div>
				</div>
				
			</div><!-- end tab ventas -->
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
		<form:form modelAttribute="clienteDTO" action="ventas.do" method="post" name="updateUserForm" id="updateUserForm">
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
    
    
    <!-- modal para buscar articulos por filtro -->
    <div id="modalSearchItem" class="modal fade" role="dialog" >
 <div class="modal-content" style="width:50%;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Buscar articulos</h4>
      </div>
      <div class="modal-body">     
		<div class="form-group row">
			<div class="col-xs-12">
				<label>Filtrar por descripci&oacute;n: </label>
				<input type="text" id="filtroDescripcionArticulo" name="filtroDescripcionArticulo" class="filtroDescripcionArticulo form-control">
				<table class="table tablaArticulos">
					<thead>
						<tr>
							<th>#</th>
							<th>Id</th>
							<th>Descripci&oacute;n</th>																											
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
      </div>      
    </div>
    </div>
    
    
    </div>

<script type="text/javascript" src="js/data-tables.js"></script>
<script type="text/javascript" src="js/admin/ventas.js"></script>

</body>
</html>