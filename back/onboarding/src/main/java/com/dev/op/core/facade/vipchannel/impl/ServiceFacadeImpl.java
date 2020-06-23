package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.dto.vipchannel.getMaterialModel;
import com.dev.op.core.facade.vipchannel.ServiceFacade;
import com.dev.op.core.service.vipchannel.ServiceService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("serviceFacade")
public class ServiceFacadeImpl implements ServiceFacade{
	
	@Autowired
	@Qualifier("serviceService")
	private ServiceService serviceService;

	@Override
	public List<getListServicePendingModel> getListServicePending() {
		List<getListServicePendingModel> getListServicePending = new ArrayList<getListServicePendingModel>();
		
		try {
			
			getListServicePending = serviceService.getListServicePending();
			if(GenericUtil.isEmpty(getListServicePending)) {
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
			
			getMaterial = serviceService.getMaterial();
			if(GenericUtil.isEmpty(getMaterial)) {
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
			
			getMaterialAll = serviceService.getMaterialAll();
			if(GenericUtil.isEmpty(getMaterialAll)) {
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
			
			postMaterial = serviceService.postMaterial(name);
			if(GenericUtil.isEmpty(postMaterial)) {
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
			
			putMaterial = serviceService.putMaterial(name, idMaterial);
			if(GenericUtil.isEmpty(putMaterial)) {
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
			
			postServiceInstall = serviceService.postServiceInstall(detaiId, nextId, tec, description, mateId, counts);
			if(GenericUtil.isEmpty(postServiceInstall)) {
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
	
}
