package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getDetailContractModel;
import com.dev.op.core.dto.vipchannel.getListDistictModel;
import com.dev.op.core.dto.vipchannel.getListSellerModel;
import com.dev.op.core.dto.vipchannel.getListServiceBySaleModel;
import com.dev.op.core.dto.vipchannel.getListServiceModel;
import com.dev.op.core.dto.vipchannel.getListStreetModel;
import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;
import com.dev.op.core.dto.vipchannel.returnGetContractModel;
import com.dev.op.core.repository.vipchannel.jdbc.deletePreInstallSaleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getDetailContractJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListDistictJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListSellerJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListServiceBySaleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListServiceJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getListStreetJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getServicePreInstallJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postSaveServiceSaleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putChangeDirectionByIdJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.returnGetContractJdbcRepository;
import com.dev.op.core.service.vipchannel.VentaService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("ventaService")
@Transactional("hibernateTransactionManager")
public class VentaServiceImpl implements VentaService{

	@Autowired
	@Qualifier("getDetailContractJdbcRepository")
	private getDetailContractJdbcRepository getDetailContractJdbcRepository;
	
	@Autowired
	@Qualifier("getListSellerJdbcRepository")
	private getListSellerJdbcRepository getListSellerJdbcRepository;
	
	@Autowired
	@Qualifier("getListStreetJdbcRepository")
	private getListStreetJdbcRepository getListStreetJdbcRepository;
	
	@Autowired
	@Qualifier("getListDistictJdbcRepository")
	private getListDistictJdbcRepository getListDistictJdbcRepository;
	
	@Autowired
	@Qualifier("getServicePreInstallJdbcRepository")
	private getServicePreInstallJdbcRepository getServicePreInstallJdbcRepository;
	
	@Autowired
	@Qualifier("getListServiceBySaleJdbcRepository")
	private getListServiceBySaleJdbcRepository getListServiceBySaleJdbcRepository;
	
	@Autowired
	@Qualifier("getListServiceJdbcRepository")
	private getListServiceJdbcRepository getListServiceJdbcRepository;
	
	@Autowired
	@Qualifier("postSaveServiceSaleJdbcRepository")
	private postSaveServiceSaleJdbcRepository postSaveServiceSaleJdbcRepository;
	
	@Autowired
	@Qualifier("putChangeDirectionByIdJdbcRepository")
	private putChangeDirectionByIdJdbcRepository putChangeDirectionByIdJdbcRepository;
	
	@Autowired
	@Qualifier("deletePreInstallSaleJdbcRepository")
	private deletePreInstallSaleJdbcRepository deletePreInstallSaleJdbcRepository;
	
	@Autowired
	@Qualifier("returnGetContractJdbcRepository")
	private returnGetContractJdbcRepository returnGetContractJdbcRepository;
	
	@Override
	public List<ResponseModel> postSaveServiceSale(String document, String code, String name, String last,
			String second, String client, String email,String fech, Integer zone, String number, String descriptionrefe,
			Integer seller, String fechadate, String timedate, Integer servicecount, String amountfirst,
			String amountsecond, String textins) {
		List<ResponseModel> postSaveServiceSale = new ArrayList<ResponseModel>();
		
		try {
			
			postSaveServiceSale = postSaveServiceSaleJdbcRepository.postSaveServiceSale(document, code, name, last, second, client, fech, email,zone, number, descriptionrefe, seller, fechadate, timedate, servicecount, amountfirst, amountsecond, textins);
			if(GenericUtil.isCollectionEmpty(postSaveServiceSale)) {
				return null;
			}
			else {
				return postSaveServiceSale;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListDistictModel> getListDistict() {
		List<getListDistictModel> getListDistict = new ArrayList<getListDistictModel>();
		
		try {
			
			getListDistict = getListDistictJdbcRepository.getListDistict();
			if(GenericUtil.isCollectionEmpty(getListDistict)) {
				return null;
			}
			else {
				return getListDistict;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListSellerModel> getListSeller() {
		List<getListSellerModel> getListSeller = new ArrayList<getListSellerModel>();
		
		try {
			
			getListSeller = getListSellerJdbcRepository.getListSeller();
			if(GenericUtil.isCollectionEmpty(getListSeller)) {
				return null;
			}
			else {
				return getListSeller;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListStreetModel> getListStreet(Integer distric) {
		List<getListStreetModel> getListStreet = new ArrayList<getListStreetModel>();
		
		try {
			
			getListStreet = getListStreetJdbcRepository.getListStreet(distric);
			if(GenericUtil.isCollectionEmpty(getListStreet)) {
				return null;
			}
			else {
				return getListStreet;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getServicePreInstallModel> getServicePreInstall(Integer codeid, String datei, String datef) {
		List<getServicePreInstallModel> getServicePreInstall = new ArrayList<getServicePreInstallModel>();
		
		try {
			
			getServicePreInstall = getServicePreInstallJdbcRepository.getServicePreInstall(codeid, datei, datef);
			if(GenericUtil.isCollectionEmpty(getServicePreInstall)) {
				return null;
			}
			else {
				return getServicePreInstall;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListServiceBySaleModel> getListServiceBySale() {
		List<getListServiceBySaleModel> getListServiceBySale = new ArrayList<getListServiceBySaleModel>();
		
		try {
			
			getListServiceBySale = getListServiceBySaleJdbcRepository.getListServiceBySale();
			if(GenericUtil.isCollectionEmpty(getListServiceBySale)) {
				return null;
			}
			else {
				return getListServiceBySale;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putChangeDirectionById(String document, String code, String number, Integer zone, String reference) {
		List<ResponseModel> putChangeDirectionById = new ArrayList<ResponseModel>();
		
		try {
			
			putChangeDirectionById = putChangeDirectionByIdJdbcRepository.putChangeDirectionById(document, code, number, zone, reference);
			if(GenericUtil.isCollectionEmpty(putChangeDirectionById)) {
				return null;
			}
			else {
				return putChangeDirectionById;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListServiceModel> getListService() {
		List<getListServiceModel> getListService = new ArrayList<getListServiceModel>();
		
		try {
			
			getListService = getListServiceJdbcRepository.getListService();
			if(GenericUtil.isCollectionEmpty(getListService)) {
				return null;
			}
			else {
				return getListService;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> deletePreInstallSale(Integer detail, Integer next, String description) {
		List<ResponseModel> deletePreInstallSale = new ArrayList<ResponseModel>();
		
		try {
			
			deletePreInstallSale = deletePreInstallSaleJdbcRepository.deletePreInstallSale(detail, next, description);
			if(GenericUtil.isCollectionEmpty(deletePreInstallSale)) {
				return null;
			}
			else {
				return deletePreInstallSale;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getDetailContractModel> getDetailContract(Integer detailId, Integer nextId) {
		List<getDetailContractModel> getDetailContract = new ArrayList<getDetailContractModel>();
		
		try {
			
			getDetailContract = getDetailContractJdbcRepository.getDetailContract(detailId, nextId);
			if(GenericUtil.isCollectionEmpty(getDetailContract)) {
				return null;
			}
			else {
				return getDetailContract;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public returnGetContractModel returnGetContract(Integer detailId, Integer nextId) {
		returnGetContractModel returnGetContract;
		
		try {
			
			returnGetContract = returnGetContractJdbcRepository.returnGetContract(detailId, nextId);
			
			if(GenericUtil.isNotNull(returnGetContract)) {
				return returnGetContract;
			}
			else {
				return null;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
