package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getReclaimStatusModel implements Serializable {

	/**
	 * call getReclaimStatus(:datei,:datef);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String service;
	
	private String code;
	
	private String client;
	
	private String direction;
	
	private String descripcion;
	
	private String register;
	
	private Integer status;
	
	public getReclaimStatusModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getRegister() {
		return register;
	}

	public void setRegister(String register) {
		this.register = register;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
