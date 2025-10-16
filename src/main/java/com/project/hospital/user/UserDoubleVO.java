package com.project.hospital.user;

import java.sql.Timestamp;
import java.time.LocalDate;

public class UserDoubleVO {
	// 유저 기본 정보
    private int userNum; // 회원번호
	private String userId; // 회원아이디
	private String userPw; // 회원비번
	private String userName; // 회원이름
	private String userPhoneNum; // 회원폰번
	private String userPhoneNum1; // 회원폰번
	private String userPhoneNum2; // 회원폰번
	private String userPhoneNum3; // 회원폰번
	private String userBirth; // 회원 생년월일
	private String birthYear;
	private String birthMonth;
	private String birthDay;
	private String userGender; // 회원 성별
	private String userAddress; // 회원 주소
	private String userMainAddress;
	private String userDetailAddress;
	private String userEmail; // 회원 이메일
	private String email1;
	private String email2;
	private String email3;
	private String userImg;
	
	// 파일 관련 정보
	private String fileOne; // 회원 파일1 : 프로필 사진
	private String fileTwo; // 회원 파일2 : (미정)
	private String fileThree; // 회원 파일3 : (미정)
	
	// 상태 정보
	private String sendState; // 약관 동의
	private Timestamp createdAt; // 회원 생성일
	private Timestamp updatedAt; // 회원 수정일
	
	// 법정 대리인 정보
	private String guardianName; // 법정대리인 이름 
	private String guardianPhoneNum; // 법정대리인 폰번
	private String guardianPhoneNum1;
	private String guardianPhoneNum2;
	private String guardianPhoneNum3;
	private String guardianEmail; // 법정대리인 이메일
	private String guardianEmail1;
	private String guardianEmail2;
	private String guardianEmail3;
	
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
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
	public String getUserPhoneNum1() {
		return userPhoneNum1;
	}
	public void setUserPhoneNum1(String userPhoneNum1) {
		this.userPhoneNum1 = userPhoneNum1;
	}
	public String getUserPhoneNum2() {
		return userPhoneNum2;
	}
	public void setUserPhoneNum2(String userPhoneNum2) {
		this.userPhoneNum2 = userPhoneNum2;
	}
	public String getUserPhoneNum3() {
		return userPhoneNum3;
	}
	public void setUserPhoneNum3(String userPhoneNum3) {
		this.userPhoneNum3 = userPhoneNum3;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public String getBirthYear() {
		return birthYear;
	}
	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
	}
	public String getBirthMonth() {
		return birthMonth;
	}
	public void setBirthMonth(String birthMonth) {
		this.birthMonth = birthMonth;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
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
	public String getUserMainAddress() {
		return userMainAddress;
	}
	public void setUserMainAddress(String userMainAddress) {
		this.userMainAddress = userMainAddress;
	}
	public String getUserDetailAddress() {
		return userDetailAddress;
	}
	public void setUserDetailAddress(String userDetailAddress) {
		this.userDetailAddress = userDetailAddress;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getEmail3() {
		return email3;
	}
	public void setEmail3(String email3) {
		this.email3 = email3;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	
	public String getFileOne() {
		return fileOne;
	}
	public void setFileOne(String fileOne) {
		this.fileOne = fileOne;
	}
	public String getFileTwo() {
		return fileTwo;
	}
	public void setFileTwo(String fileTwo) {
		this.fileTwo = fileTwo;
	}
	public String getFileThree() {
		return fileThree;
	}
	public void setFileThree(String fileThree) {
		this.fileThree = fileThree;
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
	public String getGuardianPhoneNum1() {
		return guardianPhoneNum1;
	}
	public void setGuardianPhoneNum1(String guardianPhoneNum1) {
		this.guardianPhoneNum1 = guardianPhoneNum1;
	}
	public String getGuardianPhoneNum2() {
		return guardianPhoneNum2;
	}
	public void setGuardianPhoneNum2(String guardianPhoneNum2) {
		this.guardianPhoneNum2 = guardianPhoneNum2;
	}
	public String getGuardianPhoneNum3() {
		return guardianPhoneNum3;
	}
	public void setGuardianPhoneNum3(String guardianPhoneNum3) {
		this.guardianPhoneNum3 = guardianPhoneNum3;
	}
	public String getGuardianEmail() {
		return guardianEmail;
	}
	public void setGuardianEmail(String guardianEmail) {
		this.guardianEmail = guardianEmail;
	}
	public String getGuardianEmail1() {
		return guardianEmail1;
	}
	public void setGuardianEmail1(String guardianEmail1) {
		this.guardianEmail1 = guardianEmail1;
	}
	public String getGuardianEmail2() {
		return guardianEmail2;
	}
	public void setGuardianEmail2(String guardianEmail2) {
		this.guardianEmail2 = guardianEmail2;
	}
	public String getGuardianEmail3() {
		return guardianEmail3;
	}
	public void setGuardianEmail3(String guardianEmail3) {
		this.guardianEmail3 = guardianEmail3;
	}
	
	@Override
	public String toString() {
		return "UserVO [userNum=" + userNum + ", userId=" + userId + ", userPw=" + userPw + ", userName=" + userName
				+ ", userPhoneNum=" + userPhoneNum + ", userPhoneNum1=" + userPhoneNum1 + ", userPhoneNum2="
				+ userPhoneNum2 + ", userPhoneNum3=" + userPhoneNum3 + ", userBirth=" + userBirth + ", birthYear="
				+ birthYear + ", birthMonth=" + birthMonth + ", birthDay=" + birthDay + ", userGender=" + userGender
				+ ", userAddress=" + userAddress + ", userMainAddress=" + userMainAddress + ", userDetailAddress="
				+ userDetailAddress + ", userEmail=" + userEmail + ", email1=" + email1 + ", email2=" + email2
				+ ", email3=" + email3 + ", userImg=" + userImg + ", fileOne=" + fileOne + ", fileTwo=" + fileTwo
				+ ", fileThree=" + fileThree + ", sendState=" + sendState + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", guardianName=" + guardianName + ", guardianPhoneNum=" + guardianPhoneNum
				+ ", guardianPhoneNum1=" + guardianPhoneNum1 + ", guardianPhoneNum2=" + guardianPhoneNum2
				+ ", guardianPhoneNum3=" + guardianPhoneNum3 + ", guardianEmail=" + guardianEmail + ", guardianEmail1="
				+ guardianEmail1 + ", guardianEmail2=" + guardianEmail2 + ", guardianEmail3=" + guardianEmail3 + "]";
	}
	
}
