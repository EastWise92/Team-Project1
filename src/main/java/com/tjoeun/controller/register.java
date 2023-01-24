package com.tjoeun.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

@Controller
public class register {

	private static final Logger logger = LoggerFactory.getLogger(register.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/register")
	public String register(HttpServletRequest request, Model model) {
		return "register";
	}

	@ResponseBody
	@RequestMapping("/UserRegisterCheck")
	public String UserRegisterCheck(HttpServletRequest request, Model model) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String empno = request.getParameter("empno");
		EmpVO result = mapper.registerCheck(empno);

		if (empno == null || empno == "") {
			return "1";
		} else if (result != null) {
			return "2";
		} else if (empno.length() != 5) {
			return "3";
		} else {
			return "4";
		}
	}

	@ResponseBody
	@RequestMapping("/UserRegister")
	public String UserRegister(HttpServletRequest request, Model model) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String empno = request.getParameter("empno");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String pernum = request.getParameter("pernum");
		String email = request.getParameter("email");

		// 유효성 검사 (입력 체크)
		if (empno == null || empno.equals("") 
				|| password1 == null || password1.equals("") 
				|| password2 == null || password2.equals("") 
				|| name == null || name.equals("") 
				|| gender == null || gender.equals("")
				|| pernum == null || pernum.equals("") 
				|| email == null || email.equals("")) {

			return "1";
		}
		
		// 비밀번호 체크
		if (!password1.equals(password2)) {
			return "2";
		}

		AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EmpVO vo = CTX.getBean("empvo",EmpVO.class);
		
		vo.setEmpno(Integer.parseInt(empno));
		vo.setName(name);
		vo.setPassword(password1);
		vo.setPernum(pernum);
		vo.setEmail(email);
		vo.setGender(gender);

		mapper.register(vo);
		
		return "3";

	}
	
	@ResponseBody
	@RequestMapping("/UserRegisterUpdate")
	public String UserRegisterUpdate(HttpServletRequest request, Model model, EmpVO vo) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");
		String password1 = request.getParameter("password1");		
		
		if (checkPassword == null || checkPassword.equals("")) {
			return "1";
		}
		
		if (!password.equals(checkPassword)) {
			return "2";
		}
		
		vo.setPassword(password1);
		mapper.registerUpdate(vo);		
		return "3";
	}
	// 아이디 찾기
	@RequestMapping("/findIDpage")
	public String findIDpage(HttpServletRequest request, Model model) {
		return "findID";
	}
	@RequestMapping("/findID")
	public String findID(HttpServletRequest request,HttpServletResponse response, Model model, EmpVO vo) throws IOException {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int findID = mapper.findID(vo);
		
		// jsp에서 가져오는 user정보
		String name = request.getParameter("name");
		String pernum = request.getParameter("pernum");
		request.getParameter("gender");
		if(name=="") {
			out.println("<script>if (!alert(\"이름을 입력해주세요.\")) window.location = \"findIDpage\";</script>");
			out.flush();
		}else if(pernum=="") {
			out.println("<script>if (!alert(\"전화번호를 입력해주세요.\")) window.location = \"findIDpage\";</script>");
			out.flush();
		}
		else {
			if(findID == 0) {
				out.println("<script>if (!alert(\"회원정보를 정확하게 입력해주세요.\")) window.location = \"findIDpage\";</script>");
				out.flush();
			}else {
				EmpVO empVO = mapper.foundID(vo);
				model.addAttribute("empVO", empVO);
			}
		}
		return "findID";
	}
	
	
// 비밀번호 찾기
	@RequestMapping("/findPWpage")
	public String findPWpage(HttpServletRequest request, Model model) {
		/*
		 * String empno = request.getParameter("empno1");
		 * System.out.println("findPWpage의 empno : "+ empno); if(empno!="") {
		 * model.addAttribute("empno",empno); }
		 */
		return "findPW";
	}
	@RequestMapping("/findPW")
	public String findPW(HttpServletRequest request,HttpServletResponse response, Model model, EmpVO vo) throws IOException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		int findPW = mapper.findPW(vo);

		// jsp에서 가져오는 user정보
		String empno = request.getParameter("empno");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String pernum = request.getParameter("pernum");

		if(empno=="") {
			out.println("<script>if (!alert(\"사원번호(ID)를 입력해주세요.\")) window.location = \"findPWpage\";</script>");
			out.flush();
		}else if(name=="") {
			out.println("<script>if (!alert(\"이름을 입력해주세요.\")) window.location = \"findPWpage\";</script>");
			out.flush();
		}else if(pernum=="") {
			out.println("<script>if (!alert(\"전화번호를 입력해주세요.\")) window.location = \"findPWpage\";</script>");
			out.flush();
		}else {
			if(findPW == 0) {
				out.println("<script>if (!alert(\"일치하는 회원 정보가 없습니다.\")) window.location = \"findPWpage\";</script>");
				out.flush();
			}else {
				mapper.updatePW(vo);
				EmpVO empVO = mapper.foundPW(vo);
				model.addAttribute("empVO", empVO);
			}
		}
		return "findPW";
	}

}
