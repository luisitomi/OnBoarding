package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getPayServiceDetailExitModel implements Serializable {

	/**
	 * call getPayServiceDetailExit(:document,:code,:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String service;
	
	private String amount;
	
	private String status;
	
	public getPayServiceDetailExitModel() {
		
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
