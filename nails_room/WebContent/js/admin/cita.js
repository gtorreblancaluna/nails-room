$( document ).ready(function() {
	
	// buscar clientes via AJAX
	$( '.buscarCliente' ).keyup(function(){
		var valor = $(this).val();
		if(valor != '')
			filtroClientes(valor);
	});
	
	$('.tableShowResultQuery').DataTable();
	//confirmar eliminar	
	$('form[name="actualizarEstadoForm"]').submit(function() {
	   var valid = true;
	   var $form = $('#actualizarEstadoForm');
	   var estadoCitaId = $form.find('#estadoCitaId').val();
	   
	   if(estadoCitaId != 0){
		   valid = confirm("confirma para continuar");
	   }else{
		   alert("Selecciona un estado ")
		   valid = false;
	   }
	   
	   return valid;
	});
	
	// validacion para agregar 
	$('form[name="addForm"]').submit(function() {
		var msg = '', valid = true;
		var msgCliente = ''
		var $form = $('#addForm');
		var cont = 0;
		var descripcion = $form.find('#descripcion').val();
		var fechaCita = $form.find('#fechaCita').val();		
		var clienteId = $form.find('#clienteId').val();
		
		if(descripcion == '')
			msg += ++cont + '. Descripci\u00F3n es requerida \n';
		if(fechaCita == '')
			msg += ++cont + '. Fecha es requerida \n';		
		
		if(clienteId == '' ){
			// validamos datos del nuevo cliente
			var nombre = $form.find('#name').val();
			var apPaterno = $form.find('#apPaterno').val();
			var tel1 = $form.find('#tel1').val();
			var tel2 = $form.find('#tel2').val();
			
			if(nombre == '')
				msgCliente += ++cont+'. El nombre del cliente es requerido \n';
			if(apPaterno == '')
				msgCliente += ++cont+'. El apellido paterno del cliente es requerido \n';
			if(tel1 == '' && tel2 == '')
				msgCliente += ++cont + '. Al menos un tel\u00E9fono del cliente es requerido \n';		
		}		
		
		if(clienteId == '' && msgCliente == '')
			$form.find('#clienteId').val(0);
		
		if(msg != '' || msgCliente != '' ){
			alert (msg+msgCliente);
			valid = false;
		}else{	
//			return valid;
			return confirm("Confirma para guardar la cita ");
		}
	});	
	 	
}); // end document ready

//consultar clientes y mostrar en la tabla clientes
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

function llenarTablaClientes(clientes,form){
	var func = 'elegirCliente';	
	var $form = $('#addForm');
		
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

function elegirCliente(cliente){
	var $form = $('#addForm');
	$form.find('#clienteId').val(cliente.clienteId);
	$form.find('#spanNombreCliente').text(cliente.nombre+" "+cliente.ap_paterno);
	$('.nav-tabs li:eq(1) a').tab('show');
}

function actualizarEstado(citaId){
	var $form = $('#actualizarEstadoForm');
	$form.find('#citaId').val(citaId);
	$('#modalActualizarEstado').modal('show');
}