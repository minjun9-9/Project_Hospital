package com.project.hospital.admin.dto;

import java.util.List;
import java.util.Map;

public class ChangeDateListDTO {
	
	List<Map<String, Object>> changeDateList;
	private String drId;
	
	
	public ChangeDateListDTO() {
		super();
	}


	public ChangeDateListDTO(List<Map<String, Object>> changeDateList, String drId) {
		super();
		this.changeDateList = changeDateList;
		this.drId = drId;
	}


	public List<Map<String, Object>> getChangeDateList() {
		return changeDateList;
	}


	public void setChangeDateList(List<Map<String, Object>> changeDateList) {
		this.changeDateList = changeDateList;
	}


	public String getDrId() {
		return drId;
	}


	public void setDrId(String drId) {
		this.drId = drId;
	}


	@Override
	public String toString() {
		return "ChangeDateListDTO [changeDateList=" + changeDateList + ", drId=" + drId + "]";
	}
	
	
	
	

}
