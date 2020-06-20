package com.dev.op.core.facade.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListUserModel;
import com.dev.op.core.dto.vipchannel.getModuleModel;
import com.dev.op.core.facade.vipchannel.NotificationFacade;
import com.dev.op.core.service.vipchannel.NotificationService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Component("notificationFacade")
public class NotificationFacadeImpl implements NotificationFacade{


	@Autowired
	@Qualifier("notificationService")
	private NotificationService notificationService;
	
	@Override
	public List<ResponseModel> postNotification(Integer module,Integer codeUser, String document, String client, String asunt) {
		List<ResponseModel> postNotification = new ArrayList<ResponseModel>();
		
		try {
			
			postNotification = notificationService.postNotification(module,codeUser, document, client, asunt);
			if(GenericUtil.isEmpty(postNotification)) {
				return null;
			}
			else {
				return postNotification;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getModuleModel> getModule() {
		List<getModuleModel> getModule = new ArrayList<getModuleModel>();
		
		try {
			
			getModule = notificationService.getModule();
			if(GenericUtil.isEmpty(getModule)) {
				return null;
			}
			else {
				return getModule;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<getListUserModel> getListUser(Integer codeUser) {
		List<getListUserModel> getListUser = new ArrayList<getListUserModel>();
		
		try {
			
			getListUser = notificationService.getListUser(codeUser);
			if(GenericUtil.isEmpty(getListUser)) {
				return null;
			}
			else {
				return getListUser;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<ResponseModel> putChangeAsignation(Integer notiId, Integer aigId) {
		List<ResponseModel> putChangeAsignation = new ArrayList<ResponseModel>();
		
		try {
			
			putChangeAsignation = notificationService.putChangeAsignation(notiId, aigId);
			if(GenericUtil.isEmpty(putChangeAsignation)) {
				return null;
			}
			else {
				return putChangeAsignation;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
