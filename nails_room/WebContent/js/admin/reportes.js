$( document ).ready(function() {
	
	document.getElementById('fechaInicioFiltro').valueAsDate = new Date();
	document.getElementById('fechaFinFiltro').valueAsDate = new Date();
	
	$('.tableShowResultQuery').DataTable( {
		 "order": []
	} );
	
});
