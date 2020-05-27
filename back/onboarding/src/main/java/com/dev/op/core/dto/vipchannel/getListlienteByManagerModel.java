package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
import java.math.BigDecimal;

public class getListlienteByManagerModel implements Serializable {

	/**
	 * call getListlienteByManager(:manager);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String code;
	
	private String client;
	
	private String name;
	
	private String number;
	
	private String min;
	
	private String max;
	
	private String service;
	
	private BigDecimal amount;
	
	public getListlienteByManagerModel() {
		
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
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

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
		
}
