package com.tjoeun.vo;

import java.util.ArrayList;

public class TodoList {
	
	private ArrayList<TodoVO> list = new ArrayList<TodoVO>();

	public ArrayList<TodoVO> getList() {
		return list;
	}

	public void setList(ArrayList<TodoVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "todoList [list=" + list + "]";
	}
	
}
