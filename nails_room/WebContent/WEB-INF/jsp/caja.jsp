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
.containerDetalleCaja table tr td{padding: 1px 0px 1px 1px;font-size:11px;}
.modal-content-comisiones{width:85%;font-size:11px;}
.tablaComisiones tbody tr td{padding: 1px 0px 1px 1px;font-size:10px;}
.tablaComisionesAgrupadas tbody tr td{padding: 1px 0px 1px 1px;font-size:10px;}
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
			
			<div class="col-xs-3">
				<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalFiltro">Buscar por filtro</button>
			</div>
			<c:if test="${not empty caja}">	
				<div class="col-xs-3">
					<button type="button" class="btn btn-dark" data-toggle="modal" onclick="obtenerComisiones();">Comisiones</button>
					<input type="date" id="fechaComisiones" name="fechaComisiones" class="form-control">
				</div>		
				<div class="col-xs-3">
					<button type="button" class="btn btn-dark btnRegistrarMovimiento" data-toggle="modal" data-target="#modalRegistrarMovimiento">Registrar Ingreso/Egreso</button>
				</div>
				<div class="col-xs-3">
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
						<label>Total en caja: <fmt:formatNumber value="${totalCaja}" type="currency" currencySymbol="$"/></label>
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-xs-3">
						<label>N&uacute;mero de ventas: ${numeroVentas}</label>
					</div>
					<div class="col-xs-3">
						<label>Total en ventas: <fmt:formatNumber value="${totalVentas}" type="currency" currencySymbol="$"/></label>
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
				<div class="infoVentas col-xs-8" style="">
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
		 			<td>${fn:substring(venta.descripcion, 0, 21)}</td>
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
				<div class="infoDetalleCaja col-xs-4" style="">
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
			 			<td>${fn:substring(detalle.descripcion, 0, 25)}</td>
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
    
     <div id="modalComisiones" class="modal fade" role="dialog" >
 <div class="modal-content modal-content-comisiones" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Comisiones</h4>
      </div>
      <div class="modal-body"> 
      <div id="formComisiones">   
      	<div class="form-group row">		
			<div class="col-xs-8">  			
				<table class="table tablaComisiones table-bordered table-sm">
					<thead>
						<tr>
							<th>Id venta</th>
							<th>Nombre usuario</th>
							<th>Comisi&oacute;n</th>
							<th>Descripci&oacute;n venta</th>
							<th>Total venta</th>
							<th>Total comisi&oacute;n</th>
							<th>Comisi&oacute;n pagada</th>		
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<a href="javascript:void(0);" onclick="pagarTodo();">Pagar todas</a>
			</div>
			<div class="col-xs-4">  			
				<table class="table tablaComisionesAgrupadas table-bordered table-sm">
					<thead>
						<tr>							
							<th>Nombre usuario</th>
							<th>Comisi&oacute;n</th>							
							<th>Total en ventas</th>
							<th>Total en comisiones</th>									
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
	   if( (monto < 0) || (monto > 1000000))
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

function pagarTodo(){
	 var array = '';
	 $(".tablaComisiones tbody tr").each(function () {
		 var $tr = $(this).closest('tr');
		 var ventaId = parseFloat($tr.find('.ventaId').text());
// 		 pagarTodasComisiones(ventaId);		
		 array += ventaId + "-";
	})
	if(confirm("Confirma para continuar")){
		pagarTodasComisiones(array);
		
	}

}

function obtenerComisiones(){
	var data = {}
	var fecha = $('#fechaComisiones').val();
	if(fecha == '')
		fecha = "hoy";
// 	if(valor != ''){
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "obtenerComisiones.do",
			data : fecha,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				// exito, llenamos la tabla de clientes
				console.log(data)
				llenarTablaComisiones(data.ventas,data.ventasComisiones);
			},
			error : function(e) {
				console.log("ERROR: ", e);	
				alert("ERROR: "+e)
			},
			done : function(e) {
				console.log("DONE");
			}
		});
// 	}else{
// 		alert("No se recibio el parametro, porfavor recarga la pagina e intentalo de nuevo :( ")
// 	}
}


function llenarTablaComisiones(ventas,ventasComisiones){
	var $form = $('#formComisiones');
	$form.find('.tablaComisiones tbody tr').remove();
	$form.find('.tablaComisionesAgrupadas tbody tr').remove();
	
	var contador = 0;
	$.each(ventas, function(index, venta) {
		$form.find(".tablaComisiones tbody").append(
		"<tr>"	
// 				+"<td>"+ ++contador +"</td>"
				+"<td style='text-align:center;'><span class='ventaId'>"+ venta.ventaId +"</span></td>"
				+"<td>"+ (venta.usuario.nombre +' '+ venta.usuario.ap_paterno).substring(0, 25) +"</td>"
				+"<td style='text-align:center;'>"+ (venta.usuario.comision +' %') +"</td>"
				+"<td>"+ venta.descripcion.substring(0, 25) +"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(venta.totalVenta) +"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(venta.totalComision) +"</td>"
// 				+"<td style='text-align:center;'>"+ (venta.comisionPagada == '1' ? 'Pagada' : 'No pagada') +"</td>"
				+"<td style='text-align:center;'><a href='javascript:void(0);' onclick='pagarComision("+venta.ventaId+");'>"+ (venta.comisionPagada == '1' ? 'Pagada' : 'No pagada') +"</a></td>"
		+"</tr>");		
	});	// end for each
	
	$.each(ventasComisiones, function(index, venta) {
		$form.find(".tablaComisionesAgrupadas tbody").append(
		"<tr>"
				+"<td>"+ (venta.usuario.nombre +' '+ venta.usuario.ap_paterno).substring(0, 25) +"</td>"
				+"<td style='text-align:center;'>"+ (venta.usuario.comision +' %') +"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(venta.totalVenta) +"</td>"
				+"<td style='text-align:right;'>"+ formatCurrency(venta.totalComision) +"</td>"				
		+"</tr>");		
	});	// end for each	
	$('#modalComisiones').modal('show');
}

function formatCurrency(total) {
    var neg = false;
    if(total < 0) {
        neg = true;
        total = Math.abs(total);
    }
    return (neg ? "-$" : '$') + parseFloat(total, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
}

function pagarTodasComisiones(array){

	var data = {}		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "pagarComisiones.do",
			data : array,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {				
				console.log(data);
				obtenerComisiones();
				alert(data.mensaje);
			},
			error : function(e) {
				console.log("ERROR: ", e);	
				alert("ERROR: "+e)				
			},
			done : function(e) {
				console.log("DONE");
			}
		});

}



function pagarComision(ventaId){
// 	alert(ventaId+'| ${caja.cajaId}');	
	var data = {}
// 	var parametros = ventaId;
	if(ventaId != ''){
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "pagarComisionPodIdVenta.do",
			data : ventaId+"",
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				// exito, llenamos la tabla de clientes
				console.log(data);
				alert(data.mensaje);
				if( (data.mensaje).indexOf("ERROR") == -1)
					obtenerComisiones();
				
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



</script>

</body>
</html>