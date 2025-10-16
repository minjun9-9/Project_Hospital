package com.project.hospital.reserve.dto;

public class ReservRequestDTO {
	
	private String userNum;
	private String date;
	
	public ReservRequestDTO() {
		super();
	}
	
	
	public ReservRequestDTO(String userNum, String date) {
		super();
		this.userNum = userNum;
		this.date = date;
	}

	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}


	@Override
	public String toString() {
		return "ReservRequestDTO [userNum=" + userNum + ", date=" + date + "]";
	}
	
	

}
