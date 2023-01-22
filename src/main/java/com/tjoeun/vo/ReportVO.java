package com.tjoeun.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportVO {
	private int startNo;
	private int endNo;
	private int idx;
	private String type; 
	private Date writedate;
	private String name;
	private int empno;
	private String title;
	private String content;
	private String attachedfile;
	private String realfilename;
	private int hit;
	private String searchobj;
	private String searchcategory;
	
}
