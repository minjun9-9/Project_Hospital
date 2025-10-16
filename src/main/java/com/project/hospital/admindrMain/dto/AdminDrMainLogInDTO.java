package com.project.hospital.admindrMain.dto;

public class AdminDrMainLogInDTO {
	
	private String id;
	private String pw;
	private boolean adminLogin;
	
	public AdminDrMainLogInDTO() {
		super();
	}

	public AdminDrMainLogInDTO(String id, String pw, boolean adminLogin) {
		super();
		this.id = id;
		this.pw = pw;
		this.adminLogin = adminLogin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public boolean getAdminLogin() {
		return adminLogin;
	}

	public void setAdminLogin(boolean adminLogin) {
		this.adminLogin = adminLogin;
	}

	@Override
	public String toString() {
		return "AdmindrMainLogInDTO [id=" + id + ", pw=" + pw + ", adminLogin=" + adminLogin + "]";
	}

	
}
