package com.tjoeun.vo;

import java.util.Date;

public class MailBoxesVO {
	private String transemail;
	private String receivemail;
	private String title;
	private String content;
	private Date writedate;
	private String attachedfile;
	private String status="no";
	private int idx;
	
	public String getTransemail() {
		return transemail;
	}
	public void setTransemail(String transemail) {
		this.transemail = transemail;
	}
	public String getReceivemail() {
		return receivemail;
	}
	public void setReceivemail(String receivemail) {
		this.receivemail = receivemail;
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
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	public String getAttachedfile() {
		return attachedfile;
	}
	public void setAttachedfile(String attachedfile) {
		this.attachedfile = attachedfile;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	@Override
	public String toString() {
		return "MailBoxesVO [transemail=" + transemail + ", receivemail=" + receivemail + ", title=" + title
				+ ", content=" + content + ", writedate=" + writedate + ", attachedfile=" + attachedfile + ", status="
				+ status + ", idx=" + idx + "]";
	}
}
