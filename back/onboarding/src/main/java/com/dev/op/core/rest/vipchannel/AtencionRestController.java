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
import com.dev.op.core.dto.vipchannel.getListReclaimModel;
import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;
import com.dev.op.core.dto.vipchannel.getListServiceNotActiveModel;
import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;
import com.dev.op.core.facade.vipchannel.AtencionFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/atencion")
public class AtencionRestController {
	
	@Autowired
	@Qualifier("atencionFacade")
	private AtencionFacade atencionFacade;
	
	@GetMapping("/getListReclaim")
	public ResponseEntity<List<getListReclaimModel>> getListReclaim() {
		
		try{
			List<getListReclaimModel> getListReclaim = atencionFacade.getListReclaim();
			if(!GenericUtil.isCollectionEmpty(getListReclaim)) {
				return new ResponseEntity<List<getListReclaimModel>>(getListReclaim, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListReclaimModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListReclaimModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListServiceActive/{document}/{code}")
	public ResponseEntity<List<getListServiceActiveModel>> getListServiceActive(@PathVariable(value="document") String document
			,@PathVariable(value="code") String code) {
		
		try{
			List<getListServiceActiveModel> getListServiceActive = atencionFacade.getListServiceActive(document, code);
			if(!GenericUtil.isCollectionEmpty(getListServiceActive)) {
				return new ResponseEntity<List<getListServiceActiveModel>>(getListServiceActive, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListServiceActiveModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListServiceActiveModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListServiceNotActive/{document}/{code}")
	public ResponseEntity<List<getListServiceNotActiveModel>> getListServiceNotActive(@PathVariable(value="document") String document
			,@PathVariable(value="code") String code) {
		
		try{
			List<getListServiceNotActiveModel> getListServiceNotActive = atencionFacade.getListServiceNotActive(document, code);
			if(!GenericUtil.isCollectionEmpty(getListServiceNotActive)) {
				return new ResponseEntity<List<getListServiceNotActiveModel>>(getListServiceNotActive, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListServiceNotActiveModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListServiceNotActiveModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getReclaimStatus/{datei}/{datef}")
	public ResponseEntity<List<getReclaimStatusModel>> getReclaimStatus(
			@PathVariable(value="datei") String datei,
			@PathVariable(value="datef") String datef) {
		
		try{
			List<getReclaimStatusModel> getReclaimStatus = atencionFacade.getReclaimStatus(datei, datef);
			if(!GenericUtil.isCollectionEmpty(getReclaimStatus)) {
				return new ResponseEntity<List<getReclaimStatusModel>>(getReclaimStatus, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getReclaimStatusModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getReclaimStatusModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postReclaimById/{document}/{code}/{service}/{reclaim}/{description}")
	public ResponseEntity<List<ResponseModel>> postReclaimById(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="service") Integer service,
			@PathVariable(value="reclaim") Integer reclaim,
			@PathVariable(value="description") String description) {
		
		try{
			List<ResponseModel> postReclaimById = atencionFacade.postReclaimById(document, code, service, reclaim, description);
			if(!GenericUtil.isCollectionEmpty(postReclaimById)) {
				return new ResponseEntity<List<ResponseModel>>(postReclaimById, HttpStatus.OK);
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
