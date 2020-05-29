package com.dev.op.core.facade.vipchannel.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getListMangerModel;
import com.dev.op.core.dto.vipchannel.getListPayModel;
import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.dto.vipchannel.getListVoucherModel;
import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;
import com.dev.op.core.dto.vipchannel.getManagaerCountModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;
import com.dev.op.core.facade.vipchannel.CobranzaFacade;
import com.dev.op.core.service.vipchannel.CobranzaService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("cobranzaFacade")
public class CobranzaFacadeImpl implements CobranzaFacade {

	@Autowired
	@Qualifier("cobranzaService")
	private CobranzaService cobranzaService;
	
	@Override
	public List<getPersonByDocumentModel> getPersonByDocument(String search) {
		List<getPersonByDocumentModel> getPersonByDocument = new ArrayList<getPersonByDocumentModel>();
		
		try {
			
			getPersonByDocument = cobranzaService.getPersonByDocument(search);
			if(GenericUtil.isEmpty(getPersonByDocument)) {
				return null;
			}
			else {
				return getPersonByDocument;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPersonByIdModel> getPersonById(String document) {
		List<getPersonByIdModel> getPersonById = new ArrayList<getPersonByIdModel>();
		
		try {
			
			getPersonById = cobranzaService.getPersonById(document);
			if(GenericUtil.isEmpty(getPersonById)) {
				return null;
			}
			else {
				return getPersonById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getDirectionByIdModel> getDirectionById(String document, String code) {
		List<getDirectionByIdModel> getDirectionById = new ArrayList<getDirectionByIdModel>();
		
		try {
			
			getDirectionById = cobranzaService.getDirectionById(document, code);
			if(GenericUtil.isEmpty(getDirectionById)) {
				return null;
			}
			else {
				return getDirectionById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getReferenceByIdModel> getReferenceById(String document, String code) {
		List<getReferenceByIdModel> getReferenceById = new ArrayList<getReferenceByIdModel>();
		
		try {
			
			getReferenceById = cobranzaService.getReferenceById(document, code);
			if(GenericUtil.isEmpty(getReferenceById)) {
				return null;
			}
			else {
				return getReferenceById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getManagerByIdModel> getManagerById(String document, String code) {
		List<getManagerByIdModel> getManagerById = new ArrayList<getManagerByIdModel>();
		
		try {
			
			getManagerById = cobranzaService.getManagerById(document, code);
			if(GenericUtil.isEmpty(getManagerById)) {
				return null;
			}
			else {
				return getManagerById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getVoucherByIdModel> getVoucherById(String document, String code) {
		List<getVoucherByIdModel> getVoucherById = new ArrayList<getVoucherByIdModel>();
		
		try {
			
			getVoucherById = cobranzaService.getVoucherById(document, code);
			if(GenericUtil.isEmpty(getVoucherById)) {
				return null;
			}
			else {
				return getVoucherById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailModel> getPayServiceDetail(String document, String code, String user) {
		List<getPayServiceDetailModel> getPayServiceDetail = new ArrayList<getPayServiceDetailModel>();
		
		try {
			
			getPayServiceDetail = cobranzaService.getPayServiceDetail(document, code, user);
			if(GenericUtil.isEmpty(getPayServiceDetail)) {
				return null;
			}
			else {
				return getPayServiceDetail;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListMangerModel> getListManger() {
		List<getListMangerModel> getListManger = new ArrayList<getListMangerModel>();
		
		try {
			
			getListManger = cobranzaService.getListManger();
			if(GenericUtil.isEmpty(getListManger)) {
				return null;
			}
			else {
				return getListManger;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListVoucherModel> getListVoucher() {
		List<getListVoucherModel> getListVoucher = new ArrayList<getListVoucherModel>();
		
		try {
			
			getListVoucher = cobranzaService.getListVoucher();
			if(GenericUtil.isEmpty(getListVoucher)) {
				return null;
			}
			else {
				return getListVoucher;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getManagaerCountModel> getManagaerCount(String con) {
		List<getManagaerCountModel> getManagaerCount = new ArrayList<getManagaerCountModel>();
		
		try {
			
			getManagaerCount = cobranzaService.getManagaerCount(con);
			if(GenericUtil.isEmpty(getManagaerCount)) {
				return null;
			}
			else {
				return getManagaerCount;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListlienteByManagerModel> getListlienteByManager(String manager) {
		List<getListlienteByManagerModel> getListlienteByManager = new ArrayList<getListlienteByManagerModel>();
		
		try {
			
			getListlienteByManager = cobranzaService.getListlienteByManager(manager);
			if(GenericUtil.isEmpty(getListlienteByManager)) {
				return null;
			}
			else {
				return getListlienteByManager;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListPayModel> getListPay(String user, String explicite) {
		List<getListPayModel> getListPay = new ArrayList<getListPayModel>();
		
		try {
			
			getListPay = cobranzaService.getListPay(user, explicite);
			if(GenericUtil.isEmpty(getListPay)) {
				return null;
			}
			else {
				return getListPay;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailMonthModel> getPayServiceDetailMonth(String document, String code, String user) {
		List<getPayServiceDetailMonthModel> getPayServiceDetailMonth = new ArrayList<getPayServiceDetailMonthModel>();
		
		try {
			
			getPayServiceDetailMonth = cobranzaService.getPayServiceDetailMonth(document, code, user);
			if(GenericUtil.isEmpty(getPayServiceDetailMonth)) {
				return null;
			}
			else {
				return getPayServiceDetailMonth;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchManagerById(String document, String code, Integer code_manager) {
		List<ResponseModel> patchManagerById = new ArrayList<ResponseModel>();
		
		try {
			
			patchManagerById = cobranzaService.patchManagerById(document, code, code_manager);
			if(GenericUtil.isEmpty(patchManagerById)) {
				return null;
			}
			else {
				return patchManagerById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> patchVoucherById(String document, String code, Integer voucher, Integer service) {
		List<ResponseModel> patchVoucherById = new ArrayList<ResponseModel>();
		
		try {
			
			patchVoucherById = cobranzaService.patchVoucherById(document, code, voucher, service);
			if(GenericUtil.isEmpty(patchVoucherById)) {
				return null;
			}
			else {
				return patchVoucherById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putDirectionById(String document, String code, String number, Integer zone) {
		List<ResponseModel> putDirectionById = new ArrayList<ResponseModel>();
		
		try {
			
			putDirectionById = cobranzaService.putDirectionById(document, code, number, zone);
			if(GenericUtil.isEmpty(putDirectionById)) {
				return null;
			}
			else {
				return putDirectionById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putPersonById(String document, String name, String last, String second, String client) {
		List<ResponseModel> putPersonById = new ArrayList<ResponseModel>();
		
		try {
			
			putPersonById = cobranzaService.putPersonById(document, name, last, second, client);
			if(GenericUtil.isEmpty(putPersonById)) {
				return null;
			}
			else {
				return putPersonById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putReferenceById(String document, String code, String description) {
		List<ResponseModel> putReferenceById = new ArrayList<ResponseModel>();
		
		try {
			
			putReferenceById = cobranzaService.putReferenceById(document, code, description);
			if(GenericUtil.isEmpty(putReferenceById)) {
				return null;
			}
			else {
				return putReferenceById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> deletePayService(String code) {
		List<ResponseModel> deletePayService = new ArrayList<ResponseModel>();
		
		try {
			
			deletePayService = cobranzaService.deletePayService(code);
			if(GenericUtil.isEmpty(deletePayService)) {
				return null;
			}
			else {
				return deletePayService;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> deleteDetailCount(String document, String code, Integer status) {
		List<ResponseModel> deleteDetailCount = new ArrayList<ResponseModel>();
		
		try {
			
			deleteDetailCount = cobranzaService.deleteDetailCount(document, code, status);
			if(GenericUtil.isEmpty(deleteDetailCount)) {
				return null;
			}
			else {
				return deleteDetailCount;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postChangeAmount(String document, String code, Integer service, BigDecimal amount,
			Date dateformat, Integer user) {
		List<ResponseModel> postChangeAmount = new ArrayList<ResponseModel>();
		
		try {
			
			postChangeAmount = cobranzaService.postChangeAmount(document, code, service, amount, dateformat, user);
			if(GenericUtil.isEmpty(postChangeAmount)) {
				return null;
			}
			else {
				return postChangeAmount;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postPayService(String document, String code, BigDecimal amount, Integer user,
			Integer manager) {
		List<ResponseModel> postPayService = new ArrayList<ResponseModel>();
		
		try {
			
			postPayService = cobranzaService.postPayService(document, code, amount, user, manager);
			if(GenericUtil.isEmpty(postPayService)) {
				return null;
			}
			else {
				return postPayService;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListPayOneModel> getListPayOne() {
		List<getListPayOneModel> getListPayOne = new ArrayList<getListPayOneModel>();
		
		try {
			
			getListPayOne = cobranzaService.getListPayOne();
			if(GenericUtil.isEmpty(getListPayOne)) {
				return null;
			}
			else {
				return getListPayOne;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
