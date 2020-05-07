
$(document).on('ready', function() {
	
	var flag;
	
	setTimeout(function() {
		 mostrarForm(false);
		 mostrarFormPersona(false);
	}, 1000);
	
	ocultar_mostrar(50);
	
	setTimeout(function() {
		cargarEstadEmpleado();
		ocultarBotones();
	}, 9000);
	
	setTimeout(function(){
		cargarEstado();
	}, 9000);
	
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
	
	cargarComboUbigeo();
	
	cargarComboCargo();
	
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
	
	function limpiar() {
		$('#codigoEmpleado').val('');
		$('#documentoPersonaEmpleado').val('');
		$('#empleadoNombrePersona').val('');
		$('#empleadoApellidosPersona').val('');
		$('#codigoCargo').val('');
	}
	
	function limpiarPersona() {
		$('#documentoPersona').val('');
		$('#codigoUbigeo').val('');
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
	
	function mostrarForm(flag) {
		
		limpiar();
		if(flag) {
			$('#listadoPersonasEmpleadosRegistro').hide();
			$('#formularioEmpleadosRegistro').show();
		}
		else {
			$('#listadoPersonasEmpleadosRegistro').show();
			$('#formularioEmpleadosRegistro').hide();
		}
	}
	
	function mostrarFormPersona(flag) {
		
		limpiarPersona();
		if(flag) {
			$('#listadoPersonasEmpleadosRegistro').hide();
			$('#formularioPersonaEmpleadosRegistro').show();
		}
		else {
			$('#listadoPersonasEmpleadosRegistro').show();
			$('#formularioPersonaEmpleadosRegistro').hide();
		}
	}
	
	function cancelarForm() {
		limpiar();
		mostrarForm(false);
	}
	
	function cancelarFormPersona() {
		limpiarPersona();
		mostrarFormPersona(false);
	}
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/persona/personas/listaPersonasNoEmpleados',
		dataType: 'json',
		success: function(response){
			
		}
	});
	
	$('#btnAgregarPersonaEmpleado').on('click', function(){
		mostrarFormPersona(true);
		$('#documentoPersona').attr('disabled', false);
		flag = false;
	});
	
	$('#cancelarAccion').on('click', function(){
		cancelarFormPersona();
	});
	
	/**
	 * 
	 * Funcion para cargar el combo ubigeo
	 * 
	 * */
	
	function cargarComboUbigeo() {
		
		var $codigoUbigeo = $('#codigoUbigeo');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/ubigeo/ubigeos',
			dataType: 'json',
			success: function(response) {
			
				$codigoUbigeo.html('');
				$codigoUbigeo.append('<option value="">Seleccione un Ubigeo</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoUbigeo.append('<option value="'+ response[i].codigoUbigeo+'">'+ response[i].codigoUbigeo + ' - ' + response[i].nombreUbigeo +'</option>');
				}
			}
		});
	}
	
	$('#guardarPersona').on('click', function(e) {
		e.preventDefault();
		
		if($('#documentoPersona').val().match(/^[0-9]{7,11}$/) && $('#codigoUbigeo').val().trim() != ""
			&& $('#nombrePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#apellidoPaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/)
			&& $('#apellidoMaternoPersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/) && $('#direccionActualPersona').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\#.-\s]+$/)
			&& $('#referenciaPersona').val().match(/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ\#.-\s]+$/) && $('#telefonoUnoPersona').val().match(/^[0-9]{7,9}$/)) {
			
			var formData = {
					documentoPersona: $('#documentoPersona').val(),
					ubigeo: {
						codigoUbigeo: $('#codigoUbigeo').val()
					},
					nombrePersona: $('#nombrePersona').val(),
					apellidoPaternoPersona: $('#apellidoPaternoPersona').val(),
					apellidoMaternoPersona: $('#apellidoMaternoPersona').val(),
					direccionReniecPersona: $('#direccionReniecPersona').val(),
					direccionActualPersona: $('#direccionActualPersona').val(),
					referenciaPersona: $('#referenciaPersona').val(),
					telefonoUnoPersona: $('#telefonoUnoPersona').val(),
					telefonoDosPersona: $('#telefonoDosPersona').val(),
					telefonoTresPersona: $('#telefonoTresPersona').val()
			};
			
			if(flag == true) {
				
				$.ajax({
					
					type: 'PUT',
					url: '/api/v1/persona/update',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response){
						
						
						if(response.status == "UPDATED") {
							
							swal({
								type: "success",
								title: "Persona Actualizado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/empleado/view');
								}
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
			
			if(flag == false) {
				
				$.ajax({
					
					type:'POST',
					url: '/api/v1/persona/save',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response){
						
						
						if(response.status == 'CREATED') {
							
							swal({
								type: "success",
								title: "Persona: " + response.data.nombrePersona + " Registrado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/empleado/view');
								}
							});
						}
						else if(response.status == 'ERROR') { 
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Registrar a la Persona: '+ response.data.nombrePersona +', verifique si ya existe !'
				            });
							
							limpiarPersona();
						}
					},
					error: function(){
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Persona !'
			            });
					}
				});
			}
		}
		
		if($('#documentoPersona').val() == "" && $('#codigoUbigeo').val().trim() == "" && $('#nombrePersona').val() == ""
			&& $('#apellidoPaternoPersona').val() == "" && $('#apellidoMaternoPersona').val() == "" && $('#direccionActualPersona').val() == ""
				&& $('#referenciaPersona').val() == "" && $('#telefonoUnoPersona').val() == "") {
			
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
			
			if(!($('#documentoPersona').val().match(/^[0-9]{7,11}$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Numero Documento no permite caracteres especiales ni letras'
	            });
				
				$('#documentoPersona').val('');
				$('#documentoPersona').focus();
		    	return false;
			}
			else if(!($('#nombrePersona').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$/))) {
				
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
	
	var tablaPersonas = $('#tablaPersonasEmpleados').dataTable({
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
			"url": "/api/v1/persona/personas/listaPersonasNoEmpleados",
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
			{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnAgregarPersonaEmpleado" idDocumentoPersona><i class="fa fa-users"></i> Añadir a Empleados</button>'},
			{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-info btn-xs btnEditarPersonaEmpleado" idDocumentoPersona><i class="fa fa-pencil" title="Editar"></i></button></div>'}
		]
	}).DataTable();
	
	$('#tablaPersonasEmpleados tbody').on('click', 'button', function() {
		var data = tablaPersonas.row( $(this).parents('tr')).data();
		$(this).attr('idDocumentoPersona', data.documentoPersona);
	});
	
	/**
	 * 
	 *Evento para editar Persona
	 * 
	 */
	$('#tablaPersonasEmpleados tbody').on('click', 'button.btnEditarPersonaEmpleado', function(){
		var documentoPersonaEmpleado = $(this).attr('idDocumentoPersona');
		
		mostrarFormPersona(true);
		$('#documentoPersona').attr('disabled', true);
		$('#documentoPersona').val(documentoPersonaEmpleado);
		flag = true;
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
				
				$("#codigoUbigeo option[value="+ response.ubigeo.codigoUbigeo +"]").attr("selected",true);
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
	
	/**
	 * 
	 * Evento para agregar empleado
	 * 
	 * */
	
	$('#tablaPersonasEmpleados tbody').on('click', 'button.btnAgregarPersonaEmpleado', function() {
		var documentoPersonaEmpleado = $(this).attr('idDocumentoPersona');
		
		mostrarForm(true);
		$('#documentoPersonaEmpleado').attr('disabled', true);
		$('#documentoPersonaEmpleado').val(documentoPersonaEmpleado);
		$('#empleadoNombrePersona').attr('disabled', true);
		$('#empleadoApellidosPersona').attr('disabled', true);
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
			
				$('#empleadoNombrePersona').val(response.nombrePersona);
				$('#empleadoApellidosPersona').val(response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
			}
		});
	});
	
	$('#cancelarAccionEmpleado').on('click', function() {
		cancelarForm();
	});
	
	/**
	 * 
	 * Funcion para cargar en el combo el cargo
	 */
	function cargarComboCargo() {
		
		var $codigoCargo = $('#codigoCargo');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/cargo/cargos',
			dataType: 'json',
			success: function(response){
			
				$codigoCargo.html('');
				$codigoCargo.append('<option value="">Seleccione un Cargo</option>');
				for(var i = 0; i < response.length; i++) {
					$codigoCargo.append('<option value="' + response[i].codigoCargo + '">' + response[i].descripcionCargo + '</option>');
				}
			}
		});
	}
	
	$('#guardarEmpleado').on('click', function(e) {
		e.preventDefault();
		
		if($('#codigoCargo').val().trim() != "") {
			
			var formData = {
				
					codigoEmpleado: $('#codigoEmpleado').val(),
					documentoPersonaEmpleado: $('#documentoPersonaEmpleado').val(),
					cargo: {
						codigoCargo: $('#codigoCargo').val()
					}
			};
			
			if(formData.codigoEmpleado) {
				codigoEmpleado = formData.codigoEmpleado;
				
				
				$.ajax({
					
					type: 'PUT',
					url: '/api/v1/empleado/update',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response){
						
						
						if(response.status == 'UPDATED') {
							
							swal({
								type: "success",
								title: "Empleado Actualizado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/empleado/view');
								}
							});
						}
					},
					error: function(response){
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Empleado !'
			            });
					}
				});
			}
			else {
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/empleado/save',
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
								title: "Empleado Registrado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/empleado/view');
								}
							});
						}
						else if(response.status == 'ERROR') {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Registrar al Empleado, verifique si ya existe !'
				            });
							limpiarPersona();
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Empleado !'
			            });
					}
				});
			}
		}
		
		if($('#codigoCargo').val().trim() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe seleccionar un Cargo'
            });
			
	    	return false;
		}
	});
	
	var tablaEmpleadosPlanta = $('#tablaEmpleadosPlanta').dataTable({
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
			"url": "/api/v1/empleado/empleados/listarEmpleadoINtExt",
			"dataSrc": ""
		},
		"columns": [
			{"data": "codigoempleado"},
			{"data": "documentopersonaempleado"},
			{"data": "empleadonombre"},
			{"data": "direccionempleado"},
			{"data": "telefonoprinciaplempleado"},
			{"data": "cargoempleado"},
			{ "defaultContent": '<span class="label label-success valueestado">Planta</span>'},
			{ "defaultContent": '<div class="btn-group"><button type="button" class="btn btn-success btnplantainterna btn-sm" codigoempleado ><i class="fa fa-times" title="Planta Interna"></i></button><button type="button" class="btn btn-warning btn-sm btnplantaexterna" codigoempleado documentopersonaempleado style="display:none;"><i class="fa fa-times" title="Planta Externa"></i></button><button type="button" class="btn btn-success btn-sm btnsinplanta" codigoempleado documentopersonaempleado style="display:none;"><i class="fa fa-check" title="Sin Planta - Interna"></i></button><button type="button" class="btn btn-warning btn-sm btnsinplantas" codigoempleado documentopersonaempleado style="display:none;"><i class="fa fa-check" title="Sin Planta - Externa"></i></button></div>' }
			
		]
	}).DataTable();
	
	$('#tablaEmpleadosPlanta tbody').on('click', 'button', function(){
		
		var data = tablaEmpleadosPlanta.row( $(this).parents('tr')).data();
		$(this).attr('codigoempleado', data.codigoempleado);
		$(this).attr('documentopersonaempleado', data.documentopersonaempleado);
		
	});
	
	$('#tablaEmpleadosPlanta tbody').on('click', 'button.btnplantainterna', function(){
		var codigoplantainterna = $(this).attr('documentopersonaempleado');
		
		
		swal({
	        title: '¿Esta Seguro de quitar al Empleado de la Planta Interna?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si, quitar de Planta Interna !'
	    }).then((result) => {
	    	if(result.value){

	        	 $.ajax({
	                 url: '/api/v1/empleado/plantaempleado/' + codigoplantainterna,
	                 type: 'GET',
	                 success: function(response){
	                	 
	                	
	                     swal({
	                         type: "success",
	                         title: "El Empleado: " + codigoplantainterna+ " ha sido quitado de la Planta Interna correctamente",
	                         showConfirmButton: true,
	                         confirmButtonText: "Cerrar",
	                         closeOnConfirm: false
	                     }).then((result) => {
	                         if(result.value) {
	                             $(location).attr("href", "/empleado/view");
	                         }
	                     })
	                 }
	             });
	    	}
	    	else {
	            swal({
	                type: "error",
	                title: "Cancelado", 
	                text: "Usted ha cancelado la acción de Quitar de Planta Interna"
	            });
	        }
	    });
	});
	
	$('#tablaEmpleadosPlanta tbody').on('click', 'button.btnplantaexterna', function(){
		var codigoplantaexterna = $(this).attr('documentopersonaempleado');
	
		
		swal({
	        title: '¿Esta Seguro de quitar al Empleado de la Planta Externa?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si, quitar de Planta Externa !'
	    }).then((result) => {
	    	if(result.value){

	        	 $.ajax({
	                 url: '/api/v1/empleado/plantaempleado/' + codigoplantaexterna,
	                 type: 'GET',
	                 success: function(response){
	                	 
	                
	                     swal({
	                         type: "success",
	                         title: "El Empleado: " + codigoplantaexterna+ " ha sido quitado de la Planta Externa correctamente",
	                         showConfirmButton: true,
	                         confirmButtonText: "Cerrar",
	                         closeOnConfirm: false
	                     }).then((result) => {
	                         if(result.value) {
	                             $(location).attr("href", "/empleado/view");
	                         }
	                     })
	                 }
	             });
	    	}
	    	else {
	            swal({
	                type: "error",
	                title: "Cancelado", 
	                text: "Usted ha cancelado la acción de Quitar de Planta Externa"
	            });
	        }
	    });
	});
	
	$('#tablaEmpleadosPlanta tbody').on('click', 'button.btnsinplanta', function(){
		var codigodocumento = $(this).attr('documentopersonaempleado');
		var tipoplantainterno = codigodocumento + 'NI';
		var valueestado = $('.valueestado');
		
		
		
				
				swal({
			        title: '¿Esta Seguro de agregar al Empleado a la Planta Interna?',
			        text: '¡Si no lo esta puede Cancelar la accion!',
			        type: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#3085d6',
			        cancelButtonColor: '#d33',
			        cancelButtonText: 'Cancelar',
			        confirmButtonText: '¡Si, agregar a la Planta Interna !'
			    }).then((result) => {
			    	if(result.value){

			        	 $.ajax({
			                 url: '/api/v1/empleado/plantaempleado/' + tipoplantainterno,
			                 type: 'GET',
			                 success: function(response){
			                	 
			              
			                     swal({
			                         type: "success",
			                         title: "El Empleado: " + tipoplantainterno + " ha sido guardado a la Planta Interna correctamente",
			                         showConfirmButton: true,
			                         confirmButtonText: "Cerrar",
			                         closeOnConfirm: false
			                     }).then((result) => {
			                         if(result.value) {
			                             $(location).attr("href", "/empleado/view");
			                         }
			                     })
			                 }
			             });
			    	}
			    	else {
			            swal({
			                type: "error",
			                title: "Cancelado", 
			                text: "Usted ha cancelado la acción de Agregar a la Planta Interna"
			            });
			        }
			    });
	});
	
	$('#tablaEmpleadosPlanta tbody').on('click', 'button.btnsinplantas', function(){
		var codigodocumento = $(this).attr('documentopersonaempleado');
		var tipoplantaexterno = codigodocumento + 'NE';
		var valueestado = $('.valueestado');
		
		
		
				
				swal({
			        title: '¿Esta Seguro de agregar al Empleado a la Planta Externa?',
			        text: '¡Si no lo esta puede Cancelar la accion!',
			        type: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#3085d6',
			        cancelButtonColor: '#d33',
			        cancelButtonText: 'Cancelar',
			        confirmButtonText: '¡Si, agregar a la Planta Externa !'
			    }).then((result) => {
			    	if(result.value){

			        	 $.ajax({
			                 url: '/api/v1/empleado/plantaempleado/' + tipoplantaexterno,
			                 type: 'GET',
			                 success: function(response){
			                	 
			                	
			                     swal({
			                         type: "success",
			                         title: "El Empleado: " + tipoplantaexterno + " ha sido guardado a la Planta Externa correctamente",
			                         showConfirmButton: true,
			                         confirmButtonText: "Cerrar",
			                         closeOnConfirm: false
			                     }).then((result) => {
			                         if(result.value) {
			                             $(location).attr("href", "/empleado/view");
			                         }
			                     })
			                 }
			             });
			    	}
			    	else {
			            swal({
			                type: "error",
			                title: "Cancelado", 
			                text: "Usted ha cancelado la acción de Agregar a la Planta Externa"
			            });
			        }
			    });
	});
	
	function cargarEstado(){
		
		var valueestado = $('.valueestado');
		var btnplantaexterna = $('.btnplantaexterna');
		var btnplantainterna = $('.btnplantainterna');
		var btnsinplanta = $('.btnsinplanta');
		var btnsinplantas = $('.btnsinplantas');
		for(var i=0; i < valueestado.length; i++) {
			var data = tablaEmpleadosPlanta.row($(valueestado[i]).parents('tr')).data();
			if(data.valueestado == 1) {
				$(valueestado[i]).attr("class", "label label-success");
				$(valueestado[i]).html('Planta Interna');
				$(btnplantaexterna[i]).attr('style', 'display:none');
				$(btnplantainterna[i]).attr('style', 'display:block');
				$(btnsinplanta[i]).attr('style', 'display:none');
				$(btnsinplantas[i]).attr('style', 'display:none');
			}
			if(data.valueestado == 2) {
				$(valueestado[i]).attr("class", "label label-warning");
				$(valueestado[i]).html('Planta Externa');
				$(btnplantaexterna[i]).attr('style', 'display:block');
				$(btnplantainterna[i]).attr('style', 'display:none');
				$(btnsinplanta[i]).attr('style', 'display:none');
				$(btnsinplantas[i]).attr('style', 'display:none');
			}
			if(data.valueestado == 0) {
				$(valueestado[i]).attr("class", "label label-info");
				$(valueestado[i]).html('Sin Planta');
				$(btnplantaexterna[i]).attr('style', 'display:none');
				$(btnplantainterna[i]).attr('style', 'display:none');
				$(btnsinplanta[i]).attr('style', 'display:block');
				$(btnsinplantas[i]).attr('style', 'display:block');
			}
		}
	}
	
	
	
	/**
	 * 
	 * 
	 * Tabla Empleados
	 *
	 */
	var tablaEmpleados = $('#tablaEmpleados').dataTable({
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
			"url": "/api/v1/empleado/empleados/listarPersonaEmpleado",
			"dataSrc": ""
		},
		"columns": [
			{"data": "codigoEmpleado"},
			{"data": "documentoPersonaEmpleado"},
			{"data": "cargo.descripcionCargo"},
			{"defaultContent": '<span class="label label-success estadoEmpleado">Activo</span>'},
			{"defaultContent": '<div class="btn-group"><button type="button" data-toggle="modal" class="btn btn-info btn-sm btnVerEmpleado" idDocumentoEmpleado><i class="fa fa-eye" title="Ver"></i></button><button type="button" class="btn btn-primary btn-sm btnEditarEmpleado" idDocumentoEmpleado><i class="fa fa-pencil" title="Editar"></i></button><button type="button" class="btn btn-danger btnDeshabilitarEmpleado btn-sm" idDocumentoEmpleado><i class="fa fa-times" title="Deshabilitar"></i></button><button type="button" class="btn btn-success btn-sm btnHabilitarEmpleado" idDocumentoEmpleado style="display:none;"><i class="fa fa-check" title="Habilitar"></i></button></div>'}
		]
		
	}).DataTable();
	
	/**
	 * 
	 * Asignar valor a los botones
	 * 
	 * */
	
	$('#tablaEmpleados tbody').on('click', 'button', function(){
		
		var data = tablaEmpleados.row( $(this).parents('tr')).data();
		$(this).attr('idDocumentoEmpleado', data.documentoPersonaEmpleado);
		
	});
	
	
	/**
	 * 
	 *funcion para cargar el estado del empleado
	 *
	 */
	function cargarEstadEmpleado() {
		var estadoEmpleado = $('.estadoEmpleado');
		for(var i = 0; i < estadoEmpleado.length; i++) {
			var data = tablaEmpleados.row( $(estadoEmpleado[i]).parents('tr')).data();
			if(data.estado == true) {
				$(estadoEmpleado[i]).attr('class', 'label label-success');
				$(estadoEmpleado[i]).html('Activo');
			}
			else if(data.estado == false) {
				$(estadoEmpleado[i]).attr('class', 'label label-danger');
				$(estadoEmpleado[i]).html('Inactivo');
			}
		}
	}
	
	/**
	 * 
	 *Funcion para ocultar botones segun el estado del empleado
	 * 
	 */
	function ocultarBotones() {
		
		var btnVerEmpleado = $('.btnVerEmpleado');
		for(var i = 0; i < btnVerEmpleado.length; i++) {
			var data = tablaEmpleados.row( $(btnVerEmpleado[i]).parents('tr')).data();
			if(data.estado == true) {
				$(btnVerEmpleado[i]).attr('style', 'display:block');
			}
			else if(data.estado == false) {
				$(btnVerEmpleado[i]).attr('style', 'display:none');
			}
		}
		
		var btnEditarEmpleado = $('.btnEditarEmpleado');
		for(var i = 0; i < btnEditarEmpleado.length; i++) {
			var data = tablaEmpleados.row( $(btnEditarEmpleado[i]).parents('tr')).data();
			if(data.estado == true) {
				$(btnEditarEmpleado[i]).attr('style', 'display:block');
			}
			else if(data.estado == false) {
				$(btnEditarEmpleado[i]).attr('style', 'display:none');
			}
		}
		
		var btnDeshabilitarEmpleado = $('.btnDeshabilitarEmpleado');
		for(var i = 0; i < btnDeshabilitarEmpleado.length; i++) {
			var data = tablaEmpleados.row( $(btnDeshabilitarEmpleado[i]).parents('tr')).data();
			if(data.estado == true) {
				$(btnDeshabilitarEmpleado[i]).attr('style', 'display:block');
			}
			else if(data.estado == false) {
				$(btnDeshabilitarEmpleado[i]).attr('style', 'display:none');
			}
		}
		
		var btnHabilitarEmpleado = $('.btnHabilitarEmpleado');
		for(var i = 0; i < btnHabilitarEmpleado.length; i++) {
			var data = tablaEmpleados.row( $(btnHabilitarEmpleado[i]).parents('tr')).data();
			if(data.estado == true) {
				$(btnHabilitarEmpleado[i]).attr('style', 'display:none');
			}
			else if(data.estado == false) {
				$(btnHabilitarEmpleado[i]).attr('style', 'display:block');
			}
		}
	}
	
	/**
	 * 
	 * Funcion limpiarModal
	 * 
	 */
	function limpiarModalEmpleado(){
		
		$('#myModalLabelEmpleado').html('');
		$('#detalleEmpleadoDocumento').val('');
		$('#detalleEmpleadoNombre').val('');
		$('#detalleEmpleadoDireccionActual').val('');
		$('#detalleEmpleadoTelefonoUno').val('');
		$('#detalleCodigoEmpleado').val('');
		$('#detalleCargoEmpleado').val('');
	}
	
	/**
	 * 
	 * Verr detalle Empleado
	 * 
	 */
	$('#tablaEmpleados tbody').on('click', 'button.btnVerEmpleado', function() {
		var documentoPersonaEmpleado = $(this).attr('idDocumentoEmpleado');
		$('#modalDetalleEmpleado').modal('show');
		limpiarModalEmpleado();
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
				
				$('#myModalLabelEmpleado').html('Empleado: ' + response.nombrePersona + ' ' + response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
				$('#detalleEmpleadoDocumento').val(response.documentoPersona);
				$('#detalleEmpleadoNombre').val(response.nombrePersona + ' ' + response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
				$('#detalleEmpleadoDireccionActual').val(response.direccionActualPersona);
				$('#detalleEmpleadoTelefonoUno').val(response.telefonoUnoPersona);
			}
		});
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/empleado/empleado/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
				
				$('#detalleCodigoEmpleado').val(response.codigoEmpleado);
				$('#detalleCargoEmpleado').val(response.cargo.descripcionCargo);
			}
		});
	});
	
	/**
	 * 
	 *Editar Empleado
	 * 
	 */
	$('#tablaEmpleados tbody').on('click', 'button.btnEditarEmpleado', function() {
		
		var documentoPersonaEmpleado = $(this).attr('idDocumentoEmpleado');
		
		
		mostrarForm(true);
		$('#documentoPersonaEmpleado').attr('disabled', true);
		$('#documentoPersonaEmpleado').val(documentoPersonaEmpleado);
		$('#empleadoNombrePersona').attr('disabled', true);
		$('#empleadoApellidosPersona').attr('disabled', true);
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/persona/persona/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
				
				$('#empleadoNombrePersona').val(response.nombrePersona);
				$('#empleadoApellidosPersona').val(response.apellidoPaternoPersona + ' ' + response.apellidoMaternoPersona);
			}
		});
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/empleado/empleado/' + documentoPersonaEmpleado,
			dataType: 'json',
			success: function(response){
				
				$('#codigoEmpleado').val(response.codigoEmpleado);
				$("#codigoCargo option[value="+ response.cargo.codigoCargo +"]").attr("selected",true);
			}
		});
	});
	
	/**
	 * 
	 *Evento para deshabilitar Empleado
	 * 
	 */
	 $('#tablaEmpleados tbody').on('click', 'button.btnDeshabilitarEmpleado', function(){
		
		var documentoPersonaEmpleado = $(this).attr('idDocumentoEmpleado');


		swal({
	        title: '¿Esta Seguro de deshabilitar a este Empleado ?',
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
	                 url: '/api/v1/empleado/empleado/disabled/' + documentoPersonaEmpleado,
	                 type: 'GET',
	                 success: function(response){
	                	 
	                	
	                     swal({
	                         type: "success",
	                         title: "El Empleado ha sido deshabilitado correctamente",
	                         showConfirmButton: true,
	                         confirmButtonText: "Cerrar",
	                         closeOnConfirm: false
	                     }).then((result) => {
	                         if(result.value) {
	                             $(location).attr("href", "/empleado/view");
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
	  * Evento para habilitar el empleado 
	  * 
	  */
	 $('#tablaEmpleados tbody').on('click', 'button.btnHabilitarEmpleado', function() {
		 var documentoPersonaEmpleado = $(this).attr('idDocumentoEmpleado');


		 swal({
		        title: '¿Esta Seguro de habilitar a este Empleado ?',
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
		        		
		        		url: '/api/v1/empleado/empleado/enabled/' + documentoPersonaEmpleado,
		        		type: 'GET',
		        		success: function(response){
		        			
		        			
		        			swal({
		        				type: "success",
		                        title: "El Empleado ha sido habilitado correctamente",
		                        showConfirmButton: true,
		                        confirmButtonText: "Cerrar",
		                        closeOnConfirm: false
		                       }).then((result) => {
		                         if(result.value) {
		                            $(location).attr("href", "/empleado/view");
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
