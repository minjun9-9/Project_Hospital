package com.project.hospital.qna.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class QnaDTO {
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
	
	//qna insert용
	//건의글 파일 업로드
	private List<MultipartFile> uploadFileList;
	private String userId;
	private String userName;
	private String userEmail;
	private String userPhoneNum;
	
	private int uploadFileCount;
	private List<String> filePath;
	
	//ajax 이자식용?
	private List<String> qnaIds;

	public QnaDTO() {
		super();
	}


	public QnaDTO(String qnaId, String userNum, String title, String content, String reply, Date replyAt,
			Date createdAt, Date updatedAt, String relation, String qnaType, String fileOne, String fileTwo,
			String fileThree, List<MultipartFile> uploadFileList, String userId, String userName, String userEmail,
			String userPhoneNum, int uploadFileCount, List<String> filePath, List<String> qnaIds) {
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
		this.uploadFileList = uploadFileList;
		this.userId = userId;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhoneNum = userPhoneNum;
		this.uploadFileCount = uploadFileCount;
		this.filePath = filePath;
		this.qnaIds = qnaIds;
	}



	public QnaDTO(String qnaId, String userNum, String title, String content, String reply, Date replyAt,
			Date createdAt, Date updatedAt, String relation, String qnaType, String fileOne, String fileTwo,
			String fileThree, List<MultipartFile> uploadFileList, String userName, String userEmail,
			String userPhoneNum, List<String> qnaIds) {
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
		this.uploadFileList = uploadFileList;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhoneNum = userPhoneNum;
		this.qnaIds = qnaIds;
	}






	public QnaDTO(String qnaId, String userNum, String title, String content, String reply,
			Date replyAt, Date createdAt, Date updatedAt, String relation, String qnaType,
			List<MultipartFile> uploadFileList, String userName, String userEmail, String userPhoneNum) {
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
		this.uploadFileList = uploadFileList;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhoneNum = userPhoneNum;
	}




	public QnaDTO(String qnaId, String userNum, String title, String content, String reply,
			Date replyAt, Date createdAt, Date updatedAt, String relation, String qnaType,
			List<MultipartFile> uploadFileList) {
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
		this.uploadFileList = uploadFileList;
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


	public List<MultipartFile> getUploadFileList() {
		return uploadFileList;
	}

	public void setUploadFileList(List<MultipartFile> uploadFileList) {
		this.uploadFileList = uploadFileList;
	}

	public String getUserName() {
		return userName;
	}




	public void setUserName(String userName) {
		this.userName = userName;
	}




	public String getUserEmail() {
		return userEmail;
	}




	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}




	public String getUserPhoneNum() {
		return userPhoneNum;
	}




	public void setUserPhoneNum(String userPhoneNum) {
		this.userPhoneNum = userPhoneNum;
	}



	public List<String> getQnaIds() {
		return qnaIds;
	}



	public void setQnaIds(List<String> qnaIds) {
		this.qnaIds = qnaIds;
	}

	

	public int getUploadFileCount() {
		return uploadFileCount;
	}

	public void setUploadFileCount(int uploadFileCount) {
		this.uploadFileCount = uploadFileCount;
	}
	

	public List<String> getFilePath() {
		return filePath;
	}



	public void setFilePath(List<String> filePath) {
		this.filePath = filePath;
	}
	
	


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	@Override
	public String toString() {
		return "QnaDTO [qnaId=" + qnaId + ", userNum=" + userNum + ", title=" + title + ", content=" + content
				+ ", reply=" + reply + ", replyAt=" + replyAt + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", relation=" + relation + ", qnaType=" + qnaType + ", fileOne=" + fileOne + ", fileTwo=" + fileTwo
				+ ", fileThree=" + fileThree + ", uploadFileList=" + uploadFileList + ", userId=" + userId
				+ ", userName=" + userName + ", userEmail=" + userEmail + ", userPhoneNum=" + userPhoneNum
				+ ", uploadFileCount=" + uploadFileCount + ", filePath=" + filePath + ", qnaIds=" + qnaIds + "]";
	}


	
	



	



	
}
