package com.tjoeun.controller.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.EmpVO;

@RestController
@RequestMapping("/manager")
public class rest {

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/account_approvalOK")
	public void account_approvalOK(HttpServletRequest request, Model model, @RequestBody EmpVO vo) {		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		mapper.account_approval(vo);		
	}
	
	@RequestMapping("/updatePMS")
	public void updatePMS(HttpServletRequest request, Model model, @RequestBody EmpVO vo) {		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);			
		mapper.updatePMS(vo);			
	}
	
	@RequestMapping("/checksession")
	public void checksession(HttpServletRequest request, Model model, @RequestParam Boolean data) {		
		request.getSession().setAttribute("checksession", data);		
	}
	
	@RequestMapping("/deleteboard")
	public void deleteboard(HttpServletRequest request, Model model, @RequestParam String idxs) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);	
		String[] idx = idxs.split(" "); // 하나의 문자열로 받아온 idx들 나누기
		
		for (int i = 0; i < idx.length; i++) {
			BoardVO vo = mapper.selectContentByIdx(Integer.parseInt(idx[i]));
			mapper.contentdelete(vo);
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("checksession", false);
		
	}
	
	@RequestMapping("/moveboard")
	public void moveboard(HttpServletRequest request, Model model, @RequestParam String idxs, @RequestParam String category) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);	
		String[] idx = idxs.split(" "); // 하나의 문자열로 받아온 idx들 나누기
		
		for (int i = 0; i < idx.length; i++) {
			BoardVO vo = mapper.selectContentByIdx(Integer.parseInt(idx[i]));
			vo.setCategory(category);
			mapper.categoryupdate(vo);
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("checksession", false);
		
	}
	
}
