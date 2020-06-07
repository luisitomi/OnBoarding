package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;
public class getListModuleModel implements Serializable {

	/**
	 * call getListModule(:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String description;
	
	private String ruta;
	
	private String icon;
	
	public getListModuleModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRuta() {
		return ruta;
	}

	public void setRuta(String ruta) {
		this.ruta = ruta;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
}
