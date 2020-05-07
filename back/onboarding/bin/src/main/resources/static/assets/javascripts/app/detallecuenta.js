$(document).on('ready', function() {
	
	disabledButtonGenerarCuenta(true);
	
	disabledInputs(false);
	
	buscarCliente();
	
	cargarTotalRegistrosPersonita();
	
	ocultar_mostrar(50);
	
	validarFormGenerarCuenta();
	
	cargarComboVendedores();
	
	listarCuentasGeneradas();
	
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
	
	comboServicio(); 
	
	/**
	 * 
	 *function para listar las cuentas generadas 
	 * 
	 */
	function listarCuentasGeneradas() {
		
		$('#listaCuentasGeneradas').on('click', function() {
			$(location).attr('href', '/detalleCuenta/cuentas/view');
		});
	}
	
	/**
	 * 
	 *Funcion para deshabilitar inicialmente el boton guardar cuenta 
	 */
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
	
	function disabledButtonGenerarCuenta(flag) {
		
		if(flag) {
			$('#generarCuenta').attr('disabled', true);
			$('#cancelarAccion').attr('disabled', true);
		}
		else {
			$('#generarCuenta').attr('disabled', false);
			$('#cancelarAccion').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 *Limpiar formulario 
	 * 
	 */
	function limpiarForm() {
		$('#documentoPersonaCliente').val('');
		$('#detalleCuentaCliente').val('');
		$('#detalleCuentaDireccion').val('');
		$('#detalleCuentaReferenciaDireccion').val('');
		$('#detalleCuentaAnio').val('');
		$('#detalleCuentaObservacion').val('');
	}
	
	/**
	 * 
	 *funcion para deshabilitar los inputs 
	 * 
	 */
	function disabledInputs(flag) {
		
		if(flag) {
			$('#documentoPersonaCliente').attr('disabled', true);
			$('#detalleCuentaCliente').attr('disabled', true);
			$('#detalleCuentaDireccion').attr('disabled', true);
			$('#detalleCuentaReferenciaDireccion').attr('disabled', true);
			$('#detalleCuentaAnio').attr('disabled', true);
		}
		else {
			$('#documentoPersonaCliente').attr('disabled', false);
			$('#detalleCuentaCliente').attr('disabled', false);
			$('#detalleCuentaDireccion').attr('disabled', false);
			$('#detalleCuentaReferenciaDireccion').attr('disabled', false);
			$('#detalleCuentaAnio').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 *funcion para cancelar acciones 
	 * 
	 */
	function cancelarAccion() {
		$('#cancelarAccion').on('click', function() {
			limpiarForm();
			disabledInputs(true);
			disabledButtonGenerarCuenta(true);
		});
	}
	
	/**
	 *
	 * Funcion para buscar cliente por
	 * 
	 */
	function buscarCliente() {
		
		$('#buscarCliente').on('click', function(e) {
			e.preventDefault();
			
			if($('#busqueda').val().match(/^[0-9\.-\s]{7,12}$/)) {
				
				var formData = {
						documentoPersona: $('#busqueda').val()
				};
						
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/cliente/searchCliente',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
		
						console.log(response);
						if(response != null) {				
							$('#documentoPersonaCliente').val(response.documentoPersona);
							$('#detalleCuentaCliente').val(response.cliente);
							$('#detalleCuentaDireccion').val(response.direccionPersona);
							$('#detalleCuentaReferenciaDireccion').val(response.referenciaPersona);
							$('#detalleCuentaAnio').val(response.anio);
							disabledInputs(true);
						}
						else if(response == null) {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'No se encontro al Cliente, verifique si existe!'
				            });
							
							disabledInputs(false);
							limpiarForm();
						}
						
						$('#busqueda').val('');
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Buscar Cliente !'
			            });
					}
				});
			}
			if(!($('#busqueda').val().match(/^[0-9\.-\s]{7,12}$/))) {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido de DNI/RUC para realizar la busqueda'
	            });
				$('#busqueda').val('');
				$('#busqueda').focus();
		    	return false;
			}
		});
	}
	
	/***
	 * 
	 *function para verificar que el cliente se registro  
	 * 
	 */
	function verificarCliente() {
		
		$('#generarCuenta').on('click', function(e) {
			
			e.preventDefault();
			if($('#documentoPersonaCliente').val() == "" && $('#detalleCuentaCliente').val() == ""
				&& $('#detalleCuentaDireccion').val() == "" && $('#detalleCuentaReferenciaDireccion').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe Ingresar un  Cliente !'
	            });
			}
		});
	}
	
	/**
	 * 
	 *function para validarFormGenerarCuenta 
	 * 
	 */
	function validarFormGenerarCuenta() {
		
		$('#generarCuenta').on('click', function(e) {
			
			e.preventDefault();
			
			if($('#fechaSolicitudClienteDetalleCuenta').val() == "" && $('#detalleCuentaVendedor').val().trim() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar todos los Campos !'
	            });
				return false;
			}
			
			else if($('#fechaSolicitudClienteDetalleCuenta').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para la Fecha de Solicitud'
	            });
				return false;
			}
			else if($('#detalleCuentaVendedor').val().trim() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe Seleccionar un Vendedor Responsable'
	            });
				return false;
			}
		});
	}
	
	/**
	 *
	 * cargar combo vendedores
	 * 
	 */
	function cargarComboVendedores() {
		
		var $detalleCuentaVendedor = $('#detalleCuentaVendedor');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/vendedor/vendedores',
			dataType: 'json',
			success: function(response) {
				$detalleCuentaVendedor.html('');
				$detalleCuentaVendedor.append('<option value="">Seleccione un  Vendedor Responsable</option>');
				for(var i = 0; i < response.length; i++) {
					$detalleCuentaVendedor.append('<option value="'+ response[i].vendedor +'">'+ response[i].vendedor +'</option>');
				}
			}
		});
	}
	
	/**
	 * 
	 *funcion para generarCuentaInternetColor 
	 * 
	 */
	function generarCuentaInternetColor() {
		
		$('#generarCuenta').on('click', function(e) {
			
			e.preventDefault();
			if($('#documentoPersonaCliente').val().match(/^[0-9\.-\s]{7,12}$/) && $('#fechaSolicitudClienteDetalleCuenta').val() != "" 
				&& $('#detalleCuentaVendedor').val().trim() != "") {
				
				var formDataIC = {
						documentoPersonaCliente: $('#documentoPersonaCliente').val(),
						observacionDetalleCuenta: $('#detalleCuentaObservacion').val(),
						fechaSolicitudClienteDetalleCuenta: $('#fechaSolicitudClienteDetalleCuenta').val(),
						nombreVendedor: $('#detalleCuentaVendedor').val()
				};
				console.log(formDataIC);
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/detalleCuenta/saveCuentaInternet',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataIC),
					dataType: 'json',
					success: function(response) {
						
						if(response.status == "CREATED" && response.message == "HECHO") {
							
							swal({
								type: "success",
								title: "Se Genero la Cuenta de Internet con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/detalleCuenta/cuentas/view');
								}
							});
						}
						else if(response.status == "ERROR" && response.message == "SERVICIO OPERANDO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ya se Genero la Cuenta de Internet para el Cliente, verifique el estado del Servicio !'
				            });
						}
						else if(response.status == "ERROR" && response.message == "LLENO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Dia Ocupado Totalmente, instalaciones del dia completados !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Generar Cuenta de Internet !'
			            });
					}
				});
			}
		});
	}
	
	/**
	 * 
	 * function para generarCuentaDuo
	 * 
	 */
	function generarCuentaDuo() {
		
		$('#generarCuenta').on('click', function(e) {
			
			e.preventDefault();
			if($('#documentoPersonaCliente').val().match(/^[0-9\.-\s]{7,12}$/) && $('#fechaSolicitudClienteDetalleCuenta').val() != "" 
				&& $('#detalleCuentaVendedor').val().trim() != "") {
				
				var formDataDuo = {
						documentoPersonCliente: $('#documentoPersonaCliente').val(),
						observacionDetalleCuenta: $('#detalleCuentaObservacion').val(),
						fechaSolicitudClienteDetalleCuenta: $('#fechaSolicitudClienteDetalleCuenta').val(), 
						nombreVendedor: $('#detalleCuentaVendedor').val()
				};
				console.log(formDataDuo);
				$.ajax({
					type: 'POST',
					url: '/api/v1/detalleCuenta/saveCuentaDuo',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataDuo),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						if(response.status == "CREATED" && response.message == "HECHO") {	
							swal({
								type: "success",
								title: "Se Genero la Cuenta de Duo con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/detalleCuenta/generarCuenta/view');
								}
							});
						}
						else if(response.status == "ERROR" && response.message == "SERVICIO OPERANDO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ya se Genero la Cuenta de Duo para el Cliente, verifique el estado del Servicio !'
				            });
						}
					},
					error: function() {	
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Generar Cuenta de Duo !'
			            });
					}
				});
			}
		});
	}
	
	/**
	 * 
	 *funcion para generarCuentaCableColor 
	 * 
	 */
	function generarCuentaCableColor() {
		
		$('#generarCuenta').on('click', function(e) {
			
			e.preventDefault();
			if($('#documentoPersonaCliente').val().match(/^[0-9\.-\s]{7,12}$/) && $('#fechaSolicitudClienteDetalleCuenta').val() != "" 
				&& $('#detalleCuentaVendedor').val().trim() != "") {
				
				var formDataCC = {
						documentoPersonaCliente: $('#documentoPersonaCliente').val(),
						observacionDetalleCuenta: $('#detalleCuentaObservacion').val(),
						fechaSolicitudClienteDetalleCuenta: $('#fechaSolicitudClienteDetalleCuenta').val(),
						nombreVendedor: $('#detalleCuentaVendedor').val()
				};
				console.log(formDataCC);
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/detalleCuenta/saveCuentaCable',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataCC),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						if(response.status =="CREATED" && response.message == "HECHO") {
							
							swal({
								type: "success",
								title: "Se Genero la Cuenta de Cable con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/detalleCuenta/generarCuenta/view');
								}
							});
						}
						else if(response.status == "ERROR" && response.message == "SERVICIO OPERANDO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ya se Genero la Cuenta de Cable para el Cliente, verifique el estado del Servicio !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Generar Cuenta de Cable !'
			            });
					}
				});
			}
		});
	}
	
	/**
	 * 
	 *funcion para el combo de servicios 
	 * 
	 */
	function comboServicio() {
		
		var $tipoServicio = $('#tipoServicio');
		
		$tipoServicio.on('change', function() {
			
			if($tipoServicio.val() == "") {
				limpiarForm();
				disabledInputs(false);
				disabledButtonGenerarCuenta(true);
			}
			else if($tipoServicio.val() == "IC") {
				limpiarForm();
				disabledInputs(true);
				disabledButtonGenerarCuenta(false);
				cancelarAccion();
				verificarCliente();
				generarCuentaInternetColor();
			}
			else if($tipoServicio.val() == 'CC') {
				limpiarForm();
				disabledInputs(true);
				disabledButtonGenerarCuenta(false);
				cancelarAccion();
				verificarCliente();
				generarCuentaCableColor();
			}
			else if($tipoServicio.val() == 'DUO') {
				limpiarForm();
				disabledInputs(true);
				disabledButtonGenerarCuenta(false);
				cancelarAccion();
				verificarCliente();
				generarCuentaDuo();
			}
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