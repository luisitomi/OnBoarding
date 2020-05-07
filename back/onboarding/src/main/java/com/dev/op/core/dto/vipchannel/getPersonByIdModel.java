package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getPersonByIdModel implements Serializable {

	/**
	 * call getPersonById(:document);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private String client;
	
	private String type;
	
	private String name;
	
	private String last;
	
	private String second;
	
	private String customer;

	public getPersonByIdModel() {
		
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLast() {
		return last;
	}

	public void setLast(String last) {
		this.last = last;
	}

	public String getSecond() {
		return second;
	}

	public void setSecond(String second) {
		this.second = second;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}
	
}
