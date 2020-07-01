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
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
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
	
}
