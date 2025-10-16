package com.project.hospital.vo;

import org.springframework.web.multipart.MultipartFile;

public class ReferralVO {
	private String referId;
	private String userNum;
	private String userName;
	private String sHpName;
	private String sDeptName;
	private String sDrId;
	private String sDrName;
	private String rHpName;
	private String rDeptName;
	private String rDrId;
	private String rDrName;
	private String referContent;
	private String resultContent;
	private String receiveChk;
	private String createDate;
	private String updateDate;
	private String fileone;
	private String filetwo;
	private String filethree;
	
	private MultipartFile file;
	
	private String rnum;
	
	private String searchCondition;
	private String searchKeyword;
	
	
	
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getReferId() {
		return referId;
	}
	public void setReferId(String referId) {
		this.referId = referId;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getsDeptName() {
		return sDeptName;
	}
	public void setsDeptName(String sDeptName) {
		this.sDeptName = sDeptName;
	}
	public String getsDrId() {
		return sDrId;
	}
	public void setsDrId(String sDrId) {
		this.sDrId = sDrId;
	}
	public String getsDrName() {
		return sDrName;
	}
	public void setsDrName(String sDrName) {
		this.sDrName = sDrName;
	}
	public String getrDeptName() {
		return rDeptName;
	}
	public void setrDeptName(String rDeptName) {
		this.rDeptName = rDeptName;
	}
	public String getrDrId() {
		return rDrId;
	}
	public void setrDrId(String rDrId) {
		this.rDrId = rDrId;
	}
	public String getrDrName() {
		return rDrName;
	}
	public void setrDrName(String rDrName) {
		this.rDrName = rDrName;
	}
	public String getReferContent() {
		return referContent;
	}
	public void setReferContent(String referContent) {
		this.referContent = referContent;
	}
	public String getResultContent() {
		return resultContent;
	}
	public void setResultContent(String resultContent) {
		this.resultContent = resultContent;
	}
	public String getReceiveChk() {
		return receiveChk;
	}
	public void setReceiveChk(String receiveChk) {
		this.receiveChk = receiveChk;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
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
	
	public String getsHpName() {
		return sHpName;
	}
	public void setsHpName(String sHpName) {
		this.sHpName = sHpName;
	}
	public String getrHpName() {
		return rHpName;
	}
	public void setrHpName(String rHpName) {
		this.rHpName = rHpName;
	}
	
	
	public MultipartFile getFile() {
		return file;
	}
	
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "ReferralVO [referId=" + referId + ", userNum=" + userNum + ", userName=" + userName + ", sHpName="
				+ sHpName + ", sDeptName=" + sDeptName + ", sDrId=" + sDrId + ", sDrName=" + sDrName + ", rHpName="
				+ rHpName + ", rDeptName=" + rDeptName + ", rDrId=" + rDrId + ", rDrName=" + rDrName + ", referContent="
				+ referContent + ", resultContent=" + resultContent + ", receiveChk=" + receiveChk + ", createDate="
				+ createDate + ", updateDate=" + updateDate + ", fileone=" + fileone + ", filetwo=" + filetwo
				+ ", filethree=" + filethree + ", file=" + file + ", rnum=" + rnum + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword + "]";
	}
	
	
	
	
	
	
	
}
