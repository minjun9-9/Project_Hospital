package com.project.hospital.reserve.dto;

import java.util.ArrayList;
import java.util.List;

public class ReserveResponDTO {
	
	private List<String> timeList = new ArrayList<String>();
	private String date;
	
	public ReserveResponDTO() {
		super();
	}

	public ReserveResponDTO(List<String> timeList, String date) {
		super();
		this.timeList = timeList;
		this.date = date;
	}

	public List<String> getTimeList() {
		return timeList;
	}

	public void setTimeList(List<String> timeList) {
		this.timeList = timeList;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public void addTime(String time) {
		timeList.add(time);
	}

	@Override
	public String toString() {
		return "ReserveResponDTO [timeList=" + timeList + ", date=" + date + "]";
	}
	
	
	
	
	
}
