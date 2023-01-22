package com.tjoeun.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MessageVO {

	private int idx;
	private int transempno;
	private int receiveempno;
	private String title;
	private String content;
	private Date writedate;
	private String attachedfile;
	private String realfilename;
	private String status;
	private String read;
		
}
