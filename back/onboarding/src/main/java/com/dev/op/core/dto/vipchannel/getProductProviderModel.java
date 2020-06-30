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
	
	private Integer proU;
	
	private Integer proV;
	
	
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


	public Integer getProU() {
		return proU;
	}


	public void setProU(Integer proU) {
		this.proU = proU;
	}


	public Integer getProV() {
		return proV;
	}


	public void setProV(Integer proV) {
		this.proV = proV;
	}
	
}
