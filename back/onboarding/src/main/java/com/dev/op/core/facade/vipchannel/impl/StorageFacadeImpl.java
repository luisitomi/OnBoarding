package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;
import com.dev.op.core.dto.vipchannel.getListRemisionModel;
import com.dev.op.core.dto.vipchannel.getProdctModel;
import com.dev.op.core.dto.vipchannel.getProductProviderModel;
import com.dev.op.core.dto.vipchannel.getProviderModel;
import com.dev.op.core.facade.vipchannel.StorageFacade;
import com.dev.op.core.service.vipchannel.StorageService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("storageFacade")
public class StorageFacadeImpl implements StorageFacade{

	@Autowired
	@Qualifier("storageService")
	private StorageService storageService;
	
	@Override
	public List<getProdctModel> getProdct() {
		List<getProdctModel> getProdct = new ArrayList<getProdctModel>();
		
		try {
			
			getProdct = storageService.getProdct();
			if(GenericUtil.isEmpty(getProdct)) {
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
			
			getProvider = storageService.getProvider();
			if(GenericUtil.isEmpty(getProvider)) {
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
			
			getListRemision = storageService.getListRemision();
			if(GenericUtil.isEmpty(getListRemision)) {
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
			
			getProductProvider = storageService.getProductProvider(optio,productoE);
			if(GenericUtil.isEmpty(getProductProvider)) {
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
			
			getListRemisionById = storageService.getListRemisionById(remisId);
			if(GenericUtil.isEmpty(getListRemisionById)) {
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
			
			postProductP = storageService.postProductP(productId, provideId, price);
			if(GenericUtil.isEmpty(postProductP)) {
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
			
			postSaveProvide = storageService.postSaveProvide(name);
			if(GenericUtil.isEmpty(postSaveProvide)) {
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
			
			postSaveProduc = storageService.postSaveProduc(name, code, description, codeP, medi);
			if(GenericUtil.isEmpty(postSaveProduc)) {
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
			
			postRemision = storageService.postRemision(options, typeRemi, producId, providerId, counts, conditions, autorize, codeuser);
			if(GenericUtil.isEmpty(postRemision)) {
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
			
			putSaveProvide = storageService.putSaveProvide(name, provideId);
			if(GenericUtil.isEmpty(putSaveProvide)) {
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
			
			putSaveProduct = storageService.putSaveProduct(producId, name, code, description, codeP, medi);
			if(GenericUtil.isEmpty(putSaveProduct)) {
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
