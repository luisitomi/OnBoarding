package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getUserDataModel implements Serializable {

	/**
	 * call getUserData(:user,:password);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private Integer code;
	
	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public getUserDataModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
}
