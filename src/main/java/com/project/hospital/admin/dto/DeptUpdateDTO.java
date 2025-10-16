package com.project.hospital.admin.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class DeptUpdateDTO {
	private String deptId;
	private String deptName;
	private boolean isExistFile;
	private boolean isDeleteFile;
	private String deptHeadId;
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
	public boolean isExistFile() {
		return isExistFile;
	}
	@JsonProperty("isExistFile")
	public void setExistFile(boolean existFile) {
		this.isExistFile = existFile;
	}
	public boolean isDeleteFile() {
		return isDeleteFile;
	}
	@JsonProperty("isDeleteFile")
	public void setDeleteFile(boolean isDeleteFile) {
		this.isDeleteFile = isDeleteFile;
	}
	public String getDeptHeadId() {
		return deptHeadId;
	}
	public void setDeptHeadId(String deptHeadId) {
		this.deptHeadId = deptHeadId;
	}
	public String getFileone() {
		return fileone;
	}
	public void setFileone(String fileone) {
		this.fileone = fileone;
	}
	
	@Override
	public String toString() {
		return "DeptUpdateDTO [deptId=" + deptId + ", deptName=" + deptName + ", isExistFile=" + isExistFile
				+ ", isDeleteFile=" + isDeleteFile + ", deptHeadId=" + deptHeadId + ", fileone=" + fileone + "]";
	}
	
	
	
	
	
}
