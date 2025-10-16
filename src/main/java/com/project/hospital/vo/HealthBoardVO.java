package com.project.hospital.vo;

import java.sql.Date;

public class HealthBoardVO {
	private String hbId;
	private String title;
	private String fileOne;
	private int boardCount;
	private Date createdAt;
	private Date updatedAt;
	private String content;
	public HealthBoardVO() {
	}
	public HealthBoardVO(String hbId, String title, String fileOne, int boardCount, Date createdAt, Date updatedAt,
			String content) {
		super();
		this.hbId = hbId;
		this.title = title;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.content = content;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "HealthBoardVO [hbId=" + hbId + ", title=" + title + ", fileOne=" + fileOne + ", boardCount="
				+ boardCount + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", content=" + content + "]";
	}
	
	
	
	
	
}
