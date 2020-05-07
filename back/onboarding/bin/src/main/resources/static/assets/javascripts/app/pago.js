$(document).on('ready', function() {
	
	var tablaClientesPago;
	
	var tablaDeudasCliente;
	
	var tablaPagoClienteDetalle;
	
	var tipoServicioValue;
	
	cargarTotalRegistrosPersonita();
	
	listarClientesPago();
	
	setTimeout(function() {
		mostrarFormRealizarPago(false);
	}, 100);
	
	ocultar_mostrar(50);
	
	window.setInterval(
		    function(){
		    // Sección de código para modificar el DIV
		    // $("#miDiv").text(variable);
		    	$('#total').load(cargarTotalRegistrosPersona());
		    	evaluando();
		    // Ejemplo: Cada dos segundos se imprime la hora
		    
		  }
		  // Intervalo de tiempo
		,5000);
	
	mostrarDatosRealizarPago();
	
	 disabledInputDatosCliente(true);
	
	cancelarAccionPago();
	
	cargarComboComprobante();
	
	validarInputsFormRealizarPago(); 
	
	realizarPago();
	
	verDeudaCliente();
	
	evaluadopagos();
	
	valgenerardescuento();
	
	redireccionarListaPagosView();
	
	mostrarFormReportePagosPorDia();
	
	mostrarFormReporteRangoDeFechas();
	
	mostrarReporteDeudas();
	
	/**
	 * function para listar los clientesPago
	 * 
	 * */
	function ocultar_mostrar(id){
		
		if(id !== 0){
			
			for( var i = 1;i < id ; i++ ){
			if(i < id){
				
				$.ajax({
					
					type: 'GET',
					url: '/api/v1/usuario/listamodulos/' + i,
					dataType: 'json',
					success: function(response) {
							console.log(response);					
							var descrip = response.descripcionmodulo;
							document.getElementById(descrip).style.display = 'block';
						}
					});
				}
			}
		}
	}
	
	function listarClientesPago() {
		
		tablaClientesPago = $('#tablaClientesPago').dataTable({
			
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
			"ajax": {
				"url": "/api/v1/pago/clientes/clientesPago",
				"dataSrc": ""
			},
			"columns": [
				{"data": "documentoPersonaCliente"},
				{"data": "cliente"},
				{"data": "nombreComercialCliente"},
				{"data": "direccionActualCliente"},
				{"data": "referencia"},
				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnRegistrarPagoCliente" idDocumentoPersonaClientePago><i class="fa fa-credit-card"></i> Registrar Pago</button>'}
			]
		}).DataTable();
		
		$('#tablaClientesPago tbody').on('click', 'button', function() {
			var data = tablaClientesPago.row( $(this).parents('tr')).data();
			$(this).attr('idDocumentoPersonaClientePago', data.documentoPersonaCliente);
		});
	}
	
	/**
	 *
	 * function para mostrarFormGenerarPago
	 * 
	 */
	function mostrarFormRealizarPago(flag) {
		
		limpiarInputs();
		disabledInputDatosCliente(true);
		if(flag) {
			$('#mostrarListadoClientesPago').hide();
			$('#mostrarFormGenerarPago').show();
		}
		else {
			$('#mostrarListadoClientesPago').show();
			$('#mostrarFormGenerarPago').hide();
		}
	}
	
	/**
	 * 
	 *funcion para deshabilitar input datos cliente 
	 * 
	 */
	function disabledInputDatosCliente(flag) {
		if(flag) {
			$('#documentoPersonaClientePago').attr('disabled', true);
			$('#clientePago').attr('disabled', true);
			$('#nombreComercialPago').attr('disabled', true);
			$('#direccionClientePago').attr('disabled', true);
			$('#clienteReferenciaDireccionPago').attr('disabled', true);
			$('#clienteFechaInstalacionPago').attr('disabled', true);
			$('#clienteGestorResponsablePago').attr('disabled', true);
			$('#clienteTelefonoGestorPago').attr('disabled', true);
			$('#clienteFechaInstalacionCablePago').attr('disabled', true);
			$('#clienteCodigoClienteCablePago').attr('disabled', true);
		}
		else {
			$('#documentoPersonaClientePago').attr('disabled', false);
			$('#clientePago').attr('disabled', false);
			$('#nombreComercialPago').attr('disabled', false);
			$('#direccionClientePago').attr('disabled', false);
			$('#clienteReferenciaDireccionPago').attr('disabled', false);
			$('#clienteFechaInstalacionPago').attr('disabled', false);
			$('#clienteGestorResponsablePago').attr('disabled', false);
			$('#clienteTelefonoGestorPago').attr('disabled', false);
			$('#clienteFechaInstalacionCablePago').attr('disabled', false);
			$('#clienteCodigoClienteCablePago').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 * funcion para limpiarInputs
	 * 
	 */
	function limpiarInputs() {
		$('#documentoPersonaClientePago').val('');
		$('#clientePago').val('');
		$('#nombreComercialPago').val('');
		$('#direccionClientePago').val('');
		$('#clienteReferenciaDireccionPago').val('');
		$('#clienteFechaInstalacionPago').val('');
		$('#clienteGestorResponsablePago').val('');
		$('#clienteTelefonoGestorPago').val('');
		$('#clienteFechaInstalacionCablePago').val('');
		$('#clienteCodigoClienteCablePago').val('');
		$('#codigoComprobante').val('');
		$('#cantidadPago').val('');
		$('#documentoPersonaPago').val('');
		$('#datoactualdeuda').val('');
	}
	
	/**
	 * 
	 *funcion para cancelarAccionRealizarPago 
	 *
	 */
	function cancelarAccionPago() {
		
		$('#cancelarAccion').on('click', function() {
			mostrarFormRealizarPago(false);
			limpiarInputs();
			limpiarDatosModal();
		});
	}
	/**
	 * 
	 *function para mostrarDatosRealizarPago 
	 */
	function mostrarDatosRealizarPago() {
		
		$('#tablaClientesPago tbody').on('click', 'button.btnRegistrarPagoCliente', function() {
			
			var documentoPersonaCliente = $(this).attr('idDocumentoPersonaClientePago');
			
			listarDeudasCliente(documentoPersonaCliente);
			listarPagosCliente(documentoPersonaCliente);
			
			mostrarFormRealizarPago(true);
			disabledInputDatosCliente(true);
					
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/cliente/searchClientePago/' + documentoPersonaCliente,
				dataType: 'json',
				success: function(response) {
					
					console.log(response);
					
					$('#documentoPersonaClientePago').val(response.documentoPersonaCliente);
					$('#clientePago').val(response.cliente);
					$('#nombreComercialPago').val(response.nombreComercialCliente);
					$('#direccionClientePago').val(response.direccionActualCliente);
					$('#clienteReferenciaDireccionPago').val(response.referencia);
					$('#clienteFechaInstalacionPago').val(response.fechaInstalacion);
					$('#clienteGestorResponsablePago').val(response.gestorResponsable);
					$('#clienteTelefonoGestorPago').val(response.telefonoGestor);
					$('#clienteFechaInstalacionCablePago').val(response.fechaInstalacionCable);
					$('#clienteCodigoClienteCablePago').val(response.codigoClienteCable);
					
					$('#verDeudaCliente').attr('documentoPersonaCliente', response.documentoPersonaCliente);
					$('#verPagoCliente').attr('documentoPersonaCliente', response.documentoPersonaCliente);
					$('#generarDescuento').attr('documentoPersonaCliente', response.documentoPersonaCliente);
					$('#myModalLabelDeudaCliente').html('Deuda Cliente: ' + response.cliente);
					$('#myModalLabelPagoCliente').html('Pagos Cliente: ' + response.cliente);
					$('#myModalLabelDstosClienteDescuento').html('Cliente: ' + response.cliente);
					$('#documentoPersonaClienteDescuento').val(response.documentoPersonaCliente);
				}
			});
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/pago/recuperarDatoPagoMesMonto/' + documentoPersonaCliente,
				dataType: 'json',
				success: function(response) {
					$('#datoactualdeuda').val("Mes de deuda: "+ response.mesactualdeudanombre + " con un monto S/" + response.valordedeudaactual + " soles");
				}
			});
		});
	}
	
	/**
	 *
	 * function para cargar comboComprobante
	 * 
	 */
	function cargarComboComprobante() {
		
		var $codigoComprobante = $('#codigoComprobante');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/comprobante/comprobantes',
			dataType: 'json',
			success: function(response) {
				$codigoComprobante.html('');
				$codigoComprobante.append('<option value="">Seleccione un Comprobante</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoComprobante.append('<option value="' + response[i].codigoComprobante + '">' + response[i].descripcionComprobante + '</option>');
				}
			}
		});
	}
	
	/**
	 * 
	 *function para validar inputs form pago 
	 */
	function validarInputsFormRealizarPago() {
		
		$('#realizarPagoCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobante').val().trim() == "" && $('#cantidadPago').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar algunos los Campos !'
	            });
				return false;
			}
			else {
				
				if($('#codigoComprobante').val().trim() == "") {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe seleccionar un Tipo de Comprobante !'
		            });
					return false;
				}
				if($('#cantidadPago').val() <= 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Ingrese un valor valido para el Monto a Pagar !'
		            });
					
					$('#cantidadPago').val('');
					$('#cantidadPago').focus();
					return false;
				}
			}
		});
		
		$('#documentoPersonaPago').on('change', function() {
			if(!($('#documentoPersonaPago').val().match(/^[0-9]{7,11}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo DNI Pagador no permite caracteres especiales ni letras, ingrese un valor valido'
	            });
				
				$('#documentoPersonaPago').val('');
				$('#documentoPersonaPago').focus();
		    	return false;
			}
		});
		
		$('#cantidadPago').on('keyup', function() {
			
			var valor = $(this).val();
			
			if(parseInt(valor) <= 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Ingrese un valor valido para el Monto a Pagar'
	            });
				
				$(this).val('');
				$(this).focus();
			}
		});
	}
	
	/**
	 *
	 * function para realizar Pago
	 * 
	 */
	function realizarPago() {
		
		$('#realizarPagoCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobante').val().trim() != "" && $('#cantidadPago').val() > 0) {
				
				var formData = {
					documentoPersonaCliente: $('#documentoPersonaClientePago').val(),
					codigoComprobante: $('#codigoComprobante').val(),
					montoPago: $('#cantidadPago').val(),
					documentoPersonaPago: $('#documentoPersonaPago').val()
				};
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/pagosAdelantados',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						if(response.status == "SUCCESS" && response.message == "PAGO ADELANTADO CON PROMO") {
							
							swal({
								type: "success",
								title: "Se Realizo el Pago Correctamente",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
						else if(response.status == "SUCCESS" && response.message == "PAGO ADELANTADO SIN PROMO") {
							
							swal({
								type: "success",
								title: "Se Realizo el Pago Correctamente",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
						else if(response.status == "SUCCESS" && response.message == "PAGO RAPIDO") {
							
							swal({
								type: "success",
								title: "Se Realizo el Pago Correctamente",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
					},
					error: function() {
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Realizar Pago !'
			            });
					}
				});
			}
		})
	}
	
	/**
	 * 
	 *funcion para limpiar inputs del modal 
	 * 
	 */
	function limpiarDatosModal() {
		$('#myModalLabelDeudaCliente').html('');
	}
	
	/**
	 *
	 *function para listar deudas cliente  
	 * 
	 */
	
	function listarPagosCliente(documentoPersonaCliente) {
		
		var flag = documentoPersonaCliente;
		console.log("flag: " + flag);
		
		tablaPagoClienteDetalle = $('#tablaPagoClienteDetalle').dataTable({
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
				"url": "/api/v1/pago/listaDetallePago/" + flag,
				"dataSrc": ""
			},
			"columns": [
				{"data": "totalpago"},
				{"data": "descuentototal"},
				{"data": "cantidadpago"},
				{"data": "fechadepago"},
				{"data": "informacionpago"},
				{"data": "codigocajapago"}
			]
		}).DataTable();
	}
	
	/**
	 *
	 *function para listar deudas cliente  
	 * 
	 */
	function listarDeudasCliente(documentoPersonaCliente) {
		
		var flag = documentoPersonaCliente;
		
		tablaDeudasCliente = $('#tablaDeudaCliente').dataTable({
			
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
				"url": "/api/v1/pago/clientes/listaMesesDeudas/" + flag,
				"dataSrc": ""
			},
			"columns": [
				{"data": "mesDeuda"},
				{"data": "anioValido"},
				{"data": "tipoServicio"},
				{"data": "sumaPago"},
				{"data": "descuento"},
				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnRealizarPagoDeudaCliente" documentoPersonaClientePagoDeuda mesDeuda anioValido tipoServicio sumaPago descuento><i class="fa fa-money"></i> Realizar Pago</button>'}
			]
		}).DataTable();
		
		$('#tablaDeudaCliente tbody').on('click', 'button', function() {
			
			var data = tablaDeudasCliente.row( $(this).parents('tr')).data();
			$(this).attr('documentoPersonaClientePagoDeuda', data.documentoPersonaCliente);
			$(this).attr('mesDeuda', data.mesDeuda);
			$(this).attr('anioValido', data.anioValido);
			$(this).attr('tipoServicio', data.tipoServicio);
			$(this).attr('sumaPago', data.sumaPago);
			$(this).attr('descuento', data.descuento);
		});
	}
	
	/**
	 * 
	 * function para mostrar form realizar pago deuda
	 * 
	 */
	function mostrarFormRealizarPagoDeuda() {
		
		$('#tablaDeudaCliente tbody').on('click', 'button.btnRealizarPagoDeudaCliente', function() {
			
			var documentoPersonaClienteDeuda = $(this).attr('documentoPersonaClientePagoDeuda');
			var mesDeuda = $(this).attr('mesDeuda');
			var anioValido = $(this).attr('anioValido');
			var tipoServicio = $(this).attr('tipoServicio');
			var sumaPago = $(this).attr('sumaPago');
			var descuento = $(this).attr('descuento');
		
			$('#modalFormPagoDeuda').on('show.bs.modal', function (e) {
				$('#documentoPersonaClientePagoDeuda').val(documentoPersonaClienteDeuda);
				$('#tipoServicioDeudaCliente').val(tipoServicio);
				$('#montoPagoDeuda').val(sumaPago);
				$('#descuentoDeuda').val(descuento);
				$('#mesDeuda').val(mesDeuda);
				$('#anioValidoDeuda').val(anioValido);
			});
				
			tipoServicioValue = tipoServicio;
			
			realizarAccionPorTipoServicio(tipoServicioValue);
		});
	}

	/**
	 * 
	 *funcion para ver deuda cliente 
	 */
	function verDeudaCliente() {
		
		$('#verDeudaCliente').on('click', function() {
			
			var documentoPersonaCliente = $(this).attr('documentoPersonaCliente');
			
			setTimeout(function() {
				$('#modalVerDeudaCliente').modal('show');
				//listarDeudasCliente(documentoPersonaCliente);
			}, 2500);
			mostrarFormRealizarPagoDeuda();
			
			cargarComboComprobantePagoDeuda();
			
			/*cargarComboComprobantePagoDeuda();
			
			cancelarAccionPagoDeuda();
			
			validarFormPagoDeuda();
			
			realizarPagoMora();
			*/
		});
	}
	
	function evaluadopagos(){
		
		$('#verPagoCliente').on('click', function() {
			
			var documentoPersonaCliente = $(this).attr('documentoPersonaCliente');
			
			setTimeout(function() {
				$('#modalVerPagoCliente').modal('show');
			}, 2300);
		});
	}
	
	/**
	 * 
	 * GENERAR DESCUENTOS POR MOTIVO
	 * 
	 * */
	
	function valgenerardescuento(){
		
	$('#generarDescuento').on('click', function() {
		
		var documentoPersonaCliente = $(this).attr('documentoPersonaCliente');
		
		setTimeout(function() {
			$('#modalGenerarDescuentoMes').modal('show');
		}, 2300);
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/pago/recuperarDatoPagoMes/' + documentoPersonaCliente,
			dataType: 'json',
			success: function(response) {
				
				if(response != null) {
					$('#ClienteDescuentoMesPago').val(response.mesvalidopago);
					$('#ClienteDescuentoMT').val(response.montoapagar);
					$('#ClienteDescuento').val(response.montoapagar);
					$('#ClienteDescuento').focus();
				}
				else {
					
				}
			}
		});
		
		GuardarDescuentDelMESACTUAL();
	});
	}

	/**
	 * 
	 * funcion para cargar combo comprobante pago deuda
	 * 
	 */
	function cargarComboComprobantePagoDeuda() {
		
		$codigoComprobantePagoDeuda = $('#codigoComprobantePagoDeuda');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/comprobante/comprobantes',
			dataType: 'json',
			success: function(response) {
				$codigoComprobantePagoDeuda.html('');
				$codigoComprobantePagoDeuda.append('<option value="">Seleccione un Comprobante</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoComprobantePagoDeuda.append('<option value="' + response[i].codigoComprobante + '">' + response[i].descripcionComprobante + '</option>');
				}
			}
		});
	}

	/**
	 * 
	 *function para limpiarFormPagoDeuda 
	 * 
	 */
	function limpiarFormPagoDeuda() {
		
		$('#documentoPersonaClientePagoDeuda').val('');
		$('#tipoServicioDeudaCliente').val('');
		$('#montoPagoDeuda').val('');
		$('#descuentoDeuda').val('');
		$('#mesDeuda').val('');
		$('#anioValidoDeuda').val('');
		$('#codigoComprobantePagoDeuda').val('');
		$('#cantidadPagoDeuda').val('');
		$('#documentoPersonaPagoDeuda').val('');
	}
	
	/**
	 *
	 * function para la accion cancelar pago deuda
	 *
	 */
	function cancelarAccionPagoDeuda() {
		
		$('#cancelarAccionPagoDeuda').on('click', function() {
			limpiarFormPagoDeuda();
		})
	}
	
	function GuardarDescuentDelMESACTUAL() {
		
		$('#generarDescuentoClienteSave').on('click', function(e) {
			e.preventDefault();
			
			var formData = {
					documentopersoma: $('#documentoPersonaClienteDescuento').val(),
					numerodemes: $('#ClienteDescuentoMesPago').val(),
					aniovalido: $('#ClienteDescuentoMesPago').val(),
					descuentodelmes: $('#ClienteDescuento').val(),
					motivodeldescuento: $('#ClienteDescuentoMotivo').val()
			};
				
			$.ajax({
				
				type: 'POST',
				url: '/api/v1/pago/generarDescuentoMensualidad',
				headers: {
					"Content-Type": "application/json",
					"Accept": "application/json"
				},
				data: JSON.stringify(formData),
				dataType: 'json',
				success: function(response) {
					
					if(response.message == "HECHO") {
						
						swal({
							type: "success",
							title: "Se Realizo el Descuento con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/pago/pagos');
							}
						});
					}
					else if(response.message == "ERROR") {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Ups algo salio mal, contacte con el responsable del sistema !'
			            });
					}
				}
			});
			
		})
	}
	
	/**
	 * 
	 *function para validar formPagoDeuda 
	 * 
	 */
	function validarFormPagoDeuda() {
		
		$('#realizarPagoDeudaCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobantePagoDeuda').val().trim() == "" && $('#cantidadPagoDeuda').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar algunos los Campos !'
	            });
				return false;
			}
			else {
				
				if($('#codigoComprobantePagoDeuda').val().trim() == "") {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe seleccionar un Tipo de Comprobante !'
		            });
					return false
				}
				
				if($('#cantidadPagoDeuda').val() <= 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Ingrese un valor valido para el Monto a Pagar !'
		            });
					
					$('#cantidadPagoDeuda').val('');
					$('#cantidadPagoDeuda').focus();
					return false
				}
			}
		});
		
		$('#documentoPersonaPagoDeuda').on('change', function() {
			if(!($('#documentoPersonaPagoDeuda').val().match(/^[0-9]{7,11}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo DNI Pagador no permite caracteres especiales ni letras, ingrese un valor valido'
	            });
				
				$('#documentoPersonaPagoDeuda').val('');
				$('#documentoPersonaPagoDeuda').focus();
		    	return false;
			}
		});
		
		$('#cantidadPagoDeuda').on('keyup', function() {
			
			var valor = $(this).val();
			
			if(parseInt(valor) <= 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Ingrese un valor valido para el Monto a Pagar'
	            });
				
				$(this).val('');
				$(this).focus();
			}
		});
	}
	
	/**
	 * 
	 * function para realizarPagoMoraCable
	 * 
	 */
	function realizarPagoMoraCable() {
		
		$('#realizarPagoDeudaCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobantePagoDeuda').val().trim() != "" && $('#cantidadPagoDeuda').val() > 0) {
				
				var formDataPagoDeudaCable = {
						documentoPersonaClienteDeuda: $('#documentoPersonaClientePagoDeuda').val(), 
						tipoServicio: $('#tipoServicioDeudaCliente').val(),
						codigoComprobanteDeuda: $('#codigoComprobantePagoDeuda').val(),
						descuento: $('#descuentoDeuda').val(),
						documentoPersonaPagoDeuda: $('#documentoPersonaPagoDeuda').val(),
						montoDeuda: $('#montoPagoDeuda').val(),
						montoPago: $('#cantidadPagoDeuda').val(),
						mesPago: $('#mesDeuda').val(),
						aniValidoPago: $('#anioValidoDeuda').val() 
				};
				console.log(formDataPagoDeudaCable);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/pagoMoraCable',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataPagoDeudaCable),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						
						if(response.message == "HECHO") {
							swal({
								type: "success",
								title: "Se Realizo el Pago con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
						else if(response.message == "EXCEDIO") {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Excedio el monto a Pagar !'
				            });
						}
						else if(response.message == "ERROR") {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Hubo un error al Realizar el Pago !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Hubo un error al Realizar el Pago !'
			            });
					}
				});
			}
		});
	}
	
	/**
	 *function para realizarPagoMora 
	 * 
	 */
	function realizarPagoMora() {
		
		$('#realizarPagoDeudaCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobantePagoDeuda').val().trim() != "" && $('#cantidadPagoDeuda').val() > 0) {
				
				var formDataPagoDeuda = {
						documentoPersonaClienteDeuda: $('#documentoPersonaClientePagoDeuda').val(),
						codigoComprobanteDeuda: $('#codigoComprobantePagoDeuda').val(),
						documentoPersonaPagoDeuda: $('#documentoPersonaPagoDeuda').val(),
						cantidadPagoDeuda: $('#cantidadPagoDeuda').val(),
						tipoServicio: $('#tipoServicioDeudaCliente').val(),
						montoPagoDeuda: $('#montoPagoDeuda').val(),
						descuento: $('#descuentoDeuda').val(),
						mes: $('#mesDeuda').val(),
						anioValido:$('#anioValidoDeuda').val()
				};
				
				console.log(formDataPagoDeuda);
						
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/realizarPagoMora',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataPagoDeuda),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						if(response.message == "HECHO") {
							
							swal({
								type: "success",
								title: "Se Realizo el Pago con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
						else if(response.message == "EXCEDIO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Excedio el monto a Pagar !'
				            });
						}
						else if(response.message == "ERROR") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Hubo un error al Realizar el Pago !'
				            });
						}
					}
				});
			}
		});
	}
	
	/**
	 * 
	 *function para redireccionar a la vista lista pagos 
	 * 
	 */
	function redireccionarListaPagosView() {
		
		$('#buttonListaPagos').on('click', function() {
			$(location).attr('href', '/pago/listaPagos');
		});
	}
	
	function cargarmensajespopusnuevo(valor,id){
		
		var title = "Tareas Pendientes!!!";
		
		var position = "Bottom right";
		var duration = "1000";
		var theme = "warning";
		var closeOnClick = true;
		var displayClose =true;
		
		if(valor !== 0)
		{
			
			for(var i = 0;id > i;i++)
			{			
				if(id > i){
					$.ajax(
							{
								
								type: 'GET',
								url: '/api/v1/atencion/searchMensaje/' + (parseInt(valor) + parseInt(i)),
								dataType: 'json',
								success: function(response) {
									
									var mensaje = response.descripcionmensaje;
									var message = mensaje;
							
									window.createNotification({
										closeOnClick: closeOnClick,
										displayCloseButton: displayClose,
										positionClass: position,
										showDuration: duration,
										theme: theme
									})({
								title: title,
								message: message
							});				
						}
					});
				}
			}	
		}
	}

	function cargarmensajespopus(id){
		
		var title = "Tareas Pendientes!!!";
		
		var position = "Bottom right";
		var duration = "1000";
		var theme = "warning";
		var closeOnClick = true;
		var displayClose =true;
		
		if(id === 0)
		{
			
		}else{
			
			for(var i=1;i <= id;i++)
			{			
				if(i <= id){
					$.ajax(
							{
						
								type: 'GET',
								url: '/api/v1/atencion/searchMensaje/' + i,
								dataType: 'json',
								success: function(response) {
									
									var mensaje = response.descripcionmensaje;
									var message = mensaje;
								
									window.createNotification({
										closeOnClick: closeOnClick,
										displayCloseButton: displayClose,
										positionClass: position,
										showDuration: duration,
										theme: theme
									})({
								title: title,
								message: message
							});				
						}
					});
				}
			}	
		}
	}
	
	function estado(id){
		
		if(id !== 0){
			
			for(var i=1;i<=id;i++){
			if(i <= id){
				
				$.ajax({
					
					type: 'GET',
					url: '/api/v1/atencion/searchMensaje/' + i,
					dataType: 'json',
					success: function(response) {
										
						var tag = document.createElement("li");
						tag.innerHTML = '<span class="toggle">Jan</span>';
						
						var mensaje = response.nombrepersona;
						var respuesta = response.descripcionmensaje;
						var listNode = document.getElementById('agregarmensajesnoti');
						var liNode = document.createElement('li');
						var txtNode = document.createTextNode(mensaje);
						
						liNode.innerHTML = '<a href="#" class="clearfix"><figure class="image"><img src="http://clipart-library.com/images/8i6oer5KT.png" wight="40" height="40" alt="Joseph Junior" class="img-circle" /></figure><span class="title">' + String(mensaje) + '</span><span class="mensage">' + String(respuesta) + '</span></a>';
						listNode.appendChild(liNode);
						}
					});
				}
			}
		}
	}
	
	function estadonuevo(valor){
		
		if(valor !== 0){
			
			document.getElementById("agregarmensajesnoti").innerHTML="";
			for(var i=0;i<valor;i++){
			if(i < valor && (parseInt(valor) - parseInt(i)) >-1){
				
				$.ajax({
					
					type: 'GET',
					url: '/api/v1/atencion/searchMensaje/' + (parseInt(valor) - parseInt(i)),
					dataType: 'json',
					success: function(response) {
										
						var tag = document.createElement("li");
						tag.innerHTML = '<span class="toggle">Jan</span>';
						
						var mensaje = response.nombrepersona;
						var respuesta = response.descripcionmensaje;
						var listNode = document.getElementById('agregarmensajesnoti');
						var liNode = document.createElement('li');
						var txtNode = document.createTextNode(mensaje);
						
						liNode.innerHTML = '<a href="#" class="clearfix"><figure class="image"><img src="http://clipart-library.com/images/8i6oer5KT.png" wight="40" height="40" alt="Joseph Junior" class="img-circle" /></figure><span class="title">' + String(mensaje) + '</span><span class="mensage">' + String(respuesta) + '</span></a>';
						listNode.appendChild(liNode);
						}
					});
				}
			}
		}
	}
	
	function evaluando(){
		
		var estatico = null;
		var dinamico = null;
		var valuee = null;
		
		estatico = document.getElementsByName("canje")[0].value;
		dinamico = document.getElementsByName("canjes")[0].value;
		valuee = document.getElementsByName("canjess")[0].value;
		
		var verificando = valuee - dinamico;
		
		if(estatico === valuee && valuee === dinamico){
			estado(valuee);
			cargarmensajespopus(valuee);
			$('#canje').val("0");
		}
		if(verificando === 0){
			estado(verificando);
			cargarmensajespopus(verificando);
			$('#canje').val("0");
		}
		if(verificando !== 0){
			estadonuevo(parseInt(valuee));	
			cargarmensajespopusnuevo(parseInt(dinamico) + 1,parseInt(verificando));
			$('#canje').val("0");
			$('#canjes').val(valuee);
		}
	}
	
	function cargarTotalRegistrosPersona() {
		
		var formData = {
				
		};
		
		$.ajax({
			
			type: 'POST',
			url: '/api/v1/atencion/obtenercantidad',
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json"
			},
			data: JSON.stringify(formData),
			dataType: 'json',
			success: function(response) {
				
				$('#total').html(response.message);
				$('#totalidad').html(response.message);
				$('#canjess').val(response.message);
			}
		});		
	}
	
	function cargarTotalRegistrosPersonita() {
		
		var formData = {
				
		};
		
		$.ajax({
			
			type: 'POST',
			url: '/api/v1/atencion/obtenercantidad',
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json"
			},
			data: JSON.stringify(formData),
			dataType: 'json',
			success: function(response) {
				
				$('#total').html(response.message);
				$('#totalidad').html(response.message);
				$('#canje').val(response.message);
				$('#canjes').val(response.message);
				$('#canjess').val(response.message);
			}
		});			
	}

	/**
	 * 
	 *function para mostrar el modal de reporte de pagosPorDia 
	 * 
	 */
	function mostrarFormReportePagosPorDia() {
		
		$('#buttonReportePagosDia').on('click', function() {
			$('#modalPagosPorDia').modal('show');
		});
		
		validarFormReportePagosPorDia();
		cancelarAccionBuscarPagosPorDia();
	}
	
	function cancelarAccionBuscarPagosPorDia() {
		
		$('#cancelarAccionBuscarPagosPorDia').on('click', function() {
			$('#fechaPagoPorDia').val('');
		});
	}
	
	function validarFormReportePagosPorDia() {
		
		$('#buscarPagosPorFecha').on('click', function(e) {
			e.preventDefault();
			
			if($('#fechaPagoPorDia').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para este campo !'
	            });
			}
			else if($('#fechaPagoPorDia').val() != "") {
				
				var fechaPago = $('#fechaPagoPorDia').val();
				console.log('fechaPago: ' + fechaPago);
						
				var formDataPagoPorDia = {
						fechaBusqueda: $('#fechaPagoPorDia').val()	
				};
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/pagosPorDia',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataPagoPorDia),
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
								documentTitle: 'Reporte de Pagos Por Fecha Pago',
								properties: [
									{ field: 'numeroInterno', displayName: 'Nº'},
									{ field: 'codigoPago', displayName: 'Codigo Pago'},
									{ field: 'fechaPago', displayName: 'Fecha Pago'},
									{ field: 'mesPago', displayName: 'Mes'},
									{field: 'cliente', displayName: 'Cliente'},
									{ field: 'cantidadPago', displayName: 'Monto'}
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
		});
	}
	
	/**
	 * 
	 *function para mostrar el modal de reporte de pagosPorRangoDeFecha
	 * 
	 */
	function mostrarFormReporteRangoDeFechas() {
		
		$('#buttonReportePagosPorRangoFecha').on('click', function() {
			$('#modalPagosPorRangoFecha').modal('show');
		});
		
		validarFormReporteRangoDeFechas();
		buscarReportePagosPorRangoDeFecha();
		cancelarAccionBusquedaRangoDeFechas();
	}
	
	function cancelarAccionBusquedaRangoDeFechas() {
		
		$('#cancelarAccionBuscarRangoPorFecha').on('click', function() {
			$('#fechaInicialBusqueda').val('');
			$('#fechaFinBusqueda').val('');
		});
	}
	
	/**
	 * 
	 * function para validar el form Reporte Rango de Fechas
	 * 
	 * */
	
	function validarFormReporteRangoDeFechas() {
		
		$('#buscarPagosPorRangoFecha').on('click', function(e) {
			e.preventDefault();
			
			if($('#fechaInicialBusqueda').val() == "" && $('#fechaFinBusqueda').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar todos los campos !'
	            });
				return false;
			}
			else {
				if($('#fechaInicialBusqueda').val() == "") {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe ingresar un valor valido para la Fecha Inicial !'
		            });
					return false;
				}
				if($('#fechaFinBusqueda').val() == "") {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe ingresar un valor valido para la Fecha Final !'
		            });
					return false;
				}
			}
		});
	}
	
	/**
	 * 
	 *function para buscarReportePorRangoDeFechas 
	 * 
	 */
	function buscarReportePagosPorRangoDeFecha() {
		
		$('#buscarPagosPorRangoFecha').on('click', function(e) {
			e.preventDefault();
			
			if($('#fechaInicialBusqueda').val() != "" && $('#fechaFinBusqueda').val() != "") {
				
				var formDataBusquedaPorRangoFecha = {
						fechaInicial: $('#fechaInicialBusqueda').val(),
						fechaFinal: $('#fechaFinBusqueda').val()
				};
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/pagosPorRangoFechaBusqueda',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataBusquedaPorRangoFecha),
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
								documentTitle: 'Reporte de Pagos Por Rango Fecha',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{ field: 'codigoPago', displayName: 'Codigo Pago'},
									{ field: 'mesPago', displayName: 'Mes'},
									{ field: 'fechaPagoDia', displayName: 'Fecha Pago'},
									{ field: 'cliente', displayName: 'Cliente'},
									{ field: 'cantidadPago', displayName: 'Monto'}
									
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
		});
	}
	
	/***
	 * 
	 *function para mostrar reporte de deudas 
	 * 
	 */
	function mostrarReporteDeudas() {
		$('#buttonReporteDeudas').on('click', function() {
			
			$('#modalReporteDiasDeudas').modal('show');
		});
		
		validarFormReporteDeudas();
		cancelarAccionBuscarDiasDeudas();
	}
	
	function validarFormReporteDeudas() {
		
		$('#buscarDiasDeudas').on('click', function(e) {
			e.preventDefault();
			
			if($('#diasDeudas').val().trim() != "") {
				
				var formDataDiasDeudas = {
						 diasDeudas: $('#diasDeudas').val()
				};
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/reporteDiasDeudas',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataDiasDeudas),
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
								documentTitle: 'Reporte de Dias Deudas',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{ field: 'codigoCuenta', displayName: 'Nº Cuenta'},
									{ field: 'documentoPersonaCliente', displayName: 'Nº Documento'},
									{ field: 'mesPago', displayName: 'Mes Deuda'},
									{ field: 'direccionCliente', displayName: 'Direccion Actual'},
									{ field: 'cliente', displayName: 'Cliente'}
								], 
								type: 'json'});
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
			if($('#diasDeudas').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para este campo !'
	            });
			}
		});
	}
	function cancelarAccionBuscarDiasDeudas() {
		$('#cancelarAccionBuscarDiasDeudas').on('click', function() {
			$('#diasDeudas').val('');
		});
	}
	
	function realizarAccionPorTipoServicio(tipoServicioValue) {
		
		switch(tipoServicioValue) {
			case 'IC': 
				$('#modalFormPagoDeuda').modal('show');
				cancelarAccionPagoDeuda();
				validarFormPagoDeuda();
				realizarPagoMora();
			break;
			case 'CC':
				$('#modalFormPagoDeuda').modal('show');
				cancelarAccionPagoDeuda();
				validarFormPagoDeuda();
				realizarPagoMoraCable();
			break;
			case 'DUO':
				swal({
	                type: 'warning',
	                title: 'Ooops',
	                text: 'Aun no se implemento el Pago del Servicio de DUO !'
	            });
			break;
			default:
				alert('TIPO SERVICIO NO ESPECIFICADO');
		}
	}
});