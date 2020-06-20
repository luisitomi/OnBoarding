package com.dev.op.core.service.vipchannel.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getListUserModel;
import com.dev.op.core.dto.vipchannel.getModuleModel;
import com.dev.op.core.repository.vipchannel.jdbc.getListUserJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.getModuleJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.postNotificationJdbcRepository;
import com.dev.op.core.repository.vipchannel.jdbc.putChangeAsignationJdbcRepository;
import com.dev.op.core.service.vipchannel.NotificationService;
import com.dev.op.core.util.vipchannel.GenericUtil;

@Service("notificationService")
@Transactional("hibernateTransactionManager")
public class NotificationSeviceImpl implements NotificationService{

	@Autowired
	@Qualifier("getModuleJdbcRepository")
	private getModuleJdbcRepository getModuleJdbcRepository;
	
	@Autowired
	@Qualifier("getListUserJdbcRepository")
	private getListUserJdbcRepository getListUserJdbcRepository;
	
	@Autowired
	@Qualifier("postNotificationJdbcRepository")
	private postNotificationJdbcRepository postNotificationJdbcRepository;
	
	@Autowired
	@Qualifier("putChangeAsignationJdbcRepository")
	private putChangeAsignationJdbcRepository putChangeAsignationJdbcRepository;
	
	@Override
	public List<ResponseModel> postNotification(Integer module,Integer codeUser, String document, String client, String asunt) {
		List<ResponseModel> postNotification = new ArrayList<ResponseModel>();
		
		try {
			
			postNotification = postNotificationJdbcRepository.postNotification(module,codeUser, document, client, asunt);
			if(GenericUtil.isCollectionEmpty(postNotification)) {
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
			
			getModule = getModuleJdbcRepository.getModule();
			if(GenericUtil.isCollectionEmpty(getModule)) {
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
			
			getListUser = getListUserJdbcRepository.getListUser(codeUser);
			if(GenericUtil.isCollectionEmpty(getListUser)) {
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
			
			putChangeAsignation = putChangeAsignationJdbcRepository.putChangeAsignation(notiId, aigId);
			if(GenericUtil.isCollectionEmpty(putChangeAsignation)) {
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
