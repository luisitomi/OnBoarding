package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListServiceBySaleModel implements Serializable {

	/**
	 * call getListServiceBySale();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String document;
	
	private String code;
	
	private String client;
	
	private String agreed;
	
	private String description;
	
	private String service;
	
	private String install;
	
	private String status;
	
	private String seller;

	public getListServiceBySaleModel() {
		
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getAgreed() {
		return agreed;
	}

	public void setAgreed(String agreed) {
		this.agreed = agreed;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getInstall() {
		return install;
	}

	public void setInstall(String install) {
		this.install = install;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}
	
}
