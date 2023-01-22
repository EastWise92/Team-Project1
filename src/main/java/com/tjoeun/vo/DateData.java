package com.tjoeun.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class DateData {
	
	private String year;
	private String month;
	private String date;
	private String status;
	private String event;
	private ArrayList<TodoVO> todolist = new ArrayList<TodoVO>();

	public DateData() { }

	public DateData(int year, int month, int date, String status, String event) {
		this.year = String.valueOf(year);
		this.month = String.valueOf(month);
		this.date = String.valueOf(date);
		this.status = status;
		this.event = event;
	}

	public DateData(String year, String month, int date, String status, String event) {
		this.year = year;
		this.month = month;
		this.date = String.valueOf(date);
		this.status = status;
		this.event = event;
	}

	@Override
	public String toString() {
		return "DateData [year=" + year + ", month=" + month + ", date=" + date + ", status=" + status + ", event="
				+ event + ", todolist=" + todolist + "]";
	}

}
