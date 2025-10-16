package com.project.hospital.common;

public class ResultPage <T> {
	
	private T content;
	private int count;
	private Paging paging;
	
	public ResultPage() {
		super();
	}

	public ResultPage(T content, int count, Paging paging) {
		super();
		this.content = content;
		this.count = count;
		this.paging = paging;
	}

	public T getContent() {
		return content;
	}

	public void setContent(T content) {
		this.content = content;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Paging getPaging() {
		return paging;
	}

	public void setPaging(Paging paging) {
		this.paging = paging;
	}
	
	

	
	

}
