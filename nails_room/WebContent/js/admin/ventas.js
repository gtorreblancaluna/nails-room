// variables globales
var u_cont=0;

$( document ).ready(function() {
	$('.tableShowResultQuery').DataTable();
	
	//confirmar eliminar	
	$('form[name="deleteForm"]').submit(function() {
	   return confirm("confirma para continuar");	   
	});
	
	// validacion para agregar venta
	$('form[name="addForm"]').submit(function() {
		return validarFormAdd(); 
	});
	
	// pasar tab de cliente a venta
	$( '.btnContinuarVenta' ).click(function() {
		$('.nav-tabs li:eq(1) a').tab('show');
	});
	
	// buscar clientes via AJAX
	$( '.buscarCliente' ).keyup(function(){
		var valor = $(this).val();
		if(valor != '')
			filtroClientes(valor);
	});
	
	// buscar articulos via AJAX
	$( '.filtroDescripcionArticulo' ).keyup(function(){
		var valor = $(this).val();
		if(valor != '')
			filtroArticulos(valor);
	});
	
	// funcion para eliminar una fila de la tabla
	$(".tablaVentaArticulos tbody").on('click','.btnDelete', function(){
		if(confirm("\u00BFEliminar fila?"))
			$(this).closest('tr').remove();		
		conteoFilasArticulos();
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('keyup','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('change','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('keyup','.precio', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('change','.precio', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		
	});	
		
	// buscar articulos
	$( '.btnBuscarArticulo' ).click(function() {		
		$('#modalSearchItem').modal('show');
//		$('#filtroDescripcionArticulo').focus();
		setTimeout(function() { $('input[name="filtroDescripcionArticulo"]').focus() }, 200);
	});
	
	
		
	 	
}); // end document ready

// consultar clientes y mostrar en la tabla clientes
function filtroClientes(valor){
	var data = {}
	if(valor != ''){		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "mostrarClientesPorFiltro.do",
			data : valor,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {				
				// exito, llenamos la tabla de clientes
				console.log(data.clientes)
				llenarTablaClientes(data.clientes);
				
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


//consultar clientes y mostrar en la tabla clientes
function filtroArticulos(valor){
	var data = {}
	if(valor != ''){		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "mostrarArticulosPorFiltro.do",
			data : valor,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {				
				// exito, llenamos la tabla de clientes
				console.log(data.articulos)
				llenarTablaArticulos(data.articulos);
				
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

function llenarTablaClientes(clientes){
	$('.tablaClientes tbody tr td').remove();
	var $tablaClientes = $('.tablaClientes');
	var cont = 0;
	
	$.each(clientes, function(index, value) {
		$(".tablaClientes tbody").append("<tr>"	
				+"<td>"+ ++cont +"</td>"
				+"<td>"+ value.clienteId +"</td>"
				+"<td><a href='javascript:void(0);' onclick='elegirCliente("+JSON.stringify(value)+");'>"+ value.nombre +"</a></td>"
				+"<td><a href='javascript:void(0);' onclick='elegirCliente("+JSON.stringify(value)+");'>"+ value.ap_paterno +"</a></td>"
				+"<td><a href='javascript:void(0);' onclick='elegirCliente("+JSON.stringify(value)+");'>"+ value.ap_materno +"</a></td>"
				+"<td>"+ value.email +"</td>"
				+"<td>"+ value.telefono1 +"</td>"
				+"<td>"+ value.telefono2 +"</td>"
				+"<td>"+ value.direccion +"</td>"
		+"</tr>");
	
	});	// end for each
}

// llenar tabla de articulos
function llenarTablaArticulos(articulos){
	$('.tablaArticulos tbody tr td').remove();
	var $tablaArticulos = $('.tablaArticulos');
	var cont = 0;
	
	$.each(articulos, function(index, value) {
		$(".tablaArticulos tbody").append("<tr>"
				+"<td>"+ ++cont +"</td>"
				+"<td>"+ value.articuloId +"</td>"
				+"<td><a href='javascript:void(0);' onclick='elegirArticulo("+JSON.stringify(value)+");'>"+ value.descripcion +"</a></td>"
		+"</tr>");
	
	});	// end for each
	conteoFilasArticulos();
}

function elegirArticulo(articulo){
	
	if(!verificarArticuloTabla(articulo.articuloId)){
		$('#modalSearchItem').modal('hide');	
		var descripcion = articulo.descripcion;
		var precio = parseFloat(articulo.precioVenta);
		// vamos a agregar a la tabla una fila con el articulo seleccionado
		$(".tablaVentaArticulos tbody").append("<tr>"	
				+"<td><span class='consecutivo'></span></td>"
				+"<td><input type='hidden' class='form-control articuloId' name='detalleVenta["+u_cont+"].articulo.articuloId' value="+articulo.articuloId+">"+ articulo.articuloId +"</td>"
				+"<td><input type='number' class='form-control cantidad' name='detalleVenta["+u_cont+"].cantidad' value="+(1)+"></td>"
				+"<td><input type='text' class='form-control descripcion' name='detalleVenta["+u_cont+"].articulo.descripcion' value='"+descripcion+"' disabled></td>"
				+"<td><input type='number' class='form-control precio' name='detalleVenta["+u_cont+"].precioArticulo' value="+(precio*1)+"></td>"
				+"<td><input type='number' class='form-control subtotal' value="+(precio*1)+" disabled></td>"
				+"<td><input type='button' class='form-control btnDelete' value='Eliminar'></td>"
		+"</tr>");
		++u_cont;
		totalAPagar();
		conteoFilasArticulos();
	}else{
		alert("El articulo [ "+articulo.descripcion+" ] ya se encuentra en la lista ")
	}
}

function elegirCliente(cliente){
	var $form = $('#addForm');
	$form.find('#clienteId').val(cliente.clienteId);
	$form.find('#spanNombreCliente').text(cliente.nombre+" "+cliente.ap_paterno);
	$('.nav-tabs li:eq(1) a').tab('show');
}

function validarFormAdd(){
	var msg = '', valid = true;
	var msgVenta = '';
	var msgTablaArticulos = '';
	var $form = $('#addForm');
	var cont = 0;
	
	// datos cliente
	var clienteId = $form.find('#clienteId').val();
	var nombre = $form.find('#name').val();
	var apPaterno = $form.find('#apPaterno').val();
	var apMaterno = $form.find('#apMaterno').val();
	var email = $form.find('#email').val();
	var tel1 = $form.find('#tel1').val();
	var tel2 = $form.find('#tel2').val();
	
	// datos venta
	var descripcion = $form.find('#descripcion').val();
	var usuarioId = $form.find('#usuarioId').val();
	var estacionTrabajoId = $form.find('#estacionTrabajoId').val();
	
	// validamos que haya seleccionado un cliente o los datos del cliente
	if(clienteId == ''){
		$form.find('#clienteId').val(0);
		// no eligio cliente de la lista, validamos los datos a ingresar
		if(nombre == '')
			msg += ++cont+'. El nombre es requerido \n';
		if(apPaterno == '')
			msg += ++cont+'. El apellido paterno es requerido \n';
		if(tel1 == '' && tel2 == '')
			msg += ++cont + '. Al menos un tel\u00E9fono es requerido \n';		
	}
	
	if(clienteId == '' && msg != '')
		msg += ++cont + '. No hay datos del cliente, selecciona uno de la lista o ingresa datos del nuevo cliente \n';
	
	// validacion de la venta
	if(usuarioId == '0')
		msgVenta += ++cont+'. Selecciona quien atender\u00E1 la estaci\u00F3n de trabajo \n';
	if(estacionTrabajoId == '0')
		msgVenta += ++cont+'. Elige una estaci\u00F3n de trabajo \n';
	
	
	// validando la tabla de articulos
	var totalArticulos = 0;
	 $(".tablaVentaArticulos tbody tr").each(function () {
		 ++totalArticulos;
		 var $tr = $(this).closest('tr');
		 var cantidad = parseFloat($tr.find('.cantidad').val());
		 var precio = parseFloat($tr.find('.precio').val());
		 var descripcion = $tr.find('.descripcion').val();		 
		 if(cantidad <=0 || cantidad >= 999)
			 msgTablaArticulos += ++cont + ". La cantidad ingresada para [ "+descripcion+" ] es invalida \n" ;
	})
	
	if(totalArticulos == 0)
		msgTablaArticulos += ++cont + ". Ingresa por lo menos un articulo o servicio para agregar la nota \n" ;
	 
	if(msg != '' || msgVenta != '' || msgTablaArticulos != ''){
		alert (msg+msgVenta+msgTablaArticulos);
		valid = false;
	}
	return valid;	  
	
}

// calcula el total a pagar de la nota
function totalAPagar(){
	var total=0;
	  $(".tablaVentaArticulos tbody tr").each(function () {
        stotal = $(this).find("td").eq(5).find(".subtotal").val();
        if(stotal != undefined && stotal != "")
      	  total += parseFloat(stotal);
	  })
  
	  $('#totalPagar').html(new Intl.NumberFormat('es-MX').format(total));
}

// contar las filas de la tabla de articulos
function conteoFilasArticulos(){
	var total=0;
	  $(".tablaVentaArticulos tbody tr").each(function () {
        $(this).find("td").eq(0).find(".consecutivo").text(++total);
	  })
  
	  $('#totalArticulos').text(total);
}

// verificar elemento en la tabla, si existe ya no dejara agregar
function verificarArticuloTabla(id){
	var existe = false;
	var articuloId = '';
	
	  $(".tablaVentaArticulos tbody tr").each(function () {
		articuloId = $(this).find("td").eq(1).find(".articuloId").val();
        if(id == articuloId)
        	existe = true;
	  })
  
	  return existe;
}
