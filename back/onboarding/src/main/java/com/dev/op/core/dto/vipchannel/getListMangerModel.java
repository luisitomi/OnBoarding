package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListMangerModel implements Serializable {

	/**
	 * call getListManger();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;
	
	private String manager;

	public getListMangerModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}
	
}
