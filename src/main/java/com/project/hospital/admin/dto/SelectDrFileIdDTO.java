package com.project.hospital.admin.dto;

public class SelectDrFileIdDTO {
	private String fileone;
	private String filetwo;
	private String filethree;
	private String drId;
	
	public String getFileone() {
		return fileone;
	}
	public void setFileone(String fileone) {
		this.fileone = fileone;
	}
	public String getFiletwo() {
		return filetwo;
	}
	public void setFiletwo(String filetwo) {
		this.filetwo = filetwo;
	}
	public String getFilethree() {
		return filethree;
	}
	public void setFilethree(String filethree) {
		this.filethree = filethree;
	}
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	
	@Override
	public String toString() {
		return "SelectDrFileIdDTO [fileone=" + fileone + ", filetwo=" + filetwo + ", filethree=" + filethree + ", drId="
				+ drId + "]";
	}
	
	
	
	
	
	
	
}
