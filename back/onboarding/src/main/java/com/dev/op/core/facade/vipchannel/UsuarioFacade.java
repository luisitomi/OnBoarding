package com.dev.op.core.facade.vipchannel;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.dto.vipchannel.getNameUserModel;
import com.dev.op.core.dto.vipchannel.getUserDataModel;

public interface UsuarioFacade {
	List<getListModuleModel> getListModule(String user);
	List<getListSubModuleModel> getListSubModule(String user);
	List<getUserDataModel> getUserData(String user,String pass);
	List<ResponseModel> patchUpdatePassword(String user,String pass);
	List<getNameUserModel> getNameUser(String user);
}
