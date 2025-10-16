package com.project.hospital.admindrMain.dto;

public class AdminDrMainQnaDTO {
	
	private String userName;
	private String content;
	private String reply;
	private String replyClass; // html css클래스명
	private String createdAt;
	private String dateTime;
	
	public AdminDrMainQnaDTO() {
		super();
	}

	public AdminDrMainQnaDTO(String userName, String content, String reply, String replyClass, String createdAt,
			String dateTime) {
		super();
		this.userName = userName;
		this.content = content;
		this.reply = reply;
		this.replyClass = replyClass;
		this.createdAt = createdAt;
		this.dateTime = dateTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getReplyClass() {
		return replyClass;
	}

	public void setReplyClass(String replyClass) {
		this.replyClass = replyClass;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	@Override
	public String toString() {
		return "AdminDrMainQnaDTO [userName=" + userName + ", content=" + content + ", reply=" + reply + ", replyClass="
				+ replyClass + ", createdAt=" + createdAt + ", dateTime=" + dateTime + "]";
	}

	
}
