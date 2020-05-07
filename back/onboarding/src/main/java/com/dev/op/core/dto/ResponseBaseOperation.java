package com.dev.op.core.dto;

import java.io.Serializable;

public class ResponseBaseOperation implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String status;
	
	private String message;
	
	private Object data;

	public ResponseBaseOperation() {
		
	}

	public ResponseBaseOperation(String status, String message, Object data) {
		
		this.status = status;
		this.message = message;
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
