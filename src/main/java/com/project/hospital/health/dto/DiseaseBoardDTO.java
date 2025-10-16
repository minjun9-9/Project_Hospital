package com.project.hospital.health.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DiseaseBoardDTO {
	private String diseaseBoardId;
	private String diseasePartId;
	private String bodyPartId;
	private String diseaseName;
	private String title;
	private String content;
	private String fileOne;
	private int boardCount;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date createdAt;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	private String filestoreId;
	private String originalName;
	private String filePath;
	
	//diseaseBoardManage.jsp에 필요한 필드 추가
	//파일 경로, 신체 분류명, 질환 분류명도 가져와야할 것 같아서 join한 쿼리로  getDiseaseBoardList 대체
	private String diseasePartName;
	private String bodyPartName;
	//filePath는 이미 있네
	
	private String totalCount;
	private String koreanTitle;
	private String englishTitle;
	
	public DiseaseBoardDTO() {
		super();
	}
	
	


	public DiseaseBoardDTO(String diseaseBoardId, String diseasePartId, String bodyPartId, String diseaseName,
			String title, String content, String fileOne, int boardCount, Date createdAt, Date updatedAt,
			String filestoreId, String originalName, String filePath, String diseasePartName, String bodyPartName,
			String totalCount, String koreanTitle, String englishTitle) {
		super();
		this.diseaseBoardId = diseaseBoardId;
		this.diseasePartId = diseasePartId;
		this.bodyPartId = bodyPartId;
		this.diseaseName = diseaseName;
		this.title = title;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
		this.diseasePartName = diseasePartName;
		this.bodyPartName = bodyPartName;
		this.totalCount = totalCount;
		this.koreanTitle = koreanTitle;
		this.englishTitle = englishTitle;
	}



	public DiseaseBoardDTO(String diseaseBoardId, String diseasePartId, String bodyPartId, String diseaseName,
			String title, String content, String fileOne, int boardCount, Date createdAt, Date updatedAt,
			String filestoreId, String originalName, String filePath) {
		super();
		this.diseaseBoardId = diseaseBoardId;
		this.diseasePartId = diseasePartId;
		this.bodyPartId = bodyPartId;
		this.diseaseName = diseaseName;
		this.title = title;
		this.content = content;
		this.fileOne = fileOne;
		this.boardCount = boardCount;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.filestoreId = filestoreId;
		this.originalName = originalName;
		this.filePath = filePath;
	}


	public String getDiseaseBoardId() {
		return diseaseBoardId;
	}
	public void setDiseaseBoardId(String diseaseBoardId) {
		this.diseaseBoardId = diseaseBoardId;
	}
	public String getDiseasePartId() {
		return diseasePartId;
	}
	public void setDiseasePartId(String diseasePartId) {
		this.diseasePartId = diseasePartId;
	}
	public String getBodyPartId() {
		return bodyPartId;
	}
	public void setBodyPartId(String bodyPartId) {
		this.bodyPartId = bodyPartId;
	}
	public String getDiseaseName() {
		return diseaseName;
	}
	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getFileOne() {
		return fileOne;
	}
	public void setFileOne(String fileOne) {
		this.fileOne = fileOne;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	public String getFilestoreId() {
		return filestoreId;
	}


	public void setFilestoreId(String filestoreId) {
		this.filestoreId = filestoreId;
	}


	public String getOriginalName() {
		return originalName;
	}


	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}


	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	

	
	public String getDiseasePartName() {
		return diseasePartName;
	}


	public void setDiseasePartName(String diseasePartName) {
		this.diseasePartName = diseasePartName;
	}


	public String getBodyPartName() {
		return bodyPartName;
	}


	public void setBodyPartName(String bodyPartName) {
		this.bodyPartName = bodyPartName;
	}
	
	
	
	public String getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	

	public String getKoreanTitle() {
		return koreanTitle;
	}



	public void setKoreanTitle(String koreanTitle) {
		this.koreanTitle = koreanTitle;
	}



	public String getEnglishTitle() {
		return englishTitle;
	}



	public void setEnglishTitle(String englishTitle) {
		this.englishTitle = englishTitle;
	}



	@Override
	public String toString() {
		return "DiseaseBoardDTO [diseaseBoardId=" + diseaseBoardId + ", diseasePartId=" + diseasePartId
				+ ", bodyPartId=" + bodyPartId + ", diseaseName=" + diseaseName + ", title=" + title + ", content="
				+ content + ", fileOne=" + fileOne + ", boardCount=" + boardCount + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", filestoreId=" + filestoreId + ", originalName=" + originalName
				+ ", filePath=" + filePath + ", diseasePartName=" + diseasePartName + ", bodyPartName=" + bodyPartName
				+ ", totalCount=" + totalCount + ", koreanTitle=" + koreanTitle + ", englishTitle=" + englishTitle
				+ "]";
	}






	


}
