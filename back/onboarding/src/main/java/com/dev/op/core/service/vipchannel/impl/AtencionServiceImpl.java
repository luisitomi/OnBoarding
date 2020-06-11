package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListReclaimModel;
import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;
import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListReclaimJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListServiceActiveJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getReclaimStatusJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postReclaimByIdJdbcRepository;
import com.dev.op.core.service.vipchannel.AtencionService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("atencionService")
@Transactional("hibernateTransactionManager")
public class AtencionServiceImpl implements AtencionService{

	@Autowired
	@Qualifier("getListReclaimJdbcRepository")
	private getListReclaimJdbcRepository getListReclaimJdbcRepository;
	
	@Autowired
	@Qualifier("getListServiceActiveJdbcRepository")
	private getListServiceActiveJdbcRepository getListServiceActiveJdbcRepository;
	
	@Autowired
	@Qualifier("getReclaimStatusJdbcRepository")
	private getReclaimStatusJdbcRepository getReclaimStatusJdbcRepository;
	
	@Autowired
	@Qualifier("postReclaimByIdJdbcRepository")
	private postReclaimByIdJdbcRepository postReclaimByIdJdbcRepository;
	
	@Override
	public List<getListReclaimModel> getListReclaim() {
		List<getListReclaimModel> getListReclaim = new ArrayList<getListReclaimModel>();
		
		try {
			
			getListReclaim = getListReclaimJdbcRepository.getListReclaim();
			if(GenericUtil.isCollectionEmpty(getListReclaim)) {
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
			
			getListServiceActive = getListServiceActiveJdbcRepository.getListServiceActive(document, code);
			if(GenericUtil.isCollectionEmpty(getListServiceActive)) {
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
			
			postReclaimById = postReclaimByIdJdbcRepository.postReclaimById(document, code, service, reclaim, description);
			if(GenericUtil.isCollectionEmpty(postReclaimById)) {
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
			
			getReclaimStatus = getReclaimStatusJdbcRepository.getReclaimStatus(datei, datef);
			if(GenericUtil.isCollectionEmpty(getReclaimStatus)) {
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

}
