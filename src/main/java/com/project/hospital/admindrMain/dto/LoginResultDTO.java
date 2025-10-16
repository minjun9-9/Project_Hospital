package com.project.hospital.admindrMain.dto;

public class LoginResultDTO {
	
	// 의료진
	private String drId;
	private String drName;
	//추가
	private String hashPw;
	
	// 관리자
	private String adminId;
	private String adminName;
	private String hpId;
	
	// 의료진, 관리자 타입 확인
	private String type;
	
	public LoginResultDTO() {
		super();
	}

	public LoginResultDTO(String drId, String drName, String adminId, String adminName, String hpId, String type) {
		super();
		this.drId = drId;
		this.drName = drName;
		this.adminId = adminId;
		this.adminName = adminName;
		this.hpId = hpId;
		this.type = type;
	}
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

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

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getHpId() {
		return hpId;
	}

	public void setHpId(String hpId) {
		this.hpId = hpId;
	}
	
	//추가
	public String getHashPw() {
		return hashPw;
	}

	public void setHashPw(String hashPw) {
		this.hashPw = hashPw;
	}

	@Override
	public String toString() {
		return "LoginResultDTO [drId=" + drId + ", drName=" + drName + ", hashPw=" + hashPw + ", adminId=" + adminId
				+ ", adminName=" + adminName + ", hpId=" + hpId + ", type=" + type + "]";
	}
	

	
}
