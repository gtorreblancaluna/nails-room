<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Inventario</title>
<style>		    
    

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
				<h1>Inventario</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.11 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtroArticulo" action="inventario.do" method="post" name="filtroArticulo" id="obtenerPorFiltro" >
		<div class="container-result">	
			<p>Consultar articulos por filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaInicioAltaFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaFinalAltaFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Descripci&oacute;n:<input type="text" name="descripcionFiltro" id="" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Id<input type="text" name="articuloIdFiltro" id="" class="form-control"> </span>
					</td>
									
				</tr>
				<tr>
					<td colspan=2>
					 <input type="submit" class="btn btn-dark" name="filtro" value="Enviar" />	
					</td>
					<td colspan=1>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAddProduct">Agregar articulo</button>
					</td>
					<td colspan=1>
					<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modalAddService">Agregar servicio</button>
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos los usuarios -->
		<c:if test="${not empty listaArticulos}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery">
		<thead>
			<tr>
				<th>Id</th>
				<th>Fecha alta</th>
				<th>Descripci&oacute;n</th>
				<th>Unidad medida</th>
				<th>Precio venta</th>				
				<th>Cantidad existente</th>
				<th>Producto/Servicio</th>
				<th></th>
				<th></th>		
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listaArticulos}" var="articulo">		
		 		<tr>
		 			<td>${articulo.articuloId}</td>
		 			<td>${articulo.fechaAlta}</td>
		 			<td>${articulo.descripcion}</td>
		 			<td>${articulo.unidadMedida}</td>
		 			<td>${articulo.precioVenta}</td>
		 			<td>${articulo.cantidadExistente}</td>
		 			<td>${articulo.esProducto eq '1' ? 'Producto' : 'Servicio'}</td> 			
					<td><button type="button" class="btn btn-dark btnUpdate" id="btnUpdate" data-toggle="modal" data-target="#modalUpdate">Editar</button></td>
		 			<td>		 			
			 			<form:form action="inventario.do" method="post" name="deleteForm" id="deleteForm">
							<input type="hidden" name="articuloId" id="deleteCustomerId" value="${articulo.articuloId}">			 	
			 			 	<input type="submit" class="btn btn btn-dark" name="eliminar" value="Eliminar" />	
			 			 </form:form>
		 			</td>
		 		</tr>	 	
	 		</c:forEach>
	 	</tbody>
	 		</table>
	 		</div>
		</c:if>
		

 <div id="modalAddProduct" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Agregar Articulo</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="articuloDTO" action="inventario.do" method="post" name="addForm" id="addForm">
				<div class="form-group">
					<label>Descripci&oacute;n: </label>
					<input type="text" id="descripcion" name="descripcion" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Unidad de medida: </label>
					<input type="text" id="unidadMedida" name="unidadMedida" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Precio venta: </label>
					<input type="number" id="precioVenta" name="precioVenta" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Cantidad inicial: </label>
					<input type="number" id="cantidadExistente" name="cantidadExistente" placeholder="" class="form-control">
				</div>						
				<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="agregarProducto" value="Enviar" />					
				</div>
				
		</form:form>
      </div>
    </div>
    </div>
    
    
    
 <div id="modalAddService" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Agregar Servicio</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="articuloDTO" action="inventario.do" method="post" name="addForm" id="addForm">
				<div class="form-group">
					<label>Descripci&oacute;n: </label>
					<input type="text" id="descripcion" name="descripcion" placeholder="" class="form-control">
				</div>
			
				<div class="form-group">
					<label>Precio servicio: </label>
					<input type="number" id="precioVenta" name="precioVenta" placeholder="" class="form-control">
				</div>
									
				<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="agregarServicio" value="Enviar" />					
				</div>
				
		</form:form>
      </div>
    </div>
    </div>
       
 <div id="modalUpdateProduct" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Articulo</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="articuloDTO" action="inventario.do" method="post" name="updateForm" id="updateForm">
		<input type="hidden" name="articuloId" id="articuloId">
				<div class="form-group">
					<label>Descripci&oacute;n: </label>
					<input type="text" id="descripcion" name="descripcion" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Unidad medida: </label>
					<input type="text" id="unidadMedida" name="unidadMedida" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Precio venta: </label>
					<input type="number" id="precioVenta" name="precioVenta" placeholder="" class="form-control">
				</div>
				<div class="form-group">
					<label>Cantidad existente: </label>
					<input type="number" id="cantidadExistente" name="cantidadExistente" placeholder="" class="form-control">
				</div>
							
					<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="editarArticulo" value="Enviar" />					
				</div>
		</form:form>
      </div>      
    </div>
    </div>
    
    
    
    <div id="modalUpdateService" class="modal fade" role="dialog" >
 <div class="modal-content" style="">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Editar Servicio</h4>
      </div>
      <div class="modal-body">     
		<form:form modelAttribute="articuloDTO" action="inventario.do" method="post" name="updateForm" id="updateForm">
		<input type="hidden" name="articuloId" id="articuloId">
				<div class="form-group">
					<label>Descripci&oacute;n: </label>
					<input type="text" id="descripcion" name="descripcion" placeholder="" class="form-control">
				</div>
				
				<div class="form-group">
					<label>Precio servicio: </label>
					<input type="number" id="precioVenta" name="precioVenta" placeholder="" class="form-control">
				</div>			
							
					<div class="form-group">
					<input type="submit" class="btn btn-dark login-button" name="editarServicio" value="Enviar" />					
				</div>
		</form:form>
      </div>      
    </div>
    </div>
    
    
    </div>
    
    



<script type="text/javascript">
$( document ).ready(function() {
	//confirmar eliminar	
	$('form[name="deleteForm"]').submit(function() {
	   return confirm("confirma para continuar");	   
	});
	
	// validacion para agregar cliente
	$('form[name="addForm"]').submit(function() {
		var msg = '', valid = true;
		var $form = $('#addForm');
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
	
	
	$( '.btnUpdate' ).click(function() {
		var $updateForm = $("#updateUserForm");
		 var $row = jQuery(this).closest('tr');
		    var $columns = $row.find('td');

		    $columns.addClass('row-highlight');
		    var values = "";

		    jQuery.each($columns, function(i, item) {
		        values = values + 'td' + (i + 1) + ':' + item.innerHTML + '<br/>';
		        if(i===0)
		        	$updateForm.find('#articuloId').val(item.innerHTML);
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