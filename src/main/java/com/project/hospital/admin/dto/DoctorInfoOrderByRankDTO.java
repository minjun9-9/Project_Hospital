package com.project.hospital.admin.dto;

public class DoctorInfoOrderByRankDTO {
	private String drId; 
	private String drName;
	private String deptName; 
	private String drPosition;
	private int rank;
	
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	public String getDrName() {
		return drName;
	}
	public void setDrName(String drName) {
		this.drName = drName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getDrPosition() {
		return drPosition;
	}
	public void setDrPosition(String drPosition) {
		this.drPosition = drPosition;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	
	@Override
	public String toString() {
		return "DoctorInfoOrderByRankDTO [drId=" + drId + ", drName=" + drName + ", deptName=" + deptName
				+ ", drPosition=" + drPosition + ", rank=" + rank + "]";
	}
	
	
	
	
	
}
