package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;
import com.dev.op.core.dto.vipchannel.getListActivationModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuStateModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListActivaationRangeJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListActivationJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListCountOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListOnuStateJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchActivationOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchActivationServiceJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchPasswordOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchStorageValidateJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postCreateOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putStatusOnuJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putUpdateOnuJdbcRepository;
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
	@Qualifier("getListActivaationRangeJdbcRepository")
	private getListActivaationRangeJdbcRepository getListActivaationRangeJdbcRepository;
	
	@Autowired
	@Qualifier("putStatusOnuJdbcRepository")
	private putStatusOnuJdbcRepository putStatusOnuJdbcRepository;
	
	@Autowired
	@Qualifier("getListActivationJdbcRepository")
	private getListActivationJdbcRepository getListActivationJdbcRepository;
	
	@Autowired
	@Qualifier("getListOnuStateJdbcRepository")
	private getListOnuStateJdbcRepository getListOnuStateJdbcRepository;
	
	@Autowired
	@Qualifier("patchActivationServiceJdbcRepository")
	private patchActivationServiceJdbcRepository patchActivationServiceJdbcRepository;
	
	@Autowired
	@Qualifier("patchStorageValidateJdbcRepository")
	private patchStorageValidateJdbcRepository patchStorageValidateJdbcRepository;
	
	@Autowired
	@Qualifier("postCreateOnuJdbcRepository")
	private postCreateOnuJdbcRepository postCreateOnuJdbcRepository;
	
	@Autowired
	@Qualifier("putUpdateOnuJdbcRepository")
	private putUpdateOnuJdbcRepository putUpdateOnuJdbcRepository;
	
	@Autowired
	@Qualifier("patchPasswordOnuJdbcRepository")
	private patchPasswordOnuJdbcRepository patchPasswordOnuJdbcRepository;
	
	@Autowired
	@Qualifier("patchActivationOnuJdbcRepository")
	private patchActivationOnuJdbcRepository patchActivationOnuJdbcRepository;
	
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

	@Override
	public List<ResponseModel> patchActivationService(Integer activationId, String dateinfo) {
		List<ResponseModel> patchActivationService = new ArrayList<ResponseModel>();
		
		try {
			
			patchActivationService = patchActivationServiceJdbcRepository.patchActivationService(activationId, dateinfo);
			if(GenericUtil.isCollectionEmpty(patchActivationService)) {
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
			
			patchStorageValidate = patchStorageValidateJdbcRepository.patchStorageValidate(idRemision);
			if(GenericUtil.isCollectionEmpty(patchStorageValidate)) {
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
			
			putUpdateOnu = putUpdateOnuJdbcRepository.putUpdateOnu(idOnu, nameSerie, namemac);
			if(GenericUtil.isCollectionEmpty(putUpdateOnu)) {
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
			
			patchPasswordOnu = patchPasswordOnuJdbcRepository.patchPasswordOnu(idOnu, nameId, namePass);
			if(GenericUtil.isCollectionEmpty(patchPasswordOnu)) {
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
			
			patchActivationOnu = patchActivationOnuJdbcRepository.patchActivationOnu(idOnu);
			if(GenericUtil.isCollectionEmpty(patchActivationOnu)) {
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
			
			postCreateOnu = postCreateOnuJdbcRepository.postCreateOnu(nameSerie, namemac, nameId, namePass);
			if(GenericUtil.isCollectionEmpty(postCreateOnu)) {
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
			
			getListOnuState = getListOnuStateJdbcRepository.getListOnuState();
			if(GenericUtil.isCollectionEmpty(getListOnuState)) {
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
			
			getListActivaationRange = getListActivaationRangeJdbcRepository.getListActivaationRange(datei, datef);
			if(GenericUtil.isCollectionEmpty(getListActivaationRange)) {
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
