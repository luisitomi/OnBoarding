package com.dev.op.core.service.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.dto.vipchannel.getNameUserModel;
import com.dev.op.core.dto.vipchannel.getNotificationModel;
import com.dev.op.core.dto.vipchannel.getUserDataModel;

public interface UsuarioService {
	List<getListModuleModel> getListModule(String user);
	List<getListSubModuleModel> getListSubModule(String user);
	List<getUserDataModel> getUserData(String user,String pass);
	List<ResponseModel> patchUpdatePassword(String user,String pass);
	List<getNameUserModel> getNameUser(String user);
	List<getNotificationModel> getNotification(String user);
}
