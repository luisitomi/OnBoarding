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

import com.dev.op.core.dto.vipchannel.getProductProviderModel;
import com.dev.op.core.dto.vipchannel.getProviderModel;
import com.dev.op.core.dto.vipchannel.getListRemisionModel;
import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;
import com.dev.op.core.dto.vipchannel.getProdctModel;
import com.dev.op.core.facade.vipchannel.StorageFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/almacen")
public class StorageRestController {
	
	@Autowired
	@Qualifier("storageFacade")
	private StorageFacade storageFacade;
	
	@GetMapping("/getProdct")
	public ResponseEntity<List<getProdctModel>> getProdct() {
		
		try{
			List<getProdctModel> getProdct = storageFacade.getProdct();
			if(!GenericUtil.isCollectionEmpty(getProdct)) {
				return new ResponseEntity<List<getProdctModel>>(getProdct, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getProdctModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getProdctModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getProductProvider/{optio}/{productoE}")
	public ResponseEntity<List<getProductProviderModel>> getProductProvider(
			@PathVariable(value="optio") Integer optio,
			@PathVariable(value="productoE") Integer productoE) {
		
		try{
			List<getProductProviderModel> getProductProvider = storageFacade.getProductProvider(optio, productoE);
			if(!GenericUtil.isCollectionEmpty(getProductProvider)) {
				return new ResponseEntity<List<getProductProviderModel>>(getProductProvider, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getProductProviderModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getProductProviderModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getProvider")
	public ResponseEntity<List<getProviderModel>> getProvider() {
		
		try{
			List<getProviderModel> getProvider = storageFacade.getProvider();
			if(!GenericUtil.isCollectionEmpty(getProvider)) {
				return new ResponseEntity<List<getProviderModel>>(getProvider, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getProviderModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getProviderModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListRemision")
	public ResponseEntity<List<getListRemisionModel>> getListRemision() {
		
		try{
			List<getListRemisionModel> getListRemision = storageFacade.getListRemision();
			if(!GenericUtil.isCollectionEmpty(getListRemision)) {
				return new ResponseEntity<List<getListRemisionModel>>(getListRemision, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListRemisionModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListRemisionModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListRemisionById/{remisId}")
	public ResponseEntity<List<getListRemisionByIdModel>> getListRemisionById(@PathVariable(value="remisId") Integer remisId) {
		
		try{
			List<getListRemisionByIdModel> getListRemisionById = storageFacade.getListRemisionById(remisId);
			if(!GenericUtil.isCollectionEmpty(getListRemisionById)) {
				return new ResponseEntity<List<getListRemisionByIdModel>>(getListRemisionById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListRemisionByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListRemisionByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postProductP/{productId}/{provideId}/{price}")
	public ResponseEntity<List<ResponseModel>> postProductP(
			@PathVariable(value="productId") Integer productId,
			@PathVariable(value="provideId") Integer provideId,
			@PathVariable(value="price") String price) {
		
		try{
			List<ResponseModel> postProductP = storageFacade.postProductP(productId, provideId, price);
			if(!GenericUtil.isCollectionEmpty(postProductP)) {
				return new ResponseEntity<List<ResponseModel>>(postProductP, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postSaveProvide/{name}")
	public ResponseEntity<List<ResponseModel>> postSaveProvide(
			@PathVariable(value="name") String name) {
		
		try{
			List<ResponseModel> postSaveProvide = storageFacade.postSaveProvide(name);
			if(!GenericUtil.isCollectionEmpty(postSaveProvide)) {
				return new ResponseEntity<List<ResponseModel>>(postSaveProvide, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postSaveProduc/{name}/{code}/{description}/{codeP}/{medi}")
	public ResponseEntity<List<ResponseModel>> postSaveProduc(
			@PathVariable(value="name") String name,
			@PathVariable(value="code") String code,
			@PathVariable(value="description") String description,
			@PathVariable(value="codeP") String codeP,
			@PathVariable(value="medi") String medi) {
		
		try{
			List<ResponseModel> postSaveProduc = storageFacade.postSaveProduc(name, code, description, codeP, medi);
			if(!GenericUtil.isCollectionEmpty(postSaveProduc)) {
				return new ResponseEntity<List<ResponseModel>>(postSaveProduc, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postRemision/{options}/{typeRemi}/{producId}/{providerId}/{counts}/{autorize}/{codeuser}")
	public ResponseEntity<List<ResponseModel>> postSaveProduc(
			@PathVariable(value="options") Integer options,
			@PathVariable(value="typeRemi") Integer typeRemi,
			@PathVariable(value="producId") Integer producId,
			@PathVariable(value="providerId") Integer providerId,
			@PathVariable(value="counts") Integer counts,
			@PathVariable(value="conditions") String conditions,
			@PathVariable(value="autorize") String autorize,
			@PathVariable(value="codeuser") Integer codeuser) {
		
		try{
			List<ResponseModel> postRemision = storageFacade.postRemision(options, typeRemi, producId, providerId, counts, conditions, autorize, codeuser);
			if(!GenericUtil.isCollectionEmpty(postRemision)) {
				return new ResponseEntity<List<ResponseModel>>(postRemision, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putSaveProvide/{name}/{provideId}")
	public ResponseEntity<List<ResponseModel>> putSaveProvide(
			@PathVariable(value="name") String name,
			@PathVariable(value="provideId") Integer provideId) {
		
		try{
			List<ResponseModel> putSaveProvide = storageFacade.putSaveProvide(name, provideId);
			if(!GenericUtil.isCollectionEmpty(putSaveProvide)) {
				return new ResponseEntity<List<ResponseModel>>(putSaveProvide, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putSaveProduct/{producId}/{name}/{code}/{description}/{codeP}/{medi}")
	public ResponseEntity<List<ResponseModel>> putSaveProduct(
			@PathVariable(value="producId") Integer producId,
			@PathVariable(value="name") String name,
			@PathVariable(value="code") String code,
			@PathVariable(value="description") String description,
			@PathVariable(value="codeP") String codeP,
			@PathVariable(value="medi") String medi) {
		
		try{
			List<ResponseModel> putSaveProduct = storageFacade.putSaveProduct(producId, name, code, description, codeP, medi);
			if(!GenericUtil.isCollectionEmpty(putSaveProduct)) {
				return new ResponseEntity<List<ResponseModel>>(putSaveProduct, HttpStatus.OK);
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
