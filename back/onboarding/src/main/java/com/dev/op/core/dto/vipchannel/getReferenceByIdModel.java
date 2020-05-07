package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getReferenceByIdModel implements Serializable {

	/**
	 * call getReferenceById(:document,:code);
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private String reference;

	public getReferenceByIdModel() {
		
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}
	
}
