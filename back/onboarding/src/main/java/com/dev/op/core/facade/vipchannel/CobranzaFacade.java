package com.dev.op.core.facade.vipchannel;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getListMangerModel;
import com.dev.op.core.dto.vipchannel.getListPayModel;
import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.dto.vipchannel.getListPayThreeModel;
import com.dev.op.core.dto.vipchannel.getListPayTwoModel;
import com.dev.op.core.dto.vipchannel.getListVoucherModel;
import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;
import com.dev.op.core.dto.vipchannel.getManagaerCountModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getManagerSumationModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteMonthModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;
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
	List<getPayServiceDetailModel> getPayServiceDetail(String document,String code, String user);
	List<getPayServiceDetailDeleteModel> getPayServiceDetailDelete(String document,String code);
	List<getListMangerModel> getListManger();
	List<getListVoucherModel> getListVoucher();
	List<getManagaerCountModel> getManagaerCount(String con);
	List<getManagerSumationModel> getManagerSumation();
	List<getListlienteByManagerModel> getListlienteByManager(String manager);
	List<getListPayModel> getListPay(String user,String explicite);
	List<getListPayOneModel> getListPayOne();
	List<getListPayTwoModel> getListPayTwo();
	List<getListPayThreeModel> getListPayThree();
	List<getPayServiceDetailMonthModel> getPayServiceDetailMonth(String document,String code, String user);
	List<getPayServiceDetailDeleteMonthModel> getPayServiceDetailDeleteMonth(String document,String code);
	List<ResponseModel> patchManagerById(String document,String code,Integer code_manager);
	List<ResponseModel> patchVoucherById(String document,String code,Integer voucher,Integer service);
	List<ResponseModel> putDirectionById(String document,String code,String number,Integer zone);
	List<ResponseModel> putPersonById(String document,String name,String last,String second,String client);
	List<ResponseModel> putReferenceById(String document,String code,String description);
	List<ResponseModel> deletePayService(String code);
	List<ResponseModel> deleteDetailCount(String document,String code,Integer status);
	List<ResponseModel> postChangeAmount(String document,String code,Integer service,BigDecimal amount,Date dateformat,Integer user);
	List<ResponseModel> postPayService(String document,String code,BigDecimal amount,Integer user, Integer manager);
	List<ResponseModel> postPayServiceDetailDelete(String document,String code,BigDecimal amount,Integer user);
}
