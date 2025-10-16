package com.project.hospital.common;

public class Result <T> {
	
	private T content;
	private int count;
	
	public Result() {
		super();
	}

	public Result(T content, int count) {
		super();
		this.content = content;
		this.count = count;
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
	
	

}
