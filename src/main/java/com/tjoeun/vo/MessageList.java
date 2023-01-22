package com.tjoeun.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class MessageList {
	
	private ArrayList<MessageVO> list = new ArrayList<MessageVO>();
	private int pageSize = 8; 
	private int totalCount = 0; 
	private int totalPage = 0; 
	private int currentPage = 1; 
	private int startNo = 0; 
	private int endNo = 0;
	private int startPage = 0; 
	private int endPage = 0; 

	public MessageList() {}
	
	public MessageList(int pageSize, int totalCount, int currentPage) {

		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		calculator();
	}

	private void calculator() {
		totalPage = (totalCount - 1) / pageSize + 1;
		totalPage = totalPage > currentPage ? totalPage : currentPage;
		startNo = (currentPage - 1) * pageSize + 1;
		endNo = startNo + pageSize - 1;
		endNo = endNo > totalCount ? totalCount : endNo;
		startPage = (currentPage - 1) / 10 * 10 + 1;
		endPage = startPage + 9;
		endPage = endPage > totalPage ? totalPage : endPage;
	}

}
