package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getDetailContractModel implements Serializable {

	/**
	 * call getDetailContract(:detailId,:nextId);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String name;
	
	private String email;
	
	public getDetailContractModel() {
		
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
	
}
