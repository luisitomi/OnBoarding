package com.dev.op.core.facade.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;

public interface ActivacionFacade {
	List<getListOnuModel> getListOnu();
	List<ResponseModel> putStatusOnu(Integer idOnu,Integer optio,Integer idPk,Integer nextId, String description,Integer statusOnu);
}
