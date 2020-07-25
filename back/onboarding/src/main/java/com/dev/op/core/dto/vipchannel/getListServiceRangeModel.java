package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListServiceRangeModel implements Serializable {

	/**
	 * call getListServiceRange(:datei,:datef);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String service;
	
	private String document;
	
	private String code;
	
	private String client;
	
	private String direction;
	
	private String tecn;
	
	private String fech;
	
	public getListServiceRangeModel() {
		
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
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

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getTecn() {
		return tecn;
	}

	public void setTecn(String tecn) {
		this.tecn = tecn;
	}

	public String getFech() {
		return fech;
	}

	public void setFech(String fech) {
		this.fech = fech;
	}
	
}