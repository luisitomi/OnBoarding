package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getPersonByDocumentModel implements Serializable {

	/**
	 * call getPersonByDocument(:search);
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String document;
	
	private String client;
	
	private String code;
	
	private String direction;
	
	private String reference;

	public getPersonByDocumentModel() {
		
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}
	
}
