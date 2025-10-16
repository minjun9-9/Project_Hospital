package com.project.hospital.admin.dto;

public class DeptRegisterDTO {
	private String deptId;
	private String deptName; 
	private String fileone;
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getFileone() {
		return fileone;
	}
	public void setFileone(String fileone) {
		this.fileone = fileone;
	}
	
	@Override
	public String toString() {
		return "DeptRegisterDTO [deptId=" + deptId + ", deptName=" + deptName + ", fileone=" + fileone + "]";
	}
	
	
}
