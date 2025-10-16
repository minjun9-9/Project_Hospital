package com.project.hospital.admin.dto;

public class UpdateDrRankDTO {
	private String drId;
	private int rank;
	
	public UpdateDrRankDTO() {}
	
	public UpdateDrRankDTO(String drId, int rank) {
		super();
		this.drId = drId;
		this.rank = rank;
	}
	public String getDrId() {
		return drId;
	}
	public void setDrId(String drId) {
		this.drId = drId;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	
	@Override
	public String toString() {
		return "UpdateDrRankDTO [drId=" + drId + ", rank=" + rank + "]";
	}
	
	
	
}
