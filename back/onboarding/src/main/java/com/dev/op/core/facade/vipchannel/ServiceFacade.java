package com.dev.op.core.facade.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.dto.vipchannel.getMaterialModel;

public interface ServiceFacade {
	List<getListServicePendingModel> getListServicePending();
	List<getMaterialModel> getMaterial();
	List<getMaterialAllModel> getMaterialAll();
	List<ResponseModel> postMaterial(String name);
	List<ResponseModel> putMaterial(String name,Integer idMaterial);
	List<ResponseModel> postServiceInstall(Integer detaiId,Integer nextId,Integer tec,String description, Integer mateId,Integer counts);
}
