$(document).on('ready', function() {
	
	var estatico = 0;
	
	var dinamico = 0;
	
	var tablaHerramientas;
	cancelarAccion();
	listarHerramientas();
	mostrarFormAgregarHerramienta();
	guardarHerramienta();
	guardardetalleHerramienta();
	editarpregunta();
	redireccionViewHerramientas();
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
	
	
	mostardatosherramientagenerales(true);
	/**
	 * 
	 *function para mostrar el formAgregarHerramienta 
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
	function mostrarFormAgregarHerramienta() {
		$('#btnAgregarHerramienta').on('click', function() {
			$('#modalFormAgregarHerramienta').modal('show');
		})
	}
	function listardetallepregunta(id) {
		tablalistardetallepregunta = $('#tablalistardetallepregunta').dataTable({
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
				
				"url": "/api/v1/herramienta/searchlista/" + id,
				"dataSrc": ""
			},
			"columns": [
				{"data": "codigodetalle"},
				{"data": "pregunta"},
				{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-primary btn-xs btneditardet" idcodigodetalle idpregunta><i class="fa fa-external-link"></i> Editar</button></div>'}
				
			]
		}).DataTable();
		
		$('#tablalistardetallepregunta tbody').on('click', 'button', function() {
			var data = tablalistardetallepregunta.row( $(this).parents('tr')).data();
			$(this).attr('idcodigodetalle', data.codigodetalle);
			$(this).attr('idpregunta', data.pregunta);
			

		});
		
		$('#tablalistardetallepregunta tbody').on('click', 'button.btneditardet', function(){
			var codigodetalle = $(this).attr('idcodigodetalle');
			var preguntadetalle = $(this).attr('idpregunta');
			
			$('#modalFormEditarPregunta').modal('show');
			$('#codigoedidet').attr('disabled', true);
			$('#codigoedidet').val(codigodetalle);
			$('#preguntaedidet').val(preguntadetalle);
			$('#preguntaedidet').focus();
		});
		
		
	}
	/**
	 * 
	 *function para listarHerramientas 
	 * 
	 */
	function listarHerramientas() {
		tablaHerramientas = $('#tablaHerramientas').dataTable({
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
				"url": "/api/v1/herramienta/herramientas",
				"dataSrc": ""
			},
			"columns": [
				{"data": "herramienta"},
				{"data": "descripciontipoherramienta"},
				{"data": "fechainicio"},
				{"data": "fechafinal"},
				{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-success btn-xs btnenvioherramienta" idherramienta><i class="fa fa-external-link"></i> Agregar Preguntas</button></div>'},
				{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-warning btn-xs btnverpregunta" idherramienta><i class="fa fa-external-link"></i> Lista de Preguntas</button></div>'},
				{"defaultContent": '<div class="btn-group"><button type="button" class="btn btn-info btn-xs btneditarherramienta" idherramienta><i class="fa fa-external-link"></i> Editar herramienta</button></div>'}
				
			]
		}).DataTable();
		
		$('#tablaHerramientas tbody').on('click', 'button', function() {
			var data = tablaHerramientas.row( $(this).parents('tr')).data();
			$(this).attr('idherramienta', data.herramienta);
			
			
		});
		
		$('#tablaHerramientas tbody').on('click', 'button.btnverpregunta', function(){
			limpiarInputs();
			var codigoherramienta = $(this).attr('idherramienta');
			
			$('#modalFormListaPregunta').modal('show');
			$('#codigo').attr('disabled', true);
			$('#codigo').val(codigoherramienta);
			flag = false;
			
			
			listardetallepregunta(codigoherramienta);
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/herramienta/searchherramienta/' + codigoherramienta,
				dataType: 'json',
				success: function(response) {
					
					$('#nombreh').val(response.descripcionherramienta);
					$('#nombreh').attr('disabled', true);
					
				}
			});	
			
			
		});
		
		
		
		$('#tablaHerramientas tbody').on('click', 'button.btnenvioherramienta', function(){
			var codigoherramienta = $(this).attr('idherramienta');
			
			mostardatosherramientagenerales(false);
			$('#numeroherra').attr('disabled', true);
			$('#nombreherra').attr('disabled', true);
			$('#numeroherra').val(codigoherramienta);
			flag = false;
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/herramienta/searchherramienta/' + codigoherramienta,
				dataType: 'json',
				success: function(response) {
					
					$('#nombreherra').val(response.descripcionherramienta);
					$('#nombreherra').attr('disabled', true);
					
				}
			
			
			});
			
		
			
		});
		
		$('#tablaHerramientas tbody').on('click', 'button.btneditarherramienta', function(){
			var codigoherramienta = $(this).attr('idherramienta');
		
			flag = false;
			limpiarInputs();
			$('#modalFormEditarHerramienta').modal('show');
			$('#codigoedi').attr('disabled', true);
			$('#codigoedi').val(codigoherramienta);
			
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/herramienta/searchdatos/' + (codigoherramienta),
				dataType: 'json',
				success: function(response) {
					
					$('#nombrehedi').val(response.descripcionherramienta);
					$('#fechi').val(response.fechainicio);
					$('#fechf').val(response.fechafinal);
					$('#cantidade').val(response.cantidad);
					$('#feche').val(response.fechaemision);
					$('#secuenciale').val(response.secuencial);
					$('#codigoUusarioe').val(response.codigoUusario);
					$('#codigotipoherre').val(response.codigoTipoComprobante);
					$('#nombrehedi').focus();
					editarherramienta();
				}
			
			
			});
		});
	}
	function limpiarInputs() {
		$('#nombreherra').val('');
		$('#nombreh').val('');
		$('#fechi').val('');
		$('#fechf').val('');
		$('#nombrehedi').val('');
		$('#cantidade').val('');
		$('#feche').val('');
		$('#secuenciale').val('');
		$('#codigoUusarioe').val('');
		$('#codigotipoherre').val('');
	}

	/**
	 * 
	 *function para guardarHerramienta 
	 */
	function guardarHerramienta() {
		$('#guardarHerramienta').on('click', function(e) {
			e.preventDefault();
			if($('#tipoherramienta').val().trim() != "") {
				
				var formData = {
						observacion: $('#observacion').val(),
						cantidad: $('#cantidad').val(),
						fechainicio: $('#fechainicio').val(),
						fechafinal: $('#fechafin').val(),
						tipoherramienta: $('#tipoherramienta').val()
				};
				
				
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/herramienta/insertarherramienta',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						
						swal({
							type: "success",
							title: "Se Registro la Herramienta con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/atencion/herramientas/view');
							}
						});
					},
					error: function() {
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Herramienta !'
			            });
					}
				});
			}
		});
	}
	
	function mostardatosherramientagenerales(flag){
		
		if(flag) {
			$('#agregarpreguntasherramienta').hide();
			$('#listadoherramientas').show();
		}
		else {
			$('#agregarpreguntasherramienta').show();
			 limpiarInputs();
			$('#listadoherramientas').hide();
		}
	}

	function cancelarAccion() {
		$('#cancelarAcccion').on('click', function() {
			
			mostardatosherramientagenerales(true);
		});
	}
	
	
	function editarpregunta() {
		$('#editarpregunt').on('click', function(e) {
			e.preventDefault();
			
			var formData = {
					codigodetalleherramienta: $('#codigoedidet').val(),
					pregunta: $('#preguntaedidet').val()
			};
			
			
			
			$.ajax({
				
				type: 'POST',
				url: '/api/v1/herramienta/editarpregunta/',
				headers: {
					"Content-Type": "application/json",
					"Accept": "application/json"
				},
				data: JSON.stringify(formData),
				dataType: 'json',
				success: function(response) {
				
					
					swal({
						type: "success",
						title: "Se editó la pregunta con exito",
						showConfirmButton: true,
						confirmButtonText: "Cerrar",
						closeOnConfirm: false
					}).then((result) => {

						if(result.value) {
							$(location).attr('href', '/atencion/herramientas/view');
						}
					});
				},
				error: function() {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Error al Editar Pregunta !'
		            });
				}
			});
		});
	}
	
	
	function editarherramienta() {
		$('#guardareditarherra').on('click', function(e) {
			e.preventDefault();
			
			var formData = {
					codigoherramienta: $('#codigoedi').val(),
					descripcionherramienta: $('#nombrehedi').val(),
					fechainicio: $('#fechi').val(),
					fechafinal: $('#fechf').val(),
					/*cantidadpreguntas: $('#cantidade').val(),*/
					/*tipoherramienta: $('#codigotipoherre').val(),
					fechaemision: $('#feche').val(),*/
					secuencialherramienta: $('#secuenciale').val()/*,
					codigousuario: $('#codigoUusarioe').val()*/
			};
			
			
			
			$.ajax({
				
				type: 'POST',
				url: '/api/v1/herramienta/editarherramienta',
				headers: {
					"Content-Type": "application/json",
					"Accept": "application/json"
				},
				data: JSON.stringify(formData),
				dataType: 'json',
				success: function(response) {
					
					
					swal({
						type: "success",
						title: "Se editó la herramienta con exito",
						showConfirmButton: true,
						confirmButtonText: "Cerrar",
						closeOnConfirm: false
					}).then((result) => {

						if(result.value) {
							$(location).attr('href', '/atencion/herramientas/view');
						}
					});
				},
				error: function() {
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'Error al Registrar Herramienta !'
		            });
				}
			});
		});
	}
	/*
	 * 
	 * FUNCION GUARDAR PREGUNTAS
	 * 
	 * */
	function guardardetalleHerramienta() {
		$('#guardardetalleHerramienta').on('click', function(e) {
			e.preventDefault();
				
				var formData = {
						codigoherramientareq: $('#numeroherra').val(),
						preguntadescripcion: $('#pregunta').val()
				};
				
			
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/herramienta/insertardetalleherramienta',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formData),
					dataType: 'json',
					success: function(response) {
						
						swal({
							type: "success",
							title: "Se Registro la pregunta con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/atencion/herramientas/view');
							}
						});
					},
					error: function() {
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Herramienta !'
			            });
					}
				});
			
		});
	}
	
	function redireccionViewHerramientas() {
		
		$('#buttonHerramientas').on('click', function() {
			$(location).attr('href', '/atencion/atencion/view');
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