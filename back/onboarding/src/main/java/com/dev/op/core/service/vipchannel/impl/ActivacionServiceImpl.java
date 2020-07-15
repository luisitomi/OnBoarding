package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListActivationModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListActivationJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListCountOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putStatusOnuJdbcRepository;
import com.dev.op.core.service.vipchannel.ActivacionService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("activacionService")
@Transactional("hibernateTransactionManager")
public class ActivacionServiceImpl implements ActivacionService {

	@Autowired
	@Qualifier("getListOnuJdbcRepository")
	private getListOnuJdbcRepository getListOnuJdbcRepository;
	
	@Autowired
	@Qualifier("getListCountOnuJdbcRepository")
	private getListCountOnuJdbcRepository getListCountOnuJdbcRepository;
	
	@Autowired
	@Qualifier("putStatusOnuJdbcRepository")
	private putStatusOnuJdbcRepository putStatusOnuJdbcRepository;
	
	@Autowired
	@Qualifier("getListActivationJdbcRepository")
	private getListActivationJdbcRepository getListActivationJdbcRepository;
	
	@Override
	public List<getListOnuModel> getListOnu() {
		List<getListOnuModel> getListOnu = new ArrayList<getListOnuModel>();
		
		try {
			
			getListOnu = getListOnuJdbcRepository.getListOnu();
			if(GenericUtil.isCollectionEmpty(getListOnu)) {
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
			
			putStatusOnu = putStatusOnuJdbcRepository.putStatusOnu(idOnu, optio, idPk, nextId, description, statusOnu);
			if(GenericUtil.isCollectionEmpty(putStatusOnu)) {
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
			
			getListCountOnu = getListCountOnuJdbcRepository.getListCountOnu(detalleIds, nextids);
			if(GenericUtil.isCollectionEmpty(getListCountOnu)) {
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
			
			getListActivation = getListActivationJdbcRepository.getListActivation();
			if(GenericUtil.isCollectionEmpty(getListActivation)) {
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

}
