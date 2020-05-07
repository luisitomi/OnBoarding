/**
 * 
 */
$(document).on('ready', function() {
	
	var tablaInstalacionesRealizadas;
	
	listarInstalacionesRealizadas();
	generarHojaLiquidacion();
});

function listarInstalacionesRealizadas() {
	
	tablaInstalacionesRealizadas = $('#tablaInstalacionesRealizadas').dataTable({
		"language": {
			"sProcessing":     "Procesando...",
			"sLengthMenu":     "Mostrar _MENU_ registros",
			"sZeroRecords":    "No se encontraron resultados",
			"sEmptyTable":     "Ningún dato disponible en esta tabla",
			"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
			"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
			"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix":    "",
			"sSearch":         "Buscar:",
			"sUrl":            "",
			"sInfoThousands":  ",",
			"sLoadingRecords": "Cargando...",
			"oPaginate": {
				"sFirst":    "Primero",
				"sLast":     "Último",
				"sNext":     "Siguiente",
				"sPrevious": "Anterior"
			},
			"oAria": {
				"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
				"sSortDescending": ": Activar para ordenar la columna de manera descendente"
			}
		},
		'bProcessing': true,
		"bDestroy": true,
		"ajax": {
			"url": "/api/v1/instalacion/instalacionesPorTecnico",
			"dataSrc": ""
		},
		"columns": [
			{"data": "codigoServicioInternet"},
			{"data": "documentoPersona"},
			{"data": "cliente"},
			{"data": "tecnico"},
			{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnGenerarHojaLiquidacion" codigoServicioInternet><i class="fa fa-file-pdf-o"></i> Generar Hoja Liquidacion</button>'}
		]
	}).DataTable();
	
	$('#tablaInstalacionesRealizadas tbody').on('click', 'button', function() {
		var data = tablaInstalacionesRealizadas.row( $(this).parents('tr')).data();
		console.log(data);
		$(this).attr('codigoServicioInternet', data.codigoServicioInternet);
	});
}

function generarHojaLiquidacion() {
	
	$('#tablaInstalacionesRealizadas tbody').on('click', 'button.btnGenerarHojaLiquidacion', function() {
		var codigoServicioInternet = $(this).attr('codigoServicioInternet');
		$(this).attr('href', '/api/v1/material/reciboLiquidacion/' + codigoServicioInternet);
		var url = $(this).attr('href');
		window.open(url, '_blank');
	    return false;
		console.log(url);
		console.log("codigoServicioInternet: " + codigoServicioInternet);
	});
}