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

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;
import com.dev.op.core.facade.vipchannel.CobranzaFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v1/cobranza")
public class CobranzaRestController {

	@Autowired
	@Qualifier("cobranzaFacade")
	private CobranzaFacade cobranzaFacade;
	
	@GetMapping("/getPersonByDocument/{search}")
	public ResponseEntity<List<getPersonByDocumentModel>> getPersonByDocument(@PathVariable(value="search") String search) {
		
		try{
			List<getPersonByDocumentModel> getPersonByDocument = cobranzaFacade.getPersonByDocument(search);
			if(!GenericUtil.isCollectionEmpty(getPersonByDocument)) {
				return new ResponseEntity<List<getPersonByDocumentModel>>(getPersonByDocument, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPersonByDocumentModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPersonByDocumentModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getPersonById/{document}")
	public ResponseEntity<List<getPersonByIdModel>> getPersonById(@PathVariable(value="document") String document) {
		
		try{
			List<getPersonByIdModel> getPersonById = cobranzaFacade.getPersonById(document);
			if(!GenericUtil.isCollectionEmpty(getPersonById)) {
				return new ResponseEntity<List<getPersonByIdModel>>(getPersonById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPersonByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPersonByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getDirectionById/{document}/{code}")
	public ResponseEntity<List<getDirectionByIdModel>> getDirectionById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getDirectionByIdModel> getDirectionById = cobranzaFacade.getDirectionById(document, code);
			if(!GenericUtil.isCollectionEmpty(getDirectionById)) {
				return new ResponseEntity<List<getDirectionByIdModel>>(getDirectionById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getDirectionByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getDirectionByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getReferenceById/{document}/{code}")
	public ResponseEntity<List<getReferenceByIdModel>> getReferenceById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getReferenceByIdModel> getReferenceById = cobranzaFacade.getReferenceById(document, code);
			if(!GenericUtil.isCollectionEmpty(getReferenceById)) {
				return new ResponseEntity<List<getReferenceByIdModel>>(getReferenceById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getReferenceByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getReferenceByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getManagerById/{document}/{code}")
	public ResponseEntity<List<getManagerByIdModel>> getManagerById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getManagerByIdModel> getManagerById = cobranzaFacade.getManagerById(document, code);
			if(!GenericUtil.isCollectionEmpty(getManagerById)) {
				return new ResponseEntity<List<getManagerByIdModel>>(getManagerById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getManagerByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getManagerByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getVoucherById/{document}/{code}")
	public ResponseEntity<List<getVoucherByIdModel>> getVoucherById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getVoucherByIdModel> getVoucherById = cobranzaFacade.getVoucherById(document, code);
			if(!GenericUtil.isCollectionEmpty(getVoucherById)) {
				return new ResponseEntity<List<getVoucherByIdModel>>(getVoucherById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getVoucherByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getVoucherByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getPayServiceDetail/{document}/{code}")
	public ResponseEntity<List<getPayServiceDetailModel>> getPayServiceDetail(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getPayServiceDetailModel> getPayServiceDetail = cobranzaFacade.getPayServiceDetail(document, code);
			if(!GenericUtil.isCollectionEmpty(getPayServiceDetail)) {
				return new ResponseEntity<List<getPayServiceDetailModel>>(getPayServiceDetail, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPayServiceDetailModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPayServiceDetailModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
}