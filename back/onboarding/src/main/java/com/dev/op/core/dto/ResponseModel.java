package com.dev.op.core.dto;

import java.io.Serializable;

public class ResponseModel implements Serializable {

	/**
	 * id = 0 = "ERROR"; id = 1 = "SUCCESS";
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;

	public ResponseModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
}
