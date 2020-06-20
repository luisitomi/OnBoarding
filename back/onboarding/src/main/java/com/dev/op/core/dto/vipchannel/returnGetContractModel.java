package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class returnGetContractModel implements Serializable {

	/**
	 * call returnGetContract(:detailId,:nextId,?,?,?);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String name;
	
	private String email;
	
	private String customer;
	
	private String direction;
	
	private String document;
	
	public returnGetContractModel() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}
	
}
