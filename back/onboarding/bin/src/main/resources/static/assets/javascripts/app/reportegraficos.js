
(function( $ ) {

	'use strict';
	
	generarReporteGraficosCobranzas();
	
	generarReporteGraficoCobranzasCajaUno();
	
	generarReporteGraficoCobranzasCajaDos();

	generarReporteGraficoCobranzasCajaTres();
	
	generarReporteGraficoGananciaPorCaja();
	
	generarReporteGraficoGananciaPorDia();
	
	generarReporteConsolidado();
	
	generarReporteMontoAcumuladoGestor();

}).apply( this, [ jQuery ]);

function generarReporteGraficosCobranzas() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/pagosPorMes',
		dataType: 'json',
		success: function(response) {	
			
			if(response != null) {
				/*
				Morris: Line
				*/
				Morris.Line({
					resize: true,
					element: 'morrisLine',
					data: response,
					xkey: 'diaFechaPago',
					ykeys: ['cantidadPago'],
					labels: ['Total'],
					hideHover: true,
					lineColors: ['#0088cc'],
				});
			}
		}
	});
}

function generarReporteGraficoCobranzasCajaUno() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/pagosPorMesCajaUno',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				/*
				Morris: Area
				*/
				Morris.Area({
					resize: true,
					element: 'morrisAreaGraficaCobranzaCajaUno',
					data: response,
					xkey: 'diaFechaPago',
					ykeys: ['cantidadPago'],
					labels: ['Total'],
					lineColors: ['#0088cc'],
					fillOpacity: 0.7,
					hideHover: true
				});
			}
		}
	});
}

function generarReporteGraficoCobranzasCajaDos() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/pagosPorMesCajaDos',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				/*
				Morris: Area
				*/
				Morris.Area({
					resize: true,
					element: 'morrisAreaGraficaCobranzaCajaDos',
					data: response,
					xkey: 'diaFechaPago',
					ykeys: ['cantidadPago'],
					labels: ['Total'],
					lineColors: ['#0088cc'],
					fillOpacity: 0.7,
					hideHover: true
				});
				
			}
		}
	});
}

function generarReporteGraficoCobranzasCajaTres() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/pagosPorMesCajaTres',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				/*
				Morris: Area
				*/
				Morris.Area({
					resize: true,
					element: 'morrisAreaGraficaCobranzaCajaTres',
					data: response,
					xkey: 'diaFechaPago',
					ykeys: ['cantidadPago'],
					labels: ['Total'],
					lineColors: ['#0088cc'],
					fillOpacity: 0.7,
					hideHover: true
				});
			}
		}
	});
}

function generarReporteGraficoGananciaPorDia() {
	
	var arrayDataGananciaPorDiaCaja = new Array();
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/gananciaPorDiaCaja',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				
				for(var i = 0; i < response.length; i++) {
					var gananciaPorDia = {
							label: response[i].caja,
							value: response[i].cantidadPago
					};
					arrayDataGananciaPorDiaCaja.push(gananciaPorDia);
				}
				/*
				Morris: Donut
				*/
				Morris.Donut({
					resize: true,
					element: 'morrisDonutGananciaPorDiaCaja',
					data: arrayDataGananciaPorDiaCaja,
					colors: ['#0088cc', '#734ba9', '#E36159']
				});
			}
		}
	});
}

function generarReporteGraficoGananciaPorCaja() {
	
	var arrayDataGananciaPorMesCaja = new Array();
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/pago/gananciaPorMesCaja',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				
				for(var i = 0; i < response.length; i++) {
					var gananciaPorMesCaja = {
							label: response[i].caja,
							value: response[i].cantidadPago
					};
					arrayDataGananciaPorMesCaja.push(gananciaPorMesCaja);
				}
				/*
				Morris: Donut
				*/
				Morris.Donut({
					resize: true,
					element: 'morrisDonutGananciaPorCaja',
					data: arrayDataGananciaPorMesCaja,
					colors: ['#0088cc', '#734ba9', '#E36159']
				});
			}
		}
	});
}

function generarReporteConsolidado() {
	
	$('#btnReporteConsolidado').on('click', function() {
		$(this).attr('href', '/api/v1/pago/consolidadoInternet');
		var url = $(this).attr('href');
		window.open(url, '_blank');
		return false;
		console.log(url);
	});
}

function generarReporteMontoAcumuladoGestor() {
	
	$('#btnReporteMontoAcumuladoGestor').on('click', function() {
		$(this).attr('href', '/api/v1/gestor/reporteGestorMontoAcumulado');
		var url = $(this).attr('href');
		window.open(url, '_blank');
		return false;
		console.log(url);
	});
}

