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
import com.dev.op.core.dto.vipchannel.getListActivationModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuStateModel;
import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;
import com.dev.op.core.facade.vipchannel.ActivacionFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/activacion")
public class ActivacionRestController {
	
	@Autowired
	@Qualifier("activacionFacade")
	private ActivacionFacade activacionFacade;
	
	@GetMapping("/getListOnu")
	public ResponseEntity<List<getListOnuModel>> getListOnu() {
		
		try{
			List<getListOnuModel> getListOnu = activacionFacade.getListOnu();
			if(!GenericUtil.isCollectionEmpty(getListOnu)) {
				return new ResponseEntity<List<getListOnuModel>>(getListOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListOnuModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListOnuModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListOnuState")
	public ResponseEntity<List<getListOnuStateModel>> getListOnuState() {
		
		try{
			List<getListOnuStateModel> getListOnuState = activacionFacade.getListOnuState();
			if(!GenericUtil.isCollectionEmpty(getListOnuState)) {
				return new ResponseEntity<List<getListOnuStateModel>>(getListOnuState, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListOnuStateModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListOnuStateModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListActivation")
	public ResponseEntity<List<getListActivationModel>> getListActivation() {
		
		try{
			List<getListActivationModel> getListActivation = activacionFacade.getListActivation();
			if(!GenericUtil.isCollectionEmpty(getListActivation)) {
				return new ResponseEntity<List<getListActivationModel>>(getListActivation, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListActivationModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListActivationModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListCountOnu/{detalleIds}/{nextids}")
	public ResponseEntity<List<getListCountOnuModel>> getListCountOnu(
			@PathVariable(value="detalleIds") Integer detalleIds,
			@PathVariable(value="nextids") Integer nextids) {
		
		try{
			List<getListCountOnuModel> getListCountOnu = activacionFacade.getListCountOnu(detalleIds, nextids);
			if(!GenericUtil.isCollectionEmpty(getListCountOnu)) {
				return new ResponseEntity<List<getListCountOnuModel>>(getListCountOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListCountOnuModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListCountOnuModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListActivaationRange/{datei}/{datef}")
	public ResponseEntity<List<getListActivaationRangeModel>> getListActivaationRange(
			@PathVariable(value="datei") String datei,
			@PathVariable(value="datef") String datef) {
		
		try{
			List<getListActivaationRangeModel> getListActivaationRange = activacionFacade.getListActivaationRange(datei, datef);
			if(!GenericUtil.isCollectionEmpty(getListActivaationRange)) {
				return new ResponseEntity<List<getListActivaationRangeModel>>(getListActivaationRange, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListActivaationRangeModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListActivaationRangeModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putStatusOnu/{idOnu}/{optio}/{idPk}/{nextId}/{description}/{statusOnu}")
	public ResponseEntity<List<ResponseModel>> putStatusOnu(
			@PathVariable(value="idOnu") Integer idOnu,
			@PathVariable(value="optio") Integer optio,
			@PathVariable(value="idPk") Integer idPk,
			@PathVariable(value="nextId") Integer nextId,
			@PathVariable(value="description") String description,
			@PathVariable(value="statusOnu") Integer statusOnu) {
		
		try{
			List<ResponseModel> putStatusOnu = activacionFacade.putStatusOnu(idOnu, optio, idPk, nextId, description, statusOnu);
			if(!GenericUtil.isCollectionEmpty(putStatusOnu)) {
				return new ResponseEntity<List<ResponseModel>>(putStatusOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchActivationService/{activationId}/{dateinfo}")
	public ResponseEntity<List<ResponseModel>> patchActivationService(
			@PathVariable(value="activationId") Integer activationId,
			@PathVariable(value="dateinfo") String dateinfo) {
		
		try{
			List<ResponseModel> patchActivationService = activacionFacade.patchActivationService(activationId, dateinfo);
			if(!GenericUtil.isCollectionEmpty(patchActivationService)) {
				return new ResponseEntity<List<ResponseModel>>(patchActivationService, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchStorageValidate/{idRemision}")
	public ResponseEntity<List<ResponseModel>> patchStorageValidate(
			@PathVariable(value="idRemision") Integer idRemision) {
		
		try{
			List<ResponseModel> patchStorageValidate = activacionFacade.patchStorageValidate(idRemision);
			if(!GenericUtil.isCollectionEmpty(patchStorageValidate)) {
				return new ResponseEntity<List<ResponseModel>>(patchStorageValidate, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postCreateOnu/{nameSerie}/{namemac}/{nameId}/{namePass}")
	public ResponseEntity<List<ResponseModel>> postCreateOnu(
			@PathVariable(value="nameSerie") String nameSerie,
			@PathVariable(value="namemac") String namemac,
			@PathVariable(value="nameId") String nameId,
			@PathVariable(value="namePass") String namePass) {
		
		try{
			List<ResponseModel> postCreateOnu = activacionFacade.postCreateOnu(nameSerie, namemac, nameId, namePass);
			if(!GenericUtil.isCollectionEmpty(postCreateOnu)) {
				return new ResponseEntity<List<ResponseModel>>(postCreateOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putUpdateOnu/{idOnu}/{nameSerie}/{namemac}")
	public ResponseEntity<List<ResponseModel>> putUpdateOnu(
			@PathVariable(value="idOnu") Integer idOnu,
			@PathVariable(value="nameSerie") String nameSerie,
			@PathVariable(value="namemac") String namemac) {
		
		try{
			List<ResponseModel> putUpdateOnu = activacionFacade.putUpdateOnu(idOnu, nameSerie, namemac);
			if(!GenericUtil.isCollectionEmpty(putUpdateOnu)) {
				return new ResponseEntity<List<ResponseModel>>(putUpdateOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchPasswordOnu/{idOnu}/{nameId}/{namePass}")
	public ResponseEntity<List<ResponseModel>> patchPasswordOnu(
			@PathVariable(value="idOnu") Integer idOnu,
			@PathVariable(value="nameId") String nameId,
			@PathVariable(value="namePass") String namePass) {
		
		try{
			List<ResponseModel> patchPasswordOnu = activacionFacade.patchPasswordOnu(idOnu, nameId, namePass);
			if(!GenericUtil.isCollectionEmpty(patchPasswordOnu)) {
				return new ResponseEntity<List<ResponseModel>>(patchPasswordOnu, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchActivationOnu/{idOnu}")
	public ResponseEntity<List<ResponseModel>> patchActivationOnu(
			@PathVariable(value="idOnu") Integer idOnu) {
		
		try{
			List<ResponseModel> patchActivationOnu = activacionFacade.patchActivationOnu(idOnu);
			if(!GenericUtil.isCollectionEmpty(patchActivationOnu)) {
				return new ResponseEntity<List<ResponseModel>>(patchActivationOnu, HttpStatus.OK);
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
