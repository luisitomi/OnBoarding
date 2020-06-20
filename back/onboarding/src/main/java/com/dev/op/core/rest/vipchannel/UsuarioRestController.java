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
import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.dto.vipchannel.getNameUserModel;
import com.dev.op.core.dto.vipchannel.getNotificationModel;
import com.dev.op.core.dto.vipchannel.getUserDataModel;
import com.dev.op.core.facade.vipchannel.UsuarioFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;

@RestController
@RequestMapping("/api/v2/usuario")
public class UsuarioRestController {

	@Autowired
	@Qualifier("usuarioFacade")
	private UsuarioFacade usuarioFacade;

	@GetMapping("/getListModule/{user}")
	public ResponseEntity<List<getListModuleModel>> getListModule(@PathVariable(value="user") String user) {
		
		try{
			List<getListModuleModel> getListModule = usuarioFacade.getListModule(user);
			if(!GenericUtil.isCollectionEmpty(getListModule)) {
				return new ResponseEntity<List<getListModuleModel>>(getListModule, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListModuleModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListModuleModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListSubModule/{user}")
	public ResponseEntity<List<getListSubModuleModel>> getListSubModule(@PathVariable(value="user") String user) {
		
		try{
			List<getListSubModuleModel> getListSubModule = usuarioFacade.getListSubModule(user);
			if(!GenericUtil.isCollectionEmpty(getListSubModule)) {
				return new ResponseEntity<List<getListSubModuleModel>>(getListSubModule, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListSubModuleModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListSubModuleModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getUserData/{user}/{pass}")
	public ResponseEntity<List<getUserDataModel>> getUserData(@PathVariable(value="user") String user,
			@PathVariable(value="pass") String pass) {
		
		try{
			List<getUserDataModel> getUserData = usuarioFacade.getUserData(user, pass);
			if(!GenericUtil.isCollectionEmpty(getUserData)) {
				return new ResponseEntity<List<getUserDataModel>>(getUserData, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getUserDataModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getUserDataModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getNotification/{user}")
	public ResponseEntity<List<getNotificationModel>> getNotification(@PathVariable(value="user") String user) {
		
		try{
			List<getNotificationModel> getNotification = usuarioFacade.getNotification(user);
			if(!GenericUtil.isCollectionEmpty(getNotification)) {
				return new ResponseEntity<List<getNotificationModel>>(getNotification, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getNotificationModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getNotificationModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getNameUser/{user}")
	public ResponseEntity<List<getNameUserModel>> getNameUser(
			@PathVariable(value="user") String user) {
		
		try{
			List<getNameUserModel> getNameUser = usuarioFacade.getNameUser(user);
			if(!GenericUtil.isCollectionEmpty(getNameUser)) {
				return new ResponseEntity<List<getNameUserModel>>(getNameUser, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getNameUserModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getNameUserModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchUpdatePassword/{user}/{pass}")
	public ResponseEntity<List<ResponseModel>> patchUpdatePassword(@PathVariable(value="user") String user,
			@PathVariable(value="pass") String pass) {
		
		try{
			List<ResponseModel> patchUpdatePassword = usuarioFacade.patchUpdatePassword(user, pass);
			if(!GenericUtil.isCollectionEmpty(patchUpdatePassword)) {
				return new ResponseEntity<List<ResponseModel>>(patchUpdatePassword, HttpStatus.OK);
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
