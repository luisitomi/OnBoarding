$(document).on('ready', function() {
	
	cargarTotalRegistrosPersonita();
		
	limpiarFormulario();
	
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
	
	var table = $('#datatable-default').DataTable({
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
		    			"url": "/api/v1/usuario/usuarios",
		    			"dataSrc": ""
		    		},
		    		"columns": [
		    			{ "data": "usuarioId" },
		    			{ "data": "nombreUsuario" },
		    			{ "data": "passwordUsuario" },
		    			{ "data": "documentoUsuario" },
		    			{ "defaultContent": '<span class="label label-success estadoUsuario">Activo</span>'},
		    			{ "defaultContent": '<div class="btn-group"><button type="button" data-toggle="modal" class="btn btn-info btn-sm btnEditarUsuario" idUsuario><i class="fa fa-pencil" title="Editar"></i></button><button type="button" class="btn btn-danger btnDeshabilitarUsuario btn-sm" idUsuario><i class="fa fa-times" title="Deshabilitar"></i></button><button type="button" class="btn btn-success btn-sm btnHabilitarUsuario" idUsuario style="display:none;"><i class="fa fa-check" title="Habilitar"></i></button></div>' }
		    		]});
	 
	
	 $('#datatable-default tbody').on('click', 'button', function() {
		 var data = table.row( $(this).parents('tr') ).data();
		  
		 $(this).attr('idUsuario', data.usuarioId);
	 });
	 	 
	function cargarEstado(){
		
		var estadoUsuario = $('.estadoUsuario');
		for(var i=0; i < estadoUsuario.length; i++) {

			var data = table.row($(estadoUsuario[i]).parents("tr")).data();
			if(data.habilitado == true) {
				$(estadoUsuario[i]).attr("class", "label label-success");
				$(estadoUsuario[i]).html('Activo');
			}
			else if(data.habilitado == false) {
				$(estadoUsuario[i]).attr("class", "label label-danger");
				$(estadoUsuario[i]).html('Inactivo');
			}
		}
	}
	
	function ocultarBotones() {
		
		var btnHabilitarUsuario = $('.btnHabilitarUsuario');
		for(var i=0; i < btnHabilitarUsuario.length; i++) {
			var data = table.row($(btnHabilitarUsuario[i]).parents("tr")).data();
			if(data.habilitado == true) {
				//$(btnHabilitarUsuario[i]).hide();
				$(btnHabilitarUsuario[i]).attr('style', 'display:none');
			}
			else if(data.habilitado == false){
				//$(btnHabilitarUsuario[i]).show();
				$(btnHabilitarUsuario[i]).attr('style', 'display:block');
			}
		}
		
		var btnDeshabilitarUsuario = $('.btnDeshabilitarUsuario');
		for(var i=0; i < btnDeshabilitarUsuario.length; i++){
			var data = table.row($(btnDeshabilitarUsuario[i]).parents("tr")).data();
			
			if(data.habilitado == true) {
				//$(btnDeshabilitarUsuario[i]).show();
				$(btnDeshabilitarUsuario[i]).attr('style', 'display:block');
			}
			else if(data.habilitado == false) {
				//$(btnDeshabilitarUsuario[i]).hide();
				$(btnDeshabilitarUsuario[i]).attr('style', 'display:none');
			}
		}
		
		var btnEditarUsuario = $('.btnEditarUsuario');
		for(var i=0; i <  btnEditarUsuario.length; i++) {
			var data = table.row($(btnEditarUsuario[i]).parents("tr")).data();
			if(data.habilitado == true) {
				//$(btnEditarUsuario[i]).show();
				$(btnEditarUsuario[i]).attr('style', 'display:block');
			}
			else if(data.habilitado == false) {
				//$(btnEditarUsuario[i]).hide();
				$(btnEditarUsuario[i]).attr('style', 'display:none');
			}
		}
	}
			
	$('#btnAgregarUsuario').on('click', function() {
		
		$('#modalAgregarUsuario').modal('show');
		$('#modalAgregarUsuario .modal-title').html('Nuevo Usuario');
	});
	
	setTimeout(function(){
		cargarEstado();
		ocultarBotones();
	}, 8000);
	
	$('#guardarUsuario').click(function(e) {
		
		e.preventDefault();
		
		if($('#nombreUsuario').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9\s]+$/) 
			&& $('#passwordUsuario').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9\s]+$/)
			&& $('#documentoUsuario').val().match(/^[0-9]+$/)) {
			
			var formData = {
				
					usuarioId: $('#usuarioId').val(),
					nombreUsuario: $('#nombreUsuario').val(),
					passwordUsuario: $('#passwordUsuario').val(),
					documentoUsuario: $('#documentoUsuario').val()
			};
			
			if(formData.usuarioId) {
				var usuarioId = formData.usuarioId;
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/usuario/saveOrUpdate',
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
								title: "Usuario Actualizado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/usuario/view');
								}
							});
						}
						else if(response.status == 'ERROR') {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Actualizar al Usuario, verifique su Numero Documento !'
				            });
						}	
					},
					error: function(){
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Actualizar Usuario !'
			            });
					}
				});
			}
			else {
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/usuario/saveOrUpdate',
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
								title: "Usuario: " + response.data.nombreUsuario + " Registrado con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/usuario/view');
								}
							});
						}
						else if(response.status == 'ERROR') {
							
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Ocurrio un Error al Registrar al Usuario: '+ response.data.nombreUsuario +', verifique su Numero Documento !'
				            });
						}
					},
					error: function() {
						
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'Error al Registrar Usuario !'
			            });
					}
				});
			}
		}
		
		if($('#nombreUsuario').val() == "" && $('#passwordUsuario').val() == "" && $('#documentoUsuario').val() == "") {
			
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe llenar todos los Campos !'
            });
			
			return false;
		}
		else {
			
			if($('#nombreUsuario').val() == "" || $('#nombreUsuario').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Nombre Usuario no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#nombreUsuario').focus();
		    	return false;
			}
			
			if($('#passwordUsuario').val() == "" || $('#passwordUsuario').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Password no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#passwordUsuario').focus();
		    	return false;
			}
			
			if($('#documentoUsuario').val() == "" || $('#documentoUsuario').val() == 0) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Documento Usuario no puede estar vacio, ingrese un valor valido'
	            });
		    	
		    	$('#documentoUsuario').focus();
		    	return false;
			}
			
			if(!($('#nombreUsuario').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9\s]+$/))) {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'El campo Nombre Usuario no permite caracteres especiales'
	            });
				
				$('#nombreUsuario').val('');
				$('#nombreUsuario').focus();
		    	return false;
			}
			else {
				
				if(!($('#passwordUsuario').val().match(/^[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9\s]+$/))) {
					
					swal({
		                type: 'error',
		                title: 'Ooops',
		                text: 'El campo Password no permite caracteres especiales'
		            });
					
					$('#passwordUsuario').val('');
					$('#passwordUsuario').focus();
			    	return false;
				}
				else {
					
					if(!($('#documentoUsuario').val().match(/^[0-9]+$/))) {
					
						swal({
			                type: 'error',
			                title: 'Ooops',
			                text: 'El campo Documento Usuario no permite caracteres especiales ni letras'
			            });
						
						$('#documentoUsuario').val('');
						$('#documentoUsuario').focus();
				    	return false;
					}
				}
			}
		}
	});
	
	$('#datatable-default tbody').on('click', 'button.btnEditarUsuario', function() {
		var usuarioId = $(this).attr('idUsuario');
			
		$('#modalAgregarUsuario').modal('show');
		
		$('#modalAgregarUsuario .modal-title').html('Editar Usuario');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/usuario/usuario/' + usuarioId,
			dataType: 'json',
			success: function(response){
				$('#usuarioId').val(response.usuarioId);
				$('#nombreUsuario').val(response.nombreUsuario);
				$('#passwordUsuario').val(response.passwordUsuario);
				$('#documentoUsuario').val(response.documentoUsuario);
			}
		});
		
	});
	
	$('.close').on('click', function() {
		limpiarFormulario();
	});
	
	$('#cancelarAccion').on('click', function() {
		limpiarFormulario();
	});
			
	/***
	 * 
	 * Metodo para deshabilitar Usuario
	 * 
	 */
	$('#datatable-default tbody').on('click', 'button.btnDeshabilitarUsuario', function() {
		
		var usuarioId = $(this).attr('idUsuario');
		
		swal({
	        title: '¿Esta Seguro de deshabilitar a este Usuario ?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si, deshabilitar !'
	    }).then((result) => {
	        if(result.value){
	           
	        	 $.ajax({
	                 url: '/api/v1/usuario/usuario/disabled/' + usuarioId,
	                 type: 'GET',
	                 success: function(response){
	                	 
	                     swal({
	                         type: "success",
	                         title: "El Usuario: " + response.data.nombreUsuario + " ha sido deshabilitado correctamente",
	                         showConfirmButton: true,
	                         confirmButtonText: "Cerrar",
	                         closeOnConfirm: false
	                     }).then((result) => {
	                         if(result.value) {
	                             $(location).attr("href", "/usuario/view");
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
	 * Metodo para habilitar Usuario
	 * 
	 * */
	$('#datatable-default tbody').on('click', 'button.btnHabilitarUsuario', function() {
		
		var usuarioId = $(this).attr('idUsuario');
		
		swal({
	        title: '¿Esta Seguro de habilitar a este Usuario ?',
	        text: '¡Si no lo esta puede Cancelar la accion!',
	        type: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        cancelButtonText: 'Cancelar',
	        confirmButtonText: '¡Si, habilitar !'
	    }).then((result) => {
	        if(result.value){
	           
	        	$.ajax({
	        		
	        		url: '/api/v1/usuario/usuario/enabled/' + usuarioId,
	        		type: 'GET',
	        		success: function(response){
	        			
	        			
	        			swal({
	        				type: "success",
	                        title: "El Usuario: " + response.data.nombreUsuario + " ha sido habilitado correctamente",
	                        showConfirmButton: true,
	                        confirmButtonText: "Cerrar",
	                        closeOnConfirm: false
	                       }).then((result) => {
	                         if(result.value) {
	                            $(location).attr("href", "/usuario/view");
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
	
});
function limpiarFormulario() {
	
	$('#usuarioId').val('');
	$('#nombreUsuario').val(''),
	$('#passwordUsuario').val(''),
	$('#documentoUsuario').val('')
}
