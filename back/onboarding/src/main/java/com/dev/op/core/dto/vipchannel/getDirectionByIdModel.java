package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getDirectionByIdModel implements Serializable {

	/**
	 * call getDirectionById(:document,:code);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String direction;
	
	private String name;
	
	private String number;

	public getDirectionByIdModel() {
		
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
}
