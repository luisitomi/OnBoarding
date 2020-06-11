package com.dev.op.core.facade.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListReclaimModel;
import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;
import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;

public interface AtencionFacade {
	List<getListReclaimModel> getListReclaim();
	List<getListServiceActiveModel> getListServiceActive(String document,String code);
	List<ResponseModel> postReclaimById(String document,String code,Integer service,Integer reclaim,String description);
	List<getReclaimStatusModel> getReclaimStatus(String datei,String datef);
}
