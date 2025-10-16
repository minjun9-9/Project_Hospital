package com.project.hospital.vo;


// fileStoreVO와 같음 => 이름변경 필요
public class FileStoreVO {
	
	private String filestoreId; 
	private String originalName; 
	private String filePath;
	
	public FileStoreVO() {}
	
	public FileStoreVO(String filestoreId, String originalName, String filePath) {
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
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
		return "FileStoreVO [filestoreId=" + filestoreId + ", originalName=" + originalName + ", filePath="
				+ filePath + "]";
	}
	
	
	
}
