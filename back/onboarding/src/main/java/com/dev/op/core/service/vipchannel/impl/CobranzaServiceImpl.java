package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;
import com.dev.op.core.repository.vipchannel.jdbc.getDirectionByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getManagerByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPersonByDocumentJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPersonByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getReferenceByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getVoucherByIdJdbcRepository;
import com.dev.op.core.service.vipchannel.CobranzaService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("cobranzaService")
@Transactional("hibernateTransactionManager")
public class CobranzaServiceImpl implements CobranzaService {

	@Autowired
	@Qualifier("getPersonByDocumentJdbcRepository")
	private getPersonByDocumentJdbcRepository getPersonByDocumentJdbcRepository;
	
	@Autowired
	@Qualifier("getPersonByIdJdbcRepository")
	private getPersonByIdJdbcRepository getPersonByIdJdbcRepository;

	@Autowired
	@Qualifier("getDirectionByIdJdbcRepository")
	private getDirectionByIdJdbcRepository getDirectionByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getReferenceByIdJdbcRepository")
	private getReferenceByIdJdbcRepository getReferenceByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getManagerByIdJdbcRepository")
	private getManagerByIdJdbcRepository getManagerByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getVoucherByIdJdbcRepository")
	private getVoucherByIdJdbcRepository getVoucherByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailJdbcRepository")
	private getPayServiceDetailJdbcRepository getPayServiceDetailJdbcRepository;

	
	@Override
	public List<getPersonByDocumentModel> getPersonByDocument(String search) {
		List<getPersonByDocumentModel> getPersonByDocument = new ArrayList<getPersonByDocumentModel>();
		
		try {
			
			getPersonByDocument = getPersonByDocumentJdbcRepository.getPersonByDocument(search);
			if(GenericUtil.isCollectionEmpty(getPersonByDocument)) {
				return null;
			}
			else {
				return getPersonByDocument;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPersonByIdModel> getPersonById(String document) {
		List<getPersonByIdModel> getPersonById = new ArrayList<getPersonByIdModel>();
		
		try {
			
			getPersonById = getPersonByIdJdbcRepository.getPersonById(document);
			if(GenericUtil.isCollectionEmpty(getPersonById)) {
				return null;
			}
			else {
				return getPersonById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getDirectionByIdModel> getDirectionById(String document, String code) {
		List<getDirectionByIdModel> getDirectionById = new ArrayList<getDirectionByIdModel>();
		
		try {
			
			getDirectionById = getDirectionByIdJdbcRepository.getDirectionById(document, code);
			if(GenericUtil.isCollectionEmpty(getDirectionById)) {
				return null;
			}
			else {
				return getDirectionById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getReferenceByIdModel> getReferenceById(String document, String code) {
		List<getReferenceByIdModel> getReferenceById = new ArrayList<getReferenceByIdModel>();
		
		try {
			
			getReferenceById = getReferenceByIdJdbcRepository.getReferenceById(document, code);
			if(GenericUtil.isCollectionEmpty(getReferenceById)) {
				return null;
			}
			else {
				return getReferenceById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getManagerByIdModel> getManagerById(String document, String code) {
		List<getManagerByIdModel> getManagerById = new ArrayList<getManagerByIdModel>();
		
		try {
			
			getManagerById = getManagerByIdJdbcRepository.getManagerById(document, code);
			if(GenericUtil.isCollectionEmpty(getManagerById)) {
				return null;
			}
			else {
				return getManagerById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getVoucherByIdModel> getVoucherById(String document, String code) {
		List<getVoucherByIdModel> getVoucherById = new ArrayList<getVoucherByIdModel>();
		
		try {
			
			getVoucherById = getVoucherByIdJdbcRepository.getVoucherById(document, code);
			if(GenericUtil.isCollectionEmpty(getVoucherById)) {
				return null;
			}
			else {
				return getVoucherById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailModel> getPayServiceDetail(String document, String code) {
		List<getPayServiceDetailModel> getPayServiceDetail = new ArrayList<getPayServiceDetailModel>();
		
		try {
			
			getPayServiceDetail = getPayServiceDetailJdbcRepository.getPayServiceDetail(document, code);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetail)) {
				return null;
			}
			else {
				return getPayServiceDetail;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
