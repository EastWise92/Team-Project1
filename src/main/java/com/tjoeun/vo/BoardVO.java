package com.tjoeun.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String title;
	private String content;
	private int empno;
	private int deptno;
	private String name;
	private Date writedate;
	private String attachedfile;
	private String realfilename;
	private String category;
	private int hit;
	private int seq;
	private int gup;
		
}
