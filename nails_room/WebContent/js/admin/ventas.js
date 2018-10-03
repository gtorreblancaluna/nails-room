// variables globales
var u_cont=0;
var cont_update=0;
// variable para almacenar el id del usuario cuando selecciona editar
var g_clienteIdEditar;

$( document ).ready(function() {	

	document.getElementById('fechaInicioFiltro').valueAsDate = new Date();
	document.getElementById('fechaFinFiltro').valueAsDate = new Date();
	
	$('.tableShowResultQuery').DataTable( {
//		  "orderClasses": false
			order: [[ 0, "desc" ]] //column indexes is zero based
	} );
	
	//confirmar eliminar	
	$('form[name="deleteForm"]').submit(function() {
	   return confirm("confirma para continuar");	   
	});
	
	// validacion para agregar venta
	$('form[name="addForm"]').submit(function() {
		
		if(validarForm(1)){
			var $form = $('#addForm');
			$form.find('.cantidad').prop( "disabled", false );
			var clienteId = $form.find('#clienteId').val();
			if(clienteId == '')
				$form.find('#clienteId').val(0);
			return confirm("Confirma para guardar la venta ");
		}else{
			return false;
		}
		
	});
	
	// validacion del formulario editar
	$('form[name="updateForm"]').submit(function() {	
		var valid = false;
		if(validarForm(2)){
			valid = confirm("Confirma para guardar la venta ");
		}else{
			valid = false;
		}
		
		if(valid){
			var $formUpdate = $('#updateForm');
			$formUpdate.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').prop( "disabled", false );
		}
		
		return valid;
		
	});
	
	// pasar tab de cliente a venta
	$( '.btnContinuarVenta' ).click(function() {
		$('.nav-tabs li:eq(1) a').tab('show');
	});
	
	$( '.btnContinuarVentaUpdate' ).click(function() {
		$('.navUpdate li:eq(1) a').tab('show');
	});
	
	$( '.btnUpdate' ).click(function() {
		var ventaId = $(this).attr('data-value');
		obtenerVentaPorId(ventaId);
	});
	
	$( '.btnEditarClienteUpdate' ).click(function() {
		var $formUpdate = $('#updateForm');
		// recuperamos el id globlal del cliente
		$('#updateForm').find('#clienteId').val(g_clienteIdEditar);
		$('#updateForm').find('#editarCliente').val("1");
		$formUpdate.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').prop( "disabled", false );
	});
	
	$( '.btnAgregarCliente' ).click(function() {
		var $formUpdate = $('#updateForm');
		// recuperamos el id globlal del cliente
		$('#updateForm').find('#clienteId').val(0);
		$formUpdate.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').val( "" );
		$formUpdate.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').prop( "disabled", false );
	});
	
	$( '.btnEditarNota' ).click(function() {
		var $formUpdate = $('#updateForm');
		// recuperamos el id globlal del cliente
//		$('#updateForm').find('#clienteId').val(g_clienteIdEditar);
		$formUpdate.find('#descripcion,#usuarioId,#estacionTrabajoId,.btnBuscarArticulo').prop( "disabled", false );
		$formUpdate.find('input[name="actualizar"]').prop( "disabled", false );
		$formUpdate.find('input[name="actualizarFinalizar"]').prop( "disabled", false );
		$formUpdate.find('input[name="finalizarUp"]').prop( "disabled", false );
		// habilitar los inputs de la tabla
		$(".tablaUpdateVentaArticulos tbody tr input.editarSi").prop('disabled', false);
		$(".tablaUpdateVentaArticulos tbody tr input.btnDeleteUpdate").prop('disabled', false);
				
	});
	
	// buscar clientes via AJAX
	$( '.buscarCliente' ).keyup(function(){
		var valor = $(this).val();
		if(valor != '')
			filtroClientes(valor,'add');
	});
	
	// buscar clientes via AJAX
	$( '.buscarClienteUp' ).keyup(function(){
		var valor = $(this).val();
		if(valor != '')
			filtroClientes(valor,'update');
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
		
		conteoFilasArticulos(1);
		--u_cont;
	});	
	
	// incrementar valor en uno a la cantidad de articulo
	$(".tablaVentaArticulos tbody").on('click','.incrementar', function(){
		
		$tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		if(cantidad <= 999){
			$tr.find('.cantidad').val(++cantidad);
			var precio = $tr.find('.precio').val();
			$tr.find('.subtotal').val(cantidad*precio);
			totalAPagar("1");
		}
	});	
	
	// incrementar valor en uno a la cantidad de articulo
	$(".tablaVentaArticulos tbody").on('click','.decrementar', function(){		
		$tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		if(cantidad > 1){
			$tr.find('.cantidad').val(--cantidad);		
			var precio = $tr.find('.precio').val();
			$tr.find('.subtotal').val(cantidad*precio);
			totalAPagar("1");
		}
	});	
	
	// funcion para eliminar una fila de la tabla
	$(".tablaUpdateVentaArticulos tbody").on('click','.btnDeleteUpdate', function(){
		if(confirm("\u00BFEliminar fila?"))
			$(this).closest('tr').remove();		
		conteoFilasArticulos(2);
		--cont_update;
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('keyup','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("1");
		
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('change','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("1");
		
	});	
	// funcion para calcular el subtotal
	$(".tablaUpdateVentaArticulos tbody").on('keyup','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("2");
		
	});	
	// funcion para calcular el subtotal
	$(".tablaUpdateVentaArticulos tbody").on('change','.cantidad', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("2");
	});	
	
	// funcion para calcular el subtotal
	$(".tablaVentaArticulos tbody").on('keyup','.precio', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("1");
	});	
	// funcion para calcular el subtotal
	$(".tablaUpdateVentaArticulos tbody").on('keyup','.precio', function(){
		var $tr = $(this).closest('tr');
		var cantidad = $tr.find('.cantidad').val();
		var precio = $tr.find('.precio').val();
		$tr.find('.subtotal').val(cantidad*precio);
		totalAPagar("2");
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
		$('.tablaArticulos tbody tr td').remove();
		var val = $(this).attr('data-value');
		var $ventana = $('#modalSearchItem');
		$ventana.find('#valor').val(val);
		$('#modalSearchItem').modal('show');
//		$('#filtroDescripcionArticulo').focus();
		setTimeout(function() { $('input[name="filtroDescripcionArticulo"]').focus() }, 200);
		 $('input[name="filtroDescripcionArticulo"]').val("");
	});
	
	
	
		
	 	
}); // end document ready

// consultar clientes y mostrar en la tabla clientes
function filtroClientes(valor,form){
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
				llenarTablaClientes(data.clientes,form);
				
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


function obtenerVentaPorId(ventaId){
	var data = {}
	if(ventaId != ''){		
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "obtenerVentaPorId.do",
			data : ventaId,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {				
				// exito, llenamos la tabla de clientes
				console.log(data.venta)
				llenarVenta(data.venta);
				
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

function llenarVenta(venta){
	// deshabilitar 
	var $formUpdate = $('#updateForm');
	$formUpdate.find('input[name="actualizar"]').prop( "disabled", true );
	$formUpdate.find('input[name="actualizarFinalizar"]').prop( "disabled", true );
	$formUpdate.find('input[name="finalizarUp"]').prop( "disabled", true );
	
	$formUpdate.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').prop( "disabled", true );
	$formUpdate.find('#descripcion,#usuarioId,#estacionTrabajoId,.btnBuscarArticulo').prop( "disabled", true );
	$formUpdate.find('.btnEditarNota').attr('title', 'Editar nota');
	$formUpdate.find('.btnEditarNota').prop( "disabled", false );
	$formUpdate.find('.btnEditarClienteUpdate').attr('title', 'Editar cliente');
	$formUpdate.find('.btnEditarClienteUpdate').prop( "disabled", false );
	// colocamos los datos del cliente
	g_clienteIdEditar = venta.cliente.clienteId;
	$formUpdate.find('#clienteId').val(venta.cliente.clienteId);
	$formUpdate.find('#name').val(venta.cliente.nombre);
	$formUpdate.find('#apPaterno').val(venta.cliente.ap_paterno);
	$formUpdate.find('#apMaterno').val(venta.cliente.ap_materno);
	$formUpdate.find('#email').val(venta.cliente.email);
	$formUpdate.find('#tel1').val(venta.cliente.telefono1);
	$formUpdate.find('#tel2').val(venta.cliente.telefono2);
	$formUpdate.find('#direccion').val(venta.cliente.direccion);
	
	// colocamos datos de la venta
	$formUpdate.find('#ventaId').val(venta.ventaId);
	$formUpdate.find('#descripcion').val(venta.descripcion);
	$formUpdate.find('#usuarioId').val(venta.usuario.usuarioId);
	$formUpdate.find('#estacionTrabajoId').val(venta.estacionTrabajo.estacionTrabajoId);
	
	llenarTablaUpdate(venta.detalleVenta);
	totalAPagar(2);
//	conteoFilasArticulos(2);
	var estadoVentaId = venta.estadoVenta.estadoVentaId;
	
	if(estadoVentaId == '3'){
		// si la venta esta finalizada no podra editar btnEditarNota
		$formUpdate.find('.btnEditarNota').prop( "disabled", true );
		$formUpdate.find('.btnEditarNota').attr('title', 'Esta nota esta finalizada, no podras editar');
		$formUpdate.find('.btnEditarClienteUpdate').attr('title', 'Nota finalizada');
		$formUpdate.find('.btnEditarClienteUpdate').prop( "disabled", true );
	}
	
	$('#modalUpdate').modal('show');
}

function llenarTablaUpdate(dv){
	var $form = $('#updateForm');
	$form.find('.tablaUpdateVentaArticulos tbody tr').remove();	
	
	var contador = 0;
	$.each(dv, function(index, value) {
		$form.find(".tablaUpdateVentaArticulos tbody").append("<tr>"	
				+"<td><span class='consecutivo'>"+ ((contador+1)*1) +"</span></td>"
				+"<td><input type='hidden' class='form-control articuloId' name='detalleVenta["+contador+"].articulo.articuloId' value="+value.articulo.articuloId+">"+ value.articulo.articuloId +"</td>"
				+"<td><input type='number' class='form-control cantidad editarSi' name='detalleVenta["+contador+"].cantidad' value="+value.cantidad+" disabled></td>"
				+"<td><input type='text' class='form-control descripcion' name='detalleVenta["+contador+"].articulo.descripcion' value='"+value.articulo.descripcion+"' disabled></td>"
				+"<td><input type='number' class='form-control precio editarSi' name='detalleVenta["+contador+"].precioArticulo' value="+value.precioArticulo+" disabled></td>"
				+"<td><input type='number' class='form-control subtotal' value="+(value.cantidad * value.precioArticulo)+" disabled></td>"
				+"<td><input type='button' class='form-control btnDeleteUpdate' value='Eliminar' disabled></td>"	
		+"</tr>");
		contador++;
		
	});	// end for each
	 $('#totalArticulosUpdate').text(contador);
	cont_update = contador;
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

function llenarTablaClientes(clientes,form){
	var func = '';
	if(form == 'add'){
		var $form = $('#addForm');
		func = 'elegirCliente';
	}else{
		var $form = $('#updateForm');
		func = 'elegirClienteUpdate';
	}
		
	$form.find('.tablaClientes tbody tr td').remove();
	var $tablaClientes = $('.tablaClientes');
	var cont = 0;
	
	$.each(clientes, function(index, value) {
		$form.find(".tablaClientes tbody").append("<tr>"	
				+"<td>"+ ++cont +"</td>"
				+"<td>"+ value.clienteId +"</td>"
				+"<td><a href='javascript:void(0);' onclick='"+func+"("+JSON.stringify(value)+");'>"+ value.nombre +"</a></td>"
				+"<td><a href='javascript:void(0);' onclick='"+func+"("+JSON.stringify(value)+");'>"+ value.ap_paterno +"</a></td>"
				+"<td><a href='javascript:void(0);' onclick='"+func+"("+JSON.stringify(value)+");'>"+ value.ap_materno +"</a></td>"
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
	var $ventana = $('#modalSearchItem');
	var valor = $ventana.find('#valor').val();
	$.each(articulos, function(index, value) {
		$(".tablaArticulos tbody").append("<tr>"
				+"<td>"+ ++cont +"</td>"
				+"<td>"+ value.articuloId +"</td>"
				+"<td><a href='javascript:void(0);' onclick='elegirArticulo("+JSON.stringify(value)+","+valor+");'>"+ value.descripcion +"</a></td>"
		+"</tr>");
	
	});	// end for each
//	conteoFilasArticulos(1);
}

function elegirArticulo(articulo,valor){
	
	if(!verificarArticuloTabla(articulo.articuloId,valor)){
		$('#modalSearchItem').modal('hide');	
		var descripcion = articulo.descripcion;
		var precio = parseFloat(articulo.precioVenta);
		// vamos a agregar a la tabla una fila con el articulo seleccionado
		if(valor == '1'){
			$(".tablaVentaArticulos tbody").append("<tr>"	
					+"<td><span class='consecutivo'></span></td>"
					+"<td><input type='hidden' class='form-control articuloId' name='detalleVenta["+u_cont+"].articulo.articuloId' value="+articulo.articuloId+">"+ articulo.articuloId +"</td>"
					+"<td><input type='number' style='width:25%; text-align:center;' class='form-control cantidad cellCantidad' name='detalleVenta["+u_cont+"].cantidad' value="+(1)+" disabled><button type='button' class='cellCantidad decrementar'> - </button><button type='button' class='cellCantidad incrementar'> + </button></td>"
					+"<td><input type='text' class='form-control descripcion' name='detalleVenta["+u_cont+"].articulo.descripcion' value='"+descripcion+"' disabled></td>"
					+"<td><input type='number' class='form-control precio' name='detalleVenta["+u_cont+"].precioArticulo' value="+(precio*1)+"></td>"
					+"<td><input type='number' class='form-control subtotal' value="+(precio*1)+" disabled></td>"
					+"<td><input type='button' class='form-control btnDelete' value='Eliminar'></td>"
			+"</tr>");
			++u_cont;
			totalAPagar(valor);
			conteoFilasArticulos(valor);
		}else{
			$(".tablaUpdateVentaArticulos tbody").append("<tr>"	
					+"<td><span class='consecutivo'></span></td>"
					+"<td><input type='hidden' class='form-control articuloId' name='detalleVenta["+cont_update+"].articulo.articuloId' value="+articulo.articuloId+">"+ articulo.articuloId +"</td>"
					+"<td><input type='number' class='form-control cantidad' name='detalleVenta["+cont_update+"].cantidad' value="+(1)+"></td>"
					+"<td><input type='text' class='form-control descripcion' name='detalleVenta["+cont_update+"].articulo.descripcion' value='"+descripcion+"' disabled></td>"
					+"<td><input type='number' class='form-control precio' name='detalleVenta["+cont_update+"].precioArticulo' value="+(precio*1)+"></td>"
					+"<td><input type='number' class='form-control subtotal' value="+(precio*1)+" disabled></td>"
					+"<td><input type='button' class='form-control btnDeleteUpdate' value='Eliminar'></td>"
			+"</tr>");
			++cont_update;
			totalAPagar(valor);
			conteoFilasArticulos(valor);
		}
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

function elegirClienteUpdate(cliente){
	var $form = $('#updateForm');
	// lo ponemos en negativo para identificar en el servidor que se eligio un cliente de la tabla
	$form.find('#clienteId').val((cliente.clienteId)*-1);
	$form.find('#spanNombreCliente').text(cliente.nombre+" "+cliente.ap_paterno);
	$('.navUpdate li:eq(1) a').tab('show');
	$form.find('#name,#apPaterno,#apMaterno,#email,#tel1,#tel2,#direccion').prop( "disabled", true );
}

function validarForm(val){
	var msg = '', valid = true;
	var msgVenta = '';
	var msgTablaArticulos = '';
	if (val == 1)
		var $form = $('#addForm');
	else
		var $form = $('#updateForm');
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
	if(clienteId == '' ){
//		$form.find('#clienteId').val(0);
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
	if(val == 1){
		 $(".tablaVentaArticulos tbody tr").each(function () {
			 ++totalArticulos;
			 var $tr = $(this).closest('tr');
			 var cantidad = parseFloat($tr.find('.cantidad').val());
			 var precio = parseFloat($tr.find('.precio').val());
			 var descripcion = $tr.find('.descripcion').val();		 
			 if(cantidad <=0 || cantidad >= 999)
				 msgTablaArticulos += ++cont + ". La cantidad ingresada para [ "+descripcion+" ] es invalida \n" ;
		})
	}else{
		$(".tablaUpdateVentaArticulos tbody tr").each(function () {
			 ++totalArticulos;
			 var $tr = $(this).closest('tr');
			 var cantidad = parseFloat($tr.find('.cantidad').val());
			 var precio = parseFloat($tr.find('.precio').val());
			 var descripcion = $tr.find('.descripcion').val();		 
			 if(cantidad <=0 || cantidad >= 999)
				 msgTablaArticulos += ++cont + ". La cantidad ingresada para [ "+descripcion+" ] es invalida \n" ;
		})
		
	}
	
	if(totalArticulos == 0)
		msgTablaArticulos += ++cont + ". Ingresa por lo menos un articulo o servicio para agregar la nota \n" ;
	 
	if(msg != '' || msgVenta != '' || msgTablaArticulos != ''){
		alert (msg+msgVenta+msgTablaArticulos);
		valid = false;
	}
	return valid;	  
	
}

// calcula el total a pagar de la nota
function totalAPagar(valor){
	var total=0;
	if(valor == '1'){
	  $(".tablaVentaArticulos tbody tr").each(function () {
        stotal = $(this).find("td").eq(5).find(".subtotal").val();
        if(stotal != undefined && stotal != "")
      	  total += parseFloat(stotal);
	  })
	  $('#totalPagar').html(new Intl.NumberFormat('es-MX').format(total));
	  
	}else{
		$(".tablaUpdateVentaArticulos tbody tr").each(function () {
	        stotal = $(this).find("td").eq(5).find(".subtotal").val();
	        if(stotal != undefined && stotal != "")
	      	  total += parseFloat(stotal);
		  })
		  $('#totalPagarUpdate').html(new Intl.NumberFormat('es-MX').format(total));
	}
  
	  
}

// contar las filas de la tabla de articulos
function conteoFilasArticulos(valor){
	var total=0;
	
	if(valor == '1'){
	  $(".tablaVentaArticulos tbody tr").each(function () {
		  
		var articuloId = $(this).find('td').eq(1).find(".articuloId").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
		$(this).find('td').eq(1).find(".articuloId").attr('name',articuloId);
		  
		var z = $(this).find('td').eq(3).find(".descripcion").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
		$(this).find('td').eq(3).find(".descripcion").attr('name',z);
		
		var cantidad = $(this).find('td').eq(2).find(".cantidad").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
		$(this).find('td').eq(2).find(".cantidad").attr('name',cantidad);
		
		var precio = $(this).find('td').eq(4).find(".precio").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
		$(this).find('td').eq(4).find(".precio").attr('name',precio);

		$(this).find("td").eq(0).find(".consecutivo").text(++total);
	  });
	  
	  
	  $('#totalArticulos').text(total);
	
	
	}else{
		$(".tablaUpdateVentaArticulos tbody tr").each(function () {
			// esta parte es para reoirganizar la numeracion del arreglo y evitar conflictos en el server
			
			var articuloId = $(this).find('td').eq(1).find(".articuloId").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
			$(this).find('td').eq(1).find(".articuloId").attr('name',articuloId);
			
			var z = $(this).find('td').eq(3).find(".descripcion").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
			$(this).find('td').eq(3).find(".descripcion").attr('name',z);
			
			var cantidad = $(this).find('td').eq(2).find(".cantidad").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
			$(this).find('td').eq(2).find(".cantidad").attr('name',cantidad);
			
			var precio = $(this).find('td').eq(4).find(".precio").attr('name').replace(/[^a-zA-Z_\W]+/g, total);
			$(this).find('td').eq(4).find(".precio").attr('name',precio);

			$(this).find("td").eq(0).find(".consecutivo").text(++total);
		});
	  $('#totalArticulosUpdate').text(total);
	}
  
	  
}

// verificar elemento en la tabla, si existe ya no dejara agregar
function verificarArticuloTabla(id,valor){
		var existe = false;
	var articuloId = '';
	
	if(valor == '1'){
	 // viene de formulario agregar
	   $(".tablaVentaArticulos tbody tr").each(function () {
		articuloId = $(this).find("td").eq(1).find(".articuloId").val();
        if(id == articuloId)
        	existe = true;
	  })
	}else{
		// viene del formulario actualizar
		 $(".tablaUpdateVentaArticulos tbody tr").each(function () {
				articuloId = $(this).find("td").eq(1).find(".articuloId").val();
		        if(id == articuloId)
		        	existe = true;
			  })
	}
  
	  return existe;
}

function editarNota(id){
	obtenerVentaPorId(id);
}

function imprimir(ventaId){
	window.open("generar_nota.do?ventaId="+ventaId+"", "Nota venta", "width=500,height=300");
}
