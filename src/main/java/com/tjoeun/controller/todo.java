package com.tjoeun.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.TodoList;
import com.tjoeun.vo.TodoVO;

@Controller
@RequestMapping("/todo")
public class todo {

	private static final Logger logger = LoggerFactory.getLogger(todo.class);

	@Autowired
	private SqlSession sqlSession;
	
	private Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
	private String setdate = sdf.format(date);
	
	AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	TodoList todolist = CTX.getBean("todolist",TodoList.class);

	@ResponseBody
	@RequestMapping("/todo_insert")
	public String todo_insert(HttpServletRequest request, Model model, TodoVO vo) throws ParseException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		String writedate = request.getParameter("dateinfo");
		vo.setWritedate(sdf.parse(writedate));
		vo.setDeptno(((EmpVO)session.getAttribute("EmpVO")).getDeptno());
		
		int maxidx = mapper.maxidx(vo); //idx 설정을 위한 idx 최대 값 얻어오기
		vo.setIdx(maxidx + 1); 
		
		mapper.todoinsert(vo);

		vo.setSetdate(setdate);
		todolist.setList(mapper.todolist(vo));	
		
		session.setAttribute("todoList", null);
		session.setAttribute("todoList", todolist);
		
		String idx = vo.getIdx() + "";
		return idx;
	}
	
	@ResponseBody
	@RequestMapping("/todo_updatestatus")
	public void todo_updatestatus(HttpServletRequest request, Model model, TodoVO vo) {
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		vo.setSetdate(setdate);
		
		mapper.todoupdateS(vo);	
		
		todolist.setList(mapper.todolist(vo));	
		
		HttpSession session = request.getSession();
		session.setAttribute("todoList", null);
		session.setAttribute("todoList", todolist);
	}	
	
	@ResponseBody
	@RequestMapping("/todo_delete")
	public void todo_delete(HttpServletRequest request, Model model, TodoVO vo) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		vo.setSetdate(setdate);
		int empno = ((EmpVO)session.getAttribute("EmpVO")).getEmpno();
		vo.setEmpno(empno);
		mapper.tododelete(vo);	

		todolist.setList(mapper.todolist(vo));	
		
		session.setAttribute("todoList", null);
		session.setAttribute("todoList", todolist);
	}	
	
	@ResponseBody
	@RequestMapping("/todo_update")
	public void todo_update(HttpServletRequest request, Model model, TodoVO vo) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		vo.setSetdate(setdate);
		int empno = ((EmpVO)session.getAttribute("EmpVO")).getEmpno();
		vo.setEmpno(empno);
		mapper.todoupdate(vo);	
		
		todolist.setList(mapper.todolist(vo));	
		
		session.setAttribute("todoList", null);
		session.setAttribute("todoList", todolist);
	}	
	
	

}
