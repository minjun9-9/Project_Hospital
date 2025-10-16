package com.project.hospital.health.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class HealthBoardDTO {

	private String hbId;
	private String title;
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
	private int totalCount;
	
	public HealthBoardDTO() {
	}

	

	public HealthBoardDTO(String hbId, String title, String content, String fileOne, int boardCount, Date createdAt,
			Date updatedAt, String filestoreId, String originalName, String filePath, int totalCount) {
		super();
		this.hbId = hbId;
		this.title = title;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
		this.totalCount = totalCount;
	}



	public String getHbId() {
		return hbId;
	}

	public void setHbId(String hbId) {
		this.hbId = hbId;
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

	

	public int getTotalCount() {
		return totalCount;
	}



	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}



	@Override
	public String toString() {
		return "HealthBoardDTO [hbId=" + hbId + ", title=" + title + ", content=" + content + ", fileOne=" + fileOne
				+ ", boardCount=" + boardCount + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", filestoreId=" + filestoreId + ", originalName=" + originalName + ", filePath=" + filePath
				+ ", totalCount=" + totalCount + "]";
	}



	
	
	
	
	
}
