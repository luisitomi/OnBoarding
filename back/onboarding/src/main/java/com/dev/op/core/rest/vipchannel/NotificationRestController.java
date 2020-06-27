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
import com.dev.op.core.dto.vipchannel.getModuleModel;
import com.dev.op.core.dto.vipchannel.getListUserModel;
import com.dev.op.core.facade.vipchannel.NotificationFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/notificacion")
public class NotificationRestController {
	
	@Autowired
	@Qualifier("notificationFacade")
	private NotificationFacade notificationFacade;
	
	@GetMapping("/getModule")
	public ResponseEntity<List<getModuleModel>> getModule() {
		
		try{
			List<getModuleModel> getModule = notificationFacade.getModule();
			if(!GenericUtil.isCollectionEmpty(getModule)) {
				return new ResponseEntity<List<getModuleModel>>(getModule, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getModuleModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getModuleModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListUser/{codeUser}")
	public ResponseEntity<List<getListUserModel>> getListUser(@PathVariable(value="codeUser") Integer codeUser) {
		
		try{
			List<getListUserModel> getListUser = notificationFacade.getListUser(codeUser);
			if(!GenericUtil.isCollectionEmpty(getListUser)) {
				return new ResponseEntity<List<getListUserModel>>(getListUser, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListUserModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListUserModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postNotification/{module}/{codeUser}/{document}/{client}/{asunt}")
	public ResponseEntity<List<ResponseModel>> postNotification(
			@PathVariable(value="module") Integer module,
			@PathVariable(value="codeUser") Integer codeUser,
			@PathVariable(value="document") String document,
			@PathVariable(value="client") String client,
			@PathVariable(value="asunt") String asunt) {
		
		try{
			List<ResponseModel> postNotification = notificationFacade.postNotification(module,codeUser, document, client, asunt);
			if(!GenericUtil.isCollectionEmpty(postNotification)) {
				return new ResponseEntity<List<ResponseModel>>(postNotification, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putChangeAsignation/{notiId}/{aigId}")
	public ResponseEntity<List<ResponseModel>> putChangeAsignation(
			@PathVariable(value="notiId") Integer notiId,
			@PathVariable(value="aigId") Integer aigId) {
		
		try{
			List<ResponseModel> putChangeAsignation = notificationFacade.putChangeAsignation(notiId, aigId);
			if(!GenericUtil.isCollectionEmpty(putChangeAsignation)) {
				return new ResponseEntity<List<ResponseModel>>(putChangeAsignation, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putRptaNotification/{idTarea}/{solution}")
	public ResponseEntity<List<ResponseModel>> putRptaNotification(
			@PathVariable(value="idTarea") Integer idTarea,
			@PathVariable(value="solution") String solution) {
		
		try{
			List<ResponseModel> putRptaNotification = notificationFacade.putRptaNotification(idTarea, solution);
			if(!GenericUtil.isCollectionEmpty(putRptaNotification)) {
				return new ResponseEntity<List<ResponseModel>>(putRptaNotification, HttpStatus.OK);
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
