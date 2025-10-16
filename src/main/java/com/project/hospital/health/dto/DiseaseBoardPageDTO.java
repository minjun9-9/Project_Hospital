package com.project.hospital.health.dto;

import java.util.List;

public class DiseaseBoardPageDTO {
	
	private List<DiseaseBoardDTO> boardList;
	private int currentPage; 
	private int totalPageCount;
	private int totalCount;
	
	
	public DiseaseBoardPageDTO() {
	}
	public DiseaseBoardPageDTO(List<DiseaseBoardDTO> boardList, int currentPage, int totalPageCount, int totalCount) {
		this.boardList = boardList;
		this.currentPage = currentPage;
		this.totalPageCount = totalPageCount;
		this.totalCount = totalCount;
	}
	public List<DiseaseBoardDTO> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<DiseaseBoardDTO> boardList) {
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
		return "DiseaseBoardPageDTO [boardList=" + boardList + ", currentPage=" + currentPage + ", totalPageCount="
				+ totalPageCount + ", totalCount=" + totalCount + "]";
	}
	
	

}
