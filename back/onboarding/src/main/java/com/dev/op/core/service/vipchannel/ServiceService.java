package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.dto.vipchannel.getListTecniModel;
import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.dto.vipchannel.getMaterialModel;

public interface ServiceService {
	List<getListServicePendingModel> getListServicePending(Integer codeUser);
	List<getMaterialModel> getMaterial();
	List<getListTecniModel> getListTecni();
	List<getMaterialAllModel> getMaterialAll();
	List<ResponseModel> postMaterial(String name);
	List<ResponseModel> postServiceInstall(Integer detaiId,Integer nextId,Integer tec,String description, Integer mateId,Integer counts);
	List<ResponseModel> putMaterial(String name,Integer idMaterial);
	List<ResponseModel> putTecnInstall(Integer optionI,Integer tecn,Integer idP,Integer nextId);
}
