package com.project.hospital.vo;

import java.sql.Date;

public class QnaVO {
	private String qnaId;
	private String userNum;
	private String title;
	private String content;
	private String reply;
	//혹시 이거 써야되면 쓰기
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul" )
	private Date replyAt;
	private Date createdAt;
	private Date updatedAt;
	private String relation;
	private String qnaType;
	private String fileOne;
	private String fileTwo;
	private String fileThree;
	
	public QnaVO() {
	}

	public QnaVO(String qnaId, String userNum, String title, String content, String reply,
			Date replyAt, Date createdAt, Date updatedAt, String relation, String qnaType) {
		super();
		this.qnaId = qnaId;
		this.userNum = userNum;
		this.title = title;
		this.content = content;
		this.reply = reply;
		this.replyAt = replyAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.relation = relation;
		this.qnaType = qnaType;
	}
	

	public QnaVO(String qnaId, String userNum, String title, String content, String reply, Date replyAt, Date createdAt,
			Date updatedAt, String relation, String qnaType, String fileOne, String fileTwo, String fileThree) {
		super();
		this.qnaId = qnaId;
		this.userNum = userNum;
		this.title = title;
		this.content = content;
		this.reply = reply;
		this.replyAt = replyAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.relation = relation;
		this.qnaType = qnaType;
		this.fileOne = fileOne;
		this.fileTwo = fileTwo;
		this.fileThree = fileThree;
	}

	public String getQnaId() {
		return qnaId;
	}

	public void setQnaId(String qnaId) {
		this.qnaId = qnaId;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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


	public Date getReplyAt() {
		return replyAt;
	}

	public void setReplyAt(Date replyAt) {
		this.replyAt = replyAt;
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
	

	public String getRelation() {
		return relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public String getQnaType() {
		return qnaType;
	}

	public void setQnaType(String qnaType) {
		this.qnaType = qnaType;
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

	@Override
	public String toString() {
		return "QnaVO [qnaId=" + qnaId + ", userNum=" + userNum + ", title=" + title + ", content=" + content
				+ ", reply=" + reply + ", replyAt=" + replyAt + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", relation=" + relation + ", qnaType=" + qnaType + ", fileOne=" + fileOne + ", fileTwo=" + fileTwo
				+ ", fileThree=" + fileThree + "]";
	}


	
	
	
	
	
	

}
