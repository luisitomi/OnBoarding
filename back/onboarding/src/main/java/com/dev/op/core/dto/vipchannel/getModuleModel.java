package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getModuleModel implements Serializable {

	/**
	 * call getModule();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String description;
	
	public getModuleModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
