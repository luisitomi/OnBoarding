package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListServicePendingModel implements Serializable {

	/**
	 * call getListServicePending();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer detalleId;
	
	private Integer nextId;
	
	private String name;
	
	private String client;
	
	private String sale;
	
	private String document;
	
	private String code;
	
	private String dateP;
	
	private String asunt;
	
	public getListServicePendingModel() {
		
	}

	public Integer getDetalleId() {
		return detalleId;
	}

	public void setDetalleId(Integer detalleId) {
		this.detalleId = detalleId;
	}

	public Integer getNextId() {
		return nextId;
	}

	public void setNextId(Integer nextId) {
		this.nextId = nextId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getSale() {
		return sale;
	}

	public void setSale(String sale) {
		this.sale = sale;
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

	public String getDateP() {
		return dateP;
	}

	public void setDateP(String dateP) {
		this.dateP = dateP;
	}

	public String getAsunt() {
		return asunt;
	}

	public void setAsunt(String asunt) {
		this.asunt = asunt;
	}
	
}
