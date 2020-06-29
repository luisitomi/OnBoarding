package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListRemisionByIdModel implements Serializable {

	/**
	 * call getListRemisionById();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;
	
	private String product;
	
	private String code;
	
	private String description;
	
	private String codeProduct;
	
	private String meditation;
	
	private Integer count;
	
	private String price;
	
	private String desc;
	
	private String impor;

	public getListRemisionByIdModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getImpor() {
		return impor;
	}

	public void setImpor(String impor) {
		this.impor = impor;
	}
	
}
