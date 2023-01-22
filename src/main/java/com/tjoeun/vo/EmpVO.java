package com.tjoeun.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EmpVO {
	
	private int empno;
	private String name;
	private String password;
	private String position;
	private int deptno;
	private String incnum;
	private String pernum;
	private String email;
	private Date hiredate;
	private String gender;
	private String permission;
	
	public EmpVO() {}
	
	public EmpVO(int empno, String name, String password, String pernum, String email, String gender) {
		super();
		this.empno = empno;
		this.name = name;
		this.password = password;
		this.pernum = pernum;
		this.email = email;
		this.gender = gender;
	}

}
