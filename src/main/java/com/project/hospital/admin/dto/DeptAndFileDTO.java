package com.project.hospital.admin.dto;

public class DeptAndFileDTO {
	private String deptId;
	private String deptName;
	private String drId;
	private String filestoreId;
	private String originalName;
	private String filePath;
	
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
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	public String getFilestoreId() {
		return filestoreId;
	}
	public void setFilestoreId(String filestoreId) {
		this.filestoreId = filestoreId;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Override
	public String toString() {
		return "DeptAndFileDTO [deptId=" + deptId + ", deptName=" + deptName + ", drId=" + drId + ", filestoreId="
				+ filestoreId + ", originalName=" + originalName + ", filePath=" + filePath + "]";
	}
	
	
	
	
}
