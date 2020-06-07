package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
import java.math.BigDecimal;

public class getPayServiceDetailExitMonthModel implements Serializable {

	/**
	 * call getPayServiceDetailExitMonth(:document,:code,:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String information;
	
	private String service;
	
	private BigDecimal amount;
	
	private Integer code;
	
	public getPayServiceDetailExitMonthModel() {
		
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

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}
	
}
