package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getManagerByIdModel implements Serializable {

	/**
	 * call getManagerById(:document,:code);
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String manager;
	
	private String document;

	public getManagerByIdModel() {
		
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}
	
}
