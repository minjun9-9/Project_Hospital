package com.project.hospital.admin.dto;

import java.util.ArrayList;
import java.util.List;

public class HpMemberScheduleDTO {
	
	private List<String> amOtIdList = new ArrayList<String>();
	private String amStatus;
	private List<String> pmOtIdList = new ArrayList<String>();
	private String pmStatus;
	private String date;
	private List<String> amReservOtIdList = new ArrayList<String>();
	private List<String> pmReservOtIdList = new ArrayList<String>();
	
	
	public HpMemberScheduleDTO() {
		super();
	}


	public HpMemberScheduleDTO(List<String> amOtIdList, String amStatus, List<String> pmOtIdList, String pmStatus,
			String date, List<String> amReservOtIdList, List<String> pmReservOtIdList) {
		super();
		this.amOtIdList = amOtIdList;
		this.amStatus = amStatus;
		this.pmOtIdList = pmOtIdList;
		this.pmStatus = pmStatus;
		this.date = date;
		this.amReservOtIdList = amReservOtIdList;
		this.pmReservOtIdList = pmReservOtIdList;
	}


	public List<String> getAmOtIdList() {
		return amOtIdList;
	}


	public void setAmOtIdList(List<String> amOtIdList) {
		this.amOtIdList = amOtIdList;
	}


	public String getAmStatus() {
		return amStatus;
	}


	public void setAmStatus(String amStatus) {
		this.amStatus = amStatus;
	}


	public List<String> getPmOtIdList() {
		return pmOtIdList;
	}


	public void setPmOtIdList(List<String> pmOtIdList) {
		this.pmOtIdList = pmOtIdList;
	}


	public String getPmStatus() {
		return pmStatus;
	}


	public void setPmStatus(String pmStatus) {
		this.pmStatus = pmStatus;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public List<String> getAmReservOtIdList() {
		return amReservOtIdList;
	}


	public void setAmReservOtIdList(List<String> amReservOtIdList) {
		this.amReservOtIdList = amReservOtIdList;
	}


	public List<String> getPmReservOtIdList() {
		return pmReservOtIdList;
	}


	public void setPmReservOtIdList(List<String> pmReservOtIdList) {
		this.pmReservOtIdList = pmReservOtIdList;
	}


	public void addAmList(String otId) {
		amOtIdList.add(otId);
	}


	public void addPmList(String otId) {
		pmOtIdList.add(otId);
		
	}
	

	public void addAmReservList(String otId) {
		amReservOtIdList.add(otId);
	}


	public void addPmReservList(String otId) {
		pmReservOtIdList.add(otId);
		
	}
	

}