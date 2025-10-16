package com.project.hospital.search;

public class QnaSearchDTO {
	private int count;
	private String title;   
	private String content;
	private String reply;
	private String replyAt;
	private String createdAt;
	
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
	public String getReplyAt() {
		return replyAt;
	}
	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	
	@Override
	public String toString() {
		return "QnADTO [count=" + count + ", title=" + title + ", content=" + content + ", reply=" + reply
				+ ", replyAt=" + replyAt + ", createdAt=" + createdAt + "]";
	}



	
	
	
}









