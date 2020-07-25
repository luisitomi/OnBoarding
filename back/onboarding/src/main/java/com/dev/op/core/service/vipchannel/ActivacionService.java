package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;
import com.dev.op.core.dto.vipchannel.getListActivationModel;
import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.dto.vipchannel.getListOnuStateModel;

public interface ActivacionService {
	List<getListOnuModel> getListOnu();
	List<getListCountOnuModel> getListCountOnu(Integer detalleIds,Integer nextids);
	List<getListActivationModel> getListActivation();
	List<getListOnuStateModel> getListOnuState();
	List<ResponseModel> putStatusOnu(Integer idOnu,Integer optio,Integer idPk,Integer nextId, String description,Integer statusOnu);
	List<ResponseModel> putUpdateOnu(Integer idOnu,String nameSerie,String namemac);
	List<ResponseModel> patchActivationService(Integer activationId,String dateinfo);
	List<ResponseModel> patchStorageValidate(Integer idRemision);
	List<ResponseModel> patchPasswordOnu(Integer idOnu,String nameId,String namePass);
	List<ResponseModel> patchActivationOnu(Integer idOnu);
	List<ResponseModel> postCreateOnu(String nameSerie,String namemac,String nameId,String namePass);
	List<getListActivaationRangeModel> getListActivaationRange(String datei,String datef);
}
