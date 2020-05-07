$(document).on('ready', function() {
	
	 comboServicio();
	 disabledAllButtons();
	 disabledInputContador(true);
	 cargarTotalRegistrosPersonita();
	 ocultar_mostrar(50);
	 window.setInterval(
			    function(){
			    // Sección de código para modificar el DIV
			    // $("#miDiv").text(variable);
			    	$('#total').load(cargarTotalRegistrosPersona());
			    	evaluando();
			   
			  }
			  // Intervalo de tiempo
			,5000);
	 
	 /**
	  * 
	  *function para deshabilitar todos los botones 
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
								console.log(response);
								
								var descrip = response.descripcionmodulo;
								
								document.getElementById(descrip).style.display = 'block';
							}
						});
					}
				}
			}
		
	}
	 
	 function disabledAllButtons() {
		 
		 disabledButtonReprogramacionDelDia(true);
		 disabledButtonReprogramacionPendientes(true);
	 }
	
	/**
	 * 
	 *function para deshabilitar boton de reprogramacion de dia 
	 */
	function disabledButtonReprogramacionDelDia(flag) {
		
		if(flag) {
			$('#reprogramacionDelDia').attr('disabled', true);
		}
		else {
			$('#reprogramacionDelDia').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 * function para deshabilitar boton de reprogramacion pendientes
	 * 
	 */
	function disabledButtonReprogramacionPendientes(flag) {
		
		if(flag) {
			$('#reprogramacionPendientes').attr('disabled', true);
		}
		else {
			$('#reprogramacionPendientes').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 *funcion para limpiar el contador 
	 * 
	 */
	function limpiarContador() {
		
		$('#contador').val('');
	}
	
	/**
	 * 
	 *function para deshabilitar el input contador 
	 * 
	 */
	function disabledInputContador(flag) {
		
		if(flag) {
			$('#contador').attr('disabled', true);
		}
		else {
			$('#contador').attr('disabled', false);
		}
	}
	
	/**
	 * 
	 *function activar desactivar botones segun contador 
	 * 
	 */
	function activarDesactivarBotonesSegunContador(contador) {
			
		if(contador > 0) {
			disabledButtonReprogramacionPendientes(false);
			disabledButtonReprogramacionDelDia(true);
		}
		else if(contador == 0) {
			disabledButtonReprogramacionPendientes(true);
			disabledButtonReprogramacionDelDia(false);
		}
	}
	
	/**
	 * 
	 *function para llamar al contadorPendientesCable 
	 * 
	 */
	function contadorPendientesCable() {
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/detalleCuenta/contadorPendientesCable',
			dataType: 'json',
			success: function(response) {
			
				$('#contador').val(response.data);
				var contador = $('#contador').val(response.data);
				contador = contador.val();
				
				activarDesactivarBotonesSegunContador(contador);
			}
		});
	}
	
	/**
	 * 
	 *function para llamar al contadorPendientesInternet 
	 */
	function contadorPendientesInternet() {
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/detalleCuenta/contadorPendientesInternet',
			dataType: 'json',
			success: function(response) {
				
				$('#contador').val(response.data);
				var contador = $('#contador').val(response.data);
				contador = contador.val();
				
				activarDesactivarBotonesSegunContador(contador);
			}
		});
	}
	
	/**
	 *
	 * reprogramacion del dia internet
	 * 
	 */
	function reprogramacionDelDiaInternet() {
		
		$('#reprogramacionDelDia').on('click', function() {
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/detalleCuenta/reprogramacionInstalacionInternet',
				dataType: 'json',
				success: function(response) {
					
					
					if(response.status == "SUCCESS" && response.data == "HECHO") {
						
						swal({
							type: "success",
							title: "La Reprogramacion de Instalacion de Internet del Dia se realizo con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/detalleCuenta/reprogramacion/view');
							}
						});
					}
				}
			});
		});
	}
	
	/**
	 * 
	 * reprogramacion del dia cable
	 * 
	 */
	function reprogramacionDelDiaCable() {
		
		$('#reprogramacionDelDia').on('click', function() {
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/detalleCuenta/reprogramacionInstalacionCable',
				dataType: 'json',
				success: function(response) {
					
					
					if(response.status == "SUCCESS" && response.data == "HECHO") {
						
						swal({
							type: "success",
							title: "La Reprogramacion de Instalacion de Cable del Dia se realizo con exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/detalleCuenta/reprogramacion/view');
							}
						});
					}
				}
			});
		});
	}
	
	/**
	 * 
	 *function para revalidar instalacion de cable 
	 *
	 */
	function revalidarInstalacionCable() {
		
		$('#reprogramacionPendientes').on('click', function() {
			
			$.ajax({
				
				type: 'GET',
				url : '/api/v1/detalleCuenta/revalidandoInstalacionCable',
				dataType: 'json',
				success: function(response) {
					
					
					
					if(response.status == "SUCCESS" && response.data == "HECHO") {
						
						swal({
							type: "success",
							title: "Se Reprogramaron las Instalaciones de Cable Pendientes con Exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/detalleCuenta/reprogramacion/view');
							}
						});
					}
				}
			});
		});
	}
	
	/**
	 * 
	 *function para revalidar instalaciones de internet
	 * 
	 */
	function revalidarInstalacionInternet() {
		
		$('#reprogramacionPendientes').on('click', function() {
			
			$.ajax({
				
				type: 'GET',
				url: '/api/v1/detalleCuenta/revalidandoInstalacionInternet',
				dataType: 'json',
				success: function(response) {
					
					
					
					if(response.status == "SUCCESS" && response.data == "HECHO") {
						
						swal({
							type: "success",
							title: "Se Reprogramaron las Instalaciones de Internet Pendientes con Exito",
							showConfirmButton: true,
							confirmButtonText: "Cerrar",
							closeOnConfirm: false
						}).then((result) => {

							if(result.value) {
								$(location).attr('href', '/detalleCuenta/reprogramacion/view');
							}
						});
					}
				}
			});
		});
	}
	
	/**
	 * 
	 *funcion para el combo de servicios
	 * 
	 */
	function comboServicio() {
		
		$tipoServicio = $('#tipoServicio');
		
		$tipoServicio.on('change', function() {
			
			if($tipoServicio.val() == "") {
				disabledAllButtons();
				limpiarContador();
			}
			else if($tipoServicio.val() == "IC") {
				disabledAllButtons();
				limpiarContador();
				contadorPendientesInternet();
				reprogramacionDelDiaInternet();
				revalidarInstalacionInternet();
			}
			else if($tipoServicio.val() == "CC") {
				disabledAllButtons();
				limpiarContador();
				contadorPendientesCable();
				reprogramacionDelDiaCable();
				revalidarInstalacionCable();
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