package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.dto.vipchannel.getUserDataModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListModuleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListSubModuleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getUserDataJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchUpdatePasswordJdbcRepository;
import com.dev.op.core.service.vipchannel.UsuarioService;
import com.dev.op.core.util.vipchannel.GenericUtil;;

@Service("usuarioService")
@Transactional("hibernateTransactionManager")
public class UsuarioServiceImpl implements UsuarioService{
	
	@Autowired
	@Qualifier("getListSubModuleJdbcRepository")
	private getListSubModuleJdbcRepository getListSubModuleJdbcRepository;
	
	@Autowired
	@Qualifier("getListModuleJdbcRepository")
	private getListModuleJdbcRepository getListModuleJdbcRepository;
	
	@Autowired
	@Qualifier("getUserDataJdbcRepository")
	private getUserDataJdbcRepository getUserDataJdbcRepository;
	
	@Autowired
	@Qualifier("patchUpdatePasswordJdbcRepository")
	private patchUpdatePasswordJdbcRepository patchUpdatePasswordJdbcRepository;
	

	@Override
	public List<getListModuleModel> getListModule(String user) {
		List<getListModuleModel> getListModule = new ArrayList<getListModuleModel>();
		
		try {
			
			getListModule = getListModuleJdbcRepository.getListModule(user);
			if(GenericUtil.isCollectionEmpty(getListModule)) {
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
			
			getListSubModule = getListSubModuleJdbcRepository.getListSubModule(user);
			if(GenericUtil.isCollectionEmpty(getListSubModule)) {
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
			
			getUserData = getUserDataJdbcRepository.getUserData(user, pass);
			if(GenericUtil.isCollectionEmpty(getUserData)) {
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
			
			patchUpdatePassword = patchUpdatePasswordJdbcRepository.patchUpdatePassword(user, pass);
			if(GenericUtil.isCollectionEmpty(patchUpdatePassword)) {
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
	
}
