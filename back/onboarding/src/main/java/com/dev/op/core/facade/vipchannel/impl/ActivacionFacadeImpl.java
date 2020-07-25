package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;
import com.dev.op.core.dto.vipchannel.getListActivationModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuStateModel;
import com.dev.op.core.facade.vipchannel.ActivacionFacade;
import com.dev.op.core.service.vipchannel.ActivacionService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("activacionFacade")
public class ActivacionFacadeImpl implements ActivacionFacade{
	
	@Autowired
	@Qualifier("activacionService")
	private ActivacionService activacionService;

	@Override
	public List<getListOnuModel> getListOnu() {
		List<getListOnuModel> getListOnu = new ArrayList<getListOnuModel>();
		
		try {
			
			getListOnu = activacionService.getListOnu();
			if(GenericUtil.isEmpty(getListOnu)) {
				return null;
			}
			else {
				return getListOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putStatusOnu(Integer idOnu, Integer optio, Integer idPk, Integer nextId,
			String description, Integer statusOnu) {
		List<ResponseModel> putStatusOnu = new ArrayList<ResponseModel>();
		
		try {
			
			putStatusOnu = activacionService.putStatusOnu(idOnu, optio, idPk, nextId, description, statusOnu);
			if(GenericUtil.isEmpty(putStatusOnu)) {
				return null;
			}
			else {
				return putStatusOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListCountOnuModel> getListCountOnu(Integer detalleIds, Integer nextids) {
		List<getListCountOnuModel> getListCountOnu = new ArrayList<getListCountOnuModel>();
		
		try {
			
			getListCountOnu = activacionService.getListCountOnu(detalleIds, nextids);
			if(GenericUtil.isEmpty(getListCountOnu)) {
				return null;
			}
			else {
				return getListCountOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListActivationModel> getListActivation() {
		List<getListActivationModel> getListActivation = new ArrayList<getListActivationModel>();
		
		try {
			
			getListActivation = activacionService.getListActivation();
			if(GenericUtil.isEmpty(getListActivation)) {
				return null;
			}
			else {
				return getListActivation;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchActivationService(Integer activationId, String dateinfo) {
		List<ResponseModel> patchActivationService = new ArrayList<ResponseModel>();
		
		try {
			
			patchActivationService = activacionService.patchActivationService(activationId, dateinfo);
			if(GenericUtil.isEmpty(patchActivationService)) {
				return null;
			}
			else {
				return patchActivationService;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchStorageValidate(Integer idRemision) {
		List<ResponseModel> patchStorageValidate = new ArrayList<ResponseModel>();
		
		try {
			
			patchStorageValidate = activacionService.patchStorageValidate(idRemision);
			if(GenericUtil.isEmpty(patchStorageValidate)) {
				return null;
			}
			else {
				return patchStorageValidate;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putUpdateOnu(Integer idOnu, String nameSerie, String namemac) {
		List<ResponseModel> putUpdateOnu = new ArrayList<ResponseModel>();
		
		try {
			
			putUpdateOnu = activacionService.putUpdateOnu(idOnu, nameSerie, namemac);
			if(GenericUtil.isEmpty(putUpdateOnu)) {
				return null;
			}
			else {
				return putUpdateOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchPasswordOnu(Integer idOnu, String nameId, String namePass) {
		List<ResponseModel> patchPasswordOnu = new ArrayList<ResponseModel>();
		
		try {
			
			patchPasswordOnu = activacionService.patchPasswordOnu(idOnu, nameId, namePass);
			if(GenericUtil.isEmpty(patchPasswordOnu)) {
				return null;
			}
			else {
				return patchPasswordOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchActivationOnu(Integer idOnu) {
		List<ResponseModel> patchActivationOnu = new ArrayList<ResponseModel>();
		
		try {
			
			patchActivationOnu = activacionService.patchActivationOnu(idOnu);
			if(GenericUtil.isEmpty(patchActivationOnu)) {
				return null;
			}
			else {
				return patchActivationOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postCreateOnu(String nameSerie, String namemac, String nameId, String namePass) {
		List<ResponseModel> postCreateOnu = new ArrayList<ResponseModel>();
		
		try {
			
			postCreateOnu = activacionService.postCreateOnu(nameSerie, namemac, nameId, namePass);
			if(GenericUtil.isEmpty(postCreateOnu)) {
				return null;
			}
			else {
				return postCreateOnu;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListOnuStateModel> getListOnuState() {
		List<getListOnuStateModel> getListOnuState = new ArrayList<getListOnuStateModel>();
		
		try {
			
			getListOnuState = activacionService.getListOnuState();
			if(GenericUtil.isEmpty(getListOnuState)) {
				return null;
			}
			else {
				return getListOnuState;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListActivaationRangeModel> getListActivaationRange(String datei, String datef) {
		List<getListActivaationRangeModel> getListActivaationRange = new ArrayList<getListActivaationRangeModel>();
		
		try {
			
			getListActivaationRange = activacionService.getListActivaationRange(datei, datef);
			if(GenericUtil.isEmpty(getListActivaationRange)) {
				return null;
			}
			else {
				return getListActivaationRange;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
