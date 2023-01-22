package com.tjoeun.vo;

import java.util.ArrayList;

public class MeetRoomList {
	
	private ArrayList<MeetRoomVO> list = new ArrayList<MeetRoomVO>();

	public ArrayList<MeetRoomVO> getList() {
		return list;
	}

	public void setList(ArrayList<MeetRoomVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "MeetRoomList [list=" + list + "]";
	}
	
}
