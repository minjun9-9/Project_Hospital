package com.project.hospital.vo;

import java.sql.Timestamp;

public class OpeningTimeVO {
	
	private String otId;
	private String drId;
	private String timetableId;
	private String otState;
	private String yearDate;

	// 병합 시 추가
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	
	public OpeningTimeVO() {
		super();
	}

	public OpeningTimeVO(String otId, String drId, String timetableId, String otState, String yearDate) {
		super();
		this.otId = otId;
		this.drId = drId;
		this.timetableId = timetableId;
		this.otState = otState;
		this.yearDate = yearDate;
	}
	
	public String getOtId() {
		return otId;
	}
	public String getDrId() {
		return drId;
	}
	public String getTimetableId() {
		return timetableId;
	}
	public String getOtState() {
		return otState;
	}
	public String getYearDate() {
		return yearDate;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
}
