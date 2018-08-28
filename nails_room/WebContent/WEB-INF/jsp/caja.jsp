<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Caja</title>
<link rel="stylesheet" type="text/css" href="css/data-tables.css">
<style type="text/css">
.tableShowResultQuery{padding:0px;font-size:10px;}
.tableShowResultQuery tbody tr td {padding:0px;vertical-align: inherit;}
.datosGenerales label {font-size:16px;/* text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black; */}
.container{background-color: #fff;color:#000;}
.datosGenerales{border-style: solid;border-radius: 3px;padding: 5px;}
.containerDetalleCaja{padding: 5px;}
.containerDetalleCaja table tr td{padding: 5px;font-size:11px;}
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
				<h1>Caja</h1>
			</div>
			
		</div>
		</div>
		
		<div class="form-group row">					
			<div class="col-xs-4">
				<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalFiltro">Buscar por filtro</button>
			</div>
			<c:if test="${not empty caja}">			
				<div class="col-xs-4">
					<button type="button" class="btn btn-dark btnRegistrarMovimiento" data-toggle="modal" data-target="#modalRegistrarMovimiento">Registrar Ingreso/Egreso</button>
				</div>
				<div class="col-xs-4">
					<form:form modelAttribute="caja" action="caja.do" method="post" name="cerrarCaja" id="cerrarCaja">
						<input type="hidden" name="cajaId" id="cajaId" value="${caja.cajaId}">
						<input type="submit" class="btn btn-dark btnCerrarCaja " name="cerrarCaja" value="Cerrar caja" />
					</form:form>
				</div>
			</c:if>
		</div>
		<c:if test="${not empty caja}">
			<div class="datosGenerales">	
				<div class="form-group row">	
					<div class="col-xs-6">
						<label>Fecha apertura: <fmt:formatDate value="${caja.fechaApertura}" pattern="EEEE dd 'de' MMMM 'del' yyyy" /></label>
					</div>
					<div class="col-xs-6">
						<label>Total caja: <fmt:formatNumber value="${totalCaja}" type="currency" currencySymbol="$"/></label>
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-xs-3">
						<label>N&uacute;mero de ventas: ${numeroVentas}</label>
					</div>
					<div class="col-xs-3">
						<label>Total ventas: <fmt:formatNumber value="${totalVentas}" type="currency" currencySymbol="$"/></label>
					</div>
					<div class="col-xs-3">
						<label>Ingresos: <fmt:formatNumber value="${ingresos}" type="currency" currencySymbol="$"/></label>
					</div>
					<div class="col-xs-3">
						<label>Egresos: <fmt:formatNumber value="${egresos}" type="currency" currencySymbol="$"/></label>
					</div>
				</div>
			</div>
			<div class="containerDetalleCaja ">
			<div class="form-group row">			
				<div class="infoVentas col-xs-6" style="">
					<table class="table table-bordered table-sm">
					<thead>
						<tr>
							<th>Id</th>
							<th>Descripci&oacute;n</th>
							<th>Fecha</th>
							<th>Cliente</th>
							<th>Atendi&oacute;</th>
							<th>Isla</th>
							<th>Estado</th>
							<th>Total</th>									
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${ventas}" var="venta">
					<tr>
		 			<td>${venta.ventaId}</td>
		 			<td>${venta.descripcion}</td>
		 			<td><fmt:formatDate value="${venta.fechaRegistro}" pattern="dd-MM-yyyy" /></td>
		 			<td>${venta.cliente.nombre} ${venta.cliente.ap_paterno}</td>
		 			<td>${venta.usuario.nombre} ${venta.usuario.ap_paterno}</td>		 			
		 			<td>${venta.estacionTrabajo.descripcion}</td>
		 			<td>${venta.estadoVenta.descripcion}</td>	
		 			<td style="text-align:right;"><fmt:formatNumber value="${venta.totalVenta}" type="currency" currencySymbol="$"/></td>
		 			</tr>	 
					</c:forEach>
					</tbody>
					</table>
				</div>
				<div class="infoDetalleCaja col-xs-6" style="">
					<table class="table table-bordered table-sm">
						<thead>
							<tr>								
								<th>Descripci&oacute;n</th>
								<th>Ingreso/Egreso</th>
								<th>Monto</th>																	
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${caja.detalleCaja}" var="detalle">
						<tr>			 			
			 			<td>${detalle.descripcion}</td>
			 			<td>${detalle.esIngreso eq '1' ? '(+) Ingreso' : '(-) Egreso'}</td>
			 			<td style="text-align:right;"><fmt:formatNumber value="${detalle.monto}" type="currency" currencySymbol="$"/></td>			 			
			 			</tr>	 
						</c:forEach>
						</tbody>
						</table>
				</div>	
				</div>		
			</div>
		</c:if>
	
	
		<!-- Mostramos los usuarios -->
		<c:if test="${not empty listaClientes}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery">
		<thead>
			<tr>
				<th>Id</th>
				<th>Nombre</th>
				<th>Ap Paterno</th>
				<th>Ap Materno</th>
				<th>Email</th>				
				<th>Tel1</th>
				<th>Tel2</th>
				<th>Direcci&oacute;n</th>
				<th></th>
				<th></th>		
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listaClientes}" var="cliente">		
		 		<tr>
		 			<td>${cliente.clienteId}</td>
		 			<td>${cliente.nombre}</td>
		 			<td>${cliente.ap_paterno}</td>
		 			<td>${cliente.ap_materno}</td>
		 			<td>${cliente.email}</td>
		 			<td>${cliente.telefono1}</td>
		 			<td>${cliente.telefono2}</td>
		 			<td>${cliente.direccion}</td>		 			
					<td><button type="button" class="btn btn-dark btnUpdateUser" id="btnUpdateUser" data-toggle="modal" data-target="#modalUpdateUser">Editar</button></td>
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
		
		<c:if test="${empty caja}">
			<div class="form-group row">					
				<div class="col-xs-12">
					<label class="form-control">CAJA ESTA CERRADA, ABRE CAJA PARA GENERAR VENTAS</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-12">
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAbrirCaja" style="width:100%;">Abrir caja</button>
				</div>
			</div>
		</c:if>
		

 <div id="modalAbrirCaja" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Abrir caja</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="caja" action="caja.do" method="post" name="abrirCaja" id="abrirCaja">
				<div class="form-group row">					
					<div class="col-xs-12">
						<label>Cantidad: </label>
						<input type="text" id="monto" name="detalleCajaDTO.monto" class="form-control">
					</div>					
				</div>		
						
				<div class="form-group row">					
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark " name="abrir" value="Enviar" style="width:100%;" />
					</div>					
				</div>
				
		</form:form>
      </div>
    </div>
    </div>
    <!-- Registrar ingreso/egreso -->
    <div id="modalRegistrarMovimiento" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Ingreso/Egreso</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="detalleCajaDTO" action="caja.do" method="post" name="formRegistrarMovimiento" id="formRegistrarMovimiento">
				<input type="hidden" name="cajaId" id="cajaId">
				<div class="form-group row">					
					<div class="col-xs-6">
						<label>Cantidad: </label>
						<input type="text" id="monto" name="monto" class="form-control">
					</div>									
					<div class="col-xs-6">
						<label>Ingreso/Egreso: </label>
						<select name="esIngreso" class="form-control" id="esIngreso">
							<option value="">- Seleccione -</option>							
							<option value="1">Ingreso</option>
							<option value="2">Egreso</option>							
						</select>
					</div>					
				</div>
				<div class="form-group row">					
					<div class="col-xs-12">
						<label>Descripci&oacute;n: </label>
						<input type="text" id="descripcion" name="descripcion" class="form-control">
					</div>				
				</div>	
						
				<div class="form-group row">					
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark " name="registrarMovimiento" value="Enviar" style="width:100%;" />
					</div>					
				</div>
				
		</form:form>
      </div>
    </div>
    </div>
       
 <div id="modalFiltro" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Aplicar Filtro</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="filtroCaja" action="caja.do" method="post" name="filtroCaja" id="filtroCaja">
				
				<div class="form-group row">		
					<div class="col-xs-6">
						<label>Fecha Inicial: </label>
						<input type="date" id="fechaInicial" name="fechaInicial" class="form-control">
					</div>
					<div class="col-xs-6">
						<label>Fecha Final: </label>
						<input type="date" id="fechaFinal" name="fechaFinal" class="form-control">
					</div>
				</div>
				<div class="form-group row">					
					<div class="col-xs-12">
						<input type="submit" class="btn btn-dark " name="filtro" value="Enviar" style="width:100%;" />
					</div>					
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
	$('form[name="formRegistrarMovimiento"]').submit(function() {
	   var msg = '';
	   var cont = 0;
	   var valid = true;
	   $form = $('#formRegistrarMovimiento');
	   var monto = $form.find('#monto').val();
	   var ingreso = $form.find('#esIngreso').val();
	   
	   if(monto == '')
		   msg += ++cont + '. Ingresa una cantidad a registrar\n';	   
	   if(monto < 0 || monto > 1000000)
		   msg += ++cont + '. Ingresa una cantidad valida\n';
	   if(ingreso == '')
		   msg += ++cont + '. Selecciona tipo de movimiento\n';	
	   
	   if(msg == '')
	   	valid = confirm("confirma para continuar");
	   else{
		   alert(msg);
		   valid = false;
	   }
	   return valid;
	});	
	
	$( '.btnRegistrarMovimiento' ).click(function() {
		$form = $('#formRegistrarMovimiento');
		$form.find('#cajaId').val('${caja.cajaId}');
// 		$('#modalRegistrarMovimiento').modal('show');
	});
	
	$('form[name="cerrarCaja"]').submit(function() {
		return confirm("Confirma para cerrar caja ");
	});
	
});	// end document ready
</script>

</body>
</html>