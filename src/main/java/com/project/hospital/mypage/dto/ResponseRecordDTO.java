package com.project.hospital.mypage.dto;

public class ResponseRecordDTO {
	
	private String recordType;
	private String deptName;
	private String drName;
	private String createdAt;
	private String treatmentPeriod;
	private String cost;
	
	public ResponseRecordDTO() {
		super();
	}

	public ResponseRecordDTO(String recordType, String deptName, String drName, String createdAt,
			String treatmentPeriod, String cost) {
		super();
		this.recordType = recordType;
		this.deptName = deptName;
		this.drName = drName;
		this.createdAt = createdAt;
		this.treatmentPeriod = treatmentPeriod;
		this.cost = cost;
	}

	public String getRecordType() {
		return recordType;
	}

	public void setRecordType(String recordType) {
		this.recordType = recordType;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDrName() {
		return drName;
	}

	public void setDrName(String drName) {
		this.drName = drName;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getTreatmentPeriod() {
		return treatmentPeriod;
	}

	public void setTreatmentPeriod(String treatmentPeriod) {
		this.treatmentPeriod = treatmentPeriod;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	@Override
	public String toString() {
		return "ResponseRecordDTO [recordType=" + recordType + ", deptName=" + deptName + ", drName=" + drName
				+ ", createdAt=" + createdAt + ", treatmentPeriod=" + treatmentPeriod + ", cost=" + cost + "]";
	}
	
	
}
