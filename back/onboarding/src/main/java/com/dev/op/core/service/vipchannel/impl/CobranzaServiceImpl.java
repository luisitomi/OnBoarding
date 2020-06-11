package com.dev.op.core.service.vipchannel.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getListDirectionModel;
import com.dev.op.core.dto.vipchannel.getListManagerReportModel;
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
import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitMonthModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;
import com.dev.op.core.repository.vipchannel.jdbc.deleteDetailCountJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.deletePayServiceJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getDirectionByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListDirectionJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListManagerReportJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListMangerJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListVoucherJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getManagerByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getManagerSumationJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailDeleteJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailMonthJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailDeleteMonthJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailExitJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPayServiceDetailExitMonthJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPersonByDocumentJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getPersonByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getReferenceByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getVoucherByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListPayJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListPayOneJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListPayTwoJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListPayThreeJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListlienteByManagerJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getManagaerCountJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchManagerByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.patchVoucherByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postChangeAmountJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postPayServiceJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postPayServiceDetailDeleteJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putPersonByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putDirectionByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putReferenceByIdJdbcRepository;
import com.dev.op.core.service.vipchannel.CobranzaService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("cobranzaService")
@Transactional("hibernateTransactionManager")
public class CobranzaServiceImpl implements CobranzaService {

	@Autowired
	@Qualifier("getPersonByDocumentJdbcRepository")
	private getPersonByDocumentJdbcRepository getPersonByDocumentJdbcRepository;
	
	@Autowired
	@Qualifier("getPersonByIdJdbcRepository")
	private getPersonByIdJdbcRepository getPersonByIdJdbcRepository;

	@Autowired
	@Qualifier("getDirectionByIdJdbcRepository")
	private getDirectionByIdJdbcRepository getDirectionByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getReferenceByIdJdbcRepository")
	private getReferenceByIdJdbcRepository getReferenceByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getManagerByIdJdbcRepository")
	private getManagerByIdJdbcRepository getManagerByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getVoucherByIdJdbcRepository")
	private getVoucherByIdJdbcRepository getVoucherByIdJdbcRepository;
	
	@Autowired
	@Qualifier("getListDirectionJdbcRepository")
	private getListDirectionJdbcRepository getListDirectionJdbcRepository;
	
	@Autowired
	@Qualifier("getListMangerJdbcRepository")
	private getListMangerJdbcRepository getListMangerJdbcRepository;
	
	@Autowired
	@Qualifier("getListVoucherJdbcRepository")
	private getListVoucherJdbcRepository getListVoucherJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailMonthJdbcRepository")
	private getPayServiceDetailMonthJdbcRepository getPayServiceDetailMonthJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailExitJdbcRepository")
	private getPayServiceDetailExitJdbcRepository getPayServiceDetailExitJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailDeleteMonthJdbcRepository")
	private getPayServiceDetailDeleteMonthJdbcRepository getPayServiceDetailDeleteMonthJdbcRepository;
	
	@Autowired
	@Qualifier("getListPayJdbcRepository")
	private getListPayJdbcRepository getListPayJdbcRepository;
	
	@Autowired
	@Qualifier("getListPayOneJdbcRepository")
	private getListPayOneJdbcRepository getListPayOneJdbcRepository;
	
	@Autowired
	@Qualifier("getListPayTwoJdbcRepository")
	private getListPayTwoJdbcRepository getListPayTwoJdbcRepository;
	
	@Autowired
	@Qualifier("getListPayThreeJdbcRepository")
	private getListPayThreeJdbcRepository getListPayThreeJdbcRepository;
	
	@Autowired
	@Qualifier("getListlienteByManagerJdbcRepository")
	private getListlienteByManagerJdbcRepository getListlienteByManagerJdbcRepository;
	
	@Autowired
	@Qualifier("getManagaerCountJdbcRepository")
	private getManagaerCountJdbcRepository getManagaerCountJdbcRepository;
	
	@Autowired
	@Qualifier("getManagerSumationJdbcRepository")
	private getManagerSumationJdbcRepository getManagerSumationJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailJdbcRepository")
	private getPayServiceDetailJdbcRepository getPayServiceDetailJdbcRepository;
	
	@Autowired
	@Qualifier("getPayServiceDetailDeleteJdbcRepository")
	private getPayServiceDetailDeleteJdbcRepository getPayServiceDetailDeleteMonth;
	
	@Autowired
	@Qualifier("getPayServiceDetailExitMonthJdbcRepository")
	private getPayServiceDetailExitMonthJdbcRepository getPayServiceDetailExitMonthJdbcRepository;
	
	@Autowired
	@Qualifier("getListManagerReportJdbcRepository")
	private getListManagerReportJdbcRepository getListManagerReportJdbcRepository;
	
	@Autowired
	@Qualifier("patchManagerByIdJdbcRepository")
	private patchManagerByIdJdbcRepository patchManagerByIdJdbcRepository;
	
	@Autowired
	@Qualifier("patchVoucherByIdJdbcRepository")
	private patchVoucherByIdJdbcRepository patchVoucherByIdJdbcRepository;
	
	@Autowired
	@Qualifier("putDirectionByIdJdbcRepository")
	private putDirectionByIdJdbcRepository putDirectionByIdJdbcRepository;
	
	@Autowired
	@Qualifier("putPersonByIdJdbcRepository")
	private putPersonByIdJdbcRepository putPersonByIdJdbcRepository;
	
	@Autowired
	@Qualifier("putReferenceByIdJdbcRepository")
	private putReferenceByIdJdbcRepository putReferenceByIdJdbcRepository;
	
	@Autowired
	@Qualifier("deletePayServiceJdbcRepository")
	private deletePayServiceJdbcRepository deletePayServiceJdbcRepository;
	
	@Autowired
	@Qualifier("deleteDetailCountJdbcRepository")
	private deleteDetailCountJdbcRepository deleteDetailCountJdbcRepository;
	
	@Autowired
	@Qualifier("postChangeAmountJdbcRepository")
	private postChangeAmountJdbcRepository postChangeAmountJdbcRepository;
	
	@Autowired
	@Qualifier("postPayServiceJdbcRepository")
	private postPayServiceJdbcRepository postPayServiceJdbcRepository;
	
	@Autowired
	@Qualifier("postPayServiceDetailDeleteJdbcRepository")
	private postPayServiceDetailDeleteJdbcRepository postPayServiceDetailDeleteJdbcRepository;
	
	@Override
	public List<getPersonByDocumentModel> getPersonByDocument(String search) {
		List<getPersonByDocumentModel> getPersonByDocument = new ArrayList<getPersonByDocumentModel>();
		
		try {
			
			getPersonByDocument = getPersonByDocumentJdbcRepository.getPersonByDocument(search);
			if(GenericUtil.isCollectionEmpty(getPersonByDocument)) {
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
			
			getPersonById = getPersonByIdJdbcRepository.getPersonById(document);
			if(GenericUtil.isCollectionEmpty(getPersonById)) {
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
			
			getDirectionById = getDirectionByIdJdbcRepository.getDirectionById(document, code);
			if(GenericUtil.isCollectionEmpty(getDirectionById)) {
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
			
			getReferenceById = getReferenceByIdJdbcRepository.getReferenceById(document, code);
			if(GenericUtil.isCollectionEmpty(getReferenceById)) {
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
			
			getManagerById = getManagerByIdJdbcRepository.getManagerById(document, code);
			if(GenericUtil.isCollectionEmpty(getManagerById)) {
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
			
			getVoucherById = getVoucherByIdJdbcRepository.getVoucherById(document, code);
			if(GenericUtil.isCollectionEmpty(getVoucherById)) {
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
			
			getPayServiceDetail = getPayServiceDetailJdbcRepository.getPayServiceDetail(document, code, user);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetail)) {
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
			
			getListManger = getListMangerJdbcRepository.getListManger();
			if(GenericUtil.isCollectionEmpty(getListManger)) {
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
			
			getListVoucher = getListVoucherJdbcRepository.getListVoucher();
			if(GenericUtil.isCollectionEmpty(getListVoucher)) {
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
			
			getManagaerCount = getManagaerCountJdbcRepository.getManagaerCount(con);
			if(GenericUtil.isCollectionEmpty(getManagaerCount)) {
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
			
			getListlienteByManager = getListlienteByManagerJdbcRepository.getListlienteByManager(manager);
			if(GenericUtil.isCollectionEmpty(getListlienteByManager)) {
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
	public List<getListPayModel> getListPay(Integer user, String explicite) {
		List<getListPayModel> getListPay = new ArrayList<getListPayModel>();
		
		try {
			
			getListPay = getListPayJdbcRepository.getListPay(user, explicite);
			if(GenericUtil.isCollectionEmpty(getListPay)) {
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
			
			getPayServiceDetailMonth = getPayServiceDetailMonthJdbcRepository.getPayServiceDetailMonth(document, code, user);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetailMonth)) {
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
			
			patchManagerById = patchManagerByIdJdbcRepository.patchManagerById(document, code, code_manager);
			if(GenericUtil.isCollectionEmpty(patchManagerById)) {
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
			
			patchVoucherById = patchVoucherByIdJdbcRepository.patchVoucherById(document, code, voucher, service);
			if(GenericUtil.isCollectionEmpty(patchVoucherById)) {
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
			
			putDirectionById = putDirectionByIdJdbcRepository.putDirectionById(document, code, number, zone);
			if(GenericUtil.isCollectionEmpty(putDirectionById)) {
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
			
			putPersonById = putPersonByIdJdbcRepository.putPersonById(document, name, last, second, client);
			if(GenericUtil.isCollectionEmpty(putPersonById)) {
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
			
			putReferenceById = putReferenceByIdJdbcRepository.putReferenceById(document, code, description);
			if(GenericUtil.isCollectionEmpty(putReferenceById)) {
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
			
			deletePayService = deletePayServiceJdbcRepository.deletePayService(code);
			if(GenericUtil.isCollectionEmpty(deletePayService)) {
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
			
			deleteDetailCount = deleteDetailCountJdbcRepository.deleteDetailCount(document, code, status);
			if(GenericUtil.isCollectionEmpty(deleteDetailCount)) {
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
			
			postChangeAmount = postChangeAmountJdbcRepository.postChangeAmount(document, code, service, amount, dateformat, user);
			if(GenericUtil.isCollectionEmpty(postChangeAmount)) {
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
			
			postPayService = postPayServiceJdbcRepository.postPayService(document, code, amount, user, manager);
			if(GenericUtil.isCollectionEmpty(postPayService)) {
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
			
			getListPayOne = getListPayOneJdbcRepository.getListPayOne();
			if(GenericUtil.isCollectionEmpty(getListPayOne)) {
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

	@Override
	public List<getListPayTwoModel> getListPayTwo() {
		List<getListPayTwoModel> getListPayTwo = new ArrayList<getListPayTwoModel>();
		
		try {
			
			getListPayTwo = getListPayTwoJdbcRepository.getListPayTwo();
			if(GenericUtil.isCollectionEmpty(getListPayTwo)) {
				return null;
			}
			else {
				return getListPayTwo;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListPayThreeModel> getListPayThree() {
		List<getListPayThreeModel> getListPayThree = new ArrayList<getListPayThreeModel>();
		
		try {
			
			getListPayThree = getListPayThreeJdbcRepository.getListPayThree();
			if(GenericUtil.isCollectionEmpty(getListPayThree)) {
				return null;
			}
			else {
				return getListPayThree;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailDeleteModel> getPayServiceDetailDelete(String document, String code) {
		List<getPayServiceDetailDeleteModel> getPayServiceDetailDelete = new ArrayList<getPayServiceDetailDeleteModel>();
		
		try {
			
			getPayServiceDetailDelete = getPayServiceDetailDeleteMonth.getPayServiceDetailDelete(document, code);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetailDelete)) {
				return null;
			}
			else {
				return getPayServiceDetailDelete;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailDeleteMonthModel> getPayServiceDetailDeleteMonth(String document, String code) {
		List<getPayServiceDetailDeleteMonthModel> getPayServiceDetailDeleteMonth = new ArrayList<getPayServiceDetailDeleteMonthModel>();
		
		try {
			
			getPayServiceDetailDeleteMonth = getPayServiceDetailDeleteMonthJdbcRepository.getPayServiceDetailDeleteMonth(document, code);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetailDeleteMonth)) {
				return null;
			}
			else {
				return getPayServiceDetailDeleteMonth;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> postPayServiceDetailDelete(String document, String code, BigDecimal amount,
			Integer user) {
		List<ResponseModel> postPayServiceDetailDelete = new ArrayList<ResponseModel>();
		
		try {
			
			postPayServiceDetailDelete = postPayServiceDetailDeleteJdbcRepository.postPayServiceDetailDelete(document, code, amount, user);
			if(GenericUtil.isCollectionEmpty(postPayServiceDetailDelete)) {
				return null;
			}
			else {
				return postPayServiceDetailDelete;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getManagerSumationModel> getManagerSumation() {
		List<getManagerSumationModel> getManagerSumation = new ArrayList<getManagerSumationModel>();
		
		try {
			
			getManagerSumation = getManagerSumationJdbcRepository.getManagerSumation();
			if(GenericUtil.isCollectionEmpty(getManagerSumation)) {
				return null;
			}
			else {
				return getManagerSumation;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListDirectionModel> getListDirection() {
		List<getListDirectionModel> getListDirection = new ArrayList<getListDirectionModel>();
		
		try {
			
			getListDirection = getListDirectionJdbcRepository.getListDirection();
			if(GenericUtil.isCollectionEmpty(getListDirection)) {
				return null;
			}
			else {
				return getListDirection;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailExitModel> getPayServiceDetailExit(String document, String code, String user) {
		List<getPayServiceDetailExitModel> getPayServiceDetailExit = new ArrayList<getPayServiceDetailExitModel>();
		
		try {
			
			getPayServiceDetailExit = getPayServiceDetailExitJdbcRepository.getPayServiceDetailExit(document, code, user);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetailExit)) {
				return null;
			}
			else {
				return getPayServiceDetailExit;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getPayServiceDetailExitMonthModel> getPayServiceDetailExitMonth(String document, String code,
			String user) {
		List<getPayServiceDetailExitMonthModel> getPayServiceDetailExitMonth = new ArrayList<getPayServiceDetailExitMonthModel>();
		
		try {
			
			getPayServiceDetailExitMonth = getPayServiceDetailExitMonthJdbcRepository.getPayServiceDetailExitMonth(document, code, user);
			if(GenericUtil.isCollectionEmpty(getPayServiceDetailExitMonth)) {
				return null;
			}
			else {
				return getPayServiceDetailExitMonth;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListManagerReportModel> getListManagerReport(Integer manager) {
		List<getListManagerReportModel> getListManagerReport = new ArrayList<getListManagerReportModel>();
		
		try {
			
			getListManagerReport = getListManagerReportJdbcRepository.getListManagerReport(manager);
			if(GenericUtil.isCollectionEmpty(getListManagerReport)) {
				return null;
			}
			else {
				return getListManagerReport;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
