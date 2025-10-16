package com.project.hospital.admin.dto;

public class UpdateFileStoreDTO {
	private String existFilestoreId;
	private String filestoreId; 
	private String originalName; 
	private String filePath;
	
	public UpdateFileStoreDTO() {}
	
	public UpdateFileStoreDTO(String existFilestoreId, String filestoreId, String originalName, String filePath) {
		this.existFilestoreId = existFilestoreId;
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
	}

	public String getExistFilestoreId() {
		return existFilestoreId;
	}
	public void setExistFilestoreId(String existFilestoreId) {
		this.existFilestoreId = existFilestoreId;
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
		return "UpdateFileStoreDTO [existFilestoreId=" + existFilestoreId + ", filestoreId=" + filestoreId
				+ ", originalName=" + originalName + ", filePath=" + filePath + "]";
	}
	
	
}
