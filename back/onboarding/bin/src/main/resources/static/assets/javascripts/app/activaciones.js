$(document).on('ready', function() {
		
	var tablaActivacionesDiaInternet;
	
	listarInstalacionDiaInternet();
	
	ocultar_mostrar(50);
	
	registraractivacion();
	
	generarReporteActivacionesInstalacion();
	
	mostrarFormReporteActivacionesPorRangoFecha();
	
	mostrarFormReporteActivacionesPorDia();
	
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
	
	/**
	 * 
	 *function para redireccionar a la vista de cortes
	 * 
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
	 * 
	 * function para agregar activacion
	 * 
	 */
	
	function registraractivacion() {
		
		$('#agregarActivacion').on('click', function(e) {
			
			e.preventDefault();
			
				var formDataIC = {
						codigo: $('#valorcodigocuenta').val()
				};
				
				console.log(formDataIC);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/instalacion/insrtact',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataIC),
					dataType: 'json',
					success: function(response) {
						
							if(response.message == "HECHO") {
							
							swal({
								type: "success",
								title: "Se Activo con exito la cuenta",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/instalacion/activaciones/view');
								}
							});
						}else if(response.message == "ERROR") {
								
								swal({
					                type: 'error',
					                title: 'Ooops',
					                text: 'Upss Hubo un error !'
					            });
							}
					},
					error: function() {
						console.log(formDataIC);
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Generar Activacion de Internet !'
			            });
					}
				});
		});
	}
	
	/**
	 * 
	 * fnctin para datos onu por servicio
	 * 
	 */
	
	function recuperardatosonusxserv(id){
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/onu/recuperdardatos/' + id,
			dataType: 'json',
			success: function(response) {
				console.log(response);
				$('#numerodeserie').val(response.snDescripcion);
				$('#numerodeserie').attr('disabled', true);
				$('#maconu').val(response.macDescripcion);
				$('#maconu').attr('disabled', true);
				$('#useronu').val(response.winUser);
				$('#useronu').attr('disabled', true);
				$('#passonu').val(response.winPassword);
				$('#passonu').attr('disabled', true);
				$('#pononu').val(response.ponDescripcion);
				$('#pononu').attr('disabled', true);
				$('#valorcodigocuenta').val(id);
				$('#valorcodigocuenta').attr('disabled', true);
			},
			/*error: function() {
				swal({
	                type: 'warning',
	                title: 'Ooops',
	                text: 'No se Encontraron Resultados de Busqueda !'
	            });
			}*/
		});
	}
	/**
	 * 
	 *function para listar instalaciones del dia internet 
	 * 
	 */
	function listarInstalacionDiaInternet() {
		
		tablaActivacionesDiaInternet = $('#tablaActivacionesDiaInternet').dataTable({
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
				"url": "/api/v1/instalacion/instalacionesDiaInternet",
				"dataSrc": ""
			},
			"columns": [
				{"data": "codigoDetalleCuenta"},
				{"data": "codigoCuenta"},
				{"data": "documentoPersonaCliente"},
				{"data": "cliente"},
				{"data": "direccionActualCliente"},
				{"data": "referenciaDireccion"},
				{"data": "telefonoCliente"},
				{"data": "fechaInstalacion"},
				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnProAct" data-toggle="modal" codigo><i class="fa fa-pencil-square-o"></i> Activar</button>'}
			]
		}).DataTable();
		
		$('#tablaActivacionesDiaInternet tbody').on('click', 'button', function() {
			var data = tablaActivacionesDiaInternet.row( $(this).parents('tr')).data();
			$(this).attr('codigo', data.codigoDetalleCuenta);
		});
		
		$('#tablaActivacionesDiaInternet tbody').on('click', 'button.btnProAct', function() {
			
			var codigogenerado = $(this).attr('codigo');
			recuperardatosonusxserv(codigogenerado);
			$('#modalFormActivacion').modal('show');
			console.log('codigogenerado: ' + codigogenerado);
		});
	}
	
	function generarReporteActivacionesInstalacion() {
		
		$('#btnReporteActivaciones').on('click', function() {
			$(this).attr('href', '/api/v1/instalacion/reporteActivaciones');
			var url = $(this).attr('href');
			window.open(url, '_blank');
		    return false;
			console.log(url);
		});
	}
	
	function mostrarFormReporteActivacionesPorRangoFecha() {
		
		$('#btnReporteActivacionesPorRango').on('click', function() {
			$('#modalActivacionesPorRangoFecha').modal('show');
		});
		
		buscarActivacionesPorRango();
		cancelarAccionBuscarActivacionesPorRangoFecha();
	}
	
	function cancelarAccionBuscarActivacionesPorRangoFecha() {
		
		$('#cancelarAccionBuscarActivacionesPorRango').on('click', function() {
			$('#fechaInicialBusqueda').val(''); 
			$('#fechaFinBusqueda').val('');
		});
	}
	
	function buscarActivacionesPorRango() {
		
		$('#buscarActivacionesPorRango').on('click', function(e) {
			e.preventDefault();
			
			if($('#fechaInicialBusqueda').val() != "" && $('#fechaFinBusqueda').val() != "") {
				
				var formDataBusquedaActivacionesPorRango =  {
						fechaInicial: $('#fechaInicialBusqueda').val(),
						fechaFinal: $('#fechaFinBusqueda').val()
				};
				console.log(formDataBusquedaActivacionesPorRango);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/instalacion/activacionesPorRango',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataBusquedaActivacionesPorRango),
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
								documentTitle: 'Reporte de Activaciones Por Rango Fecha',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{field: 'cliente', displayName: 'Cliente'},
									{ field: 'documentoCliente', displayName: 'Nº Documento'},
									{ field: 'direccionCliente', displayName: 'Direccion'},
									{ field: 'fechaInicioServicio', displayName: 'Fecha Inicio'},
									{ field: 'internet', displayName: 'Internet'},
									{ field: 'ubicacion', displayName: 'Ubicacion'},
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
			else if($('#fechaInicialBusqueda').val() == "" && $('#fechaFinBusqueda').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar todos los campos !'
	            });
				return false;
			}
			else if($('#fechaInicialBusqueda').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para la Fecha Inicial !'
	            });
				return false;
			}
			else if($('#fechaFinBusqueda').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para la Fecha Final !'
	            });
				return false;
			}
		});
	}
	
	function mostrarFormReporteActivacionesPorDia() {
		
		$('#btnReporteActivacionesPorDia').on('click', function() {
			$('#modalActivacionesPorDia').modal('show');
		});
		buscarActivacionesPorDia();
		cancelarAccionBuscarActivacionesPorDia();
	}
	
	function cancelarAccionBuscarActivacionesPorDia() {
		$('#cancelarAccionBuscarActivacionesPorDia').on('click', function() {
			$('#fechaBusqueda').val('');
		});
	}
	
	function buscarActivacionesPorDia() {
		
		$('#buscarActivacionesPorDia').on('click', function(e) {
			e.preventDefault();
			
			if($('#fechaBusqueda').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para este campo !'
	            });
			}
			else if($('#fechaBusqueda').val() != "") {
				
				var formDataBusquedaActivacionesPorDia = {
						fechaBusqueda: $('#fechaBusqueda').val()
				};
				console.log(formDataBusquedaActivacionesPorDia);
				
				$.ajax({
					type: 'POST',
					url: '/api/v1/instalacion/activacionesPorDia',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataBusquedaActivacionesPorDia),
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
								documentTitle: 'Reporte de Activaciones Por Dia',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{field: 'cliente', displayName: 'Cliente'},
									{ field: 'documentoPersonaCliente', displayName: 'Nº Documento'},
									{ field: 'direccionCliente', displayName: 'Direccion'},
									{ field: 'fechaInicioServicio', displayName: 'Fecha Inicio'},
									{ field: 'internet', displayName: 'Internet'},
									{ field: 'ubicacion', displayName: 'Ubicacion'},
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
