package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getNotificationModel implements Serializable {

	/**
	 * call getNotification(:user);
	 */
	private static final long serialVersionUID = 7440851506308938680L;
	
	private Integer id;
	
	private String user;
	
	private String pending;
	
	private String client;
	
	private String asign;
	
	public getNotificationModel() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPending() {
		return pending;
	}

	public void setPending(String pending) {
		this.pending = pending;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getAsign() {
		return asign;
	}

	public void setAsign(String asign) {
		this.asign = asign;
	}
	
}
