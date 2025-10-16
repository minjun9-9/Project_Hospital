package com.project.hospital.doctorInfo;

public class DoctorInfoCntDTO {
	private int count;

	
	private String deptId;
	private String deptName;
	private String drPosition;
	private String drName;
	private String searchQuery;
	private String drField;
	private String drEducation;
	private String drCareer;
	private String fileOne; //사진이 될듯
	private String filePath; //진짜 사진이 될듯

	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	public int getCount() {
		return count;
	}
	
	
	public void setCount(int count) {
		this.count = count;
	}
	public String getDrField() {
		return drField;
	}


	public void setDrField(String drField) {
		this.drField = drField;
	}


	public String getDrEducation() {
		return drEducation;
	}


	public void setDrEducation(String drEducation) {
		this.drEducation = drEducation;
	}


	public String getDrCareer() {
		return drCareer;
	}


	public void setDrCareer(String drCareer) {
		this.drCareer = drCareer;
	}


	public String getFileOne() {
		return fileOne;
	}


	public void setFileOne(String fileOne) {
		this.fileOne = fileOne;
	}


	public String getSearchQuery() {
		return searchQuery;
	}


	public void setSearchQuery(String searchQuery) {
		this.searchQuery = searchQuery;
	}


	public DoctorInfoCntDTO() {
		System.out.println(">> DoctorInfoDTO() 객체 생성");
	}


	public String getDeptId() {
		return deptId;
	}


	public void setDeptId(String deptId) {
		this.deptId = deptId;
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


	public String getDrName() {
		return drName;
	}


	public void setDrName(String drName) {
		this.drName = drName;
	}


	@Override
	public String toString() {
		return "DoctorInfoDTO [count=" + count + ", deptId=" + deptId + ", deptName=" + deptName + ", drPosition="
				+ drPosition + ", drName=" + drName + ", searchQuery=" + searchQuery + ", drField=" + drField
				+ ", drEducation=" + drEducation + ", drCareer=" + drCareer + ", fileOne=" + fileOne + ", filePath="
				+ filePath + "]";
	}





	
	
	
}









