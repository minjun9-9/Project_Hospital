package com.project.hospital.vo;

public class RecordVO {

	private String recordId;
	private String drId;
	private String userNum;
	private String recordType;

	// 병합 시 추가
	private String createdDate; // 추가된 필드
    private String createdDay;  // 추가된 필드
    private String treatmentPeriod;
    private String deptName; // 확인 후 삭제
    private String drName; // 확인 후 삭제
	private String cost;
	private String reservId; 

	public RecordVO() {
		super();
	}
	
	

	public RecordVO(String recordId, String drId, String userNum, String recordType, String createdDate,
			String createdDay, String treatmentPeriod, String deptName, String drName, String cost, String reservId) {
		super();
		this.recordId = recordId;
		this.drId = drId;
		this.userNum = userNum;
		this.recordType = recordType;
		this.createdDate = createdDate;
		this.createdDay = createdDay;
		this.treatmentPeriod = treatmentPeriod;
		this.deptName = deptName;
		this.drName = drName;
		this.cost = cost;
		this.reservId = reservId;
	}



	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getDrId() {
		return drId;
	}

	public void setDrId(String drId) {
		this.drId = drId;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getRecordType() {
		return recordType;
	}

	public void setRecordType(String recordType) {
		this.recordType = recordType;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getCreatedDay() {
		return createdDay;
	}

	public void setCreatedDay(String createdDay) {
		this.createdDay = createdDay;
	}

	public String getTreatmentPeriod() {
		return treatmentPeriod;
	}

	public void setTreatmentPeriod(String treatmentPeriod) {
		this.treatmentPeriod = treatmentPeriod;
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

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getReservId() {
		return reservId;
	}

	public void setReservId(String reservId) {
		this.reservId = reservId;
	}

	@Override
	public String toString() {
		return "RecordVO [recordId=" + recordId + ", drId=" + drId + ", userNum=" + userNum + ", recordType="
				+ recordType + ", createdDate=" + createdDate + ", createdDay=" + createdDay + ", treatmentPeriod="
				+ treatmentPeriod + ", deptName=" + deptName + ", drName=" + drName + ", cost=" + cost + ", reservId="
				+ reservId + "]";
	}
	
	
}
