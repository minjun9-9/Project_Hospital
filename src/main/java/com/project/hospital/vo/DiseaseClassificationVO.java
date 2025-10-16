package com.project.hospital.vo;

import java.sql.Date;

public class DiseaseClassificationVO {
	private String diseasePartId;
	private String diseasePartName;
	private Date createdAt;
	private Date updatedAt;
	public DiseaseClassificationVO() {
		super();
	}
	public DiseaseClassificationVO(String diseasePartId, String diseasePartName, Date createdAt, Date updatedAt) {
		super();
		this.diseasePartId = diseasePartId;
		this.diseasePartName = diseasePartName;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public String getDiseasePartId() {
		return diseasePartId;
	}
	public void setDiseasePartId(String diseasePartId) {
		this.diseasePartId = diseasePartId;
	}
	public String getDiseasePartName() {
		return diseasePartName;
	}
	public void setDiseasePartName(String diseasePartName) {
		this.diseasePartName = diseasePartName;
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
		return "DiseaseClassificationVO [diseasePartId=" + diseasePartId + ", diseasePartName=" + diseasePartName
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
	
	
}
