package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
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
	@Qualifier("putStatusOnuJdbcRepository")
	private putStatusOnuJdbcRepository putStatusOnuJdbcRepository;
	
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

}
