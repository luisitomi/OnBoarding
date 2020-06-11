package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListManagerReportModel implements Serializable {

	/**
	 * call getListManagerReport(:manager);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String code;
	
	private String client;
	
	private String direction;
	
	private String service;
	
	private String min;
	
	private String max;
	
	private String amount;
	
	public getListManagerReportModel() {
		
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

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getMax() {
		return max;
	}

	public void setMax(String max) {
		this.max = max;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
}
