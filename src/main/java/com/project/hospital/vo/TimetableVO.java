package com.project.hospital.vo;

import java.sql.Timestamp;

public class TimetableVO {
	
	private String timetableId;
	private String time;
	private String timeType;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	public TimetableVO() {
		super();
	}
	
	public TimetableVO(String timetableId, String time, String timeType) {
		super();
		this.timetableId = timetableId;
		this.time = time;
		this.timeType = timeType;
	}
	
	public String getTimetableId() {
		return timetableId;
	}
	public String getTime() {
		return time;
	}
	public String getTimeType() {
		return timeType;
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

	@Override
	public String toString() {
		return "TimetableVO [timetableId=" + timetableId + ", time=" + time + ", timeType=" + timeType + "]";
	}
	
	
	
	
}
