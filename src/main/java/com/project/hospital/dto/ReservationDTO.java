package com.project.hospital.dto;

import java.sql.Timestamp;

public class ReservationDTO {
	private String reservId;
	private String otId;
	private String userNum;
	private String reservContent;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String drId;
    private String createdDate; // 날짜
    private String createdDay; // 요일
    private String time;      // 시간
    private String deptName;  // 진료과
    private String drName;    // 의사명
    private String deptId;
    private String yearDate;
	
	public String getReservId() {
		return reservId;
	}
	public void setReservId(String reservId) {
		this.reservId = reservId;
	}
	public String getOtId() {
		return otId;
	}
	public void setOtId(String otId) {
		this.otId = otId;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getReservContent() {
		return reservContent;
	}
	public void setReservContent(String reservContent) {
		this.reservContent = reservContent;
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
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
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
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getYearDate() {
		return yearDate;
	}
	public void setYearDate(String yearDate) {
		this.yearDate = yearDate;
	}
	
	@Override
	public String toString() {
		return "ReservationDTO [reservId=" + reservId + ", otId=" + otId + ", userNum=" + userNum + ", reservContent="
				+ reservContent + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", drId=" + drId
				+ ", createdDate=" + createdDate + ", createdDay=" + createdDay + ", time=" + time + ", deptName="
				+ deptName + ", drName=" + drName + ", deptId=" + deptId + ", yearDate=" + yearDate + "]";
	}
	
}
