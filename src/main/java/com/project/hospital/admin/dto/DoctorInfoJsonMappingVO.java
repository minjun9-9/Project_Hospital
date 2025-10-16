package com.project.hospital.admin.dto;

import java.util.List;

public class DoctorInfoJsonMappingVO {
	private String deptId;
	private String drPosition;
	private String drName;
	private String drPhoneNum;
	private String drAddress;
	private List<String> drField;
	private String drEducation;
	private List<String> drCareer;
	private List<String> drAcademic;
	private List<String> drAwards;
	private String drPersonNum;
	//파일 DB컬럼 논의 후 추가 필드 작성하기(getter setter포함), DoctorRegisterVO에도 필요한 필드 넣기
	
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
	public String getDrName() {
		return drName;
	}
	public void setDrName(String drName) {
		this.drName = drName;
	}
	public String getDrPhoneNum() {
		return drPhoneNum;
	}
	public void setDrPhoneNum(String drPhoneNum) {
		this.drPhoneNum = drPhoneNum;
	}
	public String getDrAddress() {
		return drAddress;
	}
	public void setDrAddress(String drAddress) {
		this.drAddress = drAddress;
	}
	public List<String> getDrField() {
		return drField;
	}
	public void setDrField(List<String> drField) {
		this.drField = drField;
	}
	public String getDrEducation() {
		return drEducation;
	}
	public void setDrEducation(String drEducation) {
		this.drEducation = drEducation;
	}
	public List<String> getDrCareer() {
		return drCareer;
	}
	public void setDrCareer(List<String> drCareer) {
		this.drCareer = drCareer;
	}
	public List<String> getDrAcademic() {
		return drAcademic;
	}
	public void setDrAcademic(List<String> drAcademic) {
		this.drAcademic = drAcademic;
	}
	public List<String> getDrAwards() {
		return drAwards;
	}
	public void setDrAwards(List<String> drAwards) {
		this.drAwards = drAwards;
	}
	public String getDrPersonNum() {
		return drPersonNum;
	}
	public void setDrPersonNum(String drPersonNum) {
		this.drPersonNum = drPersonNum;
	}
	
	@Override
	public String toString() {
		return "DoctorInfoJsonMappingVO [deptId=" + deptId + ", drPosition=" + drPosition + ", drName=" + drName
				+ ", drPhoneNum=" + drPhoneNum + ", drAddress=" + drAddress + ", drField=" + drField + ", drEducation="
				+ drEducation + ", drCareer=" + drCareer + ", drAcademic=" + drAcademic + ", drAwards=" + drAwards
				+ ", drPersonNum=" + drPersonNum + "]";
	}
	
	
	
	
	
	
}
