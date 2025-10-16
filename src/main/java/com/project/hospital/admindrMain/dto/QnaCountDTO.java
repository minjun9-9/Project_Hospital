package com.project.hospital.admindrMain.dto;

import java.util.ArrayList;
import java.util.List;

public class QnaCountDTO {
	
	private int totalcnt;
	private int completecnt;
	private String qnaPercent;
	private List<AdminDrMainQnaDTO> qnaDescThird = new ArrayList<AdminDrMainQnaDTO>();

	public QnaCountDTO() {
		super();
	}

	public QnaCountDTO(List<AdminDrMainQnaDTO> qnaDescThird, int totalcnt, int completecnt, String qnaPercent) {
		super();
		this.qnaDescThird = qnaDescThird;
		this.totalcnt = totalcnt;
		this.completecnt = completecnt;
		this.qnaPercent = qnaPercent;
	}
	
	
	
	public String getQnaPercent() {
		return qnaPercent;
	}

	public void setQnaPercent(String qnaPercent) {
		this.qnaPercent = qnaPercent;
	}

	public List<AdminDrMainQnaDTO> getQnaDescThird() {
		return qnaDescThird;
	}

	public void setQnaDescThird(List<AdminDrMainQnaDTO> qnaDescThird) {
		this.qnaDescThird = qnaDescThird;
	}

	public int getTotalcnt() {
		return totalcnt;
	}

	public void setTotalcnt(int totalcnt) {
		this.totalcnt = totalcnt;
	}

	public int getCompletecnt() {
		return completecnt;
	}

	public void setCompletecnt(int completecnt) {
		this.completecnt = completecnt;
	}

	@Override
	public String toString() {
		return "QnaCountDTO [totalcnt=" + totalcnt + ", completecnt=" + completecnt + ", qnaPercent=" + qnaPercent
				+ ", qnaDescThird=" + qnaDescThird + "]";
	}

	

	
	
}
