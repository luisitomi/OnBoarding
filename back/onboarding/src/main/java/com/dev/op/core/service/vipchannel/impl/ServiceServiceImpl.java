package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getListTecniModel;
import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.dto.vipchannel.getMaterialModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListServicePendingJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListTecniJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getMaterialAllJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getMaterialJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postMaterialJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postServiceInstallJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putMaterialJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putTecnInstallJdbcRepository;
import com.dev.op.core.service.vipchannel.ServiceService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("serviceService")
@Transactional("hibernateTransactionManager")
public class ServiceServiceImpl implements ServiceService {
	
	@Autowired
	@Qualifier("getListServicePendingJdbcRepository")
	private getListServicePendingJdbcRepository getListServicePendingJdbcRepository;
	
	@Autowired
	@Qualifier("getMaterialAllJdbcRepository")
	private getMaterialAllJdbcRepository getMaterialAllJdbcRepository;
	
	@Autowired
	@Qualifier("getMaterialJdbcRepository")
	private getMaterialJdbcRepository getMaterialJdbcRepository;
	
	@Autowired
	@Qualifier("getListTecniJdbcRepository")
	private getListTecniJdbcRepository getListTecniJdbcRepository;
	
	@Autowired
	@Qualifier("putMaterialJdbcRepository")
	private putMaterialJdbcRepository putMaterialJdbcRepository;
	
	@Autowired
	@Qualifier("putTecnInstallJdbcRepository")
	private putTecnInstallJdbcRepository putTecnInstallJdbcRepository;
	
	@Autowired
	@Qualifier("postMaterialJdbcRepository")
	private postMaterialJdbcRepository postMaterialJdbcRepository;
	
	@Autowired
	@Qualifier("postServiceInstallJdbcRepository")
	private postServiceInstallJdbcRepository postServiceInstallJdbcRepository;
	
	@Override
	public List<getListServicePendingModel> getListServicePending(Integer codeUser) {
		List<getListServicePendingModel> getListServicePending = new ArrayList<getListServicePendingModel>();
		
		try {
			
			getListServicePending = getListServicePendingJdbcRepository.getListServicePending(codeUser);
			if(GenericUtil.isCollectionEmpty(getListServicePending)) {
				return null;
			}
			else {
				return getListServicePending;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getMaterialModel> getMaterial() {
		List<getMaterialModel> getMaterial = new ArrayList<getMaterialModel>();
		
		try {
			
			getMaterial = getMaterialJdbcRepository.getMaterial();
			if(GenericUtil.isCollectionEmpty(getMaterial)) {
				return null;
			}
			else {
				return getMaterial;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getMaterialAllModel> getMaterialAll() {
		List<getMaterialAllModel> getMaterialAll = new ArrayList<getMaterialAllModel>();
		
		try {
			
			getMaterialAll = getMaterialAllJdbcRepository.getMaterialAll();
			if(GenericUtil.isCollectionEmpty(getMaterialAll)) {
				return null;
			}
			else {
				return getMaterialAll;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postMaterial(String name) {
		List<ResponseModel> postMaterial = new ArrayList<ResponseModel>();
		
		try {
			
			postMaterial = postMaterialJdbcRepository.postMaterial(name);
			if(GenericUtil.isCollectionEmpty(postMaterial)) {
				return null;
			}
			else {
				return postMaterial;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putMaterial(String name, Integer idMaterial) {
		List<ResponseModel> putMaterial = new ArrayList<ResponseModel>();
		
		try {
			
			putMaterial = putMaterialJdbcRepository.putMaterial(name, idMaterial);
			if(GenericUtil.isCollectionEmpty(putMaterial)) {
				return null;
			}
			else {
				return putMaterial;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postServiceInstall(Integer detaiId, Integer nextId, Integer tec, String description,
			Integer mateId, Integer counts) {
		List<ResponseModel> postServiceInstall = new ArrayList<ResponseModel>();
		
		try {
			
			postServiceInstall = postServiceInstallJdbcRepository.postServiceInstall(detaiId, nextId, tec, description, mateId, counts);
			if(GenericUtil.isCollectionEmpty(postServiceInstall)) {
				return null;
			}
			else {
				return postServiceInstall;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListTecniModel> getListTecni() {
		List<getListTecniModel> getListTecni = new ArrayList<getListTecniModel>();
		
		try {
			
			getListTecni = getListTecniJdbcRepository.getListTecni();
			if(GenericUtil.isCollectionEmpty(getListTecni)) {
				return null;
			}
			else {
				return getListTecni;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putTecnInstall(Integer optionI, Integer tecn, Integer idP, Integer nextId) {
		List<ResponseModel> putTecnInstall = new ArrayList<ResponseModel>();
		
		try {
			
			putTecnInstall = putTecnInstallJdbcRepository.putTecnInstall(optionI, tecn, idP, nextId);
			if(GenericUtil.isCollectionEmpty(putTecnInstall)) {
				return null;
			}
			else {
				return putTecnInstall;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
