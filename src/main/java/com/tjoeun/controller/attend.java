package com.tjoeun.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.AttendList;
import com.tjoeun.vo.AttendVO;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.Param;
import com.tjoeun.vo.PaySlipVO;

@Controller
@RequestMapping("/attend")
public class attend {

	private static final Logger logger = LoggerFactory.getLogger(attend.class);

	@Autowired
	private SqlSession sqlSession;
	
	AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	Param param = CTX.getBean("param", Param.class);
		
	private int currentPage = 1;
	private int PageSize = 10;
	
	@RequestMapping("/move_attend_list")
	public String move_attend_list(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		session.setAttribute("searchdate", null);		
		model.addAttribute("currentPage", 1);

		return "redirect:attend_list";
	}
	
	@RequestMapping("/attend_list")
	public String attend_list(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			
		String searchdate = request.getParameter("searchdate");
		String searchname = ((EmpVO)session.getAttribute("EmpVO")).getName();
		
		if (searchdate != null) {
			searchdate = searchdate.trim().length() == 0 ? null : searchdate;
			session.setAttribute("searchdate", searchdate);
		} else { // 페이지가 이동되어도 검색 내용 유지
			searchdate = (String) session.getAttribute("searchdate");
		}

		AttendList attendList = null;
		
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}

		// 검색 내용 없을 경우 내 근태 모두 얻어오기
		if (searchdate == null) {
			int totalCount = mapper.countAttendByName(searchname);
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			param.setStartNo(attendList.getStartNo());
			param.setEndNo(attendList.getEndNo());
			param.setSearchname(searchname);
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByName(param));
		} else if (searchdate != null) { // 날짜 조회
			param.setSearchdate(searchdate);
			param.setSearchname(searchname);
			int totalCount = mapper.countAttendByDateName(param);
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			param.setStartNo(attendList.getStartNo());
			param.setEndNo(attendList.getEndNo());
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByDateName(param));
		} 
		model.addAttribute("attendList", attendList);
		model.addAttribute("currentPage", currentPage);
		
		return "attend/attend_list";
	}

	@RequestMapping("/move_left_dayoff_list")
	public String move_left_dayoff_list(HttpServletRequest request, Model model) {
			
		model.addAttribute("currentPage", 1);
		
		return "redirect:left_dayoff_list";
	}
	
	@RequestMapping("/left_dayoff_list")
	public String left_dayoff_list(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
	
		int empno = ((EmpVO)session.getAttribute("EmpVO")).getEmpno();
		Date hiredate =  ((EmpVO)session.getAttribute("EmpVO")).getHiredate();
		
		Date date = new Date();
		long workdays = (date.getTime() - hiredate.getTime()) / (24 * 60 * 60 * 1000); // 근속일수

		int annual = 15 + (int)(workdays / 365) / 2; // 근속년수 * 2 에 따른 연차 계산

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}
		
		int totalCount = mapper.countDayoffByEmpno(empno);
		
		AttendList attendList = new AttendList(PageSize, totalCount, currentPage);		
		
		param.setStartNo(attendList.getStartNo());
		param.setEndNo(attendList.getEndNo());
		param.setEmpno(empno);
		
		attendList.setList((ArrayList<AttendVO>) mapper.selectDayoffByEmpno(param));
		
		float deduce = 0; // 공제일 계산
		int latedate = 0; // 지각 횟수 계산
		for (AttendVO vo : attendList.getList()) {
			deduce += vo.getDeducedate();
			if (vo.getEtc().equals("EC")) {
				++latedate;
			}
		}
		
		model.addAttribute("annual", annual);
		model.addAttribute("deduce", deduce);
		model.addAttribute("latedate", latedate);
		model.addAttribute("attendList", attendList);
		model.addAttribute("currentPage", currentPage);
		
		return "attend/left_dayoff_list";
	}
	
	@RequestMapping("/payslip")
	public String payslip(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int empno = ((EmpVO)session.getAttribute("EmpVO")).getEmpno();
		
		Date date = new Date();
		date.setYear(date.getYear());
		date.setMonth(date.getMonth());
		date.setDate(10);
		if (date.getDate() < 10) {
			date.setMonth(date.getMonth() - 1);
			if (date.getMonth() == 0) {
				date.setYear(date.getYear() - 1);
				date.setMonth(12);
			}
		}
		
		try {
			date.setYear(Integer.parseInt(request.getParameter("year")) - 1900);
			date.setMonth(Integer.parseInt(request.getParameter("month")) - 1);
		} catch (NumberFormatException e) {
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String setdate = sdf.format(date);
		
		param.setEmpno(empno);
		param.setSearchdate(setdate);
		
		
		PaySlipVO vo = mapper.showPaySlip(param);
		
		Double paysum = vo.getBasepay() + vo.getPosallow() + vo.getAnnualpay() + vo.getExtpay() + vo.getNightpay() + vo.getHolypay() + vo.getBonus() + vo.getEtcpay() + vo.getFoodfee() + vo.getTransefee();
		Double deducesum = vo.getIncometax() + vo.getLocaltax() + vo.getNationpen() + vo.getEmpinsure() + vo.getHealthinsure() + vo.getEtcdeduce();

		model.addAttribute("year", date.getYear() + 1900);
		model.addAttribute("month", date.getMonth() + 1);
		model.addAttribute("payslip", vo);
		model.addAttribute("paysum", paysum);
		model.addAttribute("deducesum", deducesum);
		return "attend/payslip";
	}
}
