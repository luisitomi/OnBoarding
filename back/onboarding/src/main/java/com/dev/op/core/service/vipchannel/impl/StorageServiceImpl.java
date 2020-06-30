package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;
import com.dev.op.core.dto.vipchannel.getListRemisionModel;
import com.dev.op.core.dto.vipchannel.getProdctModel;
import com.dev.op.core.dto.vipchannel.getProductProviderModel;
import com.dev.op.core.dto.vipchannel.getProviderModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListRemisionByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListRemisionJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getProdctJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getProductProviderJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getProviderJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postProductPJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postRemisionJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postSaveProducJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postSaveProvideJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putSaveProductJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putSaveProvideJdbcRepository;
import com.dev.op.core.service.vipchannel.StorageService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("storageService")
@Transactional("hibernateTransactionManager")
public class StorageServiceImpl implements StorageService{
	
	@Autowired
	@Qualifier("getProdctJdbcRepository")
	private getProdctJdbcRepository getProdctJdbcRepository;
	
	@Autowired
	@Qualifier("getProductProviderJdbcRepository")
	private getProductProviderJdbcRepository getProductProviderJdbcRepository;
	
	@Autowired
	@Qualifier("getProviderJdbcRepository")
	private getProviderJdbcRepository getProviderJdbcRepository;
	
	@Autowired
	@Qualifier("getListRemisionJdbcRepository")
	private getListRemisionJdbcRepository getListRemisionJdbcRepository;
	
	@Autowired
	@Qualifier("getListRemisionByIdJdbcRepository")
	private getListRemisionByIdJdbcRepository getListRemisionByIdJdbcRepository;
	
	@Autowired
	@Qualifier("postProductPJdbcRepository")
	private postProductPJdbcRepository postProductPJdbcRepository;
	
	@Autowired
	@Qualifier("postSaveProducJdbcRepository")
	private postSaveProducJdbcRepository postSaveProducJdbcRepository;
	
	@Autowired
	@Qualifier("postSaveProvideJdbcRepository")
	private postSaveProvideJdbcRepository postSaveProvideJdbcRepository;
	
	@Autowired
	@Qualifier("postRemisionJdbcRepository")
	private postRemisionJdbcRepository postRemisionJdbcRepository;
	
	@Autowired
	@Qualifier("putSaveProvideJdbcRepository")
	private putSaveProvideJdbcRepository putSaveProvideJdbcRepository;
	
	@Autowired
	@Qualifier("putSaveProductJdbcRepository")
	private putSaveProductJdbcRepository putSaveProductJdbcRepository;

	@Override
	public List<getProdctModel> getProdct() {
		List<getProdctModel> getProdct = new ArrayList<getProdctModel>();
		
		try {
			
			getProdct = getProdctJdbcRepository.getProdct();
			if(GenericUtil.isCollectionEmpty(getProdct)) {
				return null;
			}
			else {
				return getProdct;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getProviderModel> getProvider() {
		List<getProviderModel> getProvider = new ArrayList<getProviderModel>();
		
		try {
			
			getProvider = getProviderJdbcRepository.getProvider();
			if(GenericUtil.isCollectionEmpty(getProvider)) {
				return null;
			}
			else {
				return getProvider;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListRemisionModel> getListRemision() {
		List<getListRemisionModel> getListRemision = new ArrayList<getListRemisionModel>();
		
		try {
			
			getListRemision = getListRemisionJdbcRepository.getListRemision();
			if(GenericUtil.isCollectionEmpty(getListRemision)) {
				return null;
			}
			else {
				return getListRemision;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getProductProviderModel> getProductProvider(Integer optio,Integer productoE) {
		List<getProductProviderModel> getProductProvider = new ArrayList<getProductProviderModel>();
		
		try {
			
			getProductProvider = getProductProviderJdbcRepository.getProductProvider(optio,productoE);
			if(GenericUtil.isCollectionEmpty(getProductProvider)) {
				return null;
			}
			else {
				return getProductProvider;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListRemisionByIdModel> getListRemisionById(Integer remisId) {
		List<getListRemisionByIdModel> getListRemisionById = new ArrayList<getListRemisionByIdModel>();
		
		try {
			
			getListRemisionById = getListRemisionByIdJdbcRepository.getListRemisionById(remisId);
			if(GenericUtil.isCollectionEmpty(getListRemisionById)) {
				return null;
			}
			else {
				return getListRemisionById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postProductP(Integer productId, Integer provideId, String price) {
		List<ResponseModel> postProductP = new ArrayList<ResponseModel>();
		
		try {
			
			postProductP = postProductPJdbcRepository.postProductP(productId, provideId, price);
			if(GenericUtil.isCollectionEmpty(postProductP)) {
				return null;
			}
			else {
				return postProductP;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postSaveProvide(String name) {
		List<ResponseModel> postSaveProvide = new ArrayList<ResponseModel>();
		
		try {
			
			postSaveProvide = postSaveProvideJdbcRepository.postSaveProvide(name);
			if(GenericUtil.isCollectionEmpty(postSaveProvide)) {
				return null;
			}
			else {
				return postSaveProvide;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postSaveProduc(String name, String code, String description, String codeP, String medi) {
		List<ResponseModel> postSaveProduc = new ArrayList<ResponseModel>();
		
		try {
			
			postSaveProduc = postSaveProducJdbcRepository.postSaveProduc(name, code, description, codeP, medi);
			if(GenericUtil.isCollectionEmpty(postSaveProduc)) {
				return null;
			}
			else {
				return postSaveProduc;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postRemision(Integer options, Integer typeRemi, Integer producId, Integer providerId,
			Integer counts, String conditions, String autorize, Integer codeuser) {
		List<ResponseModel> postRemision = new ArrayList<ResponseModel>();
		
		try {
			
			postRemision = postRemisionJdbcRepository.postRemision(options, typeRemi, producId, providerId, counts, conditions, autorize, codeuser);
			if(GenericUtil.isCollectionEmpty(postRemision)) {
				return null;
			}
			else {
				return postRemision;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putSaveProvide(String name, Integer provideId) {
		List<ResponseModel> putSaveProvide = new ArrayList<ResponseModel>();
		
		try {
			
			putSaveProvide = putSaveProvideJdbcRepository.putSaveProvide(name, provideId);
			if(GenericUtil.isCollectionEmpty(putSaveProvide)) {
				return null;
			}
			else {
				return putSaveProvide;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putSaveProduct(Integer producId, String name, String code, String description,
			String codeP, String medi) {
		List<ResponseModel> putSaveProduct = new ArrayList<ResponseModel>();
		
		try {
			
			putSaveProduct = putSaveProductJdbcRepository.putSaveProduct(producId, name, code, description, codeP, medi);
			if(GenericUtil.isCollectionEmpty(putSaveProduct)) {
				return null;
			}
			else {
				return putSaveProduct;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
