package com.project.hospital.reserve.dto;

public class TimeDateDTO {
	
	private String time;
	private String yearDate;
	
	public TimeDateDTO() {
		super();
	}
	
	public TimeDateDTO(String time, String yearDate) {
		super();
		this.time = time;
		this.yearDate = yearDate;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getYearDate() {
		return yearDate;
	}

	public void setYearDate(String yearDate) {
		this.yearDate = yearDate;
	}

	@Override
	public String toString() {
		return "TimeDateDTO [time=" + time + ", yearDate=" + yearDate + "]";
	}
}
