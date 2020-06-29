package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getProdctModel implements Serializable {

	/**
	 * call getProdct();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;
	
	private String name;
	
	private String code;
	
	private String description;
	
	private String codeProduct;
	
	private String meditation;
	
	
	public getProdctModel() {
		
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


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getCodeProduct() {
		return codeProduct;
	}


	public void setCodeProduct(String codeProduct) {
		this.codeProduct = codeProduct;
	}


	public String getMeditation() {
		return meditation;
	}


	public void setMeditation(String meditation) {
		this.meditation = meditation;
	}
	
}
