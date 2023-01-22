package com.tjoeun.vo;

import lombok.Data;

@Data
public class Param {

	private int startNo;
	private int endNo;
	private String category;
	private String searchcategory;
	private String searchclassify;
	private String searchobj;
	private String searchdeptno;
	private String searchname;
	private String searchdate;
	private int empno;
	private String email;

	// approval
	private String approval_search;
	private String approval_status;
	private String userName;
	private int userNo;

}
