package com.project.hospital.admin.dto;

public class DeptDrInfoDTO {
	private String drId;
	private String drName; 
	private String drPosition; 
	private String filePath;
	
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
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
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Override
	public String toString() {
		return "DeptDrInfoDTO [drId=" + drId + ", drName=" + drName + ", drPosition=" + drPosition + ", filePath="
				+ filePath + "]";
	}
	
	
	
	
	
}
