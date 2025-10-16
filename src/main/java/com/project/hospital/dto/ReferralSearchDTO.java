package com.project.hospital.dto;

public class ReferralSearchDTO {
	
	private String searchCondition;
	private String searchKeyword;
	
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	@Override
	public String toString() {
		return "ReferralSearchDTO [searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + "]";
	}
	
	

}
