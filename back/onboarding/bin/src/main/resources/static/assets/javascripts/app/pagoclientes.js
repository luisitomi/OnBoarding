$(document).on('ready', function() {
	
	var tablaClientes;
	
	listarTablaClientes();
	 
	mostrarDatosPersonaCliente();
	 
	validarFormDatosPersonaCliente();
		
	guardarDatosClientePersona();
	  	  
	var flag;
	
	var accion;
	
	setTimeout(function() {
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
	
	function cancelarFormCliente() {
		limpiarClientes();
		mostrarFormCliente(false);
	}
		
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
				{"defaultContent": '<button type="button" data-toggle="modal" class="btn btn-warning btn-xs btnEditarDatosPersona" idDocumentoCliente><i class="fa fa-user" title="Editar"></i> Datos Persona</button>'}
			]
		}).DataTable();
		
		$('#tablaClientes tbody').on('click', 'button', function() {
			
			var data = tablaClientes.row( $(this).parents('tr')).data();
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
