package com.project.hospital.admin.dto;

public class DeptForJsonDTO {
	private String deptId;
	private String deptHeadId;
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptHeadId() {
		return deptHeadId;
	}
	public void setDeptHeadId(String deptHeadId) {
		this.deptHeadId = deptHeadId;
	}
	
	@Override
	public String toString() {
		return "DeptForJsonDTO [deptId=" + deptId + ", deptHeadId=" + deptHeadId + "]";
	}
	
	
}
