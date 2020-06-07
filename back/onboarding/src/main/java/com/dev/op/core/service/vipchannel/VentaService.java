package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListDistictModel;
import com.dev.op.core.dto.vipchannel.getListSellerModel;
import com.dev.op.core.dto.vipchannel.getListServiceBySaleModel;
import com.dev.op.core.dto.vipchannel.getListStreetModel;
import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;

public interface VentaService {
	List<ResponseModel> postSaveServiceSale(String document,
											String code,
											String name,
											String last,
											String second,
											String client,
											String fech,
											Integer zone,
											String number,
											String descriptionrefe,
											Integer seller,
											String fechadate,
											String timedate,
											Integer servicecount,
											String amountfirst,
											String amountsecond,
											String textins);
	List<getListDistictModel> getListDistict();
	List<getListSellerModel> getListSeller();
	List<getListStreetModel> getListStreet(Integer distric);
	List<getServicePreInstallModel> getServicePreInstall(Integer codeid,String datei,String datef);
	List<getListServiceBySaleModel> getListServiceBySale();
	List<ResponseModel> putChangeDirectionById(String document,String code,String number,Integer zone,String reference);
}
