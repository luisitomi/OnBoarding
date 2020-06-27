package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListReclaimServiceModel implements Serializable {

	/**
	 * call getListReclaimService(:codeint);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer reclamoD;
	
	private String client;
	
	private String street;
	
	private String fecha;
	
	private String descripcion;
	
	private String tecn;

	public getListReclaimServiceModel() {
		
	}

	public Integer getReclamoD() {
		return reclamoD;
	}

	public void setReclamoD(Integer reclamoD) {
		this.reclamoD = reclamoD;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getTecn() {
		return tecn;
	}

	public void setTecn(String tecn) {
		this.tecn = tecn;
	}
	
}
