$(document).on('ready', function() {
	
	var tablaPagosRealizadosGeneral;
	
	redireccionarViewPagos();
	
	listarPagosRealizados();
	
	mostrarFormRevalidarPago();
	
	cargarTotalRegistrosPersonita();
	
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
	
	cargarComboComprobante();
	
	validarFormRevalidarPago();
	
	guardarRevalidarPago();
	
	generarReciboPago();
	
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
	
	/**
	 * 
	 *function para redireccionar a la vista de pagos 
	 * 
	 */
	function redireccionarViewPagos() {
		
		$('#buttonVolverRegistroPago').on('click', function() {
			$(location).attr('href', '/pago/pagos');
		});
	}
	
	/**
	 *
	 * function listar pagos realizados
	 * 
	 */
	function listarPagosRealizados() {
		
		tablaPagosRealizadosGeneral = $('#tablaPagosRealizadosGeneral').dataTable({
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
				"url": "/api/v1/pago/pagosDelDia",
				"dataSrc": ""
			},
			"columns": [
				{"data": "codigoPago"},
				{"data": "descuento"},
				{"data": "cantidadPago"},
				{"data": "mesValido"},
				{"data": "anioValido"},
				{"data": "cliente"},
				{"data": "direccionActualCliente"},
				{"data": "fechaPagoDia"},
				{"defaultContent": '<button type="button" data-toggle="modal" class="btn btn-primary btn-xs btnRevalidarPago" codigoPago><i class="fa fa-money"></i> Revalidar Pago</button>'},
				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnGenerarReciboPago" codigoPago><i class="fa fa-file-pdf-o"></i> Generar Recibo</button>'}
			]
		}).DataTable();
		
		$('#tablaPagosRealizadosGeneral tbody').on('click', 'button', function() {
			var data = tablaPagosRealizadosGeneral.row( $(this).parents('tr')).data();
			$(this).attr('codigoPago', data.codigoPago);
		});
	}

	/**
	 * 
	 *function para generar recibo pago 
	 * 
	 */
	function generarReciboPago() {
		
		$('#tablaPagosRealizadosGeneral tbody').on('click', 'button.btnGenerarReciboPago', function() {
			
			var codigoPago = $(this).attr('codigoPago');
			$(this).attr('href','/api/v1/pago/generarRecibo/' + codigoPago);
			var url = $(this).attr('href');
			window.open(url, '_blank');
		     return false;
			console.log(url);
			
			console.log('codigoPago: ' + codigoPago);
		});
	}
	
	/**
	 * 
	 *function para mostrar el form revalidar Pago 
	 * 
	 */
	function mostrarFormRevalidarPago() {
		
		$('#tablaPagosRealizadosGeneral tbody').on('click', 'button.btnRevalidarPago', function() {
			
			var codigoPago = $(this).attr('codigoPago');
			console.log("codigoPago: " + codigoPago);
			$('#modalFormRevalidarPago').modal('show');
			$('#codigoPagoRevalidar').val(codigoPago);
		});
	}
	
	/**
	 *
	 * function para cargarComboComprobante
	 * 
	 */
	function cargarComboComprobante() {
		
		var $codigoComprobante = $('#codigoComprobanteRevalidar');
		
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
	 *function validar form revalidar pago 
	 * 
	 */
	function validarFormRevalidarPago() {
		
		$('#guardarPagoRevalidado').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobanteRevalidar').val().trim() == "" && $('#cantidadPagoRevalidar').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar algunos los Campos !'
	            });
				return false;
			}
			else {
				if($('#codigoComprobanteRevalidar').val().trim() == "") {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Debe seleccionar un Tipo de Comprobante !'
		            });
					return false;
				}
				
				if($('#cantidadPagoRevalidar').val() <= -1) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Ingrese un valor valido para el Monto a Pagar !'
		            });
					
					$('#cantidadPagoRevalidar').val('');
					$('#cantidadPagoRevalidar').focus();
					return false;
				}
			}
		});
		
		$('#cantidadPagoRevalidar').on('keyup', function() {
			
			var valor = $(this).val();
			
			if(parseInt(valor) <= -1) {
				
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
	 *function para guardar revalidar pago 
	 * 
	 */
	function guardarRevalidarPago() {
		
		$('#guardarPagoRevalidado').on('click', function(e) {
			e.preventDefault();
			
			if($('#codigoComprobanteRevalidar').val().trim() != "" && $('#cantidadPagoRevalidar').val() >= 0) {
				
				var formData = {
						codigoPago: $('#codigoPagoRevalidar').val(),
						codigoComprobante: $('#codigoComprobanteRevalidar').val(),
						cantidadPago: $('#cantidadPagoRevalidar').val()
				};
				
				console.log(formData);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/pago/consecutivoPago',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						console.log(response);
						
						if(response.message == "BUENO") {
							
							swal({
								type: "success",
								title: "Se Revalido el Pago con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/pago/listaPagos');
								}
							});
						}
						else if(response.message == "SIN PERMISO") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'No tiene los permisos suficientes para Revalidar este Pago !'
				            });
						}
						else if(response.message == "ERROR") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un error al Revalidar Pago !'
				            });
						}
					}
				});
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