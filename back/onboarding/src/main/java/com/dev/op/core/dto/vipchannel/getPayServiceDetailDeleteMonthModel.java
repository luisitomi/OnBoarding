package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
import java.math.BigDecimal;

public class getPayServiceDetailDeleteMonthModel implements Serializable {

	/**
	 * call getPayServiceDetailMonth(:document,:code,:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String information;
	
	private String service;
	
	private BigDecimal amount;
	
	public getPayServiceDetailDeleteMonthModel() {
		
	}

	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information;
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
