package com.dev.op.core.rest.vipchannel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListSellerModel;
import com.dev.op.core.dto.vipchannel.getListStreetModel;
import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;
import com.dev.op.core.dto.vipchannel.getListDistictModel;
import com.dev.op.core.facade.vipchannel.VentaFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v1/venta")
public class VentaRestController {
	
	@Autowired
	@Qualifier("ventaFacade")
	private VentaFacade ventaFacade;
	
	@GetMapping("/postSaveServiceSale/{document}/{code}/{name}/{last}/{second}/{client}/{fech}/{zone}/{number}/{descriptionrefe}/{seller}/{fechadate}/{timedate}/{servicecount}/{amountfirst}/{amountsecond}/{textins}")
	public ResponseEntity<List<ResponseModel>> postPayServiceDetailDelete(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="name") String name,
			@PathVariable(value="last") String last,
			@PathVariable(value="second") String second,
			@PathVariable(value="client") String client,
			@PathVariable(value="fech") String fech,
			@PathVariable(value="zone") Integer zone,
			@PathVariable(value="number") String number,
			@PathVariable(value="descriptionrefe") String descriptionrefe,
			@PathVariable(value="seller") Integer seller,
			@PathVariable(value="fechadate") String fechadate,
			@PathVariable(value="timedate") String timedate,
			@PathVariable(value="servicecount") Integer servicecount,
			@PathVariable(value="amountfirst") String amountfirst,
			@PathVariable(value="amountsecond") String amountsecond,
			@PathVariable(value="textins") String textins){
		
		try{
			List<ResponseModel> postPayServiceDetailDelete = ventaFacade.postSaveServiceSale(document, code, name, last, second, client, fech, zone, number, descriptionrefe, seller, fechadate, timedate, servicecount, amountfirst, amountsecond, textins);
			if(!GenericUtil.isCollectionEmpty(postPayServiceDetailDelete)) {
				return new ResponseEntity<List<ResponseModel>>(postPayServiceDetailDelete, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListSeller")
	public ResponseEntity<List<getListSellerModel>> getListSeller() {
		
		try{
			List<getListSellerModel> getListSeller = ventaFacade.getListSeller();
			if(!GenericUtil.isCollectionEmpty(getListSeller)) {
				return new ResponseEntity<List<getListSellerModel>>(getListSeller, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListSellerModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListSellerModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListDistict")
	public ResponseEntity<List<getListDistictModel>> getListDistict() {
		
		try{
			List<getListDistictModel> getListDistict = ventaFacade.getListDistict();
			if(!GenericUtil.isCollectionEmpty(getListDistict)) {
				return new ResponseEntity<List<getListDistictModel>>(getListDistict, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListDistictModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListDistictModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListStreet/{distric}")
	public ResponseEntity<List<getListStreetModel>> getListStreet(@PathVariable(value="distric") Integer distric) {
		
		try{
			List<getListStreetModel> getListStreet = ventaFacade.getListStreet(distric);
			if(!GenericUtil.isCollectionEmpty(getListStreet)) {
				return new ResponseEntity<List<getListStreetModel>>(getListStreet, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListStreetModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListStreetModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getServicePreInstall/{codeid}/{datei}/{datef}")
	public ResponseEntity<List<getServicePreInstallModel>> getServicePreInstall(
			@PathVariable(value="codeid") Integer codeid,
			@PathVariable(value="datei") String datei,
			@PathVariable(value="datef") String datef) {
		
		try{
			List<getServicePreInstallModel> getServicePreInstall = ventaFacade.getServicePreInstall(codeid, datei, datef);
			if(!GenericUtil.isCollectionEmpty(getServicePreInstall)) {
				return new ResponseEntity<List<getServicePreInstallModel>>(getServicePreInstall, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getServicePreInstallModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getServicePreInstallModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putChangeDirectionById/{document}/{code}/{number}/{zone}/{reference}")
	public ResponseEntity<List<ResponseModel>> putChangeDirectionById(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="number") String number,
			@PathVariable(value="zone") Integer zone,
			@PathVariable(value="reference") String reference) {
		
		try{
			List<ResponseModel> putChangeDirectionById = ventaFacade.putChangeDirectionById(document, code, number, zone, reference);
			if(!GenericUtil.isCollectionEmpty(putChangeDirectionById)) {
				return new ResponseEntity<List<ResponseModel>>(putChangeDirectionById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
}
