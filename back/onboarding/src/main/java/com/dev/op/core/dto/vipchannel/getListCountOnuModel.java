package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListCountOnuModel implements Serializable {

	/**
	 * call getListCountOnu();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;

	public getListCountOnuModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
}
