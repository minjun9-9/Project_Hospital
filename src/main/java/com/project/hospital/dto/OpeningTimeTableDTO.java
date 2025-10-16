package com.project.hospital.dto;

public class OpeningTimeTableDTO {
	private String otId;
	private String drId;
	private String timetableId;
	private String otState;
	private String yearDate;
	private String time;
	private String timeType;
	
	public String getOtId() {
		return otId;
	}
	public void setOtId(String otId) {
		this.otId = otId;
	}
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	public String getTimetableId() {
		return timetableId;
	}
	public void setTimetableId(String timetableId) {
		this.timetableId = timetableId;
	}
	public String getOtState() {
		return otState;
	}
	public void setOtState(String otState) {
		this.otState = otState;
	}
	public String getYearDate() {
		return yearDate;
	}
	public void setYearDate(String yearDate) {
		this.yearDate = yearDate;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getTimeType() {
		return timeType;
	}
	public void setTimeType(String timeType) {
		this.timeType = timeType;
	}
	
	@Override
	public String toString() {
		return "OpeningTimeTableDTO [otId=" + otId + ", drId=" + drId + ", timetableId=" + timetableId + ", otState="
				+ otState + ", yearDate=" + yearDate + ", time=" + time + ", timeType=" + timeType + "]";
	}
	
}
