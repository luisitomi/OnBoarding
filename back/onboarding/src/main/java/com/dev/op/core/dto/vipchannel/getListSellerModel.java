package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListSellerModel implements Serializable {

	/**
	 * call getListSeller();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String name;
	
	public getListSellerModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
