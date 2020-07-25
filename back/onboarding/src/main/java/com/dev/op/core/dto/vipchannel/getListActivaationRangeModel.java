package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListActivaationRangeModel implements Serializable {

	/**
	 * call getListActivaationRange(:datei,:datef);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String document;
	
	private String code;
	
	private String client;
	
	private String direction;
	
	private String fech;
	
	public getListActivaationRangeModel() {
		
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

	public String getFech() {
		return fech;
	}

	public void setFech(String fech) {
		this.fech = fech;
	}
	
}
