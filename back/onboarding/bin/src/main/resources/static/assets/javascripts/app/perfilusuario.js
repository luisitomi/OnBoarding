/**
 * 
 */
$(document).on('ready', function() {
	
	var passwordUsuarioActual;
	
	obtenerDetalleCuentaUsuario(); 
	mostrarValorActualPassword();
	mostrarValorConfirmPassword();
	mostrarValorNewPassword();
	actualizarUsuarioPerfil();
});

function mostrarValorActualPassword() {
	$('#showActualPassword').mousedown(function() {
		$('#passwordUsuarioPerfil').removeAttr('type');
		$('#showActualPassword').addClass('fa-eye-slash').removeClass('fa-eye');
	});
	
	$('#showActualPassword').mouseup(function() {
		$('#passwordUsuarioPerfil').attr('type', 'password');
		$('#showActualPassword').addClass('fa-eye').removeClass('fa-eye-slash');
	});
}

function mostrarValorConfirmPassword() {
	$('#showPassword').mousedown(function() {
		$('#confirmarPasswordUsuarioPerfil').removeAttr('type');
		$('#showPassword').addClass('fa-eye-slash').removeClass('fa-eye');
	});
	
	$('#showPassword').mouseup(function() {
		$('#confirmarPasswordUsuarioPerfil').attr('type', 'password');
		$('#showPassword').addClass('fa-eye').removeClass('fa-eye-slash');
	});
}

function mostrarValorNewPassword() {
	
	$('#showNewPassword').mousedown(function() {
		$('#nuevoPasswordUsuarioPerfil').removeAttr('type');
		$('#showNewPassword').addClass('fa-eye-slash').removeClass('fa-eye');
	});
	
	$('#showNewPassword').mouseup(function() {
		$('#nuevoPasswordUsuarioPerfil').attr('type', 'password');
		$('#showNewPassword').addClass('fa-eye').removeClass('fa-eye-slash');
	});
}

function obtenerDetalleCuentaUsuario() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/usuario/perfilUsuario',
		dataType: 'json',
		success: function(response) {
			console.log(response);
			$('#descripcionCargoUsuarioPerfil').html(response.descripcionCargo);
			$('#usuarioPerfil').html(response.nombresUsuario);
			$('#cargoPerfil').html(response.cargoUsuario);
			$('#nombresUsuarioPerfil').val(response.nombresUsuario);
			$('#nombresUsuarioPerfil').attr('disabled', true);
			$('#apellidosUsuarioPerfil').val(response.apellidosUsuario);
			$('#apellidosUsuarioPerfil').attr('disabled', true);
			$('#cargoUsuarioPerfil').val(response.cargoUsuario);
			$('#cargoUsuarioPerfil').attr('disabled', true);
			$('#direccionUsuarioPerfil').val(response.direccionUsuario);
			$('#direccionUsuarioPerfil').attr('disabled', true);
			$('#telefonoUsuarioPerfil').val(response.telefonoUsuario);
			$('#telefonoUsuarioPerfil').attr('disabled', true);
			$('#nombreUsuarioPerfil').val(response.usuario);
			$('#nombreUsuarioPerfil').attr('disabled', true);
			passwordUsuarioActual = response.passwordUsuario;
		},
		error: function() {
			swal({
                type: 'warning',
                title: 'Ooops',
                text: 'No se Encontraron Resultados de Busqueda !'
            });
		}
	});
}

function validarPasswordActual() {
	
	$('#passwordUsuarioPerfil').on('change', function() {
		if($('#passwordUsuarioPerfil').val() != passwordUsuarioActual) {
			swal({
                type: 'warning',
                title: 'Ooops',
                text: 'Verifique si su contraseña actual es correcto !'
            });
		}
		else if($('#passwordUsuarioPerfil').val() == passwordUsuarioActual) {
			$('#nuevoPasswordUsuarioPerfil').focus();
		}
	});
}

function limpiarFormularioPerfilUsuario() {
	
	$('#passwordUsuarioPerfil').val('');
	$('#nuevoPasswordUsuarioPerfil').val('');
	$('#confirmarPasswordUsuarioPerfil').val('');
}

function actualizarUsuarioPerfil() {
	$('#actualizarUsuarioPerfil').on('click', function(e) {
		console.log("passwordUsuarioActual: " + passwordUsuarioActual);
		e.preventDefault();
		
		if($('#passwordUsuarioPerfil').val() == "" && $('#nuevoPasswordUsuarioPerfil').val() == "" 
			&& $('#confirmarPasswordUsuarioPerfil').val() == "") {
			swal({
                type: 'error',
                title: 'Ooops',
                text: 'Debe llenar todos los campos !'
            });
		}
		else if($('#passwordUsuarioPerfil').val() != "" && $('#nuevoPasswordUsuarioPerfil').val() != "" 
				&& $('#confirmarPasswordUsuarioPerfil').val() != "") {
			
			if($('#passwordUsuarioPerfil').val() != passwordUsuarioActual) {
				swal({
	                type: 'warning',
	                title: 'Ooops',
	                text: 'Verifique que la contraseña actual sea la correcta !'
	            });
				
				limpiarFormularioPerfilUsuario();
			}
			else if($('#passwordUsuarioPerfil').val() == passwordUsuarioActual) {
				
				if($('#nuevoPasswordUsuarioPerfil').val() != $('#confirmarPasswordUsuarioPerfil').val()) {
					swal({
		                type: 'warning',
		                title: 'Ooops',
		                text: 'La nuevas contraseñas no coinciden, verifiquelas !'
		            });
				}
				else if($('#nuevoPasswordUsuarioPerfil').val() == $('#confirmarPasswordUsuarioPerfil').val()) {
					var formDataCambioPassword = {
							passwordActualUsuario: $('#passwordUsuarioPerfil').val(),
							nuevaPasswordUsuario: $('#nuevoPasswordUsuarioPerfil').val()
					};
					console.log(formDataCambioPassword);
					
					$.ajax({
						
						type: 'POST',
						url: '/api/v1/usuario/updatePerfil',
						headers: {
							"Content-Type": "application/json",
							"Accept": "application/json"
						},
						data: JSON.stringify(formDataCambioPassword),
						dataType: 'json',
						success: function(response) {
							console.log(response);
							
							swal({
								type: "success",
								title: "Contraseña de Usuario Actualizada con exito",
								showConfirmButton: true,
								confirmButtonText: "Cerrar",
								closeOnConfirm: false
							}).then((result) => {

								if(result.value) {
									$(location).attr('href', '/login');
								}
							});
						},
						error: function() {
							swal({
				                type: 'error',
				                title: 'Ooops',
				                text: 'Error al Actualizar Contraseña de Usuario !'
				            });
						}
					});
				}
			}
		}
	});
}