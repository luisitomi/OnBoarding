package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getProductProviderModel implements Serializable {

	/**
	 * call getProductProvider();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String id;
	
	private String name;
	
	private String price;
	
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	public getProductProviderModel() {
		
	}
	
}
