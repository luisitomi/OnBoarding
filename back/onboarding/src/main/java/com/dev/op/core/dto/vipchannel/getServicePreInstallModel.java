package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getServicePreInstallModel implements Serializable {

	/**
	 * call getServicePreInstall(:codeid,:datei,:datef);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer detail;
	
	private Integer next;
	
	private String document;
	
	private String code;
	
	private String client;
	
	private String agreed;
	
	private String description;
	
	private String service;
	
	private String install;
	
	private String status;
	
	private String seller;
	
	private Integer active;

	public getServicePreInstallModel() {
		
	}

	public Integer getDetail() {
		return detail;
	}

	public void setDetail(Integer detail) {
		this.detail = detail;
	}

	public Integer getNext() {
		return next;
	}

	public void setNext(Integer next) {
		this.next = next;
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

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}
	
}
