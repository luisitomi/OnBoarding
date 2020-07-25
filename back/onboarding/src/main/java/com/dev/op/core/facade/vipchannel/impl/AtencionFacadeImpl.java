package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListReclaimModel;
import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;
import com.dev.op.core.dto.vipchannel.getListServiceNotActiveModel;
import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;
import com.dev.op.core.facade.vipchannel.AtencionFacade;
import com.dev.op.core.service.vipchannel.AtencionService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("atencionFacade")
public class AtencionFacadeImpl implements AtencionFacade{

	@Autowired
	@Qualifier("atencionService")
	private AtencionService atencionService;

	@Override
	public List<getListReclaimModel> getListReclaim() {
		List<getListReclaimModel> getListReclaim = new ArrayList<getListReclaimModel>();
		
		try {
			
			getListReclaim = atencionService.getListReclaim();
			if(GenericUtil.isEmpty(getListReclaim)) {
				return null;
			}
			else {
				return getListReclaim;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListServiceActiveModel> getListServiceActive(String document, String code) {
		List<getListServiceActiveModel> getListServiceActive = new ArrayList<getListServiceActiveModel>();
		
		try {
			
			getListServiceActive = atencionService.getListServiceActive(document, code);
			if(GenericUtil.isEmpty(getListServiceActive)) {
				return null;
			}
			else {
				return getListServiceActive;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postReclaimById(String document, String code, Integer service, Integer reclaim,
			String description) {
		List<ResponseModel> postReclaimById = new ArrayList<ResponseModel>();
		
		try {
			
			postReclaimById = atencionService.postReclaimById(document, code, service, reclaim, description);
			if(GenericUtil.isEmpty(postReclaimById)) {
				return null;
			}
			else {
				return postReclaimById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getReclaimStatusModel> getReclaimStatus(String datei, String datef) {
		List<getReclaimStatusModel> getReclaimStatus = new ArrayList<getReclaimStatusModel>();
		
		try {
			
			getReclaimStatus = atencionService.getReclaimStatus(datei, datef);
			if(GenericUtil.isEmpty(getReclaimStatus)) {
				return null;
			}
			else {
				return getReclaimStatus;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListServiceNotActiveModel> getListServiceNotActive(String document, String code) {
		List<getListServiceNotActiveModel> getListServiceNotActive = new ArrayList<getListServiceNotActiveModel>();
		
		try {
			
			getListServiceNotActive = atencionService.getListServiceNotActive(document, code);
			if(GenericUtil.isEmpty(getListServiceNotActive)) {
				return null;
			}
			else {
				return getListServiceNotActive;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
