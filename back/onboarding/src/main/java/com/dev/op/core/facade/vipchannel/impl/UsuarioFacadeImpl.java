package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.dto.vipchannel.getNameUserModel;
import com.dev.op.core.dto.vipchannel.getUserDataModel;
import com.dev.op.core.facade.vipchannel.UsuarioFacade;
import com.dev.op.core.service.vipchannel.UsuarioService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("usuarioFacade")
public class UsuarioFacadeImpl implements UsuarioFacade{

	@Autowired
	@Qualifier("usuarioService")
	private UsuarioService usuarioService;

	@Override
	public List<getListModuleModel> getListModule(String user) {
		List<getListModuleModel> getListModule = new ArrayList<getListModuleModel>();
		
		try {
			
			getListModule = usuarioService.getListModule(user);
			if(GenericUtil.isEmpty(getListModule)) {
				return null;
			}
			else {
				return getListModule;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListSubModuleModel> getListSubModule(String user) {
		List<getListSubModuleModel> getListSubModule = new ArrayList<getListSubModuleModel>();
		
		try {
			
			getListSubModule = usuarioService.getListSubModule(user);
			if(GenericUtil.isEmpty(getListSubModule)) {
				return null;
			}
			else {
				return getListSubModule;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getUserDataModel> getUserData(String user, String pass) {
		List<getUserDataModel> getUserData = new ArrayList<getUserDataModel>();
		
		try {
			
			getUserData = usuarioService.getUserData(user, pass);
			if(GenericUtil.isEmpty(getUserData)) {
				return null;
			}
			else {
				return getUserData;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchUpdatePassword(String user, String pass) {
		List<ResponseModel> patchUpdatePassword = new ArrayList<ResponseModel>();
		
		try {
			
			patchUpdatePassword = usuarioService.patchUpdatePassword(user, pass);
			if(GenericUtil.isEmpty(patchUpdatePassword)) {
				return null;
			}
			else {
				return patchUpdatePassword;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getNameUserModel> getNameUser(String user) {
		List<getNameUserModel> getNameUser = new ArrayList<getNameUserModel>();
		
		try {
			
			getNameUser = usuarioService.getNameUser(user);
			if(GenericUtil.isEmpty(getNameUser)) {
				return null;
			}
			else {
				return getNameUser;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
