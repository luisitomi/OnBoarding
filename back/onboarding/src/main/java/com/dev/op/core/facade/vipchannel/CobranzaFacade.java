package com.dev.op.core.facade.vipchannel;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getListMangerModel;
import com.dev.op.core.dto.vipchannel.getListVoucherModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;

public interface CobranzaFacade {
	List<getPersonByDocumentModel> getPersonByDocument(String search);
	List<getPersonByIdModel> getPersonById(String document);
	List<getDirectionByIdModel> getDirectionById(String document,String code);
	List<getReferenceByIdModel> getReferenceById(String document,String code);
	List<getManagerByIdModel> getManagerById(String document,String code);
	List<getVoucherByIdModel> getVoucherById(String document,String code);
	List<getPayServiceDetailModel> getPayServiceDetail(String document,String code);
	List<getListMangerModel> getListManger();
	List<getListVoucherModel> getListVoucher();
}
