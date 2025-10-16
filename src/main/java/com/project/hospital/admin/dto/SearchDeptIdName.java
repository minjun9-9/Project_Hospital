package com.project.hospital.admin.dto;

public class SearchDeptIdName {
	private String deptId;
	private String deptName;
	
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
	
	@Override
	public String toString() {
		return "SearchDeptIdName [deptId=" + deptId + ", deptName=" + deptName + "]";
	}
	
	
	
}
