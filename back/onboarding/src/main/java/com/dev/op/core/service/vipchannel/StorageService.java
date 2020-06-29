package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;
import com.dev.op.core.dto.vipchannel.getListRemisionModel;
import com.dev.op.core.dto.vipchannel.getProdctModel;
import com.dev.op.core.dto.vipchannel.getProductProviderModel;
import com.dev.op.core.dto.vipchannel.getProviderModel;

public interface StorageService {
	List<getProdctModel> getProdct();
	List<getProviderModel> getProvider();
	List<getListRemisionModel> getListRemision();
	List<getProductProviderModel> getProductProvider();
	List<getListRemisionByIdModel> getListRemisionById(Integer remisId);
	List<ResponseModel> postProductP(Integer productId,Integer provideId,String price);
	List<ResponseModel> postSaveProvide(String name);
	List<ResponseModel> postSaveProduc(String name,String code,String description,String codeP,String medi);
	List<ResponseModel> postRemision(Integer options,Integer typeRemi,Integer producId,Integer providerId,Integer counts,String conditions,String autorize,Integer codeuser);
}
