package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListReclaimServiceModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getListTecniModel;
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
	public List<getListServicePendingModel> getListServicePending(Integer codeUser) {
		List<getListServicePendingModel> getListServicePending = new ArrayList<getListServicePendingModel>();
		
		try {
			
			getListServicePending = serviceService.getListServicePending(codeUser);
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

	@Override
	public List<getListTecniModel> getListTecni() {
		List<getListTecniModel> getListTecni = new ArrayList<getListTecniModel>();
		
		try {
			
			getListTecni = serviceService.getListTecni();
			if(GenericUtil.isEmpty(getListTecni)) {
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
			
			putTecnInstall = serviceService.putTecnInstall(optionI, tecn, idP, nextId);
			if(GenericUtil.isEmpty(putTecnInstall)) {
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

	@Override
	public List<getListReclaimServiceModel> getListReclaimService(Integer codeint) {
		List<getListReclaimServiceModel> getListReclaimService = new ArrayList<getListReclaimServiceModel>();
		
		try {
			
			getListReclaimService = serviceService.getListReclaimService(codeint);
			if(GenericUtil.isEmpty(getListReclaimService)) {
				return null;
			}
			else {
				return getListReclaimService;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postServiceReclaim(Integer detaiId, Integer tec, String description, Integer mateId,
			Integer counts) {
		List<ResponseModel> postServiceReclaim = new ArrayList<ResponseModel>();
		
		try {
			
			postServiceReclaim = serviceService.postServiceReclaim(detaiId, tec, description, mateId, counts);
			if(GenericUtil.isEmpty(postServiceReclaim)) {
				return null;
			}
			else {
				return postServiceReclaim;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
