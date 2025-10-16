package com.project.hospital.mypage.dto;

public class RequestRecordDTO {
	
	private String startDate;
	private String endDate;
	private String userNum;
	private String cPage;
	
	public RequestRecordDTO() {
		super();
	}
	
	public RequestRecordDTO(String startDate, String endDate, String userNum, String cPage) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.userNum = userNum;
		this.cPage = cPage;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getcPage() {
		return cPage;
	}

	public void setcPage(String cPage) {
		this.cPage = cPage;
	}

	@Override
	public String toString() {
		return "RequestRecordDTO [startDate=" + startDate + ", endDate=" + endDate + ", userNum=" + userNum + ", cPage="
				+ cPage + "]";
	}
	
	
	
}
