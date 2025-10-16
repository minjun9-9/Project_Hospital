package com.project.hospital.vo;

import java.sql.Date;

public class UserVO {
	private String userNum;
	private String userId;
	private String userPw;
	private String userName;
	private String userPhoneNum;
	private String userBirth;
	private String userGender;
	private String userAddress;
	private String userEmail;
	private String fileone;
	private String filetwo;
	private String filethree;
	private String sendState;
	private Date createdAt;
	private Date updatedAt;
	private String guardianlName;
	private String guardianlPhoneNum;
	private String guardianlEmail;
	
	
	 
	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhoneNum() {
		return userPhoneNum;
	}

	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
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




	public String getSendState() {
		return sendState;
	}




	public void setSendState(String sendState) {
		this.sendState = sendState;
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




	public String getGuardianlName() {
		return guardianlName;
	}




	public void setGuardianlName(String guardianlName) {
		this.guardianlName = guardianlName;
	}




	public String getGuardianlPhoneNum() {
		return guardianlPhoneNum;
	}




	public void setGuardianlPhoneNum(String guardianlPhoneNum) {
		this.guardianlPhoneNum = guardianlPhoneNum;
	}




	public String getGuardianlEmail() {
		return guardianlEmail;
	}




	public void setGuardianlEmail(String guardianlEmail) {
		this.guardianlEmail = guardianlEmail;
	}




	@Override
	public String toString() {
		return "UserVO [userNum=" + userNum + ", userId=" + userId + ", userPw=" + userPw + ", userName=" + userName
				+ ", userPhoneNum=" + userPhoneNum + ", userBirth=" + userBirth + ", userGender=" + userGender
				+ ", userAddress=" + userAddress + ", userEmail=" + userEmail + ", fileone=" + fileone + ", filetwo="
				+ filetwo + ", filethree=" + filethree + ", sendState=" + sendState + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", guardianlName=" + guardianlName + ", guardianlPhoneNum="
				+ guardianlPhoneNum + ", guardianlEmail=" + guardianlEmail + "]";
	}
	
	
}
