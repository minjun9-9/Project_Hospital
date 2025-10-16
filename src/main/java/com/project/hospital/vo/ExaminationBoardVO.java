package com.project.hospital.vo;

import java.sql.Date;

public class ExaminationBoardVO {
	private String examinationId;
	private String bodyPartId;
	private String examinationName;
	private String content;
	private String fileOne;
	private int boardCount;
	private Date createdAt;
	private Date updatedAt;
	public ExaminationBoardVO() {
	}
	public ExaminationBoardVO(String examinationId, String bodyPartId, String examinationName, String content,
			String fileOne, int boardCount, Date createdAt, Date updatedAt) {
		this.examinationId = examinationId;
		this.bodyPartId = bodyPartId;
		this.examinationName = examinationName;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
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
	@Override
	public String toString() {
		return "ExaminationBoardVO [examinationId=" + examinationId + ", bodyPartId=" + bodyPartId
				+ ", examinationName=" + examinationName + ", content=" + content + ", fileOne=" + fileOne
				+ ", boardCount=" + boardCount + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
	
	

}
