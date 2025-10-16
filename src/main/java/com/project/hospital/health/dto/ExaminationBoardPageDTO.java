package com.project.hospital.health.dto;

import java.util.List;

public class ExaminationBoardPageDTO {
	
	private List<ExaminationBoardDTO> boardList;
	private int currentPage; 
	private int totalPageCount;
	private int totalCount;
	public ExaminationBoardPageDTO() {
		super();
	}
	public ExaminationBoardPageDTO(List<ExaminationBoardDTO> boardList, int currentPage, int totalPageCount,
			int totalCount) {
		super();
		this.boardList = boardList;
		this.currentPage = currentPage;
		this.totalPageCount = totalPageCount;
		this.totalCount = totalCount;
	}
	
	public List<ExaminationBoardDTO> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<ExaminationBoardDTO> boardList) {
		this.boardList = boardList;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}
	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	@Override
	public String toString() {
		return "ExaminationBoardPageDTO [boardList=" + boardList + ", currentPage=" + currentPage + ", totalPageCount="
				+ totalPageCount + ", totalCount=" + totalCount + "]";
	}
	
	
	

}
