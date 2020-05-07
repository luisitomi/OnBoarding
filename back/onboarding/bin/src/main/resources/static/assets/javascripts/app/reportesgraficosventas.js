
(function( $ ) {

	'use strict';

	reporteGraficoVentasPorVendedor();
	
	reporteGraficoVentasPorDia();
	
	reporteGraficoInstalacionesRealizadasPorDia();
	
}).apply( this, [ jQuery ]);

function reporteGraficoVentasPorVendedor() {
	
	var arrayDataVentasPorVendedor = new Array();
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/detalleCuenta/ventasPorVendedor',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				
				for(var i = 0; i < response.length; i++) {
					var ventasPorVendedor = {
							label: response[i].nombreVendedor,
							value: response[i].totalVenta
					};
					arrayDataVentasPorVendedor.push(ventasPorVendedor);
				}
				/*
				Morris: Donut
				*/
				Morris.Donut({
					resize: true,
					element: 'morrisDonutGraficaVentasPorVendedor',
					data: arrayDataVentasPorVendedor,
					colors: ['#0088cc', '#734ba9', '#E36159']
				});
			}
		}
	});
}

function reporteGraficoVentasPorDia() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/detalleCuenta/ventasPorDia',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				/*
				Morris: Line
				*/
				Morris.Line({
					resize: true,
					element: 'morrisLineVentasPorDia',
					data: response,
					xkey: 'fechaSolicitudCliente',
					ykeys: ['total'],
					labels: ['Ventas'],
					hideHover: true,
					lineColors: ['#734ba9'],
				});
			}
		}
	});
}

function reporteGraficoInstalacionesRealizadasPorDia() {
	
	$.ajax({
		
		type: 'GET',
		url: '/api/v1/instalacion/instalacionesRealizadas',
		dataType: 'json',
		success: function(response) {
			
			if(response != null) {
				/*
				Morris: Area
				*/
				Morris.Area({
					resize: true,
					element: 'morrisAreaGraficaInstalacionesPorDia',
					data: response,
					xkey: 'fechaInstalacion',
					ykeys: ['totalInstalacion'],
					labels: ['Instalaciones'],
					lineColors: ['#2baab1'],
					fillOpacity: 0.7,
					hideHover: true
				});
			}
		}
	});
}
