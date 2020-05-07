/**
 * 
 */
$(document).on('ready', function() {
		
	var tablaClientesPago;
	
	var tablaDeudasCliente;
	
	var tablaPagoClienteDetalle;
	
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
	
	cargarComboGestoresPago();
	
	cargarComboComprobante();
	
	validarInputsFormRealizarPago(); 
	
	realizarPago();
	
	verDeudaCliente();
	
	evaluadopagos();
		
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
			"bDestroy": true,
			'bProcessing': true, 
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
		$('#codigoComprobante').val('');
		$('#cantidadPago').val('');
		$('#documentoPersonaPago').val('');
		$('#nombreGestorPago').val('');
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
			mostrarFormRealizarPago(true);
			disabledInputDatosCliente(true);
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/cliente/searchClientePago/' + documentoPersonaCliente,
				dataType: 'json',
				success: function(response) {
					
					$('#documentoPersonaClientePago').val(response.documentoPersonaCliente);
					$('#clientePago').val(response.cliente);
					$('#nombreComercialPago').val(response.nombreComercialCliente);
					$('#direccionClientePago').val(response.direccionActualCliente);
					$('#clienteReferenciaDireccionPago').val(response.referencia);
					$('#clienteFechaInstalacionPago').val(response.fechaInstalacion);
					$('#clienteGestorResponsablePago').val(response.gestorResponsable);
					$('#clienteTelefonoGestorPago').val(response.telefonoGestor);
					
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
	
	/***
	 * 
	 *function para cargar combo gestores
	 * 
	 */
	function cargarComboGestoresPago() {
		
		var $nombreGestorPago = $('#nombreGestorPago');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/gestor/gestores',
			dataType: 'json',
			success: function(response) {
				$nombreGestorPago.html('');
				$nombreGestorPago.append('<option value="">Seleccione un Gestor</option>');
				for(var i = 0; i < response.length; i++) {
					$nombreGestorPago.append('<option value="' + response[i].gestor + '">' + response[i].gestor + '</option>');
				}
			}
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
			
			if($('#codigoComprobante').val().trim() == "" && $('#cantidadPago').val() == "" && $('#nombreGestorPago').val().trim() == "") {
				
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
					return false
				}
				
				if($('#nombreGestorPago').val().trim() == "") {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe seleccionar un Gestor !'
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
					return false
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
			
			if($('#codigoComprobante').val().trim() != "" && $('#cantidadPago').val() > 0 && $('#nombreGestorPago').val().trim() != "") {
				
				var formData = {
						documentoPersonaPago: $('#documentoPersonaClientePago').val(),
						codigoComprobante: $('#codigoComprobante').val(),
						cantidadPago: $('#cantidadPago').val(),
						documentoPersonaPago: $('#documentoPersonaPago').val(),
						nombreGestor: $('#nombreGestorPago').val()
				};
				
				console.log(formData);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/pagoServicioGestor',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						console.log(response);
						
						if(response.status == "SUCCESS" && response.message == "PAGO ADELANTADO CON PROMO") {
							swal({
								type: "success",
								title: "Se Realizo el Pago Adelantado con Promocion Correctamente",
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
								title: "Se Realizo el Pago Adelantado sin Promocion Correctamente",
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
						else if(response.status == "ERROR" && response.message == "ESTO ES MALO") {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Realizar el Pago !'
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
	 *function para listar pagos cliente  
	 * 
	 */
	
	function listarPagosCliente(documentoPersonaCliente) {
		
		var flag = documentoPersonaCliente;
		
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
				{"data": "descuento"}
			]
		}).DataTable();
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
				listarDeudasCliente(documentoPersonaCliente);
			}, 3700);
		});
	}
	
	function evaluadopagos(){
		
		$('#verPagoCliente').on('click', function() {
			var documentoPersonaCliente = $(this).attr('documentoPersonaCliente');
			setTimeout(function() {
				$('#modalVerPagoCliente').modal('show');
				listarPagosCliente(documentoPersonaCliente);
			}, 3700);
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
});