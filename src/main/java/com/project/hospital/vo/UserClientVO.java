package com.project.hospital.vo;

import java.sql.Timestamp;

public class UserClientVO {
	private String userNum;
	private String userId;
	private String userPw;
	private String userName;
	private String userPhoneNum;
	private String userBirth;
	private String userGender;
	private String userAddress;
	private String userEmail;
	private String sendState;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private String fileone;
	private String filetwo;
	private String filethree;
	private String guardianName;
	private String guardianPhoneNum;
	private String guardianEmail;
	private String quit;
	
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
	public String getSendState() {
		return sendState;
	}
	public void setSendState(String sendState) {
		this.sendState = sendState;
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
	public String getGuardianName() {
		return guardianName;
	}
	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}
	public String getGuardianPhoneNum() {
		return guardianPhoneNum;
	}
	public void setGuardianPhoneNum(String guardianPhoneNum) {
		this.guardianPhoneNum = guardianPhoneNum;
	}
	public String getGuardianEmail() {
		return guardianEmail;
	}
	public void setGuardianEmail(String guardianEmail) {
		this.guardianEmail = guardianEmail;
	}
	public String getQuit() {
		return quit;
	}
	public void setQuit(String quit) {
		this.quit = quit;
	}
	
	@Override
	public String toString() {
		return "UserClientVO [userNum=" + userNum + ", userId=" + userId + ", userPw=" + userPw + ", userName="
				+ userName + ", userPhoneNum=" + userPhoneNum + ", userBirth=" + userBirth + ", userGender="
				+ userGender + ", userAddress=" + userAddress + ", userEmail=" + userEmail + ", sendState=" + sendState
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", fileone=" + fileone + ", filetwo="
				+ filetwo + ", filethree=" + filethree + ", guardianName=" + guardianName + ", guardianPhoneNum="
				+ guardianPhoneNum + ", guardianEmail=" + guardianEmail + ", quit=" + quit + "]";
	}
	
}
