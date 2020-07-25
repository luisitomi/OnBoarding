package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
public class getListOnuStateModel implements Serializable {

	/**
	 * call getListOnuState();
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String serie;
	
	private String mac;
	
	private String ssid;
	
	private String pass;
	
	private Integer activo;
	
	public getListOnuStateModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSerie() {
		return serie;
	}

	public void setSerie(String serie) {
		this.serie = serie;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getSsid() {
		return ssid;
	}

	public void setSsid(String ssid) {
		this.ssid = ssid;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Integer getActivo() {
		return activo;
	}

	public void setActivo(Integer activo) {
		this.activo = activo;
	}
	
}
