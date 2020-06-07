package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListDistictModel;
import com.dev.op.core.dto.vipchannel.getListSellerModel;
import com.dev.op.core.dto.vipchannel.getListServiceBySaleModel;
import com.dev.op.core.dto.vipchannel.getListStreetModel;
import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;
import com.dev.op.core.facade.vipchannel.VentaFacade;
import com.dev.op.core.service.vipchannel.VentaService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("ventaFacade")
public class VentaFacadeImpl implements VentaFacade{

	@Autowired
	@Qualifier("ventaService")
	private VentaService ventaService;

	@Override
	public List<ResponseModel> postSaveServiceSale(String document, String code, String name, String last,
			String second, String client, String fech, Integer zone, String number, String descriptionrefe,
			Integer seller, String fechadate, String timedate, Integer servicecount, String amountfirst,
			String amountsecond, String textins) {
		List<ResponseModel> postSaveServiceSale = new ArrayList<ResponseModel>();
		
		try {
			
			postSaveServiceSale = ventaService.postSaveServiceSale(document, code, name, last, second, client, fech, zone, number, descriptionrefe, seller, fechadate, timedate, servicecount, amountfirst, amountsecond, textins);
			if(GenericUtil.isEmpty(postSaveServiceSale)) {
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
			
			getListDistict = ventaService.getListDistict();
			if(GenericUtil.isEmpty(getListDistict)) {
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
			
			getListSeller = ventaService.getListSeller();
			if(GenericUtil.isEmpty(getListSeller)) {
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
			
			getListStreet = ventaService.getListStreet(distric);
			if(GenericUtil.isEmpty(getListStreet)) {
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
			
			getServicePreInstall = ventaService.getServicePreInstall(codeid, datei, datef);
			if(GenericUtil.isEmpty(getServicePreInstall)) {
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
			
			getListServiceBySale = ventaService.getListServiceBySale();
			if(GenericUtil.isEmpty(getListServiceBySale)) {
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
	public List<ResponseModel> putChangeDirectionById(String document, String code, String number, Integer zone,
			String reference) {
		List<ResponseModel> putChangeDirectionById = new ArrayList<ResponseModel>();
		
		try {
			
			putChangeDirectionById = ventaService.putChangeDirectionById(document, code, number, zone, reference);
			if(GenericUtil.isEmpty(putChangeDirectionById)) {
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
	
}
