package com.project.hospital.health.dto;

public class DiseaseBoardTotalCountDTO {
	private int totalCount;

	public DiseaseBoardTotalCountDTO(int totalCount) {
		super();
		this.totalCount = totalCount;
	}

	public DiseaseBoardTotalCountDTO() {
		super();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	@Override
	public String toString() {
		return "DiseaseBoardTotalCountDTO [totalCount=" + totalCount + "]";
	}
	
	
}
