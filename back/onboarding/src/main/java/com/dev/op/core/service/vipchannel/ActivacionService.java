package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;

public interface ActivacionService {
	List<getListOnuModel> getListOnu();
	List<getListCountOnuModel> getListCountOnu(Integer detalleIds,Integer nextids);
	List<ResponseModel> putStatusOnu(Integer idOnu,Integer optio,Integer idPk,Integer nextId, String description,Integer statusOnu);
}
