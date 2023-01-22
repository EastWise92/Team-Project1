package com.tjoeun.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
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

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.service.getCalendar;
import com.tjoeun.vo.BoardList;
import com.tjoeun.vo.DateData;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.TodoList;
import com.tjoeun.vo.TodoVO;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	private Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
	private String setdate = sdf.format(date);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/")
	public String index(Locale locale, Model model) {
		return "redirect:login";
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		return "login";
	}

	@RequestMapping("/login_confirm")
	public String login_confirm(HttpServletRequest request, Model model) {

		AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EmpVO vo = CTX.getBean("empvo", EmpVO.class);
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		if (request.getParameter("empno").trim().length() == 0) {
			session.setAttribute("alertt", "아이디를 입력해주세요.");
			return "redirect:login";
		} else if (request.getParameter("password").trim().length() == 0){
			session.setAttribute("alertt", "비밀번호를 입력해주세요.");
			return "redirect:login";
		}
		
		vo.setEmpno(Integer.parseInt(request.getParameter("empno")));
		vo.setPassword(request.getParameter("password"));

		int confirmEmpno = mapper.confirmEmpno(vo.getEmpno());

		if (confirmEmpno != 0) {

			EmpVO confirm = mapper.selectlogin(vo.getEmpno());

			if (vo.getPassword().equals(confirm.getPassword())) {
				if (confirm.getPermission().equals("waiting")) {
					session.setAttribute("alertt", "승인되지 않은 아이디입니다.");
					return "redirect:login";
				} else {
					session.setAttribute("EmpVO", confirm);

					TodoList todolist = CTX.getBean("todolist", TodoList.class);
					TodoVO todovo = CTX.getBean("todovo", TodoVO.class);

					todovo.setSetdate(setdate);
					todovo.setEmpno(vo.getEmpno());
					
					todolist.setList(mapper.todolist(todovo));
					session.setAttribute("todoList", todolist);

					return "redirect:main";
				}
			} else {
				session.setAttribute("alertt", "틀린 비밀번호입니다.");
				return "redirect:login";
			}

		} else {
			session.setAttribute("alertt", "존재하지 않는 사원번호입니다.");
			return "redirect:login";
		}

	}

	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model, DateData dateData, HttpServletResponse response, TodoVO todo) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();

		// =============== 쿠키 ==========================
		Cookie cookie = new Cookie("coki", null);
		cookie.setComment("게시글 조회 확인");
		cookie.setMaxAge(60 * 60 * 2);

		response.addCookie(cookie); // 클라이언트에게 쿠키 추가
		// =============== 쿠키 ==========================

		// JAVA의 Calendar 추상클래스 활용
		// 추상 클래스이기 때문에 직접 new 하여 객체 생성 불가
		// => Calendar.getInstance() 이용하거나, Calendar 클래스를 상속받는 GregorianCalendar 클래스 이용
		Calendar cal = Calendar.getInstance();

		// 달력 초기화
		if (dateData.getDate() == null && dateData.getMonth() == null) {
			dateData = new DateData(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE), null,
					null);
		}

		if (Integer.parseInt(dateData.getMonth()) == 12) {
			dateData.setMonth("0");
			dateData.setYear(String.valueOf(Integer.parseInt(dateData.getYear()) + 1));
		}

		if (Integer.parseInt(dateData.getMonth()) == -1) {
			dateData.setMonth("11");
			dateData.setYear(String.valueOf(Integer.parseInt(dateData.getYear()) - 1));
		}

		todo.setEmpno(((EmpVO)session.getAttribute("EmpVO")).getEmpno());
		todo.setDeptno(((EmpVO)session.getAttribute("EmpVO")).getDeptno());
		List<DateData> dateList = getCalendar.month_info(dateData, sqlSession, todo); // 이번달 필드

		model.addAttribute("dateList", dateList);
		session.setAttribute("datedata", dateData); // 오늘 날짜

		// 공지사항
		BoardList boardlist = new BoardList();
		String category = "공지사항";
		boardlist.setList(mapper.selectNoticeList(category));
		model.addAttribute("noticeList", boardlist);
		
		// 자료실
		boardlist = new BoardList();
		category = "자료실";
		boardlist.setList(mapper.selectDataList(category));
		model.addAttribute("dataList", boardlist);
		
		// 새쪽지 여부
		EmpVO vo = (EmpVO) session.getAttribute("EmpVO");
		int noreadCount = mapper.noreadCount(vo.getEmpno());
		int recieveCount = mapper.receiveMessageSelectCount(vo.getEmpno());
		session.setAttribute("recieveCount",recieveCount);
		session.setAttribute("noRead",noreadCount);

		return "main";
	}

	@RequestMapping("/logout")
	public String lotout(HttpServletRequest request, Model model) {
			
		HttpSession session = request.getSession();
		session.setAttribute("EmpVO", null);
		return "redirect:login";
	}

}
