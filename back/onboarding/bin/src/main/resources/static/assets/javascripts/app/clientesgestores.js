/**
 * 
 */

$(document).on('ready', function() {
	
	var tablaClientesGestores;
	
	listarTablaClientesGestores();
	
	listarComboGestores(); 
	
	listarComboGestoresResponsablesReporte();
	
	mostrarFormBuscarGestorReporte();
	
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
	
	function listarTablaClientesGestores() {
		
		tablaClientesGestores = $('#tablaClientesGestores').dataTable({
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
				"url": "/api/v1/gestor/gestorClientes",
				"dataSrc": ""
			},
			"columns": [
				{"data": "consecutivoCliente"},
				{"data": "documentoPersonaCliente"},
				{"data": "cliente"},
				{"data": "direccionActualCliente"},
				{"data": "gestor"},
				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btnAsignarGestor" documentoPersonaCliente><i class="fa fa-user"></i> Asignar Gestor</button>'}
			]
		}).DataTable();
		
		$('#tablaClientesGestores tbody').on('click', 'button', function() {
			var data = tablaClientesGestores.row( $(this).parents('tr')).data();
			$(this).attr('documentoPersonaCliente', data.documentoPersonaCliente);
		});
		mostrarFormAsignarGestor();
	}
	
	function mostrarFormAsignarGestor() {
		
		$('#tablaClientesGestores tbody').on('click', 'button.btnAsignarGestor', function() {
			var documentoPersonaCliente = $(this).attr('documentoPersonaCliente');
			console.log("documentoPersonaCliente: " +  documentoPersonaCliente);
			
			limpiarModalFormAsignarGestor();
			
			$('#modalFormAsignarGestor').modal('show');
			$('#documentoPersonaCliente').attr('disabled', true);
			$('#documentoPersonaCliente').val(documentoPersonaCliente);
			
			validarFormAsignarGestor();
		});
	}
	
	function listarComboGestores() {
		
		$gestorResponsable = $('#gestorResponsable');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/gestor/gestores',
			dataType: 'json',
			success: function(response) {
				
				console.log(response);
				$gestorResponsable.html('');
				$gestorResponsable.append('<option value="">Seleccione un Gestor</option>');
				for(var i = 0; i < response.length; i++) {
					$gestorResponsable.append('<option value="' + response[i].gestor + '">' + response[i].gestor + '</option>');
				}
			}
		});
	}
	
	function listarComboGestoresResponsablesReporte() {
		
		$gestoresResponsables = $('#gestoresResponsables');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/gestor/gestores',
			dataType: 'json',
			success: function(response) {
				
				console.log(response);
				$gestoresResponsables.html('');
				$gestoresResponsables.append('<option value="">Seleccione un Gestor</option>');
				for(var i = 0; i < response.length; i++) {
					$gestoresResponsables.append('<option value="' + response[i].gestor + '">' + response[i].gestor + '</option>');
				}
			}
		});
	}
	
	function limpiarModalFormAsignarGestor() {
		
		$('#cancelarModalAsignarGestor').on('click', function() {
			
			$('#documentoPersonaCliente').val('');
			$('#gestorResponsable').val('');
		});
	}
	
	function validarFormAsignarGestor() {
		
		$('#guardarAsignarGestor').on('click', function(e) {
			
			e.preventDefault();
			
			if($('#documentoPersonaCliente').val() != "" && $('#gestorResponsable').val().trim() != "") {
				
				var formDataAsignarGestores = {
						documentoPersonaCliente: $('#documentoPersonaCliente').val(),
						gestorResponsable: $('#gestorResponsable').val()
				};
				
				console.log(formDataAsignarGestores);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/gestor/updateClienteGestor',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataAsignarGestores),
					dataType: 'json',
					success: function(response) {
						
						console.log(response);
						
						if(response.status == "SUCCESS" && response.message == "BUENO") {
							
							swal({
								type: "success",
								title: "Se asigno al Gestor Responsable con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/gestor/clienteGestores/view');
								}
							});
						}
						
						else if(response.status == "ERROR", response.message == "ERROR") {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Error al Asignar Gestor Responsable !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Asignar Gestor Responsable !'
			            });
					}
				});
			}
			
			if($('#documentoPersonaCliente').val() == "" && $('#gestorResponsable').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe llenar algunos los Campos !'
	            });
				return false;
			}
			else if($('#documentoPersonaCliente').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El Campo Numero Documento Cliente no puede estar vacio, ingrese un valor valido !'
	            });
			}
			else if($('#gestorResponsable').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe Seleccionar un Gestor Responsable !'
	            });
				return false;
			}
		});
	}
	
	function mostrarFormBuscarGestorReporte() {
		
		$('#buttonReporteGestores').on('click', function() {
			
			$('#modalFormBuscarGestor').modal('show');
			limpiarModalBuscarGestorReporte();
			buscarGestorReporte();
		});
	}
	
	function limpiarModalBuscarGestorReporte() {
		
		$('#cancelarModalBuscarGestor').on('click', function() {
			$('#gestoresResponsables').val('');
		});
	}
	
	function buscarGestorReporte() {
		
		$('#buscarGestorReporte').on('click', function(e) {
			
			e.preventDefault();
			
			if($('#gestoresResponsables').val().trim() != "") {
				
				var formDataBuscarReporteGestor = {
						gestorResponsable: $('#gestoresResponsables').val()	
				};
				
				console.log(formDataBuscarReporteGestor);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/gestor/deudasPorGestor',
					headers: {
						"Content-Type" : "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataBuscarReporteGestor),
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
								documentTitle: 'Reporte de Deudas de Clientes por Gestor',
								properties: [
									{ field: 'cliente', displayName: 'Cliente'},
									{ field: 'direccionCliente', displayName: 'Direccion Actual'},
									{ field: 'mesDeuda', displayName: 'Mes Deuda'},
									{ field: 'deuda', displayName: 'Cantidad'}
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
			
			if($('#gestoresResponsables').val().trim() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe Seleccionar un Gestor Responsable !'
	            });
				return false;
			}
		});
	}
});