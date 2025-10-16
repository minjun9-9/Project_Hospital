package com.project.hospital.health.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ExaminationBoardDTO {
	
	private String examinationId;
	private String bodyPartId;
	private String examinationName;
	private String content;
	private String fileOne;
	private int boardCount;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date createdAt;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date updatedAt;
	private String filestoreId;
	private String originalName;
	private String filePath;
	private String bodyPartName;
	private String totalCount;
	private boolean fileDelete;
	
	
	
	public ExaminationBoardDTO() {
	}



	public ExaminationBoardDTO(String examinationId, String bodyPartId, String examinationName, String content,
			String fileOne, int boardCount, Date createdAt, Date updatedAt, String filestoreId, String originalName,
			String filePath, String bodyPartName, String totalCount, boolean fileDelete) {
		super();
		this.examinationId = examinationId;
		this.bodyPartId = bodyPartId;
		this.examinationName = examinationName;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
		this.bodyPartName = bodyPartName;
		this.totalCount = totalCount;
		this.fileDelete = fileDelete;
	}



	public String getExaminationId() {
		return examinationId;
	}


	public void setExaminationId(String examinationId) {
		this.examinationId = examinationId;
	}


	public String getBodyPartId() {
		return bodyPartId;
	}


	public void setBodyPartId(String bodyPartId) {
		this.bodyPartId = bodyPartId;
	}


	public String getExaminationName() {
		return examinationName;
	}


	public void setExaminationName(String examinationName) {
		this.examinationName = examinationName;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getFileOne() {
		return fileOne;
	}


	public void setFileOne(String fileOne) {
		this.fileOne = fileOne;
	}


	public int getBoardCount() {
		return boardCount;
	}


	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}


	public Date getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}


	public Date getUpdatedAt() {
		return updatedAt;
	}


	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
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


	public String getBodyPartName() {
		return bodyPartName;
	}


	public void setBodyPartName(String bodyPartName) {
		this.bodyPartName = bodyPartName;
	}
	
	


	public String getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}


	public boolean isFileDelete() {
		return fileDelete;
	}



	public void setFileDelete(boolean fileDelete) {
		this.fileDelete = fileDelete;
	}



	@Override
	public String toString() {
		return "ExaminationBoardDTO [examinationId=" + examinationId + ", bodyPartId=" + bodyPartId
				+ ", examinationName=" + examinationName + ", content=" + content + ", fileOne=" + fileOne
				+ ", boardCount=" + boardCount + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", filestoreId=" + filestoreId + ", originalName=" + originalName + ", filePath=" + filePath
				+ ", bodyPartName=" + bodyPartName + ", totalCount=" + totalCount + ", fileDelete=" + fileDelete + "]";
	}



	
	
	

}
