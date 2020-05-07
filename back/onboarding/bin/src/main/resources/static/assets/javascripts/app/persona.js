$(document).on('ready', function() {
	
	var tablaClientes;
	
	listarTablaClientes();
	 
	mostrarDatosPersonaCliente();
	 
	validarFormDatosPersonaCliente();
	
	validarDocumentoPersonaCliente();
	
	guardarDatosClientePersona();
	 
	mostrarFormCambiarDireccion();
	 
	guardarCambioDireccion();
	 
	cargarComboListaVendedoresCambio();
	 
	cargarComboUbigeo();
	 
	var flag;
	
	var accion;
	
	setTimeout(function() {
		mostrarForm(false);
		mostrarFormCliente(false);
	},100);
	
	setTimeout(function() {
		cargarEstadoCliente();
		ocultarBotones();
	}, 8000);
	
	ocultar_mostrar(50);
	
	cargarTotalRegistrosPersonita();
	
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
	
	cargarComboSexo();
	
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
		
	var tabla = $('#tablaPersonas').dataTable({
		
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
		"bProcessing": true,
		"ajax": {
			"url": "/api/v1/persona/personas/listaPersonasNoClientes",
			"dataSrc": ""
		},
		"columns": [
			{"data": "documentoPersona"},
			{"data": "nombrePersona"},
			{"data": "apellidoPaternoPersona"},
			{"data": "apellidoMaternoPersona"},
			{"data": "direccionActualPersona"},
			{"data": "referenciaPersona"},
			{"data": "telefonoUnoPersona"},
			{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnAgregarPersonaCliente" idDocumento><i class="fa fa-users"></i> Añadir a Clientes</button>'},
			{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-info btn-sm btnEditarPersona" idDocumento><i class="fa fa-pencil" title="Editar"></i></button></div>'}
		]		
	}).DataTable();
	
	$('#tablaPersonas tbody').on('click', 'button', function() {
		
		var data = tabla.row($(this).parents('tr')).data();
		$(this).attr('idDocumento', data.documentoPersona);
	});
	
	function limpiar() {
		
		$('#documentoPersona').val('');
		$('#codigoUbigeo').val('');
		$('#nombreUbigeo').val('');
		$('#nombrePersona').val('');
		$('#apellidoPaternoPersona').val('');
		$('#apellidoMaternoPersona').val('');
		$('#direccionReniecPersona').val('');
		$('#direccionActualPersona').val('');
		$('#referenciaPersona').val('');
		$('#telefonoUnoPersona').val('');
		$('#telefonoDosPersona').val('');
		$('#telefonoTresPersona').val('');
	}
	
	function limpiarClientes() {
		
		$('#documentoPersonaCliente').val('');
		$('#clienteNombrePersona').val('');
		$('#clienteApellidosPersona').val('');
		$('#consecutivoCliente').val('');
		$('#codigoCliente').val('');
		$('#nombreComercialCliente').val('');
		$('#correoCliente').val('');
		$('#facebookCliente').val('');
		$('#codigoSexo').val('');
	}
	
	function mostrarForm(flag) {
		
		limpiar();
		if(flag) {
			
			$('#listadoPersonaRegistro').hide();
			$('#formularioPersonaRegistro').show();
		}
		else {
			
			$('#listadoPersonaRegistro').show();
			$('#formularioPersonaRegistro').hide();
		}
	}
	
	function mostrarFormCliente(flag) {
		
		limpiarClientes();
		if(flag) {
			
			$('#listadoPersonaRegistro').hide();
			$('#formularioRegistroClientes').show();
		}
		else {
			$('#listadoPersonaRegistro').show();
			$('#formularioRegistroClientes').hide();
		}
	}
	
	function cancelarForm() {
		limpiar();
		mostrarForm(false);
	}
	
	function cancelarFormCliente() {
		limpiarClientes();
		mostrarFormCliente(false);
	}
	
	$('#btnAgregarPersona').on('click', function() {
		
		mostrarForm(true);
		$('#documentoPersona').attr('disabled', false);
		$('#inputDireccionReniec').hide();
		flag = false;
	});
	
	$('#cancelarAccion').on('click', function() {
		
		cancelarForm();
	});
	
	/**
	 * 
	 * function accionValidarDocumentoPersonaCliente
	 * 
	 * */
	function validarDocumentoPersonaCliente() {
		
		$('#validarDocumentoPersonaCLiente').on('click', function(e) {
			e.preventDefault();
			
			if($('#documentoPersona').val().match(/^[0-9\.-\s]{7,12}$/)) {
				
				var formDataValidarDocumentoPersonaCliente = {
						documentoPersonaCliente: $('#documentoPersona').val()	
				};
				console.log(formDataValidarDocumentoPersonaCliente);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/cliente/generarConsecutivoCliente',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataValidarDocumentoPersonaCliente),
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
							$('#documentoPersona').val(response.documentoCliente);
							$('#nombrePersona').val(response.nombreCliente);
							$('#apellidoPaternoPersona').val(response.apellidoPaternoCliente);
							$('#apellidoMaternoPersona').val(response.apellidoMaternoCliente);
							$('#telefonoUnoPersona').val(response.telefonoCliente);
							$('#nombreComercialCliente').val(response.empresaCliente);
							$('#correoCliente').val(response.correoCliente);
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
			
			if($('#documentoPersona').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Numero Documento no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#documentoPersona').focus();
		    	return false;
			}
			else if(!($('#documentoPersona').val().match(/^[0-9\.-\s]{7,12}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Numero Documento no permite caracteres especiales ni letras'
	            });
				
				$('#documentoPersona').val('');
				$('#documentoPersona').focus();
		    	return false;
			}
		});
	}
	
	$('#guardarPersona').on('click', function(e) {
		e.preventDefault();
				
		if($('#documentoPersona').val().match(/^[0-9\.-\s]{7,12}$/) && $('#codigoUbigeo').val().trim() != ""
			&& $('#nombrePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#apellidoPaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/)
			&& $('#apellidoMaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#direccionActualPersona').val() != "" 
			&& $('#referenciaPersona').val() != "" && $('#telefonoUnoPersona').val().match(/^[0-9]{7,9}$/) 
			&& $('#correoCliente').val().match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/)
			&& $('#facebookCliente').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\,.-\s]+$/)
			&& $('#codigoSexo').val().trim() != "" ) {
		
			var formData = {
					
					documentopersoma: $('#documentoPersona').val(),
					codigoubigeo: $('#codigoUbigeo').val(),
					nombrepersona: $('#nombrePersona').val(),
					paternopersona: $('#apellidoPaternoPersona').val(),
					maternopersona: $('#apellidoMaternoPersona').val(),
					direccionreniecpersona: $('#direccionReniecPersona').val(),
					direccionactualpersona: $('#direccionActualPersona').val(),
					referenciapersona: $('#referenciaPersona').val(),
					primertelefono: $('#telefonoUnoPersona').val(),
					segundotelefono: $('#telefonoDosPersona').val(),
					tercertelefono: $('#telefonoTresPersona').val()
			};
			
			console.log(flag);
			if(flag == false) {
				
				$.ajax({

					type: 'POST',
					url: '/api/v1/persona/insrpersona',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						console.log(response);
												
						if(response.status == 'SUCCESS' && response.message == "HECHO") {
							
							var formDataCliente = {	
									documentoPersonaCliente: $('#documentoPersona').val(),
									nombreComercialCliente: $('#nombreComercialCliente').val(),
									correoCliente: $('#correoCliente').val(),
									facebookCliente: $('#facebookCliente').val(),
									codigoSexo: $('#codigoSexo').val()
							};
							
							$.ajax({
								
								type:'POST',
								url: '/api/v1/cliente/saveCliente',
								headers: {
									"Content-Type": "application/json",
									"Accept": "application/json"
								},
								data: JSON.stringify(formDataCliente),
								dataType: 'json',
								success: function(response) {
									
									console.log(response);
									
									if(response.status == 'CREATED') {
										
										swal({
											type: "success",
											title: "Cliente Registrado con exito",
											showConfirmButton: true,
											confirmButtonText: "Cerrar",
											closeOnConfirm: false
										}).then((result) => {

											if(result.value) {
												$(location).attr('href', '/persona/view');
											}
										});
									}
									else if(response.status == 'ERROR') {
										
										swal({
							                type: 'error',
							                title: 'Ooops',
							                text: 'Ocurrio un Error al Registrar al Cliente, verifique si ya existe !'
							            });
										
										limpiarClientes();
									}
								},
								error: function() {
									
									swal({
						                type: 'error',
						                title: 'Ooops',
						                text: 'Error al Registrar Cliente !'
						            });
								}
							});
						}
						else if(response.status == 'SUCCESS' && response.message == "ERROR") { 
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Registrar al Cliente: '+ response.data.nombrepersona +', verifique su Numero Documento !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Cliente !'
			            });
					}
				});
			}
			
			if(flag == true) {
			
				$.ajax({

					type: 'POST',
					url: '/api/v1/persona/editpersona',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
								
						if(response.status == 'SUCCESS' && response.message == "HECHO") {
							
							swal({
								type: "success",
								title: "Persona: " + response.data.nombrepersona + " Actualizada con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/persona/view');
								}
							});
						}
						else if(response.status == 'SUCCESS' && response.message == "ERROR") { 
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Actualizar a la Persona: '+ response.data.nombrepersona +', verifique su Numero Documento !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Persona !'
			            });
					}
				});
			}
		}
		
		if($('#documentoPersona').val() == "" && $('#codigoUbigeo').val().trim() == "" && $('#nombrePersona').val() == "" 
				&& $('#apellidoPaternoPersona').val() == "" && $('#apellidoMaternoPersona').val() == "" && $('#direccionActualPersona').val() == ""
				&& $('#referenciaPersona').val() == "" && $('#telefonoUnoPersona').val() == "" && $('#correoCliente').val() == "" 
				&& $('#facebookCliente').val() == "" && $('#codigoSexo').val().trim() == "")  {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe llenar todos los Campos !'
            });
			return false;
		}
		else {
			
			if($('#documentoPersona').val() == "" || $('#documentoPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Numero Documento no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#documentoPersona').focus();
		    	return false;
			}
			
			if($('#codigoUbigeo').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe seleccionar un Ubigeo'
	            });
				
		    	return false;
		    	
		    	$('#codigoUbigeo').focus();
		    	return false;
			}
			
			if($('#nombrePersona').val() == "" || $('#nombrePersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Nombre no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#nombrePersona').focus();
		    	return false;
			}
			
			if($('#apellidoPaternoPersona').val() == "" || $('#apellidoPaternoPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Apellido Paterno no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#apellidoPaternoPersona').focus();
		    	return false;
			}
			
			if($('#apellidoMaternoPersona').val() == "" || $('#apellidoMaternoPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Apellido Materno no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#apellidoMaternoPersona').focus();
		    	return false;
			}
			
			if($('#direccionActualPersona').val() == "" || $('#direccionActualPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Direccion Actual no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#direccionActualPersona').focus();
		    	return false;
			}
			
			if($('#referenciaPersona').val() == "" || $('#referenciaPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Referencia Direccion no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#referenciaPersona').focus();
		    	return false;
			}
			
			if($('#telefonoUnoPersona').val() == "" || $('#telefonoUnoPersona').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Telefono o Celular no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#telefonoUnoPersona').focus();
		    	return false;
			}
			
			if($('#correoCliente').val() == "" || $('#correoCliente').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Correo Electronico no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#correoCliente').focus();
		    	return false;
			}
			
			else if(!($('#correoCliente').val().match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Correo Electronico no tiene un formato de Correo valido'
	            });
				
				$('#correoCliente').val('');
				$('#correoCliente').focus();
		    	return false;
			}
			
			if($('#facebookCliente').val() == "" || $('#facebookCliente').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Facebook Cliente no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#facebookCliente').focus();
		    	return false;
			}
			
			else if(!($('#facebookCliente').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\,.-\s]+$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Ingrese un valor valido para el Facebook Cliente'
	            });
				
				$('#facebookCliente').val('');
				$('#facebookCliente').focus();
		    	return false;
			}
			
			if($('#codigoSexo').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe seleccionar un Sexo'
	            });
				
		    	return false;
			}
											
			if(!($('#documentoPersona').val().match(/^[0-9\.-\s]{7,12}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Numero Documento no permite caracteres especiales ni letras'
	            });
				
				$('#documentoPersona').val('');
				$('#documentoPersona').focus();
		    	return false;
			}
			
			else {
				
				if(!($('#nombrePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Nombre no permite caracteres especiales ni numeros'
		            });
					
					$('#nombrePersona').val('');
					$('#nombrePersona').focus();
			    	return false;
				}
				
				else if(!($('#apellidoPaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Paterno no permite caracteres especiales ni numeros'
		            });
					
					$('#apellidoPaternoPersona').val('');
					$('#apellidoPaternoPersona').focus();
			    	return false;
				}
				
				else if(!($('#apellidoMaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Materno no permite caracteres especiales ni numeros'
		            });
					
					$('#apellidoMaternoPersona').val('');
					$('#apellidoMaternoPersona').focus();
			    	return false;
				}
				
				/**
				else if(!($('#direccionActualPersona').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\#.-\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Direccion Actual no permite caracteres especiales'
		            });
					
					$('#direccionActualPersona').val('');
					$('#direccionActualPersona').focus();
			    	return false;
				}
				*/
				
				/**
				else if(!($('#referenciaPersona').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\#.-\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Referencia Direccion no permite caracteres especiales'
		            });
			    	
					$('#referenciaPersona').val('');
			    	$('#referenciaPersona').focus();
			    	return false;
				}
				*/
				
				else if(!($('#telefonoUnoPersona').val().match(/^[0-9]{7,9}$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Telefono o Celular Uno no permite caracteres especiales, ni letras'
		            });
			    	
					$('#telefonoUnoPersona').val('');
			    	$('#telefonoUnoPersona').focus();
			    	return false;
				}
			}
		}
	});
	
	/**
	 * 
	 * Evento change para el input Telefono 2
	 * 
	 * */
	$('#telefonoDosPersona').on('change', function() {
		
		if(!($('#telefonoDosPersona').val().match(/^[0-9]{7,9}$/))) {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'El campo Telefono o Celular Dos no permite caracteres especiales, ni letras'
            });
	    	
			$('#telefonoDosPersona').val('');
	    	$('#telefonoDosPersona').focus();
	    	return false;
		}
	});
	
	/**
	 * 
	 * Evento change para el input Telefono 3
	 * 
	 * */
	$('#telefonoTresPersona').on('change', function() {
		
		if(!($('#telefonoTresPersona').val().match(/^[0-9]{7,9}$/))) {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'El campo Telefono o Celular Tres no permite caracteres especiales, ni letras'
            });
	    	
			$('#telefonoTresPersona').val('');
	    	$('#telefonoTresPersona').focus();
	    	return false;
		}
	});
	
	/**
	 *
	 * Editar Persona
	 * 
	 */
	$('#tablaPersonas tbody').on('click', 'button.btnEditarPersona', function() {
		
		var documentoPersona = $(this).attr('idDocumento');
		
		mostrarForm(true);
		$('#documentoPersona').attr('disabled', true);
		flag = true;
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersona,
			dataType: 'json',
			success: function(response) {
			
				$('#documentoPersona').val(response.documentoPersona);
				$('#codigoUbigeo').val(response.ubigeo.codigoUbigeo);
				$('#nombreUbigeo').val(response.ubigeo.nombreUbigeo);
				$('#nombrePersona').val(response.nombrePersona);
				$('#apellidoPaternoPersona').val(response.apellidoPaternoPersona);
				$('#apellidoMaternoPersona').val(response.apellidoMaternoPersona);
				$('#direccionReniecPersona').val(response.direccionReniecPersona);
				$('#direccionActualPersona').val(response.direccionActualPersona);
				$('#referenciaPersona').val(response.referenciaPersona);
				$('#telefonoUnoPersona').val(response.telefonoUnoPersona);
				$('#telefonoDosPersona').val(response.telefonoDosPersona);
				$('#telefonoTresPersona').val(response.telefonoTresPersona);
			}
		});
	});
	
	function cargarComboUbigeo() {
		
		var $codigoUbigeo = $('#codigoUbigeo');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/ubigeo/listaUbigeo',
			dataType: 'json',
			success: function(response) {
				
				$codigoUbigeo.html('');
				$codigoUbigeo.append('<option value="">Seleccione un Ubigeo</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoUbigeo.append('<option value="' + response[i].codigoUbigeo + '">' + response [i].nombreUbigeo + '</option>');
				}
			}
		});
	}
	
	function cargarComboSexo() {
		
		var $codigoSexo = $('#codigoSexo');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/sexo/listaSexo',
			dataType: 'json',
			success: function(response) {
			
				$codigoSexo.html('');
				$codigoSexo.append('<option value="">Seleccione un sexo</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoSexo.append('<option id="optionComboSexo" value="' + response[i].codigoSexo +'">' + response[i].descripcionSexo + '</option>');
				}
			}
		});
	}
	
	$('#tablaPersonas tbody').on('click', 'button.btnAgregarPersonaCliente', function() {
		
		var documentoPersona = $(this).attr('idDocumento');
		
		mostrarFormCliente(true);
		accion = false;
		$('#documentoPersonaCliente').attr('disabled', true);
		$('#documentoPersonaCliente').val(documentoPersona);
		$('#clienteNombrePersona').attr('disabled', true);
		$('#clienteApellidosPersona').attr('disabled', true);
		$('#inputConsecutivoCliente').hide();
		$('#inputCodigoCliente').hide();
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersona,
			dataType: 'json',
			success: function(response) {
				
				$('#clienteNombrePersona').val(response.nombrePersona);
				$('#clienteApellidosPersona').val(response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
			}
		});
	});
	
	$('#cancelarAccionCliente').on('click', function() {
		
		cancelarFormCliente();
	});
	
	$('#guardarCliente').on('click', function(e) {
		
		e.preventDefault();
		
		if($('#correoCliente').val().match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/)
			&& $('#facebookCliente').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\,.-\s]+$/)
			&& $('#codigoSexo').val().trim() != "") {
				
			var formData = {	
					documentoPersonaCliente: $('#documentoPersonaCliente').val(),
					consecutivoCliente: $('#consecutivoCliente').val(),
					codigoCliente: $('#codigoCliente').val(),
					nombreComercialCliente: $('#nombreComercialCliente').val(),
					correoCliente: $('#correoCliente').val(),
					facebookCliente: $('#facebookCliente').val(),
					sexo: {
						codigoSexo: $('#codigoSexo').val()
					}
			};
			
			if(accion == true) {
				
				$.ajax({
					
					type: 'PUT',
					url: '/api/v1/cliente/update',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						swal({
							type: "success",
							title: "Cliente Actualizado con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/persona/view');
							}
						});
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Cliente !'
			            });
					}
				});
			}
			
			else if(accion == false) {
					
				$.ajax({
					
					type:'POST',
					url: '/api/v1/cliente/save',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						
						if(response.status == 'CREATED') {
							
							swal({
								type: "success",
								title: "Cliente Registrado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/persona/view');
								}
							});
						}
						else if(response.status == 'ERROR') {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Registrar al Cliente, verifique si ya existe !'
				            });
							
							limpiarClientes();
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Cliente !'
			            });
					}
				});
			}
		}
		
		if($('#correoCliente').val() == "" && $('#facebookCliente').val() == "" && $('#codigoSexo').val().trim() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe llenar todos los Campos !'
            });
		
			return false;
		}
		
		else{
			
			if($('#correoCliente').val() == "" || $('#correoCliente').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Correo Electronico no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#correoCliente').focus();
		    	return false;
			}
			else if($('#facebookCliente').val() == "" || $('#facebookCliente').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Facebook Cliente no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#facebookCliente').focus();
		    	return false;
			}
			else if($('#codigoSexo').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe seleccionar un Sexo'
	            });
				
		    	return false;
			}
						
			else if(!($('#correoCliente').val().match(/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Correo Electronico no tiene un formato de Correo valido'
	            });
				
				$('#correoCliente').val('');
				$('#correoCliente').focus();
		    	return false;
			}
			
			else if(!($('#facebookCliente').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\,.-\s]+$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Ingrese un valor valido para el Facebook Cliente'
	            });
				
				$('#facebookCliente').val('');
				$('#facebookCliente').focus();
		    	return false;
			}
		}
	});
	
	$('#nombreComercialCliente').on('change', function() {
		
		if(!($('#nombreComercialCliente').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\,.-\s]+$/))) {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'El campo Nombre Comercial Cliente no permite caracteres especiales'
            });
			
			$('#nombreComercialCliente').val('');
			$('#nombreComercialCliente').focus();
	    	return false;
		}
	});
	
	function listarTablaClientes() {
		
		tablaClientes = $('#tablaClientes').dataTable({
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
			"bProcessing": true,
			"ajax": {
				"url": "/api/v1/cliente/clientes/listarClientesPorVendedor",
				"dataSrc": ""
			},
			"columns": [
				{"data": "documentoPersonaCliente"},
				{"data": "cliente"},
				{"data": "direccionActualCliente"},
				{"data": "facebookCliente"},
				{"data": "correoCliente"},
				{"defaultContent": '<span class="label label-success estadoCliente">Activo</span>'},
				{"defaultContent": '<div class="btn-group"><button type="button" data-toggle="modal" class="btn btn-info btn-sm btnVerCliente" idDocumentoCliente><i class="fa fa-eye" title="Ver"></i></button><button type="button" class="btn btn-primary btn-sm btnEditarCliente" idDocumentoCliente><i class="fa fa-pencil" title="Editar"></i></button></div>'},
				{"defaultContent": '<button type="button" data-toggle="modal" class="btn btn-warning btn-xs btnEditarDatosPersona" idDocumentoCliente><i class="fa fa-user" title="Editar"></i> Datos Persona</button>'},
				{"defaultContent": '<button type="button" data-toggle="modal" class="btn btn-success btn-xs btnCambiarDireccionCliente" idDocumentoCliente><i class="fa fa-home" title="Editar"></i> Cambiar Direccion</button>'}
			]
		}).DataTable();
		
		$('#tablaClientes tbody').on('click', 'button', function() {
			
			var data = tablaClientes.row( $(this).parents('tr')).data();
			console.log(data);
			$(this).attr('idDocumentoCliente', data.documentoPersonaCliente);
		});
	}
	
	/**
	 *
	 * function para limpiarInputsDelFormDatosPersonaCliente
	 * 
	 */
	function limpiarInputsFormDatosPersonaCliente() {
		
		$('#myModalLabelDatosPersona').html('');
		$('#documentoPersonaClientePersona').val('');
		$('#nombreClientePersona').val('');
		$('#apellidoPaternoClientePersona').val('');
		$('#apellidoMaternoClientePersona').val('');
		$('#telefonoUnoClientePersona').val('');
		$('#telefonoDosClientePersona').val('');
		$('#telefonoTresClientePersona').val('');
		$('#direccionClientePersona').val('');
	}
	
	/**
	 * 
	 *function para mostrarDatosPersonaCliente 
	 *
	 **/
	function mostrarDatosPersonaCliente() {
		
		$('#tablaClientes tbody').on('click', 'button.btnEditarDatosPersona', function() {
			
			var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
			console.log('documentoPersonaCliente: ' + documentoPersonaCliente);
			
			limpiarInputsFormDatosPersonaCliente();
			$('#modalDatosPersona').modal('show');
			$('#documentoPersonaClientePersona').attr('disabled', true);
			$('#direccionClientePersona').attr('disabled', true);
			
			$.ajax({
				
				type:'GET',
				url: '/api/v1/cliente/cliente/recuperarDatosCliente/' + documentoPersonaCliente,
				dataType: 'json',
				success: function(response) {
					console.log(response);
					$('#myModalLabelDatosPersona').html('Persona: ' + response.apellidoPaternoCliente + ' ' + response.apellidoMaternoCliente + ', ' + response.nombresCliente);
					$('#documentoPersonaClientePersona').val(response.documentoPersonaCliente);
					$('#nombreClientePersona').val(response.nombresCliente);
					$('#apellidoPaternoClientePersona').val(response.apellidoPaternoCliente);
					$('#apellidoMaternoClientePersona').val(response.apellidoMaternoCliente);
					$('#telefonoUnoClientePersona').val(response.telefonoUnoCliente);
					$('#telefonoDosClientePersona').val(response.telefonoDosCliente);
					$('#telefonoTresClientePersona').val(response.telefonoTresCliente);
					$('#direccionClientePersona').val(response.direccionActualCliente);
				}
			});
		});
	}
	
	/**
	 * 
	 *function para limpiar el modal de cambiar direccion 
	 * 
	 */
	function limpiarInputsCambiarDireccion() {
		
		$('#myModalLabelCambiarDireccion').html('');
		$('#documentoPersonaClienteCambiarDireccion').val('');
		$('#nombreClienteCambiarDireccion').val('');
		$('#apellidoPaternoClienteCambiarDireccion').val('');
		$('#direccionClienteCambiarDireccion').val('');
		$('#nuevaDireccionCliente').val('');
		$('#observacionCambiarDireccion').val('');
		$('#fechaSugerenciaCambiarDireccion').val('');
	}
	
	/**
	 * 
	 *function para mostrarFormDireccion 
	 * 
	 */
	function mostrarFormCambiarDireccion() {
	
		$('#tablaClientes tbody').on('click', 'button.btnCambiarDireccionCliente', function() {
			
			var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
			console.log('documentoPersonaCliente: ' + documentoPersonaCliente);
			
			$('#documentoPersonaClienteCambiarDireccion').attr('disabled', true);
			$('#nombreClienteCambiarDireccion').attr('disabled', true);
			$('#apellidoPaternoClienteCambiarDireccion').attr('disabled', true);
			$('#direccionClienteCambiarDireccion').attr('disabled', true);
			
			limpiarInputsCambiarDireccion();
			$('#modalCambiarDireccion').modal('show');
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/cliente/cliente/recuperarDatosCliente/' + documentoPersonaCliente,
				dataType: 'json',
				success: function(response) {
					console.log(response);
					$('#myModalLabelCambiarDireccion').html('Cliente: ' + response.apellidoPaternoCliente + ' ' + response.apellidoMaternoCliente + ', ' + response.nombresCliente);
					$('#documentoPersonaClienteCambiarDireccion').val(response.documentoPersonaCliente);
					$('#nombreClienteCambiarDireccion').val(response.nombresCliente);
					$('#apellidoPaternoClienteCambiarDireccion').val(response.apellidoPaternoCliente + ' ' + response.apellidoMaternoCliente);
					$('#direccionClienteCambiarDireccion').val(response.direccionActualCliente);
				}
			});
		});
	}
	
	/**
	 * function para cargar combo lista vendedores
	 * 
	 * */
	function cargarComboListaVendedoresCambio() {
		
		$vendedorResponsableCambio = $('#vendedorResponsableCambio');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/vendedor/vendedores',
			dataType: 'json',
			success: function(response) {
				console.log(response);
				$vendedorResponsableCambio.html('');
				$vendedorResponsableCambio.append('<option value="">Seleccione un  Vendedor Responsable</option>');
				for(var i = 0; i < response.length; i++) {
					$vendedorResponsableCambio.append('<option value="' + response[i].vendedor + '">' + response[i].vendedor + '</option>');
				}
			}
		});
	}
	
	/**
	 * 
	 *realizar evento guardarCambioDireccion 
	 * 
	 */
	function guardarCambioDireccion() {
		
		$('#guardarDatosCambiarDireccion').on('click', function(e) {
			e.preventDefault();
			
			if($('#nuevaDireccionCliente').val() != "" && $('#fechaSugerenciaCambiarDireccion').val() != "" && $('#vendedorResponsableCambio').val().trim() != "") {
				
				var formDataCambiarDireccion = {
						documentoPersonaCliente: $('#documentoPersonaClienteCambiarDireccion').val(),
						nuevaDireccion: $('#nuevaDireccionCliente').val(),
						observacionCuenta: $('#observacionCambiarDireccion').val(),
						vendedorResponsable: $('#vendedorResponsableCambio').val(),
						fechaElegida: $('#fechaSugerenciaCambiarDireccion').val()
				};
				console.log(formDataCambiarDireccion);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/cliente/cliente/cambiarDomicilio',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataCambiarDireccion),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						
						swal({
							type: "success",
							title: "Direccion del Cliente Actualizada con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/persona/view');
							}
						});
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Direccion del Cliente !'
			            });
					}
				});
			}
			
			if($('#nuevaDireccionCliente').val() == "" && $('#fechaSugerenciaCambiarDireccion').val() == "" && $('#vendedorResponsableCambio').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar todos los Campos !'
	            });
			
				return false;
				
			}
			else {
				if($('#nuevaDireccionCliente').val() == "") {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Nueva Direccion no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#nuevaDireccionCliente').focus();
			    	return false;
				}
				
				if($('#fechaSugerenciaCambiarDireccion').val() == "") {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Fecha Sugerencia no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#fechaSugerenciaCambiarDireccion').focus();
			    	return false;
				}
				
				if($('#vendedorResponsableCambio').val().trim() == "") {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe Seleccionar un Vendedor Responsable !'
		            });
					return false;
				}
			}
		});
	}
	
	/**
	 * 
	 *function validarFormDatosPersonaCliente 
	 * 
	 */
	function validarFormDatosPersonaCliente() {
		
		$('#guardarDatosClientePersona').on('click', function(e) {
			e.preventDefault();
			
			if($('#nombreClientePersona').val() == "" && $('#apellidoPaternoClientePersona').val() == "" && $('#apellidoMaternoClientePersona').val() == ""
				&& $('#telefonoUnoClientePersona').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar algunos Campos !'
	            });
			
				return false;
			}
			else {
				
				if($('#nombreClientePersona').val() == "" || $('#nombreClientePersona').val() == 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Nombre Persona no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#nombreClientePersona').focus();
			    	return false;
				}
				
				if($('#apellidoPaternoClientePersona').val() == "" || $('#apellidoPaternoClientePersona').val() == 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Paterno Persona no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#apellidoPaternoClientePersona').focus();
			    	return false;
				}
				
				if($('#apellidoMaternoClientePersona').val() == "" || $('#apellidoMaternoClientePersona').val() == 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Materno Persona no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#apellidoMaternoClientePersona').focus();
			    	return false;
				}
				
				if($('#telefonoUnoClientePersona').val() == "" || $('#telefonoUnoClientePersona').val() == 0) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Telefono o Celular no puede estar vacio, ingrese un valor valido'
		            });
			    	
			    	$('#telefonoUnoClientePersona').focus();
			    	return false;
				}
				
				if(!($('#nombreClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Nombre no permite caracteres especiales ni numeros'
		            });
					
					$('#nombreClientePersona').val('');
					$('#nombreClientePersona').focus();
			    	return false;
				}
				
				if(!($('#apellidoPaternoClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Paterno no permite caracteres especiales ni numeros'
		            });
					
					$('#apellidoPaternoClientePersona').val('');
					$('#apellidoPaternoClientePersona').focus();
			    	return false;
				}
				
				if(!($('#apellidoMaternoClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Apellido Materno no permite caracteres especiales ni numeros'
		            });
					
					$('#apellidoMaternoClientePersona').val('');
					$('#apellidoMaternoClientePersona').focus();
			    	return false;
				}
				
				if(!($('#telefonoUnoClientePersona').val().match(/^[0-9]{7,9}$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Telefono o Celular Uno no permite caracteres especiales, ni letras'
		            });
			    	
					$('#telefonoUnoClientePersona').val('');
			    	$('#telefonoUnoClientePersona').focus();
			    	return false;
				}
			}
		});
		
		/**
		 * 
		 * Evento change para el input Telefono 2
		 * 
		 * */
		$('#telefonoDosClientePersona').on('change', function() {
			
			if(!($('#telefonoDosClientePersona').val().match(/^[0-9]{7,9}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Telefono o Celular Dos no permite caracteres especiales, ni letras'
	            });
		    	
				$('#telefonoDosClientePersona').val('');
		    	$('#telefonoDosClientePersona').focus();
		    	return false;
			}
		});
		
		$('#telefonoTresClientePersona').on('change', function() {
			
			if(!($('#telefonoTresClientePersona').val().match(/^[0-9]{7,9}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Telefono o Celular Tres no permite caracteres especiales, ni letras'
	            });
		    	
				$('#telefonoTresClientePersona').val('');
		    	$('#telefonoTresClientePersona').focus();
		    	return false;
			}
		});
	}
	
	/**
	 * 
	 *function guardar datos clientePersona 
	 * 
	 */
	function guardarDatosClientePersona() {
		
		$('#guardarDatosClientePersona').on('click', function(e) {
			e.preventDefault();
			
			if($('#nombreClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#apellidoPaternoClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/)
					&& $('#apellidoMaternoClientePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#telefonoUnoClientePersona').val().match(/^[0-9]{7,9}$/)) {
				
				var formDataDatosPersonaCliente = {
						documentoPersonaCliente: $('#documentoPersonaClientePersona').val(),
						apellidoPaternoCliente: $('#apellidoPaternoClientePersona').val(),
						apellidoMaternoCliente: $('#apellidoMaternoClientePersona').val(),
						nombrePersonaCliente: $('#nombreClientePersona').val(),
						telefonoUnoCliente: $('#telefonoUnoClientePersona').val(),
						telefonoDosCliente: $('#telefonoDosClientePersona').val(),
						telefonoTresCliente: $('#telefonoTresClientePersona').val()
				};
				
				console.log(formDataDatosPersonaCliente);
				
				$.ajax({
					
					type: 'PUT',
					url: '/api/v1/cliente/updatePersonaCliente',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataDatosPersonaCliente),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						
						if(response.status == 'SUCCESS' && response.message == 'HECHO') {
							
							swal({
								type: "success",
								title: "Datos de la Persona Actualizado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/persona/view');
								}
							});
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Datos de la Persona !'
			            });
					}
				});
			}
		});
	}
	
	function cargarEstadoCliente() {
		
		var estadoCliente = $('.estadoCliente');
		for(var i=0; i < estadoCliente.length; i++) {
			var data = tablaClientes.row( $(estadoCliente[i]).parents("tr")).data();
			if(data.estado == true) {
				$(estadoCliente[i]).attr("class", "label label-success");
				$(estadoCliente[i]).html('Activo');
			}
			else if(data.estado == false) {
				$(estadoCliente[i]).attr("class", "label label-danger");
				$(estadoCliente[i]).html('Inactivo');
			}
		}
	}
	
	function ocultarBotones() {
		
		var btnVerCliente = $('.btnVerCliente');
		for(var i=0; i < btnVerCliente.length; i++) {
			var data = tablaClientes.row( $(btnVerCliente[i]).parents("tr")).data();
			if(data.estado == true) {
				$(btnVerCliente[i]).attr("style", "display:block");
			}
			else if(data.estado == false) {
				$(btnVerCliente[i]).attr("style", "display:none");
			}
		}
		
		var btnEditarCliente = $('.btnEditarCliente');
		for(var i=0; i < btnEditarCliente.length; i++) {
			var data = tablaClientes.row( $(btnEditarCliente[i]).parents("tr")).data();
			if(data.estado == true) {
				$(btnEditarCliente[i]).attr("style", "display:block");
			}
			else if(data.estado == false) {
				$(btnEditarCliente[i]).attr("style", "display:none");
			}
		}
		
		var btnDeshabilitarCliente = $('.btnDeshabilitarCliente');
		for(var i=0; i < btnDeshabilitarCliente.length; i++) {
			var data = tablaClientes.row( $(btnDeshabilitarCliente[i]).parents("tr")).data();
			if(data.estado == true) {
				$(btnDeshabilitarCliente[i]).attr("style", "display:block");
			}
			else if(data.estado == false) {
				$(btnDeshabilitarCliente[i]).attr("style", "display:none");
			}
		}
		
		var btnHabilitarCliente = $('.btnHabilitarCliente');
		for(var i=0; i < btnHabilitarCliente.length; i++) {
			var data = tablaClientes.row( $(btnHabilitarCliente[i]).parents("tr")).data();
			if(data.estado == true) {
				$(btnHabilitarCliente[i]).attr("style", "display:none");
			}
			else if(data.estado == false) {
				$(btnHabilitarCliente[i]).attr("style", "display:block");
			}
		}
	}
	
	/**
	 * 
	 *Funcion para limpiar modal 
	 * 
	 */
	function limpiarModalCliente() {
		
		$('#myModalLabelCliente').html('');
		$('#detalleClienteDocumento').val('');
		$('#detalleClienteNombre').val('');
		$('#detalleClienteDireccionActual').val('');
		$('#detalleClienteTelefonoUno').val('');
		$('#detalleCodigoCliente').val('');
		$('#detalleClienteNombreComercial').val('');
		$('#detalleClienteCorreoElectronico').val('');
		$('#detalleClienteFacebook').val('');
	}
	
	/**
	 * 
	 *Ver detalles del Cliente
	 * 
	 */
	$('#tablaClientes tbody').on('click', 'button.btnVerCliente', function(){
		
		var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
		
		$('#modalDetalleCliente').modal('show');
		limpiarModalCliente();
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaCliente,
			dataType: 'json',
			success: function(response) {
				
				$('#myModalLabelCliente').html('Cliente : ' + response.nombrePersona + ' ' + response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
				$('#detalleClienteDocumento').val(response.documentoPersona);
				$('#detalleClienteNombre').val(response.nombrePersona + ' ' + response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
				$('#detalleClienteDireccionActual').val(response.direccionActualPersona);
				$('#detalleClienteTelefonoUno').val(response.telefonoUnoPersona);
			}
		});
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/cliente/cliente/' + documentoPersonaCliente,
			dataType: 'json',
			success: function(response) {
				
				$('#detalleCodigoCliente').val(response.codigoCliente);
				$('#detalleClienteNombreComercial').val(response.nombreComercialCliente);
				$('#detalleClienteCorreoElectronico').val(response.correoCliente);
				$('#detalleClienteFacebook').val(response.facebookCliente);
			}
		});
	});
	
	/**
	 * 
	 * Editar Cliente 
	 * 
	 */
	$('#tablaClientes tbody').on('click', 'button.btnEditarCliente', function() {
		
		var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
		
		mostrarFormCliente(true);
		accion = true;
		$('#documentoPersonaCliente').attr('disabled', true);
		$('#documentoPersonaCliente').val(documentoPersonaCliente);
		$('#clienteNombrePersona').attr('disabled', true);
		$('#clienteApellidosPersona').attr('disabled', true);
		$('#inputConsecutivoCliente').show();
		$('#inputCodigoCliente').show();
		$('#consecutivoCliente').attr('disabled', true);
		$('#codigoCliente').attr('disabled', true);
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaCliente,
			dataType: 'json',
			success: function(response) {
			
				$('#clienteNombrePersona').val(response.nombrePersona);
				$('#clienteApellidosPersona').val(response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
			}
		});
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/cliente/cliente/' + documentoPersonaCliente,
			dataType: 'json',
			success: function(response) {
			
				$('#consecutivoCliente').val(response.consecutivoCliente);
				$('#codigoCliente').val(response.codigoCliente);
				$('#nombreComercialCliente').val(response.nombreComercialCliente);
				$('#correoCliente').val(response.correoCliente);
				$('#facebookCliente').val(response.facebookCliente);
				$("#codigoSexo option[value="+ response.sexo.codigoSexo +"]").attr("selected",true);
			}
		});
	});
	
	/**
	 * 
	 * Evento para deshabilitar Cliente
	 * 
	 */
	$('#tablaClientes tbody').on('click', 'button.btnDeshabilitarCliente', function() {
		
		var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
		
		
		swal({
	        title: '¿Esta Seguro de deshabilitar a este Cliente ?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si!'
	    }).then((result) => {
	        if(result.value){
	           
	        	 $.ajax({
	                 url: '/api/v1/cliente/cliente/disabled/' + documentoPersonaCliente,
	                 type: 'GET',
	                 success: function(response){
	                	 
	                	 
	                     swal({
	                         type: "success",
	                         title: "El Cliente ha sido deshabilitado correctamente",
	                         showConfirmButton: true,
	                         confirmButtonText: "Cerrar",
	                         closeOnConfirm: false
	                     }).then((result) => {
	                         if(result.value) {
	                             $(location).attr("href", "/persona/view");
	                         }
	                     })
	                 }
	             });
	        }
	        else {
	            swal({
	                type: "error",
	                title: "Cancelado", 
	                text: "Usted ha cancelado la acción de deshabilitar"
	            });
	        }
	    });
		
	});
	
	/**
	 *
	 * Evento para habilitar el Cliente
	 * 
	 */
	$('#tablaClientes tbody').on('click', 'button.btnHabilitarCliente', function() {
		
		var documentoPersonaCliente = $(this).attr('idDocumentoCliente');
		
		swal({
	        title: '¿Esta Seguro de habilitar a este Cliente ?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si!'
	    }).then((result) => {
	        if(result.value){
	           
	        	$.ajax({
	        		
	        		url: '/api/v1/cliente/cliente/enabled/' + documentoPersonaCliente,
	        		type: 'GET',
	        		success: function(response){
	        			        			
	        			swal({
	        				type: "success",
	                        title: "El Cliente ha sido habilitado correctamente",
	                        showConfirmButton: true,
	                        confirmButtonText: "Cerrar",
	                        closeOnConfirm: false
	                       }).then((result) => {
	                         if(result.value) {
	                            $(location).attr("href", "/persona/view");
	                        }
	                     })
	                 }
	        	});
	        }
	        else {
	            swal({
	                type: "error",
	                title: "Cancelado", 
	                text: "Usted ha cancelado la acción de habilitar"
	            });
	        }
	    });
	});
	
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
