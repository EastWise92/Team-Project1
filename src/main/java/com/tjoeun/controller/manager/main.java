package com.tjoeun.controller.manager;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

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
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.AttendList;
import com.tjoeun.vo.AttendVO;
import com.tjoeun.vo.BoardList;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.EmpList;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.PagingInfo;
import com.tjoeun.vo.Param;

@Controller
@RequestMapping("/manager")
public class main {
	
	private static final Logger logger = LoggerFactory.getLogger(rest.class);

	@Autowired
	private SqlSession sqlSession;
	
	AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	Param param = CTX.getBean("param", Param.class);
		
	private int currentPage = 1;
	private int PageSize = 10;

	@RequestMapping("/Manager_Main")
	public String Manager_Meun(HttpServletRequest request, Model model) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		// 공지사항
		BoardList boardlist = new BoardList();
		String category = "공지사항";
		boardlist.setList(mapper.selectNoticeList(category));
		model.addAttribute("noticeList", boardlist);
		
		// 계정 승인 대기 목록
		int totalCount = mapper.countwaiting();
		
		EmpList waitingList = new EmpList(PageSize, totalCount, currentPage);		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", waitingList.getStartNo());
		hmap.put("endNo", waitingList.getEndNo());		
		waitingList.setList((ArrayList<EmpVO>) mapper.selectwaiting(hmap));
		model.addAttribute("waitingList", waitingList);
		
		// 결재 대기 목록
		PagingInfo paging = new PagingInfo();
		Param param = new Param();
		param.setApproval_status("결재대기");
		param.setEndNo(10);
		param.setStartNo(1);
		paging.setList(mapper.selectApprovalList(param));
		System.out.println(paging);
		model.addAttribute("appList", paging);
		
		return "manager/Manager_Main";
	}
	
	@RequestMapping("/account_approval")
	public String account_approval(HttpServletRequest request, Model model) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}
		
		int totalCount = mapper.countwaiting();
		
		EmpList waitingList = new EmpList(PageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", waitingList.getStartNo());
		hmap.put("endNo", waitingList.getEndNo());
		
		waitingList.setList((ArrayList<EmpVO>) mapper.selectwaiting(hmap));
		
		model.addAttribute("waitingList", waitingList);
		model.addAttribute("currentPage", currentPage);
		
		return "manager/account_approval";
	}
	
	@RequestMapping("/move_emp_list")
	public String move_emp_list(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		session.setAttribute("searchdeptno", null);
		session.setAttribute("searchname", null);
		model.addAttribute("currentPage", 1);

		return "redirect:emp_list";
	}
	
	@RequestMapping("/emp_list")
	public String emp_list(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		String searchdeptno = request.getParameter("searchdeptno");
		String searchname = request.getParameter("searchname");
		
		if (searchdeptno != null || searchname != null) {
			session.setAttribute("searchdeptno", searchdeptno);
			searchname = searchname.trim().length() == 0 ? null : searchname;
			session.setAttribute("searchname", searchname);
		} else { // 페이지가 이동되어도 검색 내용 유지
			searchdeptno = (String) session.getAttribute("searchdeptno");
			searchname = (String) session.getAttribute("searchname");
		}

		EmpList empList = null;
		
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}

		// 검색 내용 없을 경우에 전체 직원 목록 얻어오기
		if (searchdeptno == null || searchdeptno.trim().length() == 0 && searchname == null) {
			int totalCount = mapper.countemp();
			
			empList = new EmpList(PageSize, totalCount, currentPage);
			
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", empList.getStartNo());
			hmap.put("endNo", empList.getEndNo());
			
			empList.setList((ArrayList<EmpVO>) mapper.selectemp(hmap));
		} else if (searchdeptno != null && searchname == null) { // 팀만 조회
			int totalCount = mapper.countByDept(Integer.parseInt(searchdeptno));

			empList = new EmpList(PageSize, totalCount, currentPage);

			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", empList.getStartNo());
			hmap.put("endNo", empList.getEndNo());
			hmap.put("deptno", Integer.parseInt(searchdeptno));

			empList.setList((ArrayList<EmpVO>) mapper.selectByDept(hmap));
		} else if (searchdeptno == null || searchdeptno.trim().length() == 0 && searchname != null) { // 이름만 조회
			int totalCount = mapper.countByName(searchname);
			
			empList = new EmpList(PageSize, totalCount, currentPage);
			
			Param param = new Param();
			
			param.setStartNo(empList.getStartNo());
			param.setEndNo(empList.getEndNo());
			param.setSearchname(searchname);
			
			empList.setList((ArrayList<EmpVO>) mapper.selectByName(param));			
		} else { // 팀, 이름 같이 조회
			Param param = new Param();
			param.setSearchdeptno(searchdeptno);
			param.setSearchname(searchname);
			
			int totalCount = mapper.countByMultiEmp(param);
			
			empList = new EmpList(PageSize, totalCount, currentPage);
			
			param.setStartNo(empList.getStartNo());
			param.setEndNo(empList.getEndNo());
			
			empList.setList((ArrayList<EmpVO>) mapper.selectByMultiEmp(param));			
		}
		
		model.addAttribute("empList", empList);
		model.addAttribute("currentPage", currentPage);
		
		return "manager/emp_list";
	}
	
	@RequestMapping("/move_show_all_board")
	public String move_show_all_board(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		session.setAttribute("category", null);
		session.setAttribute("searchcategory", null);
		session.setAttribute("searchobj", null);
		session.setAttribute("checksession", null);
		model.addAttribute("currentPage", 1);

		return "redirect:show_all_board";
	}
	
	@RequestMapping("/show_all_board")
	public String show_all_board(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String category = request.getParameter("category"); // 카테고리
		String searchcategory = request.getParameter("searchcategory"); // 검색범위
		String searchobj = request.getParameter("searchobj"); // 검색 내용

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {

		}
		
		if (searchobj != null || category != null) {
			category = category.trim().length() == 0 ? null : category;
			searchobj = searchobj.trim().length() == 0 ? null : searchobj;
			
			session.setAttribute("category", category);
			session.setAttribute("searchcategory", searchcategory);
			session.setAttribute("searchobj", searchobj);
		} else { // 페이지가 이동되어도 검색 내용 유지
			category = (String) session.getAttribute("category");
			searchcategory = (String) session.getAttribute("searchcategory");
			searchobj = (String) session.getAttribute("searchobj");		
		}
		
		BoardList boardlist = null;

		// 검색 내용 없을 경우에 전체 글 목록 얻어오기
		if (category == null && searchobj == null) {
			int totalCount = mapper.AllBoardCount();

			boardlist = new BoardList(PageSize, totalCount, currentPage);

			param.setStartNo(boardlist.getStartNo());
			param.setEndNo(boardlist.getEndNo());

			boardlist.setList(mapper.AllBoardSelect(param));
		} else if (category != null && searchobj == null) { 
			int totalCount = mapper.selectCount(category);

			boardlist = new BoardList(PageSize, totalCount, currentPage);

			param.setStartNo(boardlist.getStartNo());
			param.setEndNo(boardlist.getEndNo());
			param.setCategory(category);

			boardlist.setList(mapper.selectList(param));
		} else if (category == null && searchobj != null) {		
			param.setSearchobj(searchobj);
			param.setSearchcategory(searchcategory);
			
			int totalCount = mapper.NoCatCountMulti(param);
			
			boardlist = new BoardList(PageSize, totalCount, currentPage);

			param.setStartNo(boardlist.getStartNo());
			param.setEndNo(boardlist.getEndNo());

			boardlist.setList(mapper.NoCatSelectMulti(param));			
		} else {
			param.setCategory(category);
			param.setSearchobj(searchobj);
			param.setSearchcategory(searchcategory);
			
			int totalCount = mapper.selecCountMulti(param);
			
			boardlist = new BoardList(PageSize, totalCount, currentPage);

			param.setStartNo(boardlist.getStartNo());
			param.setEndNo(boardlist.getEndNo());

			boardlist.setList(mapper.selectListMulti(param));	
		}
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("BoardList", boardlist);
		
		return "manager/board_list";
	}
	
	@RequestMapping("/board_view")
	public String board_view(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue(value = "coki") String cookie) throws UnsupportedEncodingException {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);		
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
//		=============쿠키 ==============
		if (!cookie.contains(String.valueOf(idx))) {
			cookie += idx;
			mapper.increment_hit(idx);
		}
		cookie = URLEncoder.encode(cookie, "utf-8"); // 한글, 세미콜론, 콤마, 이콜 사인, 공백은 쿠키 값으로 이용될 수 없기 떄문에 쿠키 추가전에 인코딩
		response.addCookie(new Cookie("coki", cookie));
//		=============쿠키 ==============
			
		BoardVO vo = mapper.selectContentByIdx(idx);
		
		int PageSize = 7;
		int totalCount = mapper.selectCommentCount(idx);

		BoardList commentlist = new BoardList(PageSize, totalCount, currentPage);

		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", commentlist.getStartNo());
		hmap.put("endNo", commentlist.getEndNo());
		hmap.put("idx", idx);

		commentlist.setList(mapper.selectCommentList(hmap));

		
		model.addAttribute("vo", vo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("commentList", commentlist);
		
		return "manager/board_view";		
	}
	
	@RequestMapping("/move_attend_list")
	public String move_attend_list(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		session.setAttribute("searchdeptno", null);
		session.setAttribute("searchname", null);
		session.setAttribute("searchdate", null);
		
		model.addAttribute("currentPage", 1);

		return "redirect:attend_list";
	}
	
	@RequestMapping("/attend_list")
	public String attend_list(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		String searchdeptno = request.getParameter("searchdeptno");
		String searchdate = request.getParameter("searchdate");
		String searchname = request.getParameter("searchname");
		
		if (searchdeptno != null || searchname != null || searchdate != null) {
			searchdeptno = searchdeptno.trim().length() == 0 ? null : searchdeptno;
			searchdate = searchdate.trim().length() == 0 ? null : searchdate;
			searchname = searchname.trim().length() == 0 ? null : searchname;
			
			session.setAttribute("searchdeptno", searchdeptno);
			session.setAttribute("searchdate", searchdate);
			session.setAttribute("searchname", searchname);
		} else { // 페이지가 이동되어도 검색 내용 유지
			searchdeptno = (String) session.getAttribute("searchdeptno");
			searchdate = (String) session.getAttribute("searchdate");
			searchname = (String) session.getAttribute("searchname");
		}

		AttendList attendList = null;
		
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}

		// 검색 내용 없을 경우에 전체 직원 목록 얻어오기
		if (searchdeptno == null && searchdate == null && searchname == null) {
			int totalCount = mapper.countAttnedAll();
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", attendList.getStartNo());
			hmap.put("endNo", attendList.getEndNo());
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendAll(hmap));
		} else if (searchdeptno != null && searchdate == null && searchname == null) { // 부서로 조회
			int totalCount = mapper.countAttendByDept(Integer.parseInt(searchdeptno));
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", attendList.getStartNo());
			hmap.put("endNo", attendList.getEndNo());
			hmap.put("deptno", Integer.parseInt(searchdeptno));
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByDept(hmap));
		} else if (searchdeptno == null && searchdate != null && searchname == null) { // 날짜로 조회
			int totalCount = mapper.countAttendByDate(searchdate);
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			param.setStartNo(attendList.getStartNo());
			param.setEndNo(attendList.getEndNo());
			param.setSearchdate(searchdate);
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByDate(param));
		} else if (searchdeptno == null && searchdate == null && searchname != null) { // 이름으로 조회
			int totalCount = mapper.countAttendByName(searchname);
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			param.setStartNo(attendList.getStartNo());
			param.setEndNo(attendList.getEndNo());
			param.setSearchname(searchname);
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByName(param));
		} else if (searchdeptno != null && searchdate != null && searchname == null) { // 부서, 날짜로 조회
			param.setSearchdate(searchdate);
			param.setSearchdeptno(searchdeptno);
			int totalCount = mapper.countAttendByDeptDate(param);
			
			attendList = new AttendList(PageSize, totalCount, currentPage);
			
			param.setStartNo(attendList.getStartNo());
			param.setEndNo(attendList.getEndNo());
			
			attendList.setList((ArrayList<AttendVO>) mapper.selectAttendByDeptDate(param));
		} else if (searchdeptno == null && searchdate != null && searchname != null) { // 날짜, 이름으로 조회
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
		
		return "manager/attend_list";
	}
	
}
