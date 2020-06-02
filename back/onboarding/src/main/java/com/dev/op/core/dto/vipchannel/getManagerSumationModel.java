package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getManagerSumationModel implements Serializable {

	/**
	 * call getManagaerCount(:con);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String manager;
	
	private String amount;
	
	public getManagerSumationModel() {
		
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
		
}
