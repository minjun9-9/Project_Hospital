package com.project.hospital.health.dto;

public class SearchDTO {
	
	private String keyword;
	private String bodyPart;
	private String diseasePartId;

	//diseaseBpardManage.jsp 구현 중 추가
	private String searchTopic;
	private String selectedPartId;
	
	private String startDate;
	private String endDate;
	
	public SearchDTO() {
	}
	


	public SearchDTO(String keyword, String bodyPart, String diseasePartId, String searchTopic, String selectedPartId,
			String startDate, String endDate) {
		super();
		this.keyword = keyword;
		this.bodyPart = bodyPart;
		this.diseasePartId = diseasePartId;
		this.searchTopic = searchTopic;
		this.selectedPartId = selectedPartId;
		this.startDate = startDate;
		this.endDate = endDate;
	}



	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	

	public String getBodyPart() {
		return bodyPart;
	}


	public void setBodyPart(String bodyPart) {
		this.bodyPart = bodyPart;
	}

	

	public String getDiseasePartId() {
		return diseasePartId;
	}


	public void setDiseasePartId(String diseasePartId) {
		this.diseasePartId = diseasePartId;
	}
	
	


	public String getSearchTopic() {
		return searchTopic;
	}




	public void setSearchTopic(String searchTopic) {
		this.searchTopic = searchTopic;
	}
	


	public String getSelectedPartId() {
		return selectedPartId;
	}



	public void setSelectedPartId(String selectedPartId) {
		this.selectedPartId = selectedPartId;
	}

	


	public String getStartDate() {
		return startDate;
	}



	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}



	public String getEndDate() {
		return endDate;
	}



	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}



	@Override
	public String toString() {
		return "SearchDTO [keyword=" + keyword + ", bodyPart=" + bodyPart + ", diseasePartId=" + diseasePartId
				+ ", searchTopic=" + searchTopic + ", selectedPartId=" + selectedPartId + ", startDate=" + startDate
				+ ", endDate=" + endDate + "]";
	}






	
	

}
