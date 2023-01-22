package com.tjoeun.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TodoVO {
	
	private int idx;
	private int empno;
	private int deptno;
	private Date writedate;
	private String content;
	private String status;
	private String shareset;
	private String colorcode;
	private String setdate;
			
}
