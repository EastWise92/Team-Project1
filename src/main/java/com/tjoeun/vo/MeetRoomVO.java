package com.tjoeun.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MeetRoomVO {
	
	private int roomnum;
	private int deptno;
	private Date setdate;
	private String starttime;
	private String endtime;

}
