package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
import java.math.BigDecimal;

public class getManagaerCountModel implements Serializable {

	/**
	 * call getManagaerCount(:con);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String manager;
	
	private BigDecimal amount;
	
	public getManagaerCountModel() {
		
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
		
}
