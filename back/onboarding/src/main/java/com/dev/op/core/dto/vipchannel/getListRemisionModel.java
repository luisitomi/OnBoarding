package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListRemisionModel implements Serializable {

	/**
	 * call getListRemision();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;
	
	private String name;
	
	private Integer item;
	
	private String autorizhe;
	
	private String impor;
	
	private String igv;
	
	private String sumation;
	
	private Integer validate;

	public getListRemisionModel() {
		
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

	public Integer getItem() {
		return item;
	}

	public void setItem(Integer item) {
		this.item = item;
	}

	public String getAutorizhe() {
		return autorizhe;
	}

	public void setAutorizhe(String autorizhe) {
		this.autorizhe = autorizhe;
	}

	public String getImpor() {
		return impor;
	}

	public void setImpor(String impor) {
		this.impor = impor;
	}

	public String getIgv() {
		return igv;
	}

	public void setIgv(String igv) {
		this.igv = igv;
	}

	public String getSumation() {
		return sumation;
	}

	public void setSumation(String sumation) {
		this.sumation = sumation;
	}

	public Integer getValidate() {
		return validate;
	}

	public void setValidate(Integer validate) {
		this.validate = validate;
	}
	
}
