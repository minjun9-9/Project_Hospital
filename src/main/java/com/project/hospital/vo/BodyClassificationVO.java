package com.project.hospital.vo;

import java.sql.Date;

public class BodyClassificationVO {
	private String bodyPartId;
	private String bodyPartName;
	private Date createdAt;
	private Date updatedAt;
	public BodyClassificationVO() {
		super();
	}
	public BodyClassificationVO(String bodyPartId, String bodyPartName, Date createdAt, Date updatedAt) {
		super();
		this.bodyPartId = bodyPartId;
		this.bodyPartName = bodyPartName;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public String getBodyPartId() {
		return bodyPartId;
	}
	public void setBodyPartId(String bodyPartId) {
		this.bodyPartId = bodyPartId;
	}
	public String getBodyPartName() {
		return bodyPartName;
	}
	public void setBodyPartName(String bodyPartName) {
		this.bodyPartName = bodyPartName;
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
		return "BodyClassificationVO [bodyPartId=" + bodyPartId + ", bodyPartName=" + bodyPartName + ", createdAt="
				+ createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
};
