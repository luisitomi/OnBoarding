package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListDistictModel implements Serializable {

	/**
	 * call getListDistict();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String name;
	
	public getListDistictModel() {
		
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
