package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
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
}