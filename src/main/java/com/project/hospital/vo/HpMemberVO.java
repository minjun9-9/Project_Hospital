package com.project.hospital.vo;

import java.security.Timestamp;

public class HpMemberVO {
	
	private String drId;
	private String drPw;
	private String deptId;
	private String drPosition;
	private String drName;
	private String drPhoneNum;
	private String drAddress;
	private String drField;
	private String drEducation;
	private String drCareer;
	private String drAcademic;
	private String drAwards;
	private String drPersonNum;
	private String fileone;
	private String filetwo;
	private String filethree;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String quit;
	
	public HpMemberVO() {
		super();
	}

	
	
	public HpMemberVO(String drId, String drPw, String deptId, String drPosition, String drName, String drPhoneNum,
			String drAddress, String drField, String drEducation, String drCareer, String drAcademic, String drAwards,
			String drPersonNum, String fileone, String filetwo, String filethree) {
		super();
		this.drId = drId;
		this.drPw = drPw;
		this.deptId = deptId;
		this.drPosition = drPosition;
		this.drName = drName;
		this.drPhoneNum = drPhoneNum;
		this.drAddress = drAddress;
		this.drField = drField;
		this.drEducation = drEducation;
		this.drCareer = drCareer;
		this.drAcademic = drAcademic;
		this.drAwards = drAwards;
		this.drPersonNum = drPersonNum;
		this.fileone = fileone;
		this.filetwo = filetwo;
		this.filethree = filethree;
	}


	public String getQuit() {
		return quit;
	}



	public void setQuit(String quit) {
		this.quit = quit;
	}



	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getDrId() {
		return drId;
	}



	public void setDrId(String drId) {
		this.drId = drId;
	}



	public String getDrPw() {
		return drPw;
	}



	public void setDrPw(String drPw) {
		this.drPw = drPw;
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



	public String getDrPersonNum() {
		return drPersonNum;
	}



	public void setDrPersonNum(String drPersonNum) {
		this.drPersonNum = drPersonNum;
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


	
}
