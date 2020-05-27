package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
import java.math.BigDecimal;

public class getListPayModel implements Serializable {

	/**
	 * call getListPay(:user,:explicite);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String id;
	
	private String code;
	
	private String client;
	
	private BigDecimal amountOne;
	
	private BigDecimal amountTwo;
	
	private BigDecimal amountThree;
	
	private BigDecimal sumation;
	
	public getListPayModel() {
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public BigDecimal getAmountOne() {
		return amountOne;
	}

	public void setAmountOne(BigDecimal amountOne) {
		this.amountOne = amountOne;
	}

	public BigDecimal getAmountTwo() {
		return amountTwo;
	}

	public void setAmountTwo(BigDecimal amountTwo) {
		this.amountTwo = amountTwo;
	}

	public BigDecimal getAmountThree() {
		return amountThree;
	}

	public void setAmountThree(BigDecimal amountThree) {
		this.amountThree = amountThree;
	}

	public BigDecimal getSumation() {
		return sumation;
	}

	public void setSumation(BigDecimal sumation) {
		this.sumation = sumation;
	}
	
}
