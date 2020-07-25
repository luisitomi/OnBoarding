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

import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.dto.vipchannel.getMaterialModel;
import com.dev.op.core.dto.vipchannel.getListServiceRangeModel;
import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListReclaimServiceModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getListTecniModel;
import com.dev.op.core.facade.vipchannel.ServiceFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/servicio")
public class ServiceRestController {
	
	@Autowired
	@Qualifier("serviceFacade")
	private ServiceFacade serviceFacade;
	
	@GetMapping("/getListServicePending/{codeUser}")
	public ResponseEntity<List<getListServicePendingModel>> getListServicePending(@PathVariable(value="codeUser") Integer codeUser) {
		
		try{
			List<getListServicePendingModel> getListServicePending = serviceFacade.getListServicePending(codeUser);
			if(!GenericUtil.isCollectionEmpty(getListServicePending)) {
				return new ResponseEntity<List<getListServicePendingModel>>(getListServicePending, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListServicePendingModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListServicePendingModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListReclaimService/{codeint}")
	public ResponseEntity<List<getListReclaimServiceModel>> getListReclaimService(@PathVariable(value="codeint") Integer codeint) {
		
		try{
			List<getListReclaimServiceModel> getListReclaimService = serviceFacade.getListReclaimService(codeint);
			if(!GenericUtil.isCollectionEmpty(getListReclaimService)) {
				return new ResponseEntity<List<getListReclaimServiceModel>>(getListReclaimService, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListReclaimServiceModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListReclaimServiceModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getMaterialAll")
	public ResponseEntity<List<getMaterialAllModel>> getMaterialAll() {
		
		try{
			List<getMaterialAllModel> getMaterialAll = serviceFacade.getMaterialAll();
			if(!GenericUtil.isCollectionEmpty(getMaterialAll)) {
				return new ResponseEntity<List<getMaterialAllModel>>(getMaterialAll, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getMaterialAllModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getMaterialAllModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListTecni")
	public ResponseEntity<List<getListTecniModel>> getListTecni() {
		
		try{
			List<getListTecniModel> getListTecni = serviceFacade.getListTecni();
			if(!GenericUtil.isCollectionEmpty(getListTecni)) {
				return new ResponseEntity<List<getListTecniModel>>(getListTecni, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListTecniModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListTecniModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getMaterial")
	public ResponseEntity<List<getMaterialModel>> getMaterial() {
		
		try{
			List<getMaterialModel> getMaterial = serviceFacade.getMaterial();
			if(!GenericUtil.isCollectionEmpty(getMaterial)) {
				return new ResponseEntity<List<getMaterialModel>>(getMaterial, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getMaterialModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getMaterialModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListServiceRange/{datei}/{datef}")
	public ResponseEntity<List<getListServiceRangeModel>> getListServiceRange(
			@PathVariable(value="datei") String datei,
			@PathVariable(value="datef") String datef) {
		
		try{
			List<getListServiceRangeModel> getListServiceRange = serviceFacade.getListServiceRange(datei, datef);
			if(!GenericUtil.isCollectionEmpty(getListServiceRange)) {
				return new ResponseEntity<List<getListServiceRangeModel>>(getListServiceRange, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListServiceRangeModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListServiceRangeModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postMaterial/{name}")
	public ResponseEntity<List<ResponseModel>> postMaterial(
			@PathVariable(value="name") String name) {
		
		try{
			List<ResponseModel> postMaterial = serviceFacade.postMaterial(name);
			if(!GenericUtil.isCollectionEmpty(postMaterial)) {
				return new ResponseEntity<List<ResponseModel>>(postMaterial, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postServiceInstall/{detaiId}/{nextId}/{tec}/{description}/{mateId}/{counts}")
	public ResponseEntity<List<ResponseModel>> postServiceInstall(
			@PathVariable(value="detaiId") Integer detaiId,
			@PathVariable(value="nextId") Integer nextId,
			@PathVariable(value="tec") Integer tec,
			@PathVariable(value="description") String description,
			@PathVariable(value="mateId") Integer mateId,
			@PathVariable(value="counts") Integer counts) {
		
		try{
			List<ResponseModel> postServiceInstall = serviceFacade.postServiceInstall(detaiId, nextId, tec, description, mateId, counts);
			if(!GenericUtil.isCollectionEmpty(postServiceInstall)) {
				return new ResponseEntity<List<ResponseModel>>(postServiceInstall, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postServiceReclaim/{detaiId}/{tec}/{description}/{mateId}/{counts}")
	public ResponseEntity<List<ResponseModel>> postServiceReclaim(
			@PathVariable(value="detaiId") Integer detaiId,
			@PathVariable(value="tec") Integer tec,
			@PathVariable(value="description") String description,
			@PathVariable(value="mateId") Integer mateId,
			@PathVariable(value="counts") Integer counts) {
		
		try{
			List<ResponseModel> postServiceReclaim = serviceFacade.postServiceReclaim(detaiId, tec, description, mateId, counts);
			if(!GenericUtil.isCollectionEmpty(postServiceReclaim)) {
				return new ResponseEntity<List<ResponseModel>>(postServiceReclaim, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putMaterial/{name}/{idMaterial}")
	public ResponseEntity<List<ResponseModel>> putMaterial(
			@PathVariable(value="name") String name,
			@PathVariable(value="idMaterial") Integer idMaterial) {
		
		try{
			List<ResponseModel> putMaterial = serviceFacade.putMaterial(name, idMaterial);
			if(!GenericUtil.isCollectionEmpty(putMaterial)) {
				return new ResponseEntity<List<ResponseModel>>(putMaterial, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putTecnInstall/{optionI}/{tecn}/{idP}/{nextId}")
	public ResponseEntity<List<ResponseModel>> putTecnInstall(
			@PathVariable(value="optionI") Integer optionI,
			@PathVariable(value="tecn") Integer tecn,
			@PathVariable(value="idP") Integer idP,
			@PathVariable(value="nextId") Integer nextId) {
		
		try{
			List<ResponseModel> putTecnInstall = serviceFacade.putTecnInstall(optionI, tecn, idP, nextId);
			if(!GenericUtil.isCollectionEmpty(putTecnInstall)) {
				return new ResponseEntity<List<ResponseModel>>(putTecnInstall, HttpStatus.OK);
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
