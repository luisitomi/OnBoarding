package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getNameUserModel implements Serializable {

	/**
	 * call getNameUser(:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String name;
	
	public getNameUserModel() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
