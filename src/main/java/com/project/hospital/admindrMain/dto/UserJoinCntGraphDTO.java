package com.project.hospital.admindrMain.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserJoinCntGraphDTO {
	
	private int todayCnt;
	private int monthCnt;
	private int totalCnt;
	private List<MonthCntDTO> graphList = new ArrayList<MonthCntDTO>();
	
	public UserJoinCntGraphDTO() {
		super();
	}

	public UserJoinCntGraphDTO(int todayCnt, int monthCnt, int totalCnt, List<MonthCntDTO> graphList) {
		super();
		this.todayCnt = todayCnt;
		this.monthCnt = monthCnt;
		this.totalCnt = totalCnt;
		this.graphList = graphList;
	}

	public int getTodayCnt() {
		return todayCnt;
	}

	public void setTodayCnt(int todayCnt) {
		this.todayCnt = todayCnt;
	}

	public int getMonthCnt() {
		return monthCnt;
	}

	public void setMonthCnt(int monthCnt) {
		this.monthCnt = monthCnt;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public List<MonthCntDTO> getGraphList() {
		return graphList;
	}

	public void setGraphList(List<MonthCntDTO> graphList) {
		this.graphList = graphList;
	}

	@Override
	public String toString() {
		return "UserJoinCntGraphDTO [todayCnt=" + todayCnt + ", monthCnt=" + monthCnt + ", totalCnt=" + totalCnt
				+ ", graphList=" + graphList + "]";
	}
	
	

}
