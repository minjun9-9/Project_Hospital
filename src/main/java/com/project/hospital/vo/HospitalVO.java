package com.project.hospital.vo;

import java.sql.Timestamp;

public class HospitalVO {
	private String hpId;
	private String hpName;
	private String hpAddress;
	private String hpNumber;
	private String hpRegion;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String quit;
	
	
	public String getHpId() {
		return hpId;
	}
	public void setHpId(String hpId) {
		this.hpId = hpId;
	}
	public String getHpName() {
		return hpName;
	}
	public void setHpName(String hpName) {
		this.hpName = hpName;
	}
	public String getHpAddress() {
		return hpAddress;
	}
	public void setHpAddress(String hpAddress) {
		this.hpAddress = hpAddress;
	}
	public String getHpNumber() {
		return hpNumber;
	}
	public void setHpNumber(String hpNumber) {
		this.hpNumber = hpNumber;
	}
	public String getHpRegion() {
		return hpRegion;
	}
	public void setHpRegion(String hpRegion) {
		this.hpRegion = hpRegion;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getQuit() {
		return quit;
	}
	public void setQuit(String quit) {
		this.quit = quit;
	}
	
	@Override
	public String toString() {
		return "HospitalVO [hpId=" + hpId + ", hpName=" + hpName + ", hpAddress=" + hpAddress + ", hpNumber=" + hpNumber
				+ ", hpRegion=" + hpRegion + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", quit=" + quit
				+ "]";
	}
	
}
