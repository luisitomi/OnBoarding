package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getVoucherByIdModel implements Serializable {

	/**
	 * call getVoucherById(:document,:code);
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer voucherId;
	
	private String voucher;
	
	private String name;
	
	private Integer service;

	public getVoucherByIdModel() {
		
	}

	public Integer getVoucherId() {
		return voucherId;
	}

	public void setVoucherId(Integer voucherId) {
		this.voucherId = voucherId;
	}

	public String getVoucher() {
		return voucher;
	}

	public void setVoucher(String voucher) {
		this.voucher = voucher;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getService() {
		return service;
	}

	public void setService(Integer service) {
		this.service = service;
	}
	
}
