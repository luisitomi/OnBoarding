-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: vipchannel
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'vipchannel'
--
/*!50003 DROP FUNCTION IF EXISTS `mes_monto_deuda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `mes_monto_deuda`(operacion int,servicioActivo int,
	document varchar(11),code varchar(8),user int) RETURNS int(11)
    DETERMINISTIC
begin
		declare count_service int;
		declare code_count int;
		declare code_next_service_table int;
		declare code_next int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data_two(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_two_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data_two
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data_two
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = 2;
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 2 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data_two
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where p.serviciosId = 2 and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = 2 limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data_two
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data_two
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data_two
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data_two
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data_two
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data_two
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data_two
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data_two
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data_two
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data_two
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data_two
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		delete from vipchannel_data_two_process;
		insert into vipchannel_data_two_process
		select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data_two where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		
		if(id = 1 and operacion = 1)then
			return (select distinct
				min(code_mes_temporary) as information
			from vipchannel_data_two_process
			where code_service_temporary = servicioActivo
			group by code_service_temporary
			order by code_mes_temporary asc);
		end if;
		if(id = 1 and operacion = 2)then
			return (select distinct
				max(code_mes_temporary) as information
			from vipchannel_data_two_process
			where code_service_temporary = servicioActivo
			group by code_service_temporary
			order by code_mes_temporary desc); 
		end if;
		if(id = 1 and operacion = 3)then
			return (select distinct
			ifnull(sum(code_amount_temporary),0) as information
			from vipchannel_data_two_process
			where code_service_temporary = servicioActivo
			group by code_service_temporary
			order by code_mes_temporary asc);
		end if;
		
		drop temporary table vipchannel_data_two;
		drop temporary table vipchannel_data_two_process;
		
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `monto_descuento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `monto_descuento`(codigo int,document varchar(20),
code varchar(8)) RETURNS int(11)
    DETERMINISTIC
begin
	declare amount decimal(10,2);
	declare dias int;
	set dias = (select ifnull(max(dia),0) from vipchannel_calendario where anio = year(now()) and mes = month(now()) order by `calendarioId` desc limit 1);
	set amount = (select dc.mensualidad_mensual from vipchannel_detalle_cuenta dc inner join vipchannel_cuenta cu on
					dc.`cuentaId`= cu.`cuentaId` where cu.documento = document and cu.codigo = code
					and dc.activo = 1 and cu.activo = 1 and dc.`servicioId` = codigo limit 1);
	if(codigo = 1)then	return 2 + amount - ((amount / dias) * (day(now()))) ; end if;
	if(codigo = 2)then	return 0 + amount - ((amount / dias) * (day(now()))) ; else  return 0; end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `monto_tipo` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `monto_tipo`(codigo varchar(20),valor int) RETURNS decimal(10,2)
    DETERMINISTIC
begin
				declare activo int;
				declare inactivo int;
				set activo = (select ifnull(count(*),0) from vipchannel_detalle_pago d where d.serie = codigo and d.`tipoId` = valor and d.activo = 1);
				set inactivo = (select ifnull(count(*),0) from vipchannel_detalle_pago d where d.serie = codigo and d.`tipoId` = valor and d.activo = 0);
				if(activo > 0)then return (select round(ifnull(sum(d.monto),0),2) from vipchannel_detalle_pago d where d.serie = codigo and d.`tipoId` = valor and d.activo = 1); end if;
				if(activo = 0 and inactivo >= 0)then return 0; end if;
				
		end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP FUNCTION IF EXISTS `nombre_del_mes` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nombre_del_mes`(codigo int) RETURNS text CHARSET latin1
    DETERMINISTIC
begin
		
			if(codigo = 1)then	return 'Enero'; end if;
			if(codigo = 2)then	return 'Febrero'; end if;
			if(codigo = 3)then	return 'Marzo'; end if;
			if(codigo = 4)then	return 'Abril'; end if;
			if(codigo = 5)then	return 'Mayo'; end if;
			if(codigo = 6)then	return 'Junio'; end if;
			if(codigo = 7)then	return 'Julio'; end if;
			if(codigo = 8)then	return 'Agosto'; end if;
			if(codigo = 9)then return 'Setiembre'; end if;
			if(codigo = 10)then	return 'Octubre'; end if;
			if(codigo = 11)then	return 'Noviembre'; end if;
			if(codigo = 12)then	return 'Diciembre'; end if;
			if(codigo is null)then	return 'Nulo'; end if;
			if(codigo > 12 || codigo = 0)then	return ''; end if;
			
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteDetailCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDetailCount`(
		in document varchar(11),
		in code varchar(8),
		in status int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare code_next_service_table int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		declare contador_registros_procesando int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		set contador_registros_procesando = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		if(status = 0)then
			set id = 0;
		else
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 1 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(status = 3)then
			set contador_registros_procesando = (select ifnull(count(*),0)
												 from vipchannel_data_process
												 where code_document_temporary = document and code_code_temporary =
												 code and code_amount_temporary > 0
												 order by code_mes_temporary asc);
			if(contador_registros_procesando = 0)then
				update vipchannel_detalle_cuenta
				set tipoId = 4
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 1 or `servicioId` = 2) and activo = 1;
			else
				update vipchannel_detalle_cuenta
				set tipoId = 3
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 1 or `servicioId` = 2) and activo = 1;
				insert into vipchannel_detalle_cuenta_deuda
				select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_amount_temporary,0,right(code_mes_temporary,2),left(code_mes_temporary,4),1
				from vipchannel_data_process where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
				order by code_mes_temporary asc;
			end if;
			set id = 1;
		end if;
		if(status = 2)then
			set contador_registros_procesando = (select ifnull(count(*),0)
												 from vipchannel_data_process
												 where code_document_temporary = document and code_code_temporary =
												 code and code_amount_temporary > 0
												 order by code_mes_temporary asc);
			if(contador_registros_procesando = 0)then
				update vipchannel_detalle_cuenta
				set tipoId = 4
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 2) and activo = 1;
			else
				update vipchannel_detalle_cuenta
				set tipoId = 3
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 2) and activo = 1;
				insert into vipchannel_detalle_cuenta_deuda
				select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_amount_temporary,0,right(code_mes_temporary,2),left(code_mes_temporary,4),1
				from vipchannel_data_process where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
				and code_service_temporary = 2 order by code_mes_temporary asc;
			end if;
			set id = 1;
		end if;
		if(status = 1)then
			set contador_registros_procesando = (select ifnull(count(*),0)
												 from vipchannel_data_process
												 where code_document_temporary = document and code_code_temporary =
												 code and code_amount_temporary > 0
												 order by code_mes_temporary asc);
			if(contador_registros_procesando = 0)then
				update vipchannel_detalle_cuenta
				set tipoId = 4
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 1) and activo = 1;
			else
				update vipchannel_detalle_cuenta
				set tipoId = 3
				where `cuentaId` = code_count and `consecutivoId` = code_next and
				(`servicioId` = 1) and activo = 1;
				insert into vipchannel_detalle_cuenta_deuda
				select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_amount_temporary,0,right(code_mes_temporary,2),left(code_mes_temporary,4),1
				from vipchannel_data_process where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
				and code_service_temporary = 1 order by code_mes_temporary asc;
			end if;
			set id = 1;
		end if;
		select id;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePayService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePayService`(
		in code varchar(20))
begin
		declare id int;
		declare count_pay int;
		declare i int;
		declare code_state int;
		declare code_detail int;
		declare code_amount float(10,2);
		declare code_detail_count int;
		declare code_month int;
		set i = 0;
		set id = 0;
		set count_pay = (select ifnull(count(*),0) from vipchannel_detalle_pago  where serie = code and activo = 1);
		while i < count_pay do
			set code_detail = (select ifnull(min(`detalleId`),0) from vipchannel_detalle_pago  where serie = code and activo = 1 order by `detalleId` asc limit 1);
			set code_state = (select ifnull(max(state),0) from vipchannel_detalle_pago  where serie = code and activo = 1 and `detalleId` = code_detail order by `detalleId` asc limit 1);
			set code_amount = (select ifnull(max(monto),0) from vipchannel_detalle_pago  where serie = code and activo = 1 and `detalleId` = code_detail order by `detalleId` asc limit 1);
			set code_month = (select ifnull(concat(c.anio,right(concat('00',c.mes),2)),0) from vipchannel_detalle_pago d inner join vipchannel_calendario c 
								on c.mesid = d.`calendarioId` where d.serie = code and d.activo = 1 and d.`detalleId` = code_detail order by d.`detalleId` asc limit 1);
			set code_detail_count =(select ifnull(max(s.`detalleId`),0) from vipchannel_detalle_pago d inner join vipchannel_pago p on p.`pagoId` = d.`pagoId` inner join vipchannel_servicios
									s on s.`serviciosId` = p.`serviciosId` and s.`consecutivoId` = p.`consecutivoId` where d.serie = code and d.activo = 1 and
									d.`detalleId` = code_detail order by d.`detalleId` asc limit 1);
			if(code_state =1)then
				update vipchannel_pago p
				inner join vipchannel_detalle_pago d
				on p.`pagoId` = d.`pagoId`
				set d.activo = 0, p.activo = 0
				where d.`detalleId` = code_detail;
			end if;
			if(code_state =2)then
				update vipchannel_pago p
				inner join vipchannel_detalle_pago d
				on p.`pagoId` = d.`pagoId`
				set d.activo = 0, p.activo = 0
				where d.`detalleId` = code_detail;
				update vipchannel_detalle_cuenta_historial
				set monto_restante = monto_restante - code_amount,
				activo = 1
				where `detalleId` = code_detail_count and concat(year(fecha_inicio),
				right(concat('00',month(fecha_fin)),2)) = code_month;
			end if;
			if(code_state =3)then
				update vipchannel_pago p
				inner join vipchannel_detalle_pago d
				on p.`pagoId` = d.`pagoId`
				set d.activo = 0, p.activo = 0
				where d.`detalleId` = code_detail;
				update vipchannel_detalle_cuenta_cambio
				set monto_restante = monto_restante - code_amount,
				activo = 1
				where `detalleId` = code_detail_count and concat(anio,
				right(concat('00',mes),2)) = code_month;
			end if;
			if(code_state =4)then
				update vipchannel_pago p
				inner join vipchannel_detalle_pago d
				on p.`pagoId` = d.`pagoId`
				set d.activo = 0, p.activo = 0
				where d.`detalleId` = code_detail;
				update vipchannel_detalle_cuenta_deuda
				set monto_restante = monto_restante - code_amount,
				activo = 1
				where `detalleId` = code_detail_count and concat(anio,
				right(concat('00',mes),2)) = code_month;
			end if;
			set i = i + 1;
		end while;
		set id = 1;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePreInstallSale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePreInstallSale`(
	in detail int,
	in next int,
	in description varchar(250))
begin
	declare id int;
	set id = 0;
	update vipchannel_detalle_cuenta
	set activo = 0,
	motivo_cancelacion = description
	where `detalleId` = detail and
	consecutivo = next and
	activo = 1;
	set id = 1;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDetailContract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetailContract`(
	in detailId int,
	in nextId int)
begin
	select
		concat(substring_index(p.nombre, ' ' , 1),' ',
		p.apellido_paterno) as message,
		p.correo as email
	from
		vipchannel_detalle_cuenta vdc 
	inner join
		vipchannel_cuenta vc
	on
		vc.cuentaId = vdc.cuentaId
	inner join 
		vipchannel_persona_direccion pe
	on
		pe.documento = vc.documento 
	and
		pe.codigo = vc.codigo 
	inner join
		vipchannel_persona p
	on
		p.documento = pe.documento 
	inner join
		vipchannel_referencia re
	on
		re.documento = pe.documento 
	and
		re.codigo = pe.codigo
	where
		vdc.detalleId  = detailId
	and
		vdc.consecutivo = nextId
	limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDirectionById` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDirectionById`(document varchar(11),code varchar(8))
begin
	select
		concat(c.nombre,' ',p.numero) as direction,
		c.nombre as name,
		c.calleId as id,
		p.numero as number
	from
		vipchannel_persona_direccion p
	inner join
		vipchannel_calle c
	on
		c.calleId = p.calleId
	where
		p.activo = 1
	and
		p.documento = document
	and
		p.codigo = code;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListDirection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListDirection`()
begin
		select
			c.nombre,
			c.`calleId`
		from
			vipchannel_calle c
		where
			c.activo = 1;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListDistict` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListDistict`()
begin
	select * from vipchannel_distrito
	where activo = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManager`(in manager int)
begin
		delete from vipchannel_datos_gestor where gestor = manager;
		insert into vipchannel_datos_gestor
		(select
			null,
			pd.codigo as code,
			case when pe.empresa = "" then
			concat(pe.apellido_paterno,' ',
			pe.apellido_materno,' ',pe.nombre)
			else pe.empresa end as client,
			ca.nombre as name,
			pd.numero as number,
			concat(left(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01') as min,
			concat(left(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01') as max,
			case when dc.servicioId = 1 then "Cable" else "Internet" end as service,
			mes_monto_deuda(3,dc.`servicioId`,pd.documento,pd.codigo,99) as amount,
			manager
		from
			vipchannel_persona_direccion pd
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calle ca
		on
			ca.`calleId` = pd.`calleId`
		inner join
			vipchannel_cuenta cu
		on
			cu.documento = pd.documento
		and
			cu.codigo = pd.codigo
		inner join
			vipchannel_detalle_cuenta dc
		on
			dc.`cuentaId` = cu.`cuentaId`
		and
			dc.`consecutivoId` = cu.`consecutivoId`
		where
			pd.`gestorId` = manager
		and
			dc.activo = 1
		order by
			ca.`calleId` asc,
			dc.`servicioId` asc)
		union all
		(select
			null,
			"" as code,
			"" as client,
			"" as name,
			"" as number,
			"" as min,
			"" as max,
			"Total" as service,
			sum(mes_monto_deuda(3,dc.`servicioId`,pd.documento,pd.codigo,99)) as amount,
			manager
		from
			vipchannel_persona_direccion pd
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calle ca
		on
			ca.`calleId` = pd.`calleId`
		inner join
			vipchannel_cuenta cu
		on
			cu.documento = pd.documento
		and
			cu.codigo = pd.codigo
		inner join
			vipchannel_detalle_cuenta dc
		on
			dc.`cuentaId` = cu.`cuentaId`
		and
			dc.`consecutivoId` = cu.`consecutivoId`
		where
			pd.`gestorId` = manager
		and
			dc.activo = 1
		order by
			ca.`calleId` asc,
			dc.`servicioId` asc);
		
		select
			pd.codigo as code,
			case when pe.empresa = "" then
			concat(pe.apellido_paterno,' ',
			pe.apellido_materno,' ',pe.nombre)
			else pe.empresa end as client,
			ca.nombre as name,
			pd.numero as number,
			concat(left(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01') as min,
			concat(left(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01') as max,
			case when dc.servicioId = 1 then "Cable" else "Internet" end as service,
			mes_monto_deuda(3,dc.`servicioId`,pd.documento,pd.codigo,99) as amount
		from
			vipchannel_persona_direccion pd
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calle ca
		on
			ca.`calleId` = pd.`calleId`
		inner join
			vipchannel_cuenta cu
		on
			cu.documento = pd.documento
		and
			cu.codigo = pd.codigo
		inner join
			vipchannel_detalle_cuenta dc
		on
			dc.`cuentaId` = cu.`cuentaId`
		and
			dc.`consecutivoId` = cu.`consecutivoId`
		where
			pd.`gestorId` = manager
		and
			dc.activo = 1
		order by
			ca.`calleId` asc,
			dc.`servicioId` asc;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerEight` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerEight`()
begin
		select * from vipchannel_datos_gestor where gestor = 8;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerFive` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerFive`()
begin
		select * from vipchannel_datos_gestor where gestor = 5;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerFour` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerFour`()
begin
		select * from vipchannel_datos_gestor where gestor = 4;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerOne` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerOne`()
begin
		select * from vipchannel_datos_gestor where gestor = 1;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerSeven` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerSeven`()
begin
		select * from vipchannel_datos_gestor where gestor = 7;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerSix` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerSix`()
begin
		select * from vipchannel_datos_gestor where gestor = 6;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerThree` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerThree`()
begin
		select * from vipchannel_datos_gestor where gestor = 3;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListlienteByManagerTwo` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListlienteByManagerTwo`()
begin
		select * from vipchannel_datos_gestor where gestor = 2;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListManagerReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListManagerReport`(in manager int)
begin
	if(manager = 0)then
		select
			pd.documento,
			pd.codigo as code,
			case when pe.empresa = "" then
			concat(pe.apellido_paterno,' ',
			pe.apellido_materno,' ',pe.nombre)
			else pe.empresa end as client,
			ca.nombre as name,
			pd.numero as number,
			ifnull(se.nombre,"") as service,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(concat(left(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01'),'') end as min,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(concat(left(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01'),'') end as max,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(mes_monto_deuda(3,dc.`servicioId`,pd.documento,pd.codigo,99),'') end as amount
		from
			vipchannel_persona_direccion pd
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calle ca
		on
			ca.`calleId` = pd.`calleId`
		left join
			vipchannel_cuenta cu
		on
			cu.documento = pd.documento
		and
			cu.codigo = pd.codigo
		left join
			vipchannel_detalle_cuenta dc
		on
			dc.`cuentaId` = cu.`cuentaId`
		and
			dc.`consecutivoId` = cu.`consecutivoId`
		left join
			vipchannel_servicio se
		on
			se.`servicioId` = dc.`servicioId`
		order by
			ca.`calleId` asc,
			dc.`servicioId` asc;
	else
		select
			pd.documento,
			pd.codigo as code,
			case when pe.empresa = "" then
			concat(pe.apellido_paterno,' ',
			pe.apellido_materno,' ',pe.nombre)
			else pe.empresa end as client,
			ca.nombre as name,
			pd.numero as number,
			ifnull(se.nombre,"") as service,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(concat(left(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(1,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01'),'') end as min,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(concat(left(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),4),
			'-',right(mes_monto_deuda(2,dc.`servicioId`,pd.documento,pd.codigo,99),2),
			'-01'),'') end as max,
			case when ifnull(se.nombre,"") = "" then ""
			else
			ifnull(mes_monto_deuda(3,dc.`servicioId`,pd.documento,pd.codigo,99),'') end as amount
		from
			vipchannel_persona_direccion pd
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calle ca
		on
			ca.`calleId` = pd.`calleId`
		left join
			vipchannel_cuenta cu
		on
			cu.documento = pd.documento
		and
			cu.codigo = pd.codigo
		left join
			vipchannel_detalle_cuenta dc
		on
			dc.`cuentaId` = cu.`cuentaId`
		and
			dc.`consecutivoId` = cu.`consecutivoId`
		left join
			vipchannel_servicio se
		on
			se.`servicioId` = dc.`servicioId`
		where
			pd.`gestorId` = manager
		order by
			ca.`calleId` asc,
			dc.`servicioId` asc;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListManger` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListManger`()
begin
		select
			g.gestorId as id,
			concat(p.nombre,' ',p.apellido_paterno,' ',p.apellido_materno) as manager
		from
			vipchannel_gestor g
		inner join
			vipchannel_persona p
		on
			g.documento = p.documento
		where
			g.activo = 1;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getListModule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListModule`(
	in user varchar(50))
begin
	select
	distinct
		m.idmodulo,m.descripcion,m.ruta,m.imagen
	from
		vipchannel_asignacion a
	inner join
		vipchannel_usuario u
	on
		u.id = a.id
	inner join
		vipchannel_union_modulo um
	on
		um.detalleid = a.detalleid
	inner join
		vipchannel_modulo m
	on
		m.idmodulo = um.idmodulo
	where
		u.usuario = user;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListPay` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListPay`(in user INT,in explicite date)
begin
		declare monto_salida decimal(10,2);
		set monto_salida = 0;
		delete from vipchannel_datos_cajero where cajero = user;
		
		insert into vipchannel_datos_cajero
		(select
			null,
			d.serie as id,
			pd.codigo as code,
			case when pe.empresa = "" then
			concat(pe.apellido_paterno,' ',
			pe.apellido_materno,' ',pe.nombre)
			else pe.empresa end as client,
			monto_tipo(d.serie,1) as amount_month,
			monto_tipo(d.serie,6) as amount_two,
			monto_tipo(d.serie,2) + monto_tipo(d.serie,3) + monto_tipo(d.serie,4) + monto_tipo(d.serie,5) as amount_three,
			round(monto_tipo(d.serie,1) + monto_tipo(d.serie,2) + monto_tipo(d.serie,3) + 
				  monto_tipo(d.serie,4) + monto_tipo(d.serie,5) + monto_tipo(d.serie,6),2) as summation,
			user,
			explicite
		from
			vipchannel_detalle_pago d
		inner join
			vipchannel_pago p
		on
			d.`pagoId` = p.`pagoId`
		inner join
			vipchannel_servicios s
		on
			s.`serviciosId` = p.`serviciosId`
		inner join
			vipchannel_detalle_cuenta dc
		on
			dc.`detalleId` = s.`detalleId`
		inner join
			vipchannel_cuenta c
		on
			c.`cuentaId` = dc.`cuentaId`
		inner join
			vipchannel_persona_direccion pd
		on
			pd.documento = c.documento
		and
			pd.codigo = c.codigo
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calendario ca
		on
			ca.`calendarioId` = d.`fechaId`
		and
			concat(ca.anio,'-',ca.mes,'-',ca.dia) = explicite
		where
			p.`cajeroId` = user
		group by
			id,
			code,
			client,
			user
		order by
			d.`detalleId` asc);
		
		set monto_salida = (select ifnull(sum(CAST(summation AS DECIMAL(10,6))),0) from vipchannel_datos_cajero where CAST(summation AS DECIMAL(10,6)) > -1);
		
		insert into vipchannel_datos_cajero
		(select
			null,
			"" as id,
			"" as code,
			"" as client,
			"" as amount_month,
			"" as amount_two,
			"Total" as amount_three,
			round(sum(monto_tipo(d.serie,1) + monto_tipo(d.serie,2) + monto_tipo(d.serie,3) + 
					  monto_tipo(d.serie,4) + monto_tipo(d.serie,5) + monto_tipo(d.serie,6)),2) as summation,
			user,
			explicite
		from
			vipchannel_detalle_pago d
		inner join
			vipchannel_pago p
		on
			d.`pagoId` = p.`pagoId`
		inner join
			vipchannel_servicios s
		on
			s.`serviciosId` = p.`serviciosId`
		inner join
			vipchannel_detalle_cuenta dc
		on
			dc.`detalleId` = s.`detalleId`
		inner join
			vipchannel_cuenta c
		on
			c.`cuentaId` = dc.`cuentaId`
		inner join
			vipchannel_persona_direccion pd
		on
			pd.documento = c.documento
		and
			pd.codigo = c.codigo
		inner join
			vipchannel_persona pe
		on
			pe.documento = pd.documento
		inner join
			vipchannel_calendario ca
		on
			ca.`calendarioId` = d.`fechaId`
		and
			concat(ca.anio,'-',ca.mes,'-',ca.dia) = explicite
		where
			p.`cajeroId` = user
		group by
			id,
			code,
			client,
			user
		order by
			d.`detalleId` asc);
		
		select * from vipchannel_datos_cajero where cajero = user and CAST(summation AS DECIMAL(10,6)) > -1
		order by number asc;
		
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListPayOne` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListPayOne`()
begin
		declare countpay int;
		declare countint int;
		declare i int;
		declare j int;
		set i = 0;
		create temporary table if not exists vipchannel_data
		as
		select * from vipchannel_datos_cajero
		where cajero = 1;
		
		create temporary table if not exists vipchannel_data_copy
		as
		select * from vipchannel_datos_cajero
		where cajero = 1;
		
		create temporary TABLE `vipchannel_datos_cajero_data` (
			number int,
		  `id` varchar(20) ,
		  `code` varchar(20) ,
		  `client` varchar(200) ,
		  `amount` varchar(20) ,
		  `amounttwo` varchar(20) ,
		  `amountthree` varchar(20) ,
		  `sumation` varchar(20) ,
		  `cajero` int(11) ,
		  fecha date
		) ;
		
		set countpay = (select count(*) from vipchannel_data);
		
		if(countpay < 74)then
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,1 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,1 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1) as sumation,1 cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha)
          	union all
			(select * from vipchannel_data where code != "" order by number asc)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) * 1.00 from vipchannel_data_copy where code != ""),'',null);
		else
			set countint = round((countpay/74 + 0.49));
			while i < countint do
				set j = i*74;
				insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 as cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1 + i) as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code,concat("FECHA DE DÍA SOLICITADO: ",(select fecha from vipchannel_datos_cajero where cajero = 1 limit 1)) as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,1 cajero,null as fecha;
				insert into vipchannel_datos_cajero_data
				select * from vipchannel_data order by number asc
				limit j,74;
				set i = i + 1;
			end while;
			(select * from vipchannel_datos_cajero_data)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) from vipchannel_data_copy where code != ""),'',null);
		end if;
		
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_copy;
		drop temporary table vipchannel_datos_cajero_data;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListPayThree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListPayThree`()
begin
		declare countpay int;
		declare countint int;
		declare i int;
		declare j int;
		set i = 0;
		create temporary table if not exists vipchannel_data
		as
		select * from vipchannel_datos_cajero
		where cajero = 3;
		
		create temporary table if not exists vipchannel_data_copy
		as
		select * from vipchannel_datos_cajero
		where cajero = 3;
		
		create temporary TABLE `vipchannel_datos_cajero_data` (
			number int,
		  `id` varchar(20) ,
		  `code` varchar(20) ,
		  `client` varchar(200) ,
		  `amount` varchar(20) ,
		  `amounttwo` varchar(20) ,
		  `amountthree` varchar(20) ,
		  `sumation` varchar(20) ,
		  `cajero` int(11) ,
		  fecha date
		) ;
		
		set countpay = (select count(*) from vipchannel_data);
		
		if(countpay < 74)then
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,3 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,3 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1) as sumation,3 cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha)
          	union all
			(select * from vipchannel_data where code != "" order by number asc)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) * 1.00 from vipchannel_data_copy where code != ""),'',null);
		else
			set countint = round((countpay/74 + 0.49));
			while i < countint do
				set j = i*74;
				insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 as cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1 + i) as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code,concat("FECHA DE DÍA SOLICITADO: ",(select fecha from vipchannel_datos_cajero where cajero = 3 limit 1)) as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,3 cajero,null as fecha;
				insert into vipchannel_datos_cajero_data
				select * from vipchannel_data order by number asc
				limit j,74;
				set i = i + 1;
			end while;
			(select * from vipchannel_datos_cajero_data)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) from vipchannel_data_copy where code != ""),'',null);
		end if;
		
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_copy;
		drop temporary table vipchannel_datos_cajero_data;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListPayTwo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListPayTwo`()
begin
		declare countpay int;
		declare countint int;
		declare i int;
		declare j int;
		set i = 0;
		create temporary table if not exists vipchannel_data
		as
		select * from vipchannel_datos_cajero
		where cajero = 2;
		
		create temporary table if not exists vipchannel_data_copy
		as
		select * from vipchannel_datos_cajero
		where cajero = 2;
		
		
		create temporary TABLE `vipchannel_datos_cajero_data` (
			number int,
		  `id` varchar(20) ,
		  `code` varchar(20) ,
		  `client` varchar(200) ,
		  `amount` varchar(20) ,
		  `amounttwo` varchar(20) ,
		  `amountthree` varchar(20) ,
		  `sumation` varchar(20) ,
		  `cajero` int(11) ,
		  fecha date
		) ;
		
		set countpay = (select count(*) from vipchannel_data);
		
		if(countpay < 74)then
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,2 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,2 cajero,null as fecha)
          	union all
			(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1) as sumation,2 cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
          	(select 0 as number,"" as id,"" as code," " as client,""
          	as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha)
          	union all
			(select * from vipchannel_data where code != "" order by number asc)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) * 1.00 from vipchannel_data_copy where code != ""),'',null);
		else
			set countint = round((countpay/74 + 0.49));
			while i < countint do
				set j = i*74;
				insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 as cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("FECHA: ",cast(NOW() as DATE)) as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("HORA: ",cast(NOW() as TIME)) as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,CONCAT("N° de Página: ",1 + i) as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code,concat("FECHA DE DÍA SOLICITADO: ",(select fecha from vipchannel_datos_cajero where cajero = 2 limit 1)) as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
          		insert into vipchannel_datos_cajero_data
				select 0 as number,"" as id,"" as code," " as client,""
          		as amount,"" as amounttwo,"" as amountthree,"" as sumation,2 cajero,null as fecha;
				insert into vipchannel_datos_cajero_data
				select * from vipchannel_data order by number asc
				limit j,74;
				set i = i + 1;
			end while;
			(select * from vipchannel_datos_cajero_data)
			union all
			(select '','','','','','','Total:',(select round(ifnull(sum(summation),0),2) from vipchannel_data_copy where code != ""),'',null);
		end if;
		
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_copy;
		drop temporary table vipchannel_datos_cajero_data;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListReclaim` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListReclaim`()
begin
	select * from vipchannel_tipo_reclamo where activo= 1 ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListSeller` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListSeller`()
begin
	select v.`vendedorId`,
	case when length(p.empresa) > 1 then
		p.empresa else concat(p.nombre,' ',
		p.apellido_paterno,' ',p.apellido_materno)
		end as client
	from vipchannel_vendedor v
	inner join vipchannel_persona p
	on p.documento = v.documento
	where v.activo = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListService`()
begin
	select nombre,`servicioId` from vipchannel_servicio;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListServiceActive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListServiceActive`(
	in document varchar(20),
	in code varchar(8))
begin
	select
		se.`servicioId`,se.nombre
	from
		vipchannel_detalle_cuenta dc
	inner join
		vipchannel_cuenta cu
	on
		dc.`cuentaId` = cu.`cuentaId`
	inner join
		vipchannel_servicio se
	on
		se.`servicioId` = dc.`servicioId`
	where
		cu.codigo = code
	and
		cu.documento = document
	and
		dc.activo = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListServiceBySale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListServiceBySale`()
begin
	declare countpay int;
	
	create temporary table if not exists vipchannel_data
	as
	select * from vipchannel_datos_vendedor;
	
	set countpay = (select count(*) from vipchannel_data);

	if(countpay < 60)then
		(select 0 as id,0 as detalleId,"" as documento,""
		as codigo,"" as cliente,"" as fechainicip,"" as motivo,"" as servicio,
		"" as fechafinal,"" as vendedor,"" as activo,"" as busqueda)
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","",CONCAT(cast(NOW() as DATE)),"")
		union all
		(select 0,0,"","","","","","","","",CONCAT("HORA: ",cast(NOW() as TIME)),"")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select * from vipchannel_data);
	else
		(select 0 as id,0 as detalleId,"" as documento,""
		as codigo,"" as cliente,"" as fechainicip,"" as motivo,"" as servicio,
		"" as fechafinal,"" as vendedor,"" as activo,"" as busqueda)
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","",CONCAT("FECHA: ",cast(NOW() as DATE)),"")
		union all
		(select 0,0,"","","","","","","","",CONCAT("HORA: ",cast(NOW() as TIME)),"")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select 0,0,"","","","","","","","","","")
		union all
		(select * from vipchannel_data);
	end if;

	drop temporary table vipchannel_data;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListServicePending` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListServicePending`()
begin
	select distinct
		dc.`detalleId`,dc.consecutivo,se.nombre,case when length(pe.empresa) > 1 then
		pe.empresa else concat(pe.nombre,' ',pe.apellido_paterno,' ',pe.apellido_materno)
		end as client,concat(pv.nombre,' '
		,pv.apellido_paterno,' ',pv.apellido_materno) as sale,pe.documento,pd.codigo,
		dc.fecha_pactada,dc.motivo_instalacion
	from
		vipchannel_detalle_cuenta dc
	left join
		vipchannel_servicios s
	on
		dc.`detalleId` = s.`detalleId`
	and
		dc.consecutivo = s.consecutivo
	inner join
		vipchannel_servicio se
	on
		se.`servicioId` = dc.`servicioId`
	inner join
		vipchannel_cuenta cu
	on
		cu.`cuentaId` = dc.`cuentaId`
	inner join
		vipchannel_vendedor ve
	on
		ve.`vendedorId` = dc.vendedorid
	inner join
		vipchannel_persona_direccion pd
	on
		pd.codigo = cu.codigo
	and
		pd.documento = cu.documento
	inner join
		vipchannel_persona pe
	on
		pe.documento = pd.documento
	inner join
		vipchannel_persona pv
	on
		pv.documento = ve.documento
	where
		s.`detalleId` is null
	and
		s.consecutivo is null
	and
		dc.venta = 1
	and
		dc.activo = 1
	order by
		s.fecha_instalacion_inicial desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListStreet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListStreet`(in distric int)
begin
	select * from vipchannel_calle
	where activo = 1 and `distritoId` = distric;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListSubModule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListSubModule`(
	in user varchar(50))
begin
	select
	distinct
		m.idmodulo,s.descripcion,
		um.ruta,um.imagen
	from
		vipchannel_asignacion a
	inner join
		vipchannel_usuario u
	on
		u.id = a.id
	inner join
		vipchannel_union_modulo um
	on
		um.detalleid = a.detalleid
	inner join
		vipchannel_modulo m
	on
		m.idmodulo = um.idmodulo
	inner join
		vipchannel_submodulo s
	on
		s.idsubm = um.idsubm
	where
		u.usuario = user
	and
		um.detalleid < 8
	or
		um.detalleid > 10
	and
		um.activo  = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListUser`(in codeUser int)
begin
	if(codeUser = 0)then
		select distinct 
			u.codigo,
			u.nombre
		from 
			vipchannel_usuario u;
	end if;
	if(codeUser = 4)then
		select distinct
			u.codigo,
			u.nombre
		from 
			vipchannel_usuario u
		inner join
			vipchannel_asignacion a
		on
			a.id = u.id
		inner join
			vipchannel_rol r
		on
			r.idrol = a.idrol
		where
			r.idrol  = 4;
	end if;
	if(codeUser = 5)then
		select distinct
			u.codigo,
			u.nombre
		from 
			vipchannel_usuario u
		where
			u.codigo = 5;
	end if;
	if(codeUser = 7)then
		select distinct
			u.codigo,
			u.nombre
		from 
			vipchannel_usuario u
		inner join
			vipchannel_asignacion a
		on
			a.id = u.id
		inner join
			vipchannel_rol r
		on
			r.idrol = a.idrol
		where
			r.idrol  = 2;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListVoucher` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListVoucher`()
begin
		select
			comprobanteId as voucher,
			nombre as name
		from
			vipchannel_comprobante
		where
			activo = 1;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getManagaerCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getManagaerCount`(in con int)
begin
		if(con < 2)then
			delete from vipchannel_datos_sumatoria;
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 1 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 2 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 3 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 4 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 5 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 6 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 7 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
			on pe.documento = g.documento where g.`gestorId` = 8 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
			insert into vipchannel_datos_sumatoria
			select null,"Total" as manager,(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
			(select ifnull(sum(dg.amount),0) as amount
			from vipchannel_datos_gestor dg inner join vipchannel_gestor g
			on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
			pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "") as amount,con;
		else
			if(con > 1 and con < 3)then
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,concat("INTERVALO DE: "," 2 MESES"),"",2;
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,"","",2;
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 1 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 2 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 3 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 4 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 5 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 6 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 7 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 8 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,"Total" as manager,(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 = con and dg.max != "" and dg.min != "") as amount,con;
			else
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,concat("INTERVALO DE: "," 3 A MÁS MESES"),"",con;
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,"","",con;
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 1 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 2 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 3 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 4 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 5 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 6 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 7 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,ifnull(concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre),ifnull((select concat(pe.apellido_paterno,' ',pe.apellido_materno,
			' ',pe.nombre) from vipchannel_gestor g inner join vipchannel_persona pe
				on pe.documento = g.documento where g.`gestorId` = 8 limit 1),'')) as manager, ifnull(sum(dg.amount),0) as amount,con
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "";
				insert into vipchannel_datos_sumatoria
				select null,"Total" as manager,(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 1 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 2 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 3 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 4 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 5 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 6 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 7 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "")+
				(select ifnull(sum(dg.amount),0) as amount
				from vipchannel_datos_gestor dg inner join vipchannel_gestor g
				on dg.gestor = g.`gestorId` inner join vipchannel_persona pe on
				pe.documento = g.documento where dg.gestor = 8 and g.activo = 1 and TIMESTAMPDIFF(month, dg.min, dg.max) + 1 >= con and dg.max != "" and dg.min != "") as amount,con;
			end if;
		end if;
		select * from vipchannel_datos_sumatoria where monto != "" order by id asc;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getManagerById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getManagerById`(document varchar(11),code varchar(8))
begin
	select
		concat(p.nombre,' ',p.apellido_paterno,
		' ',p.apellido_materno) as manager,
		g.`gestorId` as documentManager
	from
		vipchannel_persona_direccion pe
	inner join
		vipchannel_gestor g
	on
		g.gestorId = pe.gestorId
	inner join
		vipchannel_persona p
	on
		p.documento = g.documento
	where
		p.trabajador = 1
	and
		pe.activo = 1
	and
		pe.documento = document
	and
		pe.codigo = code;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getManagerSumation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getManagerSumation`()
begin
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, concat("INTERVALO DE: ",(select intervalo from vipchannel_datos_sumatoria limit 1), " MESES") as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select 0 as id, "" as nombre,"" as monto, 0 as i)
		union all
		(select * from vipchannel_datos_sumatoria);
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getModule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getModule`()
begin
	select
		idmodulo,
		descripcion
	from
		vipchannel_modulo
	where
		idmodulo  != 4;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNameUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNameUser`(in user varchar(20))
begin
	select nombre from vipchannel_usuario where usuario = user;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNotification`(
	in user varchar(50))
begin
	declare cont int;
	
	if(user = "lularosaint")then
		select
			t.tareaId,
			u.nombre ,
			t.asunto,
			t.nombre as client,
 			case when t.asignado  = 0 then ""
 			else ss.nombre end as asign
		from
			vipchannel_asignacion va
		inner join
			vipchannel_union_modulo um
		on
			va.detalleid  = um.detalleid
		inner join
			vipchannel_usuario u
		on
			u.id = va.id
		inner join
			vipchannel_tarea t
		on
			t.detalleid = um.detalleid
		inner join
			vipchannel_usuario ss
		on
			ss.codigo = t.asignado 
		where
			u.usuario = user
		and
			t.activo  = 1
		and
			t.notificado = 1;
	else
		set cont = (select
						ifnull(count(*),0)
					from
						vipchannel_asignacion va
					inner join
						vipchannel_union_modulo um
					on
						va.detalleid  = um.detalleid
					inner join
						vipchannel_usuario u
					on
						u.id = va.id
					inner join
						vipchannel_tarea t
					on
						t.detalleid = um.detalleid 
					where
						u.usuario = user
					and
						t.activo  = 1
					and
						t.notificado = 1
					and
						(t.asignado  = 0
					or
						u.codigo  = t.asignado ));
		if(cont = 0)then
			select
				t.tareaId,
				s.nombre,
				t.asunto,
				t.nombre as client,
 				ss.nombre as asign
			from
				vipchannel_tarea t
			inner join
				vipchannel_usuario u
			on
				t.asignado  = u.codigo
			inner join
				vipchannel_usuario s
			on
				s.id  = t.id
			inner join
				vipchannel_usuario ss
			on
				ss.codigo = t.asignado 
			where
				u.usuario = user
			and
				t.activo  = 1
			and
				t.notificado = 1
			and
				u.codigo  = t.asignado;
		else
			select
				t.tareaId,
				u.nombre ,
				t.asunto,
				t.nombre as client,
 				ss.nombre as asign
			from
				vipchannel_asignacion va
			inner join
				vipchannel_union_modulo um
			on
				va.detalleid  = um.detalleid
			inner join
				vipchannel_usuario u
			on
				u.id = va.id
			inner join
				vipchannel_tarea t
			on
				t.detalleid = um.detalleid 
			inner join
				vipchannel_usuario ss
			on
				ss.codigo = t.asignado 
			where
				u.usuario = user
			and
				t.activo  = 1
			and
				t.notificado = 1
			and
				(t.asignado  = 0
			or
				u.codigo  = t.asignado );
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetail`(
		in document varchar(11),
		in code int,
		in user int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare code_next_service_table int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table vipchannel_data_process_list(
			information varchar(20),
			service varchar(20),
			amount decimal(10,2)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(id = 1)then
			insert into vipchannel_data_process_list
			select distinct
				concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
				case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
				code_amount_temporary as amount
			from vipchannel_data_process
			order by code_mes_temporary asc;
			select sum(amount) as amount,service,"Activo" as status from vipchannel_data_process_list group by service;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_process_list;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetailDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetailDelete`(
		in document varchar(11),
		in code varchar(8))
begin
		select "Cortado" as status,
			case when dc.`servicioId` = 1 then "Cable" else "Internet" end as service,
			ifnull(sum(dcd.monto - dcd.monto_restante),0) as amount from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
			dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
			and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 group by status,service;
		
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetailDeleteMonth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetailDeleteMonth`(
		in document varchar(11),
		in code varchar(8))
begin
		select concat(nombre_del_mes(right(dcd.mes,2)),' del ',left(dcd.anio,4)) as information,
			case when dc.`servicioId` = 1 then "Cable" else "Internet" end as service,
			ifnull(sum(dcd.monto - dcd.monto_restante),0) as amount from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
			dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
			and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 group by information,service;
		
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetailExit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetailExit`(
		in document varchar(11),
		in code varchar(8),
		in user int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare code_next_service_table int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table vipchannel_data_process_list(
			information varchar(20),
			service varchar(20),
			codeservice int,
			amount decimal(10,2)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(id = 1)then
			if(empleado = 1)then
				insert into vipchannel_data_process_list
				select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary as amount
				from vipchannel_data_process
				order by code_mes_temporary asc;
				select sum(amount) as amount,service,"Activo" as status from vipchannel_data_process_list group by service;
			else
				set end_month = (select right(concat('00',month(now())),2) limit 1);
				set end_year = (select concat(year(now()),end_month) limit 1);
				insert into vipchannel_data_process_list
				select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary as amount
				from vipchannel_data_process
				where end_year > code_mes_temporary
				order by code_mes_temporary asc;
				insert into vipchannel_data_process_list
				select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary - ifnull(monto_descuento(code_service_temporary,document,code),0) as amount
				from vipchannel_data_process
				where end_year = code_mes_temporary
				order by code_mes_temporary asc;
				
				select sum(amount) as amount,service,"Activo" as status,codeservice from vipchannel_data_process_list group by service;
			end if;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_process_list;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetailExitMonth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetailExitMonth`(
		in document varchar(11),
		in code varchar(8),
		in user int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare code_next_service_table int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process_(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table vipchannel_data_process_list(
			information varchar(20),
			service varchar(20),
			codeservice int,
			amount decimal(10,2)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		insert into vipchannel_data_process_
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(id = 1)then
			if(empleado = 1)then
				insert into vipchannel_data_process_list
				(select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary as amount
				from vipchannel_data_process
				order by code_mes_temporary asc);
				select * from vipchannel_data_process_list;
			else
				set end_month = (select right(concat('00',month(now())),2) limit 1);
				set end_year = (select concat(year(now()),end_month) limit 1);
				insert into vipchannel_data_process_list
				(select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary as amount
				from vipchannel_data_process
				where end_year > code_mes_temporary
				order by code_mes_temporary asc)
				union all
				(select distinct
					concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
					case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
					code_service_temporary,
					code_amount_temporary - ifnull(monto_descuento(code_service_temporary,document,code),0) as amount
				from vipchannel_data_process_
				where end_year = code_mes_temporary
				order by code_mes_temporary asc);
				select * from vipchannel_data_process_list;
			end if;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_process_;
		drop temporary table vipchannel_data_process_list;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPayServiceDetailMonth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPayServiceDetailMonth`(
		in document varchar(11),
		in code int,
		in user int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next_service_table int;
		declare code_next int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = 2;
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = 2 and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where p.serviciosId = 2 and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = 2 limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(id = 1)then
			select distinct
				concat(nombre_del_mes(right(code_mes_temporary,2)),' del ',left(code_mes_temporary,4)) as information,
				case when code_service_temporary = 1 then "Cable" else "Internet" end as service,
				code_amount_temporary as amount
			from vipchannel_data_process
			order by code_mes_temporary asc;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPersonByDocument` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonByDocument`(search varchar(10))
begin
	if(search = "&")then
		select
			p.documento as document,
			case when length(p.empresa) > 1 then
			p.empresa else concat(p.nombre,' ',
			p.apellido_paterno,' ',p.apellido_materno)
			end as client,
			pe.codigo as code,
			concat(c.nombre,' ',pe.numero) as direction,
			r.descripcion as reference
		from
			vipchannel_persona p
		inner join
			vipchannel_persona_direccion pe
		on
			p.documento = pe.documento
		inner join
			vipchannel_calle c
		on
			c.calleId = pe.calleId
		inner join
			vipchannel_referencia r
		on
			r.documento = pe.documento
		and
			r.codigo = pe.codigo
		where
			r.activo = 1
		and
			pe.activo = 1
		order by
			c.nombre
		asc;
	else
		select
			p.documento as document,
			case when length(p.empresa) > 1 then
			p.empresa else concat(p.nombre,' ',
			p.apellido_paterno,' ',p.apellido_materno)
			end as client,
			pe.codigo as code,
			concat(c.nombre,' ',pe.numero) as direction,
			r.descripcion as reference
		from
			vipchannel_persona p
		inner join
			vipchannel_persona_direccion pe
		on
			p.documento = pe.documento
		inner join
			vipchannel_calle c
		on
			c.calleId = pe.calleId
		inner join
			vipchannel_referencia r
		on
			r.documento = pe.documento
		and
			r.codigo = pe.codigo
		where
			r.activo = 1
		and
			pe.activo = 1
		and
			((p.documento like concat('%',search,'%'))||
			(p.nombre like concat('%',search,'%'))||
			(p.apellido_paterno like concat('%',search,'%'))||
			(p.apellido_materno like concat('%',search,'%'))||
			(pe.codigo like concat('%',search,'%'))||
			(c.nombre like concat('%',search,'%'))||
			(pe.numero like concat('%',search,'%'))||
			(r.descripcion like concat('%',search,'%')))
		order by
			c.nombre
		asc;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPersonById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonById`(document varchar(11))
begin
	select
		case when length(p.empresa) > 1 then
		p.empresa else concat(p.nombre,' ',
		p.apellido_paterno,' ',p.apellido_materno)
		end as client,
		case when p.empresa = "" then
		1 else 0
		end as type,
		p.nombre as name,
		p.apellido_paterno as last,
		p.apellido_materno as second,
		p.empresa as customer
	from
		vipchannel_persona p
	where
		p.documento = document
	and
		p.cliente = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getReclaimStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getReclaimStatus`(
	in datei date,
	in datef date)
begin
	select
		re.`reclamoD` as id,
		se.nombre as service,
		case when length(pe.empresa) > 1 then
		pe.empresa else concat(pe.nombre,' ',
		pe.apellido_paterno,' ',pe.apellido_materno)
		end as client,re.descripcion,cast(re.fecha as date)
		as date,re.activo,pd.codigo,pd.numero,ca.nombre
	from
		vipchannel_reclamo re
	inner join
		vipchannel_detalle_cuenta dc
	on
		re.`detalleId` = dc.`detalleId`
	inner join
		vipchannel_servicio se
	on
		se.`servicioId` = dc.`servicioId`
	inner join
		vipchannel_cuenta cu
	on
		cu.`cuentaId` = dc.`cuentaId`
	inner join
		vipchannel_persona_direccion pd
	on
		pd.documento = cu.documento
	and
		pd.codigo = cu.codigo
	inner join
		vipchannel_persona pe
	on
		pe.documento = pd.documento
	inner join
		vipchannel_calle ca
	on
		ca.`calleId` = pd.`calleId`
	where
		cast(re.fecha as date) >= datei
	and
		cast(re.fecha as date) <= datef
	and
		dc.activo = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getReferenceById` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getReferenceById`(document varchar(11),code varchar(8))
begin
	select
		r.descripcion as reference
	from
		vipchannel_referencia r
	where
		r.activo = 1
	and
		r.documento = document
	and
		r.codigo = code;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `getServicePreInstall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicePreInstall`(
	in codeid int,
	in datei date,
	in datef date)
begin
	
	create temporary table vipchannel_data
	as
	(select distinct
		dc.`detalleId`,dc.consecutivo,1 as pending,
		se.nombre,case when length(pe.empresa) > 1 then
		pe.empresa else concat(pe.nombre,' ',
		pe.apellido_paterno,' ',pe.apellido_materno)
		end as client,s.fecha_instalacion_inicial,ve.`vendedorId`,concat(pv.nombre,' '
		,pv.apellido_paterno,' ',pv.apellido_materno) as sale,
		pe.documento,pd.codigo,dc.fecha_pactada,dc.motivo_instalacion,"INSTALADO" as des
	from
		vipchannel_detalle_cuenta dc
	inner join
		vipchannel_servicios s
	on
		dc.`detalleId` = s.`detalleId`
	and
		dc.consecutivo = s.consecutivo
	inner join
		vipchannel_servicio se
	on
		se.`servicioId` = dc.`servicioId`
	inner join
		vipchannel_cuenta cu
	on
		cu.`cuentaId` = dc.`cuentaId`
	inner join
		vipchannel_vendedor ve
	on
		ve.`vendedorId` = ve.`vendedorId` = dc.vendedorid
	inner join
		vipchannel_persona_direccion pd
	on
		pd.codigo = cu.codigo
	and
		pd.documento = cu.documento
	inner join
		vipchannel_persona pe
	on
		pe.documento = pd.documento
	inner join
		vipchannel_persona pv
	on
		pv.documento = ve.documento
	where
		s.activo = 1
	and
		dc.venta = 1
	and
		dc.activo = 1
	order by
		s.fecha_instalacion_inicial desc)
	union all
	(select distinct
		dc.`detalleId`,dc.consecutivo,case when dc.motivo_cancelacion != "" 
		then 2 else 0 end as pending,se.nombre,case when length(pe.empresa) > 1 then
		pe.empresa else concat(pe.nombre,' ',pe.apellido_paterno,' ',pe.apellido_materno)
		end as client,"" as fecha_instalacion_inicial,ve.`vendedorId`,concat(pv.nombre,' '
		,pv.apellido_paterno,' ',pv.apellido_materno) as sale,pe.documento,pd.codigo,
		dc.fecha_pactada,case when dc.motivo_cancelacion != "" 
		then concat('I: ',dc.motivo_instalacion,'
','C:',dc.motivo_cancelacion) else dc.motivo_instalacion end as motivo_instalacion,case when dc.motivo_cancelacion != "" 
		then "ANULADO" else "PENDIENTE" end as des
	from
		vipchannel_detalle_cuenta dc
	left join
		vipchannel_servicios s
	on
		dc.`detalleId` = s.`detalleId`
	and
		dc.consecutivo = s.consecutivo
	inner join
		vipchannel_servicio se
	on
		se.`servicioId` = dc.`servicioId`
	inner join
		vipchannel_cuenta cu
	on
		cu.`cuentaId` = dc.`cuentaId`
	inner join
		vipchannel_vendedor ve
	on
		ve.`vendedorId` = dc.vendedorid
	inner join
		vipchannel_persona_direccion pd
	on
		pd.codigo = cu.codigo
	and
		pd.documento = cu.documento
	inner join
		vipchannel_persona pe
	on
		pe.documento = pd.documento
	inner join
		vipchannel_persona pv
	on
		pv.documento = ve.documento
	where
		s.`detalleId` is null
	and
		s.consecutivo is null
	and
		dc.venta = 1
	order by
		s.fecha_instalacion_inicial desc);
		
	if(codeid = 0)then
		create temporary table data_process
		as
		select * from vipchannel_data
		where datei <= 
		fecha_pactada and datef >= fecha_pactada
		order by fecha_pactada asc,pending asc;
		
		select * from vipchannel_data
		where datei <= 
		fecha_pactada and datef >= fecha_pactada
		order by fecha_pactada asc,pending asc;
	else
		create temporary table data_process
		as
		select * from vipchannel_data
		where vendedorId = codeid and datei <= 
		fecha_pactada and datef >= fecha_pactada
		order by fecha_pactada asc,pending asc;	
	
		select * from vipchannel_data
		where vendedorId = codeid and datei <= 
		fecha_pactada and datef >= fecha_pactada
		order by fecha_pactada asc,pending asc;	
	end if;
	
	delete from vipchannel_datos_vendedor;
	
	insert into vipchannel_datos_vendedor
	select null,detalleId,documento,codigo,client,
	fecha_pactada,motivo_instalacion,nombre,fecha_instalacion_inicial,
	sale,des,codeid from data_process;
	
	drop temporary table vipchannel_data;
	drop temporary table data_process;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserData`(
	in user varchar(50),
	in pass varchar(6))
begin
	declare id int;
	declare coun int;
	set coun = (select ifnull(count(*),0) from vipchannel_usuario where usuario = user and contrasena = pass and activo = 1);
	if(coun = 1)then
		select 1 as id,codigo from vipchannel_usuario where usuario = user and contrasena = pass and activo = 1;
	else
		select 0 as id,0 as codigo;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getVoucherById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getVoucherById`(document varchar(11),code varchar(8))
begin
		select
			b.comprobanteId as voucherId,
			b.nombre as voucher,
			s.nombre as name,
			s.servicioId as service
		from
			vipchannel_cuenta c
		inner join
			vipchannel_detalle_cuenta dc
		on
			c.cuentaId = dc.cuentaId
		inner join
			vipchannel_comprobante b
		on
			b.comprobanteId = dc.comprobanteid
		inner join
			vipchannel_servicio s
		on
			s.servicioId = dc.servicioId
		where
			c.documento = document
		and
			c.codigo = code
		and
			c.activo = 1
		and
			dc.activo = 1
		and
			dc.tipoId  = 1;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `patchManagerById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `patchManagerById`(
		in document varchar(11),
		in code varchar(8),
		in code_manager int)
begin
		declare id int;
		set id = 0;
		update vipchannel_persona_direccion
		set `gestorId` = code_manager
		where documento = document and codigo = codigo
		and activo = 1;
		set id = 1;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `patchUpdatePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `patchUpdatePassword`(
	in user varchar(50),
	in pass varchar(6))
begin
	declare id int;
	set id = 0;
	update vipchannel_usuario
	set contrasena = pass
	where usuario = user;
	set id = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `patchVoucherById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `patchVoucherById`(
		in document varchar(11),
		in code varchar(8),
		in voucher int,
		in service int)
begin
		declare id int;
		set id = 0;
		update vipchannel_detalle_cuenta dc
		inner join vipchannel_cuenta cu
		on cu.`cuentaId` = dc.`cuentaId` and
		cu.`consecutivoId` = dc.`consecutivoId`
		set dc.`comprobanteId` = voucher
		where dc.activo = 1 and dc.`servicioId` = service
		and cu.documento = document and cu.codigo = code;
		set id = 1;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postAgreement` */;
ALTER DATABASE `vipchannel` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postAgreement`(
		in document varchar(11),
		in code varchar(8),
		in service int,
		in amount float(10,2),
		in counts int,
		in datem date)
begin
		declare code_detail int;
		declare code_next int;
		declare id int;
		declare i int;
		declare months date;
		
		set i = 0;
		set months = (select DATE_ADD(datem, interval i month));
		set code_detail = (select ifnull(max(`detalleId`),0) from vipchannel_detalle_cuenta d inner join vipchannel_cuenta c on c.`cuentaId` = d.`cuentaId`
							and c.`consecutivoId` = d.`consecutivoId` where c.documento = document and c.codigo = code and d.activo
							= 1 and c.activo = 1 and d.`tipoId` = 1);
		set code_next = (select ifnull(max(d.consecutivo),0) from vipchannel_detalle_cuenta d inner join vipchannel_cuenta c on c.`cuentaId` = d.`cuentaId`
							and c.`consecutivoId` = d.`consecutivoId` where c.documento = document and c.codigo = code and d.activo
							= 1 and c.activo = 1 and d.`tipoId` = 1);
		if(code_detail = 0 || code_next = 0)then
			set id = 0;
		else
			while i < counts do
				if(i < counts)then
					insert into vipchannel_detalle_cuenta_historial
					select null,code_detail,code_next,amount,0,months,months,1;
				end if;
				set i = i + 1;
				set months = (select DATE_ADD(datem, interval i month));
			end while;
			set id = 1;
		end if;
		update vipchannel_detalle_cuenta
		set `tipoId` = 2
		where `detalleId` = code_detail and consecutivo = code_next and activo = 1;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `vipchannel` CHARACTER SET utf8 COLLATE utf8_bin ;
/*!50003 DROP PROCEDURE IF EXISTS `postChangeAmount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postChangeAmount`(
		in document varchar(11),
		in code varchar(8),
		in service int,
		in amount decimal(10,2),
		in dateformat date,
		in user int)
begin
		declare id_finish int;
		declare coun_finish int;
		declare detail_finish int;
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare code_next_service_table int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set id_finish= 0;
		set coun_finish = (select ifnull(max(`cuentaId`),0) from vipchannel_cuenta where documento = documento
					and codigo = code and activo = 1);
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table if not exists vipchannel_data_process(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		create temporary table vipchannel_data_process_list(
			id int auto_increment primary key,
			code_detail_temporary int,
			code_next_temporary int,
			code_service_temporary int,
			code_type_temporary int,
			code_amount_temporary float(10,2),
			code_mes_temporary int,
			code_document_temporary varchar(11),
			code_code_temporary varchar(10)
		);
		if(user = 0)then
			set id = 0;
		else
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago where `cajeroId` = user);
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto),0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set id = 1;
		end if;
		insert into vipchannel_data_process
		select null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
		from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
		order by code_mes_temporary asc;
		if(id = 1)then
			insert into vipchannel_data_process_list
			select distinct
				null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
				code_amount_temporary
			from vipchannel_data_process
			order by code_mes_temporary asc;
		end if;
		update vipchannel_detalle_cuenta_cambio
		set activo = 0
		where `detalleId` =  detail_finish;
		insert into vipchannel_detalle_cuenta_cambio
		select
		null,code_detail_temporary,code_next_temporary,code_amount_temporary,0,right(code_mes_temporary,2)
		,left(code_mes_temporary,4),1
		from vipchannel_data_process_list l where code_service_temporary = service
		and code_mes_temporary < concat(year(dateformat),right(concat('00',month(dateformat)),2));
		create temporary table vipchannel_data_detcun
		as
		select * from vipchannel_detalle_cuenta dc where
		`cuentaId` = coun_finish and activo = 1 and `servicioId` = service limit 1;
		set detail_finish = (select ifnull(max(`detalleId`),0) from vipchannel_detalle_cuenta where `cuentaId`
		= coun_finish and activo = 1 and `servicioId` = service limit 1);
		create temporary table vipchannel_data_serv
		as
		select * from vipchannel_servicios s where
		s.`detalleId` =  detail_finish and s.activo = 1 limit 1;
		update vipchannel_servicios s
		inner join vipchannel_detalle_cuenta dc
		on dc.`detalleId` = s.`detalleId`
		inner join vipchannel_cuenta cu
		on cu.`cuentaId` = dc.`cuentaId`
		set s.activo = 0,dc.activo = 0
		where s.activo = 1 and dc.activo = 1
		and dc.`servicioId` = service and
		cu.codigo = code and cu.documento = document;
		update vipchannel_data_detcun
		set consecutivo = consecutivo + 1,
		mensualidad_mensual = amount,
		mensualidad_mes_instalacion = amount,
		venta = 0;
		update vipchannel_data_serv
		set consecutivoId = consecutivoId + 1,
		consecutivo = consecutivo + 1,
		fecha_instalacion = dateformat,
		hora_instalacion = date_format(now(),'%H:%i');
		insert into vipchannel_detalle_cuenta
		select * from vipchannel_data_detcun;
		insert into vipchannel_servicios
		select * from vipchannel_data_serv;
		set id_finish = 1;
		select id_finish;
		drop temporary table vipchannel_data_detcun;
		drop temporary table vipchannel_data_serv;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_process_list;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postNotification`(
	in module int,
	in codeUser int,
	in document varchar(11),
	in client varchar(100),
	in asunt varchar(250))
begin
	declare id int;
	set id = 0;
	if(module = 1)then
		insert into vipchannel_tarea
		select null,codeUser,8,document,client,asunt,0,1,1;
		set id = 1;
	end if;
	if(module = 2)then
		insert into vipchannel_tarea
		select null,codeUser,9,document,client,asunt,0,1,1;
		set id = 1;
	end if;
	if(module = 3)then
		insert into vipchannel_tarea
		select null,codeUser,10,document,client,asunt,0,1,1;
		set id = 1;
	end if;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postPayService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postPayService`(
		in document varchar(11),
		in code varchar(8),
		in amount float(10,2),
		in user int,
		in managerId int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_next_service_table int;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int,
				code_document_temporary varchar(11),
				code_code_temporary varchar(10)
			);
			create temporary table if not exists vipchannel_data_process(
				id int auto_increment primary key,
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int,
				code_document_temporary varchar(11),
				code_code_temporary varchar(10)
			);
			create temporary table if not exists vipchannel_data_save(
				id int auto_increment primary key,
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int
			);
		if(user = 0)then
			set id = 0;
		else
			set amount_copy = amount;
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(DATE_ADD(now(), interval 2 year)),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1 and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service = 1)then
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				else
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 1 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 1 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 1 and activo = 1);				
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,1,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,1,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 1 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,1,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,1,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 1 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 1 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,1,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = 2 and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					set code_service = (select ifnull(max(servicioId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and `servicioId` = 2 and cuentaId = code_count and activo = 1 limit 1);
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where d.tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2
										and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = 2 and activo = 1);
					
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto2 + monto4;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto4 = monto4 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select
													concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,2,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,2,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto2 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = 2 and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto4 = monto4 + monto2;
								set monto5 = monto2;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,2,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,2,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = 2 and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = 2 and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,2,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			insert into vipchannel_data_process
			select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
			from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
			order by code_mes_temporary asc;
			set id_process= 1;
			set id_process_detail =(select s.code_detail_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set id_process_next = (select s.code_next_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set id_process_type = (select s.code_type_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set amount_process = (select s.code_amount_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set service_process = (select s.code_service_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set month_process = (select s.code_mes_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			while amount >= 0 do
				if(amount > amount_process)then
					insert into vipchannel_data_save
					select null,id_process_detail,id_process_next,service_process,id_process_type,amount_process,month_process;
					set amount = amount - amount_process;
				else
					insert into vipchannel_data_save
					select null,id_process_detail,id_process_next,service_process,id_process_type,amount,month_process;
					set amount = - 1;
				end if;
				set id_process= id_process + 1;
				set id_process_detail =(select s.code_detail_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set id_process_next = (select s.code_next_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set id_process_type = (select s.code_type_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set amount_process = (select s.code_amount_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set service_process = (select s.code_service_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set month_process = (select s.code_mes_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			end while;
			set id_save = 1;
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
			set i = (select 1 + ifnull(max(consecutivo),0) from vipchannel_pago);
			set id_save_count = (select ifnull(count(*),0) from vipchannel_data_save s);
			set id_save_detail = (select s.code_detail_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set id_save_next = (select s.code_next_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set id_save_type = (select s.code_type_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set amount_save = (select s.code_amount_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set service_save = (select s.code_service_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set month_save = (select s.code_mes_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where
									consecutivo = id_save_next and `detalleId` =  id_save_detail limit 1);
			set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
			set date_pay_active = (select `calendarioId` from vipchannel_calendario where dia = day(now()) and mes = right(concat('00',month(now())),2) and anio = left(year(now()),4) limit 1);
			while id_save_count >= id_save do
				if(id_save_type = 2)then
					set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_historial where `detalleId` =  id_save_detail and consecutivo =
											id_save_next and activo = 1 and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save);
					if(amount_process != amount_save)then
						update vipchannel_detalle_cuenta_historial
						set monto_restante = monto_restante + amount_save
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
						set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_historial where `detalleId` =  id_save_detail and consecutivo =
												id_save_next and activo = 1 and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save);
						if(amount_process = 0)then
							update vipchannel_detalle_cuenta_historial
							set activo = 0,monto_restante = monto
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
							and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
							update vipchannel_detalle_cuenta
							set `tipoId` = 1
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next;
						end if;
					else
						update vipchannel_detalle_cuenta_historial
						set activo = 0,monto_restante = monto
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
						update vipchannel_detalle_cuenta
						set `tipoId` = 1
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next;
					end if;
				end if;
				if(id_save_type = 3.)then
					set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_cambio where `detalleId` =  id_save_detail and consecutivo =
											id_save_next and activo = 1 and concat(anio,right(concat('00',mes),2)) = month_save);
					if(amount_process != amount_save)then
						update vipchannel_detalle_cuenta_cambio
						set monto_restante = monto_restante + amount_save
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(anio,right(concat('00',mes),2)) = month_save;
						set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_cambio where `detalleId` =  id_save_detail and consecutivo =
												id_save_next and activo = 1 and concat(anio,right(concat('00',mes),2)) = month_save);
						if(amount_process = 0)then
							update vipchannel_detalle_cuenta_cambio
							set activo = 0,monto_restante = monto
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
							and concat(anio,right(concat('00',mes),2)) = month_save;
						end if;
					else
						update vipchannel_detalle_cuenta_cambio
						set activo = 0,monto_restante = monto
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(anio,right(concat('00',mes),2)) = month_save;
					end if;
				end if;
				set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
											code_pay_cor and `cajeroId` = user);
				if(code_pay_cor = 1)then
					set string_pay = concat("B00",user,' N ',code_pay_cor_user);
				end if;
				if(code_pay_cor = 2)then
					set string_pay = concat("F00",user,' N ',code_pay_cor_user);
				end if;
				if(code_pay_cor = 3)then
					set string_pay = concat("R00",user,' N ',code_pay_cor_user);
				end if;
				set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = id_save_type and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = id_save_detail and activo = 1 limit 1);
				insert into vipchannel_pago
				select code_pay,i,user,service_save,id_save_next,amount_copy,1;
				insert into vipchannel_detalle_pago
				select null,code_pay,i,user,1,month_pay_active,date_pay_active,id_save_type,amount_save,string_pay,managerId,1;
				set id_save = id_save + 1;
				set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
				set id_save_detail = (select s.code_detail_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set id_save_next = (select s.code_next_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set id_save_type = (select s.code_type_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set amount_save = (select s.code_amount_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set service_save = (select s.code_service_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set month_save = (select s.code_mes_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where
									consecutivo = id_save_next and `detalleId` =  id_save_detail limit 1);
				set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
			end while;
			set id = 1;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_save;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postPayServiceDetailDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postPayServiceDetailDelete`(
		in document varchar(11),
		in code int,
		in amount decimal(10,2),
		in user int)
begin
		declare id int;
		declare code_detail int;
		declare counted int;
		declare count_detail int;
		declare amount_code decimal(10,2);
		declare i int;
		declare code_pay int;
		declare countpay int;
		declare servpay int;
		declare conspay int;
		declare month_pay_active int;
		declare date_pay_active int;
		declare code_pay_cor int;
		declare string_pay varchar(30);
		declare month_save int;
		declare amount_copy decimal(10,2);
		declare code_pay_cor_user int;
		set amount_copy = amount;
		create temporary table if not exists vipchannel_data(
			ids int auto_increment primary key,
			info int,
			serv int,
			price decimal(10,2)
		);
		set id = 0;
		set date_pay_active = (select `calendarioId` from vipchannel_calendario where dia = day(now()) and mes = right(concat('00',month(now())),2) and anio = left(year(now()),4) limit 1);
		set counted = (select ifnull(count(dc.`servicioId`),0) as c from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
				dc on dc.`cuentaId` = cu.`cuentaId` where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
		set countpay = (select 1 + ifnull(max(consecutivo),0) from vipchannel_pago);
		set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
		if(counted = 1)then
			set i = 0;
			insert into vipchannel_data
			select null,concat(dcd.anio,right(concat('00',dcd.mes),2)) as information,
				dc.`detalleId` as service,
				ifnull(sum(dcd.monto - dcd.monto_restante),0) as amount from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
				dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
				and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 group by information
				order by information asc,service asc;
			if((select ifnull(sum(price),0) from vipchannel_data) < amount)then
				set id= 0;
			else
				if((select ifnull(sum(price),0) from vipchannel_data) = amount)then
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N° ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo =0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				else
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N° ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set activo =0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				end if;
			end if;
		else
			set i = 0;
			insert into vipchannel_data
			select null,concat(dcd.anio,right(concat('00',dcd.mes),2)) as information,
				dc.`detalleId` as service,
				ifnull(sum(dcd.monto - dcd.monto_restante),0) as amount from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
				dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
				and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1
				group by information order by information asc,service asc;
			if((select ifnull(sum(price),0) from vipchannel_data) < amount)then
				set id= 0;
			else
				if((select ifnull(sum(price),0) from vipchannel_data) = amount)then
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data where deta = code_detail);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N° ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo =0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				else
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 1);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N° ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo =0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				end if;
			end if;
			set i = 0;
			drop temporary table vipchannel_data;
			create temporary table if not exists vipchannel_data(
				id int auto_increment,
				info int,
				serv int,
				price decimal(10,2)
			);
			insert into vipchannel_data
			select null,concat(dcd.anio,right(concat('00',dcd.mes),2)) as information,
				dc.`detalleId` as service,
				ifnull(sum(dcd.monto - dcd.monto_restante),0) as amount from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
				dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
				and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2
				group by information order by information asc,service asc;
			if((select ifnull(sum(price),0) from vipchannel_data) < amount)then
				set id= 0;
			else
				if((select ifnull(sum(price),0) from vipchannel_data) = amount)then
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data where deta = code_detail);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N° ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N° ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo =0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				else
					set code_detail = (select ifnull(max(dc.`detalleId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3);
					set count_detail = (select ifnull(count(*),0) from vipchannel_data);
					set servpay = (select ifnull(max(s.`serviciosId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2);
					set conspay = (select ifnull(max(s.`consecutivoId`),0) from vipchannel_cuenta cu inner join vipchannel_detalle_cuenta
										dc on dc.`cuentaId` = cu.`cuentaId` inner join vipchannel_detalle_cuenta_deuda dcd on dcd.`detalleId` = dc.`detalleId`
										and dcd.activo = 1 inner join vipchannel_servicios s on s.`detalleId` = dc.`detalleId`
										where cu.codigo = code and cu.documento = document and dc.`tipoId` = 3 and dc.`servicioId` = 2);
					while count_detail > i do
						set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where `detalleId` =  code_detail and activo = 1 limit 1);
						set amount_code = (select ifnull(price,0) from vipchannel_data where ids = i + 1);
						set month_save = (select ifnull(info,0) from vipchannel_data where ids = i + 1);
						set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						if(count_detail > i and amount >= amount_code)then
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							if(code_pay_cor = 1)then
								set string_pay = concat("B00",user,' N ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 2)then
								set string_pay = concat("F00",user,' N ',code_pay_cor_user);
							end if;
							if(code_pay_cor = 3)then
								set string_pay = concat("R00",user,' N ',code_pay_cor_user);
							end if;
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount_code,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 0,
							monto_restante = amount_code
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set i = i +1;
							set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
							set id= 1;
							if(amount - amount_code < 0)then
								set i = 10000;
							end if;
							set amount = amount - amount_code;
							set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
						else
							set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
													code_pay_cor and `cajeroId` = user);
							insert into vipchannel_pago
							select code_pay,countpay,user,servpay,conspay,amount_copy,1;
							insert into vipchannel_detalle_pago
							select null,code_pay,countpay,user,1,month_pay_active,date_pay_active,4,amount,string_pay,0,1;
							update vipchannel_detalle_cuenta_deuda
							set 
							activo = 1,
							monto_restante = amount
							where `detalleId` = code_detail and anio = left(month_save,4) and mes = right(month_save,2) and activo = 1;
							set id = 1;
							set i = 10000;
						end if;
					end while;
				end if;
			end if;
		end if;
		drop temporary table vipchannel_data;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postPayServiceExit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postPayServiceExit`(
		in document varchar(11),
		in code varchar(8),
		in amount float(10,2),
		in user int,
		in managerId int,
		in type int,
		in serviceSelect int)
begin
		declare count_service int;
		declare code_count int;
		declare code_next int;
		declare amount_calendar_ float(10,2);
		declare name_service varchar(10);
		declare code_service int;
		declare code_service_next int;
		declare id int;
		declare id_process_detail int;
		declare id_process_next int;
		declare end_month varchar(2);
		declare end_month_date date;
		declare code_next_service_table int;
		declare code_calendar int;
		declare code_monthId int;
		declare end_year int;
		declare pay_value int;
		declare id_save_detail int;
		declare id_save_next int;
		declare id_save_type int;
		declare monto1 float(18,2);
		declare monto2 float(18,2);
		declare monto3 float(18,2);
		declare monto4 float(18,2);
		declare monto5 float(18,2);
		declare monto11 float(18,2);
		declare monto22 float(18,2);
		declare monto33 float(18,2);
		declare monto44 float(18,2);
		declare amount_second float(10,2);
		declare amount_first float(10,2);
		declare code_detail int;
		declare count_pay int;
		declare mont_valu_data int;
		declare amount_calendar float(10,2);
		declare code_servc int;
		declare empleado int;
		declare amount_process float(10,2);
		declare id_process int;
		declare id_process_type int;
		declare service_process int;
		declare month_process int;
		declare id_save int;
		declare id_save_count int;
		declare service_save int;
		declare month_save int;
		declare code_pay_cor int;
		declare code_pay_cor_user int;
		declare string_pay varchar(30);
		declare xx int;
		declare code_next_detail int;
		declare amount_amount float(10,2);
		declare code_pay int;
		declare month_pay_active int;
		declare amount_save float(10,2);
		declare date_pay_active int;
		declare amount_copy float(10,2);
		declare i int;
		set i = 1;
		set monto1 = 0;
		set monto2 = 0;
		set monto11 = 0;
		set monto22 = 0;
		create temporary table if not exists vipchannel_data(
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int,
				code_document_temporary varchar(11),
				code_code_temporary varchar(10)
			);
			create temporary table if not exists vipchannel_data_process(
				id int auto_increment primary key,
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int,
				code_document_temporary varchar(11),
				code_code_temporary varchar(10)
			);
			create temporary table if not exists vipchannel_data_save(
				id int auto_increment primary key,
				code_detail_temporary int,
				code_next_temporary int,
				code_service_temporary int,
				code_type_temporary int,
				code_amount_temporary float(10,2),
				code_mes_temporary int
			);
		if(user = 0)then
			set id = 0;
		else
			set amount_copy = amount;
			set empleado = (select trabajador from vipchannel_persona where documento = document);
			set monto3 = 0;
			set monto4 = 0;
			set end_month = (select right(concat('00',month(now())),2) limit 1);
			set end_year = (select concat(year(now()),end_month) limit 1);
			set code_count = (select ifnull(max(cuentaId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set code_next = (select ifnull(max(consecutivoId),0) from vipchannel_cuenta where documento =
									document and codigo = code and activo = 1 limit 1);
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 1 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 and `servicioId` = serviceSelect limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service > 0)then
					set code_service = serviceSelect;
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 1  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId =1  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 1 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
							end if;
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);						
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						if(amount_calendar = amount_second)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			set count_service = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where tipoId = 2 and
									cuentaId = code_count and consecutivoId = code_next and activo = 1 and `servicioId` = serviceSelect limit 1);
			if(count_service = 0 or count_service > 3 or count_service is null)then
				set id = 0;
			else
				if(count_service > 0)then
					set code_service = serviceSelect;
					set name_service = (select s.nombre from vipchannel_detalle_cuenta d inner join vipchannel_servicio s
											on s.servicioId = d.servicioId where tipoId = 2  and d.cuentaId = code_count and consecutivoId
											= code_next and d.activo = 1 limit 1);
					set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
										and activo = 1 limit 1);
					set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2  and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = code_detail and activo = 1 limit 1);
					set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
										limit 1);
					set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
													limit 1);
					set count_pay = (select ifnull(count(*),0) from vipchannel_pago p where p.serviciosId = code_servc and p.`consecutivoId` 
										= code_next_service_table and p.activo = 1 limit 1);
					set amount_second = (select ifnull(max(mensualidad_mensual),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set amount_first = (select ifnull(max(mensualidad_mes_instalacion),0) from vipchannel_detalle_cuenta where tipoId = 2  and
										consecutivoId = code_next and cuentaId = code_count and servicioId = code_service and activo = 1);
					set code_next_detail = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = 2 and
											servicioId = code_service and	consecutivoId = code_next and cuentaId = code_count and activo = 1 limit 1);
					if(count_pay = 0)then
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set end_month_date = (select DATE_ADD(end_month_date, interval 1 month));
							set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						end while;
						set monto3 = monto3 + amount_first;
						set end_month_date = (select fecha_instalacion from vipchannel_servicios where serviciosId = code_servc and activo = 1 limit 1);
						set mont_valu_data = (select concat(year(end_month_date),right(concat('00',month(end_month_date)),2)) limit 1);
						set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
										where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
										concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,1,amount_first,mont_valu_data,document,code;
						insert into vipchannel_data
						select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
					else
						set code_calendar = (select ifnull(max(d.`calendarioId`),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p .`pagoId` where serviciosId = code_servc and d.activo = 1 limit 1);
						set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc limit 1);
						set amount_calendar_ = (select	ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
						if(amount_calendar = amount_second + amount_calendar_)then
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId + 1 limit 1);
						else
							set code_monthId = code_calendar;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_calendar limit 1);
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 1 limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,1,amount_second - amount_calendar,mont_valu_data,document,code;
							set amount_calendar = (select ifnull(sum(d.monto),0) from vipchannel_pago p inner join vipchannel_detalle_pago d
												on d.`pagoId` = p.`pagoId` where d.`calendarioId` = code_calendar and p.serviciosId = code_servc and d.state = 2 limit 1);
							set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
													where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
													concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,2,monto22 - amount_calendar,mont_valu_data,document,code;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end if;
						while mont_valu_data <= end_year do
							if(mont_valu_data <= end_year)then
								set monto1 = amount_second
											+
											(select case when empleado = 1 then 0 else valor end from vipchannel_parametro where descripcion = code_service and
													concat(anio_mes,right(concat('00',inicio_mes),2)) <= mont_valu_data
													and concat(anio_fin,right(concat('00',fin_mes),2)) >= mont_valu_data limit 1);
								set monto3 = monto1 + monto3;
								set monto5 = monto1;
								set monto22 = (select ifnull(sum(h.monto),0) from vipchannel_detalle_cuenta_historial h
												where h.`detalleId` = code_detail and h.activo = 1 and concat(year(h.fecha_inicio),right(
												concat('00',month(h.fecha_fin)),2)) = mont_valu_data and h.consecutivo = code_next_detail);
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,1,monto5,mont_valu_data,document,code;
								insert into vipchannel_data
								select code_detail,code_service_next,code_service,2,monto22,mont_valu_data,document,code;
							end if;
							set code_monthId = code_monthId + 1;
							set mont_valu_data = (select concat(anio,right(concat('00',mes),2)) from vipchannel_calendario where mesid = code_monthId limit 1);
						end while;
					end if;
					set mont_valu_data = (select concat(c.anio,right(concat('00',c.mes),2)) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.activo = 1 and k.`servicioId` = code_service and c.`detalleId` = code_detail order by anio asc, mes asc limit 1);
					while mont_valu_data <= end_year do
						if(mont_valu_data <= end_year)then
							set monto5 = (select ifnull(sum(monto)/2,0) from vipchannel_detalle_cuenta_cambio c
										  inner join vipchannel_detalle_cuenta k on k.`detalleId` = c.`detalleId`
										  where c.anio = left(mont_valu_data,4) and c.mes = right(mont_valu_data,2) and c.activo = 1
										  and k.`servicioId` = code_service and c.`detalleId` = code_detail limit 1);
							insert into vipchannel_data
							select code_detail,code_service_next,code_service,3,monto5,mont_valu_data,document,code;
						end if;
						set mont_valu_data = mont_valu_data + 1;
					end while;
				end if;
			end if;
			insert into vipchannel_data_process
			select distinct null,code_detail_temporary,code_next_temporary,code_service_temporary,code_type_temporary,code_amount_temporary,code_mes_temporary,code_document_temporary,code_code_temporary 
			from vipchannel_data where code_document_temporary = document and code_code_temporary = code and code_amount_temporary > 0
			order by code_mes_temporary asc;
			set id_process= 1;
			set id_process_detail =(select s.code_detail_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set id_process_next = (select s.code_next_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set id_process_type = (select s.code_type_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set amount_process = (select s.code_amount_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set service_process = (select s.code_service_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			set month_process = (select s.code_mes_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			while amount >= 0 do
				if(amount > amount_process)then
					insert into vipchannel_data_save
					select null,id_process_detail,id_process_next,service_process,id_process_type,amount_process,month_process;
					set amount = amount - amount_process;
				else
					insert into vipchannel_data_save
					select null,id_process_detail,id_process_next,service_process,id_process_type,amount,month_process;
					set amount = - 1;
				end if;
				set id_process= id_process + 1;
				set id_process_detail =(select s.code_detail_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set id_process_next = (select s.code_next_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set id_process_type = (select s.code_type_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set amount_process = (select s.code_amount_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set service_process = (select s.code_service_temporary from vipchannel_data_process s where s.id = id_process limit 1);
				set month_process = (select s.code_mes_temporary from vipchannel_data_process s where s.id = id_process limit 1);
			end while;
			set id_save = 1;
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
			set i = (select 1 + ifnull(max(consecutivo),0) from vipchannel_pago);
			set id_save_count = (select ifnull(count(*),0) from vipchannel_data_save s);
			set id_save_detail = (select s.code_detail_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set id_save_next = (select s.code_next_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set id_save_type = (select s.code_type_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set amount_save = (select s.code_amount_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set service_save = (select s.code_service_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set month_save = (select s.code_mes_temporary from vipchannel_data_save s where s.id = id_save limit 1);
			set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where
									consecutivo = id_save_next and `detalleId` =  id_save_detail limit 1);
			set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
			set date_pay_active = (select `calendarioId` from vipchannel_calendario where dia = day(now()) and mes = right(concat('00',month(now())),2) and anio = left(year(now()),4) limit 1);
			while id_save_count >= id_save do
				if(id_save_type = 2)then
					set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_historial where `detalleId` =  id_save_detail and consecutivo =
											id_save_next and activo = 1 and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save);
					if(amount_process != amount_save)then
						update vipchannel_detalle_cuenta_historial
						set monto_restante = monto_restante + amount_save
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
						set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_historial where `detalleId` =  id_save_detail and consecutivo =
												id_save_next and activo = 1 and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save);
						if(amount_process = 0)then
							update vipchannel_detalle_cuenta_historial
							set activo = 0,monto_restante = monto
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
							and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
							update vipchannel_detalle_cuenta
							set `tipoId` = 1
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next;
						end if;
					else
						update vipchannel_detalle_cuenta_historial
						set activo = 0,monto_restante = monto
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(year(fecha_inicio),right(concat('00',month(fecha_inicio)),2)) = month_save;
						update vipchannel_detalle_cuenta
						set `tipoId` = 1
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next;
					end if;
				end if;
				if(id_save_type = 3.)then
					set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_cambio where `detalleId` =  id_save_detail and consecutivo =
											id_save_next and activo = 1 and concat(anio,right(concat('00',mes),2)) = month_save);
					if(amount_process != amount_save)then
						update vipchannel_detalle_cuenta_cambio
						set monto_restante = monto_restante + amount_save
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(anio,right(concat('00',mes),2)) = month_save;
						set amount_process = (select ifnull(sum(monto),0) - ifnull(sum(monto_restante),0) from vipchannel_detalle_cuenta_cambio where `detalleId` =  id_save_detail and consecutivo =
												id_save_next and activo = 1 and concat(anio,right(concat('00',mes),2)) = month_save);
						if(amount_process = 0)then
							update vipchannel_detalle_cuenta_cambio
							set activo = 0,monto_restante = monto
							where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
							and concat(anio,right(concat('00',mes),2)) = month_save;
						end if;
					else
						update vipchannel_detalle_cuenta_cambio
						set activo = 0,monto_restante = monto
						where `detalleId` = id_save_detail and activo = 1 and consecutivo = id_save_next
						and concat(anio,right(concat('00',mes),2)) = month_save;
					end if;
				end if;
				set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
											code_pay_cor and `cajeroId` = user);
				if(code_pay_cor = 1)then
					set string_pay = concat("B00",user,' N ',code_pay_cor_user);
				end if;
				if(code_pay_cor = 2)then
					set string_pay = concat("F00",user,' N ',code_pay_cor_user);
				end if;
				if(code_pay_cor = 3)then
					set string_pay = concat("R00",user,' N ',code_pay_cor_user);
				end if;
				set code_service_next = (select ifnull(max(consecutivo),0) from vipchannel_detalle_cuenta where tipoId = id_save_type and
											consecutivoId = code_next and cuentaId = code_count and `detalleId` = id_save_detail and activo = 1 limit 1);
				insert into vipchannel_pago
				select code_pay,i,user,service_save,id_save_next,amount_copy,1;
				insert into vipchannel_detalle_pago
				select null,code_pay,i,user,1,month_pay_active,date_pay_active,id_save_type,amount_save,string_pay,managerId,1;
				set id_save = id_save + 1;
				set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
				set id_save_detail = (select s.code_detail_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set id_save_next = (select s.code_next_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set id_save_type = (select s.code_type_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set amount_save = (select s.code_amount_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set service_save = (select s.code_service_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set month_save = (select s.code_mes_temporary from vipchannel_data_save s where s.id = id_save limit 1);
				set code_pay_cor = (select `comprobanteId` from vipchannel_detalle_cuenta where
									consecutivo = id_save_next and `detalleId` =  id_save_detail limit 1);
				set month_pay_active = (select mesid from vipchannel_calendario where mes = right(month_save,2) and anio = left(month_save,4) limit 1);
			end while;
			set id = 1;
		end if;
		if(type = 2)then
			set code_service = serviceSelect;
			set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
									consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
									and activo = 1 limit 1);
			set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
									limit 1);
			set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
											limit 1);
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
			set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
										code_pay_cor and `cajeroId` = user);
			if(code_pay_cor = 1)then
				set string_pay = concat("B00",user,' N ',code_pay_cor_user);
			end if;
			if(code_pay_cor = 2)then
				set string_pay = concat("F00",user,' N ',code_pay_cor_user);
			end if;
			if(code_pay_cor = 3)then
				set string_pay = concat("R00",user,' N ',code_pay_cor_user);
			end if;
			insert into vipchannel_pago
			select code_pay,i,user,code_servc,code_next_service_table,amount_copy,1;
			insert into vipchannel_detalle_pago
			select null,code_pay,i,user,2,0,date_pay_active,5,10,string_pay,managerId,1;
		else
			set code_detail = (select ifnull(max(detalleId),0) from vipchannel_detalle_cuenta where tipoId = 1  and
									consecutivoId = code_next and cuentaId = code_count and servicioId = code_service
									and activo = 1 limit 1);
			set code_servc = (select ifnull(max(serviciosId),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
									limit 1);
			set code_next_service_table = (select ifnull(max(`consecutivoId`),0) from vipchannel_servicios where detalleId = code_detail and activo = 1
											limit 1);
			set code_pay = (select 1 + ifnull(max(`pagoId`),0) from vipchannel_pago);
			set code_pay_cor_user = (select valor from vipchannel_correlativo where activo = 1 and comprobanteid =
										code_pay_cor and `cajeroId` = user);
			if(code_pay_cor = 1)then
				set string_pay = concat("B00",user,' N ',code_pay_cor_user);
			end if;
			if(code_pay_cor = 2)then
				set string_pay = concat("F00",user,' N ',code_pay_cor_user);
			end if;
			if(code_pay_cor = 3)then
				set string_pay = concat("R00",user,' N ',code_pay_cor_user);
			end if;
			insert into vipchannel_pago
			select code_pay,i,user,code_servc,code_next_service_table,amount_copy,1;
			insert into vipchannel_detalle_pago
			select null,code_pay,i,user,3,0,date_pay_active,5,20,string_pay,managerId,1;
		end if;
		drop temporary table vipchannel_data;
		drop temporary table vipchannel_data_process;
		drop temporary table vipchannel_data_save;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postReclaimById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postReclaimById`(
	in document varchar(20),
	in code varchar(8),
	in service int,
	in reclaim int,
	in description varchar(250))
begin
	declare id int;
	declare codeDetailt int;
	declare codenext int;
	set id = 0;
	set codeDetailt = (select ifnull(max(dc.`detalleId`),0) from vipchannel_detalle_cuenta dc inner join vipchannel_cuenta cu
						on dc.`cuentaId` = cu.`cuentaId`and dc.`servicioId` = service and dc.activo = 1
						and cu.codigo = code and cu.documento = document);
	set codenext = (select ifnull(max(dc.consecutivo),0) from vipchannel_detalle_cuenta dc inner join vipchannel_cuenta cu
						on dc.`cuentaId` = cu.`cuentaId`and dc.`servicioId` = service and dc.activo = 1
						and cu.codigo = code and cu.documento = document);
	
	if(codeDetailt = 0 or codenext = 0)then
		set id = 0;
	else
		insert into vipchannel_reclamo
		select null,codeDetailt,codenext,reclaim,description,now(),0;
		set id = 1;
	end if;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `postSaveServiceSale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `postSaveServiceSale`(
	in document varchar(20),
	in code varchar(8),
	in name varchar(30),
	in last varchar(30),
	in second varchar(30),
	in client varchar(200),
	in fech date,
	in email varchar(100),
	in zone int,
	in number varchar(50),
	in descriptionrefe varchar(255),
	in seller int,
	in fechadate date,
	in timedate VARCHAR(10),
	in servicecount int,
	in amountfirst float(10,2),
	in amountsecond float(10,2),
	in textins varchar(250))
begin
	declare countperson int;
	declare countdocucode int;
	declare countmanagerclient int;
	declare countcount int;
	declare manager int;
	declare managerzone int;
	declare zoneid int;
	declare countcode int;
	declare countcodedetail int;
	declare countactivecc int;
	declare countactiveic int;
	declare countclient int;
	declare countclientnext int;
	declare id int;
	set id = 0;
	set countperson = (select ifnull(count(*),0) from vipchannel_persona where documento = document);
	set countdocucode = (select ifnull(count(*),0) from vipchannel_persona_direccion pd  inner join vipchannel_persona pe on pe.documento = pd.documento
							 where pd.activo = 1 and pd.documento = document and pd.codigo = code);
	set countcode = (select 1 + ifnull(max(`cuentaId`),0) from vipchannel_cuenta);
	set countcodedetail = (select 1 + ifnull(max(`detalleId`),0) from vipchannel_detalle_cuenta);
	if(countperson = 0)then
		insert into vipchannel_persona
		select document,name,last,second,case when length(client) < 2 then "" else client end,1,0,fech,email;
	else
		update vipchannel_persona
		set cliente = 1,
			empresa = case when length(client) < 2 then "" else client end 
		where documento = document;
	end if;
	set id = 1;
	if(id = 1)then
		if(countdocucode < 1)then
			if(countmanagerclient = 1)then
				set countmanagerclient =(select ifnull(count(*),0) from vipchannel_gestor_calle gc where `calleId` = zone);
				set manager =(select gc.`gestorId` from vipchannel_gestor_calle gc where `calleId` = zone);
				set managerzone =(select gc.`gestorCalleId` from vipchannel_gestor_calle gc where `calleId` = zone);
				set zoneid =(select ifnull(max(pd.`zonaId`),0) from vipchannel_persona_direccion pd where `calleId` = zone);
				insert into vipchannel_persona_direccion
				select document,code,managerzone,zone,manager,zoneid,number,"","",1,1;
				insert into vipchannel_referencia
				select null,document,code,descriptionrefe,1;
				set id = 1;
			else
				insert into vipchannel_persona_direccion
				select document,code,0,zone,0,0,number,"","",1,1;
				insert into vipchannel_referencia
				select null,document,code,descriptionrefe,1;
				set id = 1;
			end if;
		else
			set id = 1;
		end if;
	else
		set id = 1;
	end if;
	if(id = 1)then
		set countcount = (select ifnull(count(*),0) from vipchannel_cuenta where documento = document and codigo = code and activo = 1);
		if(countcount > 0)then
			set countclient = (select ifnull(max(`cuentaId`),0) from vipchannel_cuenta where documento = document and codigo = code and activo = 1);
			set countclientnext = (select ifnull(max(`consecutivoId`),0) from vipchannel_cuenta where documento = document and codigo = code and activo = 1);
			set id = 1;
		else
			insert into vipchannel_cuenta
			select countcode,1,document,code,1;
			set id = 1;
			set countclient = (select ifnull(max(`cuentaId`),0) from vipchannel_cuenta where documento = document and codigo = code and activo = 1);
			set countclientnext = (select ifnull(max(`consecutivoId`),0) from vipchannel_cuenta where documento = document and codigo = code and activo = 1);
		end if;
	else
		if(id = 2)then
			set id = 2;
		else
			set id = 0;
		end if;
	end if;
	if(id = 1)then
		set countactivecc = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where `cuentaId` = countclient and activo = 1 and `servicioId` = 1 and `tipoId` < 4);
		set countactiveic = (select ifnull(count(*),0) from vipchannel_detalle_cuenta where `cuentaId` = countclient and activo = 1 and `servicioId` = 2 and `tipoId` < 4);
		if(countactivecc > 0 and countactiveic > 0)then
			set id = 2;
		else
			if(servicecount = 1 and countactivecc < 1)then
				insert into vipchannel_detalle_cuenta
				select countcodedetail,1,1,countclient,countclientnext,1,1,1,amountsecond,amountfirst,amountfirst,fechadate,textins,'','',seller,1,1;
				set id = 1;
			else
				if(servicecount = 2 and countactiveic < 1)then
					insert into vipchannel_detalle_cuenta
					select countcodedetail,1,1,countclient,countclientnext,2,1,1,amountsecond,amountfirst,amountfirst,fechadate,textins,'','',seller,1,1;
					set id = 1;
				else
					if(servicecount = 2 and countactivecc < 1 and countactiveic < 1)then
						insert into vipchannel_detalle_cuenta
						select countcodedetail,1,1,countclient,countclientnext,1,1,1,amountsecond,amountfirst,amountfirst,fechadate,textins,'','',seller,1,1;
						insert into vipchannel_detalle_cuenta
						select countcodedetail,1,1,countclient,countclientnext,2,1,1,amountsecond,amountfirst,amountfirst,fechadate,textins,'','',seller,1,1;
						set id = 1;
					else
						set id = 0;
					end if;
				end if;
			end if;
			set id = 1;
		end if;
	else
		if(id = 2)then
			set id = 2;
		else
			set id = 0;
		end if;
	end if;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `putChangeAsignation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `putChangeAsignation`(
	in notiId int,
	in aigId int
)
begin
	declare id int;
	set id = 0;
	update 
		vipchannel_tarea 
	set
		asignado = aigId
	where
		tareaId = notiId;
	set id = 1;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `putChangeDirectionById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `putChangeDirectionById`(
	in document varchar(11),
	in code varchar(8),
	in number varchar(50),
	in zone int,
	in reference varchar(250))
begin
	declare id int;
	declare idcount int;
	set id = 0;
	set idcount = (select ifnull(max(`cuentaId`),0) from vipchannel_cuenta where documento = document and codigo = code);
	
	create temporary table if not exists vipchannel_data_update
	as
	select * from vipchannel_persona_direccion
	where codigo = code and documento = document;
	
	create temporary table if not exists vipchannel_data_detalle
	as
	select * from vipchannel_detalle_cuenta
	where `cuentaId` = idcount;
	
	update
		vipchannel_persona_direccion
	set
		activo = 0
	where
		documento = document
	and
		codigo = code
	and
		activo = 1;
	
	update
		vipchannel_detalle_cuenta
	set
		activo = 0
	where
		`cuentaId` = idcount;
	
	update
		vipchannel_servicios s
	inner join
		vipchannel_detalle_cuenta dc
	on
		s.`detalleId` = dc.`detalleId`
	inner join
		vipchannel_cuenta cu
	on
		cu.`cuentaId` = dc.`cuentaId`
	set
		s.activo = 0
	where
		cu.codigo = code
	and
		cu.documento = document;
	
	update
		vipchannel_referencia
	set
		activo = 0
	where
		codigo = code
	and
		documento = document;
	
	
	
	
	
	update
		vipchannel_data_update
	set
		numero = number,
		`calleId` = zone,
		latitud = "",
		longitud = ""
	where
		documento = document
	and
		codigo = code
	and
		activo = 1;
	
	update
		vipchannel_data_detalle
	set
		consecutivo = consecutivo + 1,
		`instalacionId` = 3,
		vendedorid = 0
	where
		`cuentaId` = idcount;
	
	insert into vipchannel_persona_direccion
	select *  from vipchannel_data_update;
	
	insert into vipchannel_detalle_cuenta
	select * from vipchannel_data_detalle;
	
	insert into vipchannel_referencia
	select null,document,code,reference,1;
	
	drop temporary table vipchannel_data_update;
	drop temporary table vipchannel_data_detalle;
	
	set id = 1;
	select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `putDirectionById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `putDirectionById`(
		in document varchar(11),
		in code varchar(8),
		in number varchar(50),
		in zone int)
begin
		declare id int;
		set id = 0;
	    update
			vipchannel_persona_direccion
		set
			numero = number
		where
			documento = document
		and
			codigo = code
		and
			activo = 1;
		set id = 1;
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `putPersonById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `putPersonById`(
		in document varchar(11),
		in name varchar(100),
		in last varchar(100),
		in second varchar(100),
		in client varchar(100))
begin
		declare id int;
		set id = 0;
	    update
			vipchannel_persona
		set
			nombre = name,
			apellido_paterno = last,
			apellido_materno = second,
			empresa = case when length(client) < 2 then "" else client end
		where
			documento = document;
		set id = 1;
		select id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `putReferenceById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `putReferenceById`(
		in document varchar(11),
		in code varchar(8),
		in description varchar(250))
begin
		declare id int;
	    	update
				vipchannel_referencia
			set
				activo = 0
			where
				documento = document
			and
				codigo = code
			and
				activo = 1;
			insert into vipchannel_referencia
			select null,document,code,description,1;
			set id = 1;	
		select id;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `returnGetContract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `returnGetContract`(
	in detailId int,
	in nextId int,
	out client varchar(200),
	out email varchar(200),
	out customer varchar(200),
	out direction varchar(200),
	out document varchar(11))
begin
	select
		concat(p.nombre,' ',
		p.apellido_paterno,' ',p.apellido_materno)
		as clients,p.correo as emails,p.empresa as customers,
		concat(cal.nombre ,' ',pe.numero ,' ,Distrito ',dis.nombre ),
		p.documento 
		into client,email,customer,direction,document
	from
		vipchannel_detalle_cuenta vdc 
	inner join
		vipchannel_cuenta vc
	on
		vc.cuentaId = vdc.cuentaId
	inner join 
		vipchannel_persona_direccion pe
	on
		pe.documento = vc.documento 
	and
		pe.codigo = vc.codigo 
	inner join
		vipchannel_persona p
	on
		p.documento = pe.documento
	inner join
		vipchannel_calle cal
	on
		cal.calleId  = pe.calleId 
	inner join
		vipchannel_distrito dis
	on
		dis.distritoId  = cal.distritoId 
	inner join
		vipchannel_referencia re
	on
		re.documento = pe.documento 
	and
		re.codigo = pe.codigo
	where
		vdc.detalleId  = detailId
	and
		vdc.consecutivo = nextId
	limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:35
