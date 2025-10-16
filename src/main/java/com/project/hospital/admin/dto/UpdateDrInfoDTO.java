package com.project.hospital.admin.dto;

import java.util.List;

public class UpdateDrInfoDTO {
	private String drId;
	private String drName;
	private String drEducation;
	private String drPhoneNum;
	private String deptId;
	private String drPosition;
	private String drAddress;
	private List<String> drFieldList;
	private List<String> drCareerList;
	private List<String> drAcademicList;
	private List<String> drAwardsList;
	private String drField;
	private String drCareer;
	private String drAcademic;
	private String drAwards;
	private String fileone;
	private String filetwo;
	private String filethree;
	private List<String> filestoreIdList;
	private boolean deptHeadCheck;
	
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
	public String getDrEducation() {
		return drEducation;
	}
	public void setDrEducation(String drEducation) {
		this.drEducation = drEducation;
	}
	public String getDrPhoneNum() {
		return drPhoneNum;
	}
	public void setDrPhoneNum(String drPhoneNum) {
		this.drPhoneNum = drPhoneNum;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDrPosition() {
		return drPosition;
	}
	public void setDrPosition(String drPosition) {
		this.drPosition = drPosition;
	}
	public String getDrAddress() {
		return drAddress;
	}
	public void setDrAddress(String drAddress) {
		this.drAddress = drAddress;
	}
	public List<String> getDrFieldList() {
		return drFieldList;
	}
	public void setDrFieldList(List<String> drFieldList) {
		this.drFieldList = drFieldList;
	}
	public List<String> getDrCareerList() {
		return drCareerList;
	}
	public void setDrCareerList(List<String> drCareerList) {
		this.drCareerList = drCareerList;
	}
	public List<String> getDrAcademicList() {
		return drAcademicList;
	}
	public void setDrAcademicList(List<String> drAcademicList) {
		this.drAcademicList = drAcademicList;
	}
	public List<String> getDrAwardsList() {
		return drAwardsList;
	}
	public void setDrAwardsList(List<String> drAwardsList) {
		this.drAwardsList = drAwardsList;
	}
	public String getDrField() {
		return drField;
	}
	public void setDrField(String drField) {
		this.drField = drField;
	}
	public String getDrCareer() {
		return drCareer;
	}
	public void setDrCareer(String drCareer) {
		this.drCareer = drCareer;
	}
	public String getDrAcademic() {
		return drAcademic;
	}
	public void setDrAcademic(String drAcademic) {
		this.drAcademic = drAcademic;
	}
	public String getDrAwards() {
		return drAwards;
	}
	public void setDrAwards(String drAwards) {
		this.drAwards = drAwards;
	}
	public String getFileone() {
		return fileone;
	}
	public void setFileone(String fileone) {
		this.fileone = fileone;
	}
	public String getFiletwo() {
		return filetwo;
	}
	public void setFiletwo(String filetwo) {
		this.filetwo = filetwo;
	}
	public String getFilethree() {
		return filethree;
	}
	public void setFilethree(String filethree) {
		this.filethree = filethree;
	}
	public List<String> getFilestoreIdList() {
		return filestoreIdList;
	}
	public void setFilestoreIdList(List<String> filestoreIdList) {
		this.filestoreIdList = filestoreIdList;
	}
	public boolean isDeptHeadCheck() {
		return deptHeadCheck;
	}
	public void setDeptHeadCheck(boolean deptHeadCheck) {
		this.deptHeadCheck = deptHeadCheck;
	}
	
	@Override
	public String toString() {
		return "UpdateDrInfoDTO [drId=" + drId + ", drName=" + drName + ", drEducation=" + drEducation + ", drPhoneNum="
				+ drPhoneNum + ", deptId=" + deptId + ", drPosition=" + drPosition + ", drAddress=" + drAddress
				+ ", drFieldList=" + drFieldList + ", drCareerList=" + drCareerList + ", drAcademicList="
				+ drAcademicList + ", drAwardsList=" + drAwardsList + ", drField=" + drField + ", drCareer=" + drCareer
				+ ", drAcademic=" + drAcademic + ", drAwards=" + drAwards + ", fileone=" + fileone + ", filetwo="
				+ filetwo + ", filethree=" + filethree + ", filestoreIdList=" + filestoreIdList + ", deptHeadCheck="
				+ deptHeadCheck + "]";
	}
	
	
	
	
	
	
	
}
