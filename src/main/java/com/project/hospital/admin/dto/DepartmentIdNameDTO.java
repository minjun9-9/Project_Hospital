package com.project.hospital.admin.dto;

public class DepartmentIdNameDTO {
	
	private String deptId;
	private String deptName;
	
	public DepartmentIdNameDTO() {
		super();
	}
	public DepartmentIdNameDTO(String deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}
	
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
		return "DepartmentNameVO [deptId=" + deptId + ", deptName=" + deptName + "]";
	}
	
	
	
}
