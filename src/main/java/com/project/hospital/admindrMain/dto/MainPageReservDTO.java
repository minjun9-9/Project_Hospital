package com.project.hospital.admindrMain.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MainPageReservDTO {
	
	private int todayReservCnt; // 오늘 예약 한 횟수
	private int monthReservCnt; // 이번달 예약 한 횟수
	private int d_DayReservCnt; // 오늘이 예약날인 횟수
	private int d_MonthReservCnt; // 이번달이 예약날인 횟수
	private int d_DayShowCnt; // 오늘 예약 방문
	private int d_MonthShowCnt; // 이번달 예약 방문
	private int d_DayNoShowCnt; // 오늘 예약인데 노쇼
	private int d_MonthNoShowCnt; // 이번달 예약인데 노쇼
	private int d_DayNoShowPercent; // 노쇼 비율 오늘
	private int d_MonthNoShowPercent; // 노쇼 비율 이번달
	
	
	List<Map<String, String>> reservPhoneAndTime = new ArrayList<Map<String,String>>();
			
	public MainPageReservDTO() {
		super();
	}
	
	public MainPageReservDTO(int todayReservCnt, int monthReservCnt, int d_DayReservCnt, int d_MonthReservCnt,
			int d_DayNoShowCnt, int d_MonthNoShowCnt, int d_DayNoShowPercent, int d_MonthNoShowPercent, int d_DayShowCnt,
			int d_MonthShowCnt,
			List<Map<String, String>> reservPhoneAndTime) {
		super();
		this.todayReservCnt = todayReservCnt;
		this.monthReservCnt = monthReservCnt;
		this.d_DayReservCnt = d_DayReservCnt;
		this.d_MonthReservCnt = d_MonthReservCnt;
		this.d_DayNoShowCnt = d_DayNoShowCnt;
		this.d_MonthNoShowCnt = d_MonthNoShowCnt;
		this.d_DayNoShowPercent = d_DayNoShowPercent;
		this.d_MonthNoShowPercent = d_MonthNoShowPercent;
		this.d_DayShowCnt = d_DayShowCnt;
		this.d_MonthShowCnt = d_MonthShowCnt;
		this.reservPhoneAndTime = reservPhoneAndTime;
	}



	public int getD_DayShowCnt() {
		return d_DayShowCnt;
	}

	public void setD_DayShowCnt(int d_DayShowCnt) {
		this.d_DayShowCnt = d_DayShowCnt;
	}

	public int getD_MonthShowCnt() {
		return d_MonthShowCnt;
	}

	public void setD_MonthShowCnt(int d_MonthShowCnt) {
		this.d_MonthShowCnt = d_MonthShowCnt;
	}

	public int getD_DayNoShowPercent() {
		return d_DayNoShowPercent;
	}



	public void setD_DayNoShowPercent(int d_DayNoShowPercent) {
		this.d_DayNoShowPercent = d_DayNoShowPercent;
	}



	public int getD_MonthNoShowPercent() {
		return d_MonthNoShowPercent;
	}



	public void setD_MonthNoShowPercent(int d_MonthNoShowPercent) {
		this.d_MonthNoShowPercent = d_MonthNoShowPercent;
	}



	public int getTodayReservCnt() {
		return todayReservCnt;
	}
	public void setTodayReservCnt(int todayReservCnt) {
		this.todayReservCnt = todayReservCnt;
	}
	public int getMonthReservCnt() {
		return monthReservCnt;
	}
	public void setMonthReservCnt(int monthReservCnt) {
		this.monthReservCnt = monthReservCnt;
	}
	public int getD_DayReservCnt() {
		return d_DayReservCnt;
	}
	public void setD_DayReservCnt(int d_DayReservCnt) {
		this.d_DayReservCnt = d_DayReservCnt;
	}
	public int getD_MonthReservCnt() {
		return d_MonthReservCnt;
	}
	public void setD_MonthReservCnt(int d_MonthReservCnt) {
		this.d_MonthReservCnt = d_MonthReservCnt;
	}
	public int getD_DayNoShowCnt() {
		return d_DayNoShowCnt;
	}
	public void setD_DayNoShowCnt(int d_DayNoShowCnt) {
		this.d_DayNoShowCnt = d_DayNoShowCnt;
	}
	public int getD_MonthNoShowCnt() {
		return d_MonthNoShowCnt;
	}
	public void setD_MonthNoShowCnt(int d_MonthNoShowCnt) {
		this.d_MonthNoShowCnt = d_MonthNoShowCnt;
	}
	public List<Map<String, String>> getReservPhoneAndTime() {
		return reservPhoneAndTime;
	}
	public void setReservPhoneAndTime(List<Map<String, String>> reservPhoneAndTime) {
		this.reservPhoneAndTime = reservPhoneAndTime;
	}

	@Override
	public String toString() {
		return "MainPageReservDTO [todayReservCnt=" + todayReservCnt + ", monthReservCnt=" + monthReservCnt
				+ ", d_DayReservCnt=" + d_DayReservCnt + ", d_MonthReservCnt=" + d_MonthReservCnt + ", d_DayShowCnt="
				+ d_DayShowCnt + ", d_MonthShowCnt=" + d_MonthShowCnt + ", d_DayNoShowCnt=" + d_DayNoShowCnt
				+ ", d_MonthNoShowCnt=" + d_MonthNoShowCnt + ", d_DayNoShowPercent=" + d_DayNoShowPercent
				+ ", d_MonthNoShowPercent=" + d_MonthNoShowPercent + ", reservPhoneAndTime=" + reservPhoneAndTime + "]";
	}

	
	
	
	
	
}

