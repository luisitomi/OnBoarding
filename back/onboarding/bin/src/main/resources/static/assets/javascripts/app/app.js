$(document).on('ready', function() {
	
	recuperarUsuarioActual();
	
	/**
	 * 
	 * function recuperar usuario actual del sistema
	 * 
	 */

	function recuperarUsuarioActual() {
		
		$.ajax({
			
			type: 'GET',
			url: '/api/v1/usuario/usuarioLogueado',
			dataType: 'json',
			success: function(response) {
				console.log(response);
				$('#nombreUsuarioLogueado').html(response.username);
				var usuarioLogueado = response.username;
				console.log("usuarioLogueado: " + usuarioLogueado);
				
				$.ajax({
					type: 'GET',
					url: '/api/v1/usuario/perfilUsuario',
					dataType: 'json',
					success: function(response) {
						console.log(response);
						$('#cargoUsuarioLogueado').html(response.cargoUsuario);
					}
				});
				
			}
		});
	}
});