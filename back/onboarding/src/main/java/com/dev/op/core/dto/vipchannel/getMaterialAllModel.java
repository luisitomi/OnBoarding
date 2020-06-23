package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getMaterialAllModel implements Serializable {

	/**
	 * getMaterialAll
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String name;
	
	private Integer active;
	
	public getMaterialAllModel() {
		
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

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}
	
}
