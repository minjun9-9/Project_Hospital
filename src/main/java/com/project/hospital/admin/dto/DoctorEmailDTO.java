package com.project.hospital.admin.dto;

public class DoctorEmailDTO {
	private String email;
	private String emailPwd;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailPwd() {
		return emailPwd;
	}
	public void setEmailPwd(String emailPwd) {
		this.emailPwd = emailPwd;
	}
	
	@Override
	public String toString() {
		return "DoctorEmailDTO [email=" + email + ", emailPwd=" + emailPwd + "]";
	}
	
}
