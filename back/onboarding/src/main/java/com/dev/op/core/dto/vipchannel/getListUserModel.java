package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListUserModel implements Serializable {

	/**
	 * call getListUser(:codeUser);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String code;
	
	private String user;
	
	public getListUserModel() {
		
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
}
