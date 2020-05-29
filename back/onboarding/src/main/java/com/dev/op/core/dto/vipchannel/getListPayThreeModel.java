package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListPayThreeModel implements Serializable {

	/**
	 * call getListPayThree();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String id;
	
	private String code;
	
	private String client;
	
	private String amountOne;
	
	private String amountTwo;
	
	private String amountThree;
	
	private String sumation;
	
	public getListPayThreeModel() {
		
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

	public String getAmountOne() {
		return amountOne;
	}

	public void setAmountOne(String amountOne) {
		this.amountOne = amountOne;
	}

	public String getAmountTwo() {
		return amountTwo;
	}

	public void setAmountTwo(String amountTwo) {
		this.amountTwo = amountTwo;
	}

	public String getAmountThree() {
		return amountThree;
	}

	public void setAmountThree(String amountThree) {
		this.amountThree = amountThree;
	}

	public String getSumation() {
		return sumation;
	}

	public void setSumation(String sumation) {
		this.sumation = sumation;
	}
	
}
