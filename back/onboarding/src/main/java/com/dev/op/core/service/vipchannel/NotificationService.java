package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListUserModel;
import com.dev.op.core.dto.vipchannel.getModuleModel;

public interface NotificationService {
	List<ResponseModel> postNotification(Integer module,Integer codeUser,String document,String client,String asunt);
	List<getModuleModel> getModule();
	List<getListUserModel> getListUser(Integer codeUser);
	List<ResponseModel> putChangeAsignation(Integer notiId,Integer aigId);
}
