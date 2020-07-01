package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListActivationModel implements Serializable {

	/**
	 * call getListActivation();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer id;
	
	private String client;
	
	private String direction;
	
	private String tec;
	
	private String serie;

	public getListActivationModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getTec() {
		return tec;
	}

	public void setTec(String tec) {
		this.tec = tec;
	}

	public String getSerie() {
		return serie;
	}

	public void setSerie(String serie) {
		this.serie = serie;
	}
	
}
