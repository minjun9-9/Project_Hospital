package com.project.hospital.dto;

public class HpMemberDeptDTO {
	private String drId;
	private String otId;
	private String deptId;
	private String drName;
	private String drPosition;
	private String deptName;
	
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	public String getOtId() {
		return otId;
	}
	public void setOtId(String otId) {
		this.otId = otId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDrName() {
		return drName;
	}
	public void setDrName(String drName) {
		this.drName = drName;
	}
	public String getDrPosition() {
		return drPosition;
	}
	public void setDrPosition(String drPosition) {
		this.drPosition = drPosition;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	@Override
	public String toString() {
		return "HpMemberDeptDTO [drId=" + drId + ", otId=" + otId + ", deptId=" + deptId + ", drName=" + drName
				+ ", drPosition=" + drPosition + ", deptName=" + deptName + "]";
	}
	
}
