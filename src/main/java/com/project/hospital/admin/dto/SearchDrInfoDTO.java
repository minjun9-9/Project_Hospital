package com.project.hospital.admin.dto;

public class SearchDrInfoDTO {
	private String keyword;
	private String value;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return "SearchDrInfoDTO [keyword=" + keyword + ", value=" + value + "]";
	}
	
	
}
