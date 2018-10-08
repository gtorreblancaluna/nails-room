<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Detalle Caja</title>
<link rel="stylesheet" type="text/css" href="css/data-tables.css">
<style type="text/css">
.tablaMovimientos tbody tr td{padding: 1px 0px 1px 1px;font-size:10px;}
.tablaVentas tbody tr td{padding: 1px 0px 1px 1px;font-size:10px;}
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
					<h1>Caja Detalle</h1>
				</div>
				
			</div>
		</div>
		
		<form:form modelAttribute="filtroCaja" action="caja_detalle.do" method="post" name="filtroCaja" id="filtroCaja" >
		<div class="container-result">	
			<p>Consultar caja por filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaInicioFiltro" id="fechaInicioFiltro" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaFinFiltro" id="fechaFinFiltro" class="form-control"> </span>
					</td>									
									
				</tr>
				<tr>
					<td colspan=2>
					 <input type="submit" class="btn btn-dark" name="filtro" value="Enviar" />	
					</td>					
				</tr>				
			</tbody>
			</table>	
		</div>
		</form:form>
		
		<c:if test="${not empty cajas}">
		<div class="containerShowResultQuery container-result">
			<table class="table tableShowResultQuery table-bordered table-sm">
			<thead>
				<tr>
					<th>Id</th>
					<th>Usuario</th>
					<th>Fecha apertura</th>
					<th>Fecha cierre</th>
					<th>Descripci&oacute;n</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cajas}" var="caja">		
			 		<tr>
			 			<td style="text-align:center;">
			 				<a href="javascript:void(0);" onclick='verDetallesCaja("${caja.cajaId}");'>${caja.cajaId}</a>
			 			</td>
			 			<td>${caja.usuario.nombre} ${caja.usuario.ap_paterno}</td>
			 			<td>${caja.fechaApertura}</td>
			 			<td>${caja.fechaCierre}</td>
			 			<td>${caja.descripcion}</td>
			 		</tr>
		 		</c:forEach>
			</tbody>
			</table>
		</div>
		
		</c:if> <!-- end lista cajas -->
		
		
	<div id="detalleCajaModal" class="modal fade" role="dialog" >
 	<div class="modal-content" style="width:95%;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Detalle Caja</h4>
      </div>
      <div class="modal-body">		
      			<!-- INFORMACION GENERAL -->
     			<div class="form-group row">
     				<div class="col-xs-3">
	     				<div>Total en caja: </div><label id="totalCaja"></label>
	     			</div>    
	     			<div class="col-xs-3">
	     				<div>Total ventas: </div><label id="totalVentas"></label>
	     			</div> 
	     			<div class="col-xs-3">
	     				<div>Ingresos: </div><label id="ingresos"></label>
	     			</div>
	     			<div class="col-xs-3">
	     				<div>Egresos: </div><label id="egresos"></label>
	     			</div>	     			 			
     			</div>		
				<div class="form-group row">
				<!-- VENTAS -->		
					<div class="col-xs-6">
					<table class="table table-bordered table-sm tablaVentas">
						<caption>Ventas</caption>
						<thead>
							<tr>
								<th>Id</th>
								<th>Descripci&oacute;n</th>
								<th>Fecha</th>
								<th>Cliente</th>
								<th>Atendi&oacute;</th>
								<th>Estaci&oacute;n</th>
								<th>Estado</th>
								<th>Total</th>									
							</tr>
						</thead>
						<tbody>					
						</tbody>
					</table>
					</div>
					<!-- MOVIMIENTOS EN CAJA -->
					<div class="col-xs-6">
						<table class="table table-bordered table-sm tablaMovimientos">
							<caption>Movimientos en caja</caption>
							<thead>
								<tr>								
									<th>Descripci&oacute;n</th>
									<th>Movimiento</th>
									<th>Monto</th>															
								</tr>
							</thead>
							<tbody>							
							</tbody>
						</table>
					</div>
				</div>			
	
      </div>      
    </div>
    </div> <!-- end Detalle Modal Caja -->
		
</div> <!-- end container -->


<script type="text/javascript" src="js/data-tables.js"></script>
<script type="text/javascript">

$( document ).ready(function() {
	document.getElementById('fechaInicioFiltro').valueAsDate = new Date();
	document.getElementById('fechaFinFiltro').valueAsDate = new Date();
	
	
	
});	// end document ready


function verDetallesCaja(cajaId){
	var data = {}
	if(cajaId != ''){		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "obtenerDetalleCajaPorId.do",
			data : cajaId,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {				
				// exito, llenamos la tabla de clientes
				console.log(data.caja)
				llenarDatos(data);
				
			},
			error : function(e) {
				console.log("ERROR: ", e);	
				alert("ERROR: "+e)
			},
			done : function(e) {
				console.log("DONE");
			}
		});
	}else{
		alert("No se recibio el parametro, porfavor recarga la pagina e intentalo de nuevo :( ")
	}
}

function llenarDatos(data){
	$('.tablaVentas tbody tr').remove();
	$('.tablaMovimientos tbody tr').remove();
	
	// informacion general
	$('#ingresos').text(formatCurrency(data.ingresos));
	$('#egresos').text(formatCurrency(data.egresos));
	$('#totalVentas').text(formatCurrency(data.totalVentas));
	$('#totalCaja').text(formatCurrency(data.totalCaja));
	
	
	
	// llenamos la tabla de las ventas
	$.each(data.ventas, function(index, venta) {
		$(".tablaVentas tbody").append("<tr>"				
				+"<td>"+venta.ventaId+"</td>"
				+"<td>"+venta.descripcion+"</td>"
				+"<td>"+venta.fechaRegistroFormatoNormal+"</td>"
				+"<td>"+venta.cliente.nombre + ' ' + venta.cliente.ap_paterno +"</td>"
				+"<td>"+venta.usuario.nombre + ' ' + venta.usuario.ap_paterno +"</td>"				
				+"<td>"+venta.estacionTrabajo.descripcion+"</td>"
				+"<td>"+venta.estadoVenta.descripcion+"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(venta.totalVenta)+"</td>"
		+"</tr>");
		
	});	// end for each
	
	// llenamos los movimientos en caja
	$.each(data.caja.detalleCaja, function(index, detalle) {
		$(".tablaMovimientos tbody").append("<tr>"				
				+"<td>"+ detalle.descripcion +"</td>"
				+"<td>"+ ( detalle.esIngreso == '1' ? '(+) Ingreso' : '(-) Egreso' ) +"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(detalle.monto) +"</td>"
				
		+"</tr>");
		
	});	// end for each
	
	$('#detalleCajaModal').modal('show');
	
}

function formatCurrency(total) {
    var neg = false;
    if(total < 0) {
        neg = true;
        total = Math.abs(total);
    }
    return (neg ? "-$" : '$') + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
}

</script>
</body>
</html>