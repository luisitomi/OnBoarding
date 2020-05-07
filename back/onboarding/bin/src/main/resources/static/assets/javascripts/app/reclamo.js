$(document).on('ready', function() {
	
	cargarComboResponsable();
	
	listartablareclamo();
	
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

	var tablaReclamo;
	
	redireccionViewHerramientas() ;
	
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

	function listartablareclamo(){
		
		tablaReclamo = $('#tablaReclamo').dataTable({
			
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
				"url": "/api/v1/atencion/reclamo/",
				"dataSrc": ""
			},
			"columns": [
				{"data": "codigoreclamo"},
				{"data": "nombrecliente"},
				{"data": "direccioncliente"},
				{"data": "descripcionreclamo"},
				{"data": "fechareclamo"},
				{"data": "hora"},

				{"defaultContent": '<button type="button" class="btn btn-success btn-xs btntecnicoreclamo" codigoreclamo><i class="fa fa-hand-o-up "></i> Asignar Técnico</button>'}
			]
		}).DataTable();
		
		$('#tablaReclamo tbody').on('click', 'button', function(){
			
			var data = tablaReclamo.row( $(this).parents('tr')).data();
			$(this).attr('codigoreclamo', data.codigoreclamo);
			
		});
		
		$('#tablaReclamo tbody').on('click', 'button.btntecnicoreclamo', function(){
			var codigoreclamoevaluado = $(this).attr('codigoreclamo');
			
			$('#codigore').attr('disabled', true);
			$('#codigore').val(codigoreclamoevaluado);
			
			$('#modalFormTecnicoagregar').modal('show');
			asignartecnico();
		});
		
		
	}
	
	function asignartecnico() {
		$('#asignartecnico').on('click', function(e) {
			e.preventDefault();
				
				var codigoreclamoes =  $('#codigore').val();
				var personaencargadas = codigoreclamoes + 'p' + $('#personaencargada').val();
				var tecnicoescogioes = $('#personaencargada').val();
				

				e.preventDefault();
					
					var formData = {
							
							datovaluar: personaencargadas,
							descripciontarea: $('#desc').val()
					};
					
					
					
					$.ajax({
						
						type: 'POST',
						url: '/api/v1/atencion/updatetecnico',
						headers: {
							"Content-Type": "application/json",
							"Accept": "application/json"
						},
						data: JSON.stringify(formData),
						dataType: 'json',
						success: function(response) {
						
							
							swal({
								type: "success",
								title: "Se asigno con exito al Sr: " + tecnicoescogioes + " como responsable del reclamo",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/atencion/reclamo/view');
								}
							});
						},
						error: function() {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Error al Registrar Responsable Reclamo !'
				            });
						}
					});
		});
			
	}
	
	function redireccionViewHerramientas() {
		
		$('#buttonregresaratencion').on('click', function() {
			$(location).attr('href', '/atencion/atencion/view');
		});
	}
	
	
	function cargarComboResponsable() {
		
		var personaencargada = $('#personaencargada');

		$.ajax({

			type: 'GET',
			url: '/api/v1/atencion/comboempleado/0',
			dataType: 'json',
			success: function(response) {
				
				personaencargada.html('');
				personaencargada.append('<option value="">Seleccione un Responsable para el Reclamo</option>');
				for(var i = 0; i < response.length; i++) {
					personaencargada.append('<option value="' + response[i].tecnicoescogigo + '">' + response[i].tecnicoescogigo + '</option>');
				}
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