/**
 * 
 */
$(document).on('ready', function() {
	
	var tablaEstadoCuentasInternet;
	
	listarTablaEstadoCuentasInternet();
	
	listarComboEstadoCuentas();
	
	mostrarFormReporteCuentasPorEstado();
	
	mostrarFormReporteCuentasInstaladasPorFecha();
	
	regresarListadoCuentas();
});

function listarTablaEstadoCuentasInternet() {
	
	tablaEstadoCuentasInternet = $('#tablaEstadoCuentasInternet').dataTable({
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
			"url": "/api/v1/detalleCuenta/estadoCuentas",
			"dataSrc": ""
		},
		"columns": [
			{"data": "codigoDetalleCuenta"},
			{"data": "codigoCuenta"},
			{"data": "cliente"},
			{"data": "documentoPersonaCliente"},
			{"data": "direccionCliente"},
			{"data": "estado"}
		]
	}).DataTable();
}

function mostrarFormReporteCuentasInstaladasPorFecha() {
	
	$('#btnReporteCuentasInstaladasPorFecha').on('click', function() {
		
		$('#modalCuentasInstaladasPorFecha').modal('show');
	});
	
	validarFormReporteCuentasInstaladasPorFecha();
	cancelarAccionBuscarCuentasInstaladasPorFecha();
}

function cancelarAccionBuscarCuentasInstaladasPorFecha() {
	
	$('#cancelarAccionBusquedaCuentasInstaladasPorFecha').on('click', function() {
		$('#fechaInicio').val('');  
		$('#fechaFin').val('');
	});
}

function validarFormReporteCuentasInstaladasPorFecha() {
	
	$('#buscarCuentasInstaladasPorFecha').on('click', function(e) {
		
		e.preventDefault();
		
		if($('#fechaInicio').val() != "" && $('#fechaFin').val() != "") {
			
			var formDataCuentasInstaladasPorFecha = {
					fechaInicial: $('#fechaInicio').val(),
					fechaFinal: $('#fechaFin').val()
			}
			console.log(formDataCuentasInstaladasPorFecha);
			
			$.ajax({
				
				type: 'POST',
				url: '/api/v1/detalleCuenta/cuentasInstaladas',
				headers: {
					"Content-Type": "application/json",
					"Accept": "application/json"
				},
				data: JSON.stringify(formDataCuentasInstaladasPorFecha),
				dataType: 'json',
				success: function(response) {
					
					if(response == null) {
						swal({
			                type: 'warning',
			                title: 'Ooops',
			                text: 'No se Encontraron Resultados de Busqueda !'
			            });
					}
					else if(response != null) {
						printJS({
							printable: response,
							showModal: true,
							documentTitle: 'Reporte de Cuentas Instaladas Por Rango Fecha',
							properties: [
								{ field: 'numeracion', displayName: '#'},
								{ field: 'codigoCuenta', displayName: 'Nº Cuenta'},
								{ field: 'cliente', displayName: 'Cliente'},
								{ field: 'documentoCliente', displayName: 'Nº Documento'},
								{ field: 'observacion', displayName: 'Observacion'}
							], 
							type: 'json'})
					}
				},
				error: function() {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Ocurrio un Error !'
		            });
				}
			});
		}
		
		if($('#fechaInicio').val() == "" && $('#fechaFin').val() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe ingresar un valor valido para estos campos !'
            });
		}
		
		else if($('#fechaInicio').val() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe ingresar un valor valido para la Fecha Inicial !'
            });
		}
		else if($('#fechaFin').val() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe ingresar un valor valido para la Fecha Final !'
            });
		}
	});
}

function mostrarFormReporteCuentasPorEstado() {
	
	$('#btnReporteCuentasPorEstado').on('click', function() {
		
		$('#modalCuentasPorEstado').modal('show');
	});
	
	validarFormReporteCuentasPorEstado();
}

function validarFormReporteCuentasPorEstado() {
	
	$('#buscarCuentasPorEstado').on('click', function(e) {
		e.preventDefault();
		
		if($('#estadoCuenta').val().trim() != "") {
			
			var formDataBuscarReporteCuentasPorEstado = {
					codigoEstado: $('#estadoCuenta').val()
			};
			console.log(formDataBuscarReporteCuentasPorEstado);
			
			$.ajax({
				
				type: 'POST',
				url: '/api/v1/detalleCuenta/cuentasPorEstado',
				headers: {
					"Content-Type": "application/json",
					"Accept": "application/json"
				},
				data: JSON.stringify(formDataBuscarReporteCuentasPorEstado),
				dataType: 'json',
				success: function(response) {
					
					if(response == null) {
						swal({
			                type: 'warning',
			                title: 'Ooops',
			                text: 'No se Encontraron Resultados de Busqueda !'
			            });
					}
					else if(response != null) {
						console.log(response);
						printJS({
							printable: response,
							showModal: true,
							documentTitle: 'Reporte de Cuentas Por Estado',
							properties: [
								{ field: 'numeracion', displayName: '#'},
								{ field: 'codigoDetalleCuenta', displayName: 'Nº Cuenta'},
								{ field: 'cliente', displayName: 'Cliente'},
								{ field: 'documentoPersonaCliente', displayName: 'Nº Documento'},								
								{ field: 'estado', displayName: 'Estado'},
								{ field: 'direccionCliente', displayName: 'Direccion'},
								{ field: 'referencia', displayName: 'Referencia'},
								{ field: 'vendedorResponsable', displayName: 'Vendedor'}
								
							], 
							type: 'json'})
					}
				},
				error: function() {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Ocurrio un Error !'
		            });
				}
			});
		}
		
		if($('#estadoCuenta').val().trim() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe Seleccionar un Estado Cuenta !'
            });
			return false;
		}
	});
}

function listarComboEstadoCuentas() {
	
	$estadoCuenta = $('#estadoCuenta');
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/detalleCuenta/estados',
		dataType: 'json',
		success: function(response) {
			console.log(response);
			$estadoCuenta.html('');
			$estadoCuenta.append('<option value="">Seleccione un Estado Cuenta</option>');
			for(var i = 0; i < response.length; i++) {
				$estadoCuenta.append('<option value="' + response[i].codigoEstado + '">' + response[i].estado + '</option>');
			}
		}
	});
}

function regresarListadoCuentas() {
	
	$('#btnRegresarListaCuentas').on('click', function() {
		$(location).attr('href', '/detalleCuenta/cuentas/view');
	});
}