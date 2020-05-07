/**
 * 
 */
$(document).on('ready', function() {
	
	var tablaCuentasInternet;

	tablaListarCuentasInternet();
	
	anularCuenta();
	
	 mostrarFormBusquedaCuentasPorDia();
	 
	 mostrarFormBusquedaCuentasPorRango();
	
	cargarTotalRegistrosPersonita();
	
	redireccionarListadoEstadoCuentas();
	
	mostrarModalCuentasPorVendedor();
	
	cargarComboListarVendedores();
	
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
	
	function tablaListarCuentasInternet() {
		
		tablaCuentasInternet = $('#tablaCuentasInternet').dataTable({
			
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
				"url": "/api/v1/detalleCuenta/cuentas",
				"dataSrc": ""
			},
			"columns": [
				{"data": "codigoDetalleCuenta"},
				{"data": "codigoCuenta"},
				{"data": "documentoPersonaCliente"},
				{"data": "cliente"},
				{"data": "direccionActualCliente"},
				{"data": "fechaProgramacionInstalacion"},
				{"defaultContent": '<button type="button" class="btn btn-danger btn-xs btnAnularCuenta" codigoDetalleCuenta><i class="fa fa-times"></i> Anular Cuenta</button>'}
			]
		}).DataTable();
		
		$('#tablaCuentasInternet tbody').on('click', 'button', function() {
			var data = tablaCuentasInternet.row( $(this).parents('tr')).data();
			$(this).attr('codigoDetalleCuenta', data.codigoDetalleCuenta);
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
		
	/**
	 * 
	 *function para mostrar el form busqueda de cuentas por dia 
	 * 
	 **/
	function mostrarFormBusquedaCuentasPorDia() {
		
		$('#btnReporteCuentasPorFecha').on('click', function() {
			
			limpiarInputBusquedaCuentaPorDia();
			$('#modalCuentasPorDia').modal('show');
			busquedaDeCuentasPorDia();
		});
	}
	
	/**
	 * 
	 * function para mostrar el form busqueda de cuentas por rango
	 * */
	function mostrarFormBusquedaCuentasPorRango() {
		
		$('#btnReporteCuentasPorRango').on('click', function() {
			lmpiarInputsBusquedCuentasPorRango();
			$('#modalCuentasPorRangoFecha').modal('show');
		});
		
		busquedaDeCuentasPorRango();
	}
	
	/**
	 * 
	 * function busqueda de cuentasPorRango
	 * 
	 * */
	function busquedaDeCuentasPorRango() {
		
		$('#buscarCuentasPorRango').on('click', function(e) {
			
			e.preventDefault();
			
			if($('#fechaInicio').val() != "" && $('#fechaFin').val() != "") {
				
				var formDataCuentasPorRango = {
						fechaInicio: $('#fechaInicio').val(),
						fechaFin: $('#fechaFin').val()
				};
				console.log(formDataCuentasPorRango);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/detalleCuenta/reporteCuentasPorRango',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataCuentasPorRango),
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
								documentTitle: 'Reporte de Cuentas Por Rango Fecha',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{ field: 'codigoDetalleCuenta', displayName: 'DC'},
									{ field: 'codigoCuenta', displayName: 'Nº Cuenta'},
									{ field: 'documentoPersona', displayName: 'Nº Documento'},
									{ field: 'cliente', displayName: 'Cliente'},
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
			
			if($('#fechaInicio').val() == "" && $('#fechaFin').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para estos campos !'
	            });
			}
			else if($('#fechaInicio').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para la Fecha Inicial !'
	            });
			}
			else if($('#fechaFin').val() == "") {
				
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para la Fecha Final !'
	            });
			}
		});
	}
	
	/**
	 *
	 *function para cancelar accion busqueda cuentas por rango
	 * 
	 */
	function lmpiarInputsBusquedCuentasPorRango() {
		
		$('input[type=date]').val('');
	}
	
	/**
	 * function para cancelar accion busqueda cuenta por dia
	 * 
	 * */
	function limpiarInputBusquedaCuentaPorDia() {
		
		$('input[type=date]').val('');
	}
	
	/**
	 * 
	 * function busqueda de cuentasPorDia
	 * 
	 * */
	function busquedaDeCuentasPorDia() {
		
		$('#buscarCuentasPorFecha').on('click', function(e) {
			
			e.preventDefault();
			
			if($('#fechaBusqueda').val() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe ingresar un valor valido para este campo !'
	            });
			}
			else if($('#fechaBusqueda').val() != "") {
				
				var formDataCuentasPorDia = {
						fechaBusqueda: $('#fechaBusqueda').val()	
				};
				console.log(formDataCuentasPorDia);
				
				$.ajax({
					type: 'POST',
					url: '/api/v1/detalleCuenta/reporteCuentasPorDia',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataCuentasPorDia),
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
								documentTitle: 'Reporte de Cuentas Por Dia',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{ field: 'codigoDetalleCuenta', displayName: 'DC'},
									{ field: 'codigoCuenta', displayName: 'Nº Cuenta'},
									{ field: 'documentoPersona', displayName: 'Nº Documento'},
									{ field: 'cliente', displayName: 'Cliente'},
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
	
	function anularCuenta() {
		
		$('#tablaCuentasInternet tbody').on('click', 'button.btnAnularCuenta', function() {
			
			var codigoDetalleCuenta = $(this).attr('codigoDetalleCuenta');
			console.log("codigoDetalleCuenta: " + codigoDetalleCuenta);
			
			swal({
		        title: '¿Esta Seguro de Anular esta Cuenta ?',
		        text: '¡Si no lo esta puede Cancelar la accion!',
		        type: 'warning',
		        showCancelButton: true,
		        confirmButtonColor: '#3085d6',
		        cancelButtonColor: '#d33',
		        cancelButtonText: 'Cancelar',
		        confirmButtonText: '¡Si, Anular!'
		    }).then((result) => {
		        if(result.value){
		           
		        	$.ajax({
		        		
		        		url: '/api/v1/detalleCuenta/anular/' + codigoDetalleCuenta,
		        		type: 'GET',
		        		dataType: 'json',
		        		success: function(response){
		        			
		        			swal({
		        				type: "success",
		                        title: "Se Anulo la Cuenta con exito",
		                        showConfirmButton: true,
		                        confirmButtonText: "Cerrar",
		                        closeOnConfirm: false
		                       }).then((result) => {
		                         if(result.value) {
		                            $(location).attr("href", "/detalleCuenta/cuentas/view");
		                        }
		                     })
		                 }
		        	});
		        }
		        else {
		            swal({
		                type: "error",
		                title: "Cancelado", 
		                text: "Usted ha cancelado la acción de Anular Cuenta"
		            });
		        }
		    });
		});
	}
	
	/**
	 * 
	 * function para redireccionar listado estado cuentas
	 * 
	 * */
	function redireccionarListadoEstadoCuentas() {
		
		$('#btnListarEstadoCuentas').on('click', function() {
			$(location).attr('href', '/detalleCuenta/estadoCuentas/view');
		});
	}
	
	/**
	 * 
	 * function para mostrar el modal cuentas por vendedor
	 * 
	 * */
	function mostrarModalCuentasPorVendedor() {
		
		$('#btnReporteCuentasPorVendedor').on('click', function() {
			$('#modalCuentasPorVendedor').modal('show');
		});
		
		cancelarAccionBuscarCuentasPorVendedor();
		buscarCuentasPorVendedor();
	}
	
	/**
	 * 
	 * function para cargar el combo lista de vendedores
	 * 
	 * */
	function cargarComboListarVendedores() {
		
		var $vendedorResponsable = $('#vendedorResponsable');
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/vendedor/vendedores',
			dataType: 'json',
			success: function(response) {
				console.log(response);
				$vendedorResponsable.html('');
				$vendedorResponsable.append('<option value="">Seleccione un Vendedor Responsable</option>');
				for(var i = 0; i < response.length; i++) {
					$vendedorResponsable.append('<option value="' + response[i].vendedor + '">' + response[i].vendedor + '</option>');
				}
			}
		});
	}
	
	
	/**
	 * 
	 * function para buscar cuentasPorVendedor
	 * 
	 * */
	function buscarCuentasPorVendedor() {
		
		$('#buscarCuentasPorVendedor').on('click', function(e) {
			e.preventDefault();
			
			if($('#vendedorResponsable').val().trim() != "") {
				
				var formDataBuscarCuentasPorVendedor = {
						vendedorResponsable: $('#vendedorResponsable').val()
				};
				
				console.log(formDataBuscarCuentasPorVendedor);
				
				$.ajax({
					
					type: 'POST',
					url: '/api/v1/detalleCuenta/cuentasPorVendedor',
					headers: {
						"Content-Type": "application/json",
						"Accept": "application/json"
					},
					data: JSON.stringify(formDataBuscarCuentasPorVendedor),
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
								documentTitle: 'Reporte de Cuentas Por Vendedor',
								properties: [
									{ field: 'numeracion', displayName: '#'},
									{ field: 'cliente', displayName: 'Cliente'},
									{ field: 'direccionCliente', displayName: 'Direccion'},
									{ field: 'fechaInicio', displayName: 'Fecha Inicio'},
									{ field: 'estado', displayName: 'Estado'}
									
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
			
			if($('#vendedorResponsable').val().trim() == "") {
				swal({
	                type: 'error',
	                title: 'Ooops',
	                text: 'Debe Seleccionar un Vendedor Responsable !'
	            });
				return false;
			}
		});
	}
	
	/**
	 * function para cancelar buscar cuentas por vendedor
	 * 
	 * */
	function cancelarAccionBuscarCuentasPorVendedor() {
		$('#cancelarAccionBusquedaCuentasPorVendedor').on('click', function() {
			$('#vendedorResponsable').val('');
		});
	}
});



