package com.project.hospital.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DiseaseBoardVO {
	private String diseaseBoardId;
	private String diseasePartId;
	private String bodyPartId;
	private String diseaseName;
	private String title;
	private String content;
	private String fileOne;
	private int boardCount;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date createdAt;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date updatedAt;
	public DiseaseBoardVO() {
	}
	public DiseaseBoardVO(String diseaseBoardId, String diseasePartId, String bodyPartId, String diseaseName,
			String title, String content, String fileOne, int boardCount, Date createdAt, Date updatedAt) {
		super();
		this.diseaseBoardId = diseaseBoardId;
		this.diseasePartId = diseasePartId;
		this.bodyPartId = bodyPartId;
		this.diseaseName = diseaseName;
		this.title = title;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public String getDiseaseBoardId() {
		return diseaseBoardId;
	}
	public void setDiseaseBoardId(String diseaseBoardId) {
		this.diseaseBoardId = diseaseBoardId;
	}
	public String getDiseasePartId() {
		return diseasePartId;
	}
	public void setDiseasePartId(String diseasePartId) {
		this.diseasePartId = diseasePartId;
	}
	public String getBodyPartId() {
		return bodyPartId;
	}
	public void setBodyPartId(String bodyPartId) {
		this.bodyPartId = bodyPartId;
	}
	public String getDiseaseName() {
		return diseaseName;
	}
	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
		return "DiseaseBoardVO [diseaseBoardId=" + diseaseBoardId + ", diseasePartId=" + diseasePartId + ", bodyPartId="
				+ bodyPartId + ", diseaseName=" + diseaseName + ", title=" + title + ", content=" + content
				+ ", fileOne=" + fileOne + ", boardCount=" + boardCount + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + "]";
	}
	
	
	
}
