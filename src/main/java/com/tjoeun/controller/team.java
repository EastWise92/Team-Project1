package com.tjoeun.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.EmpList;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.Param;
import com.tjoeun.vo.ReportList;
import com.tjoeun.vo.ReportVO;

@Controller
@RequestMapping("/team")
public class team {

	private static final Logger logger = LoggerFactory.getLogger(team.class);

	@Autowired
	private SqlSession sqlSession;
	
	AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	BoardVO vo = CTX.getBean("boardvo", BoardVO.class);
	Param param = CTX.getBean("param", Param.class);

	private int PageSize = 10;
	private int currentPage = 1;

//	=====================================주소록======================================
	@RequestMapping("/move_address_book_list")
	public String move_address_book_list(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		session.setAttribute("searchdeptno", null);
		session.setAttribute("searchname", null);	
		model.addAttribute("currentPage", 1);

		return "redirect:address_book_list";
	}
	
	@RequestMapping("/address_book_list")
	public String address_book_list(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		int deptno = ((EmpVO) session.getAttribute("EmpVO")).getDeptno();
		String searchname = request.getParameter("searchname");
		
		if (searchname != null) {
			searchname = searchname.trim().length() == 0 ? null : searchname;
			session.setAttribute("searchname", searchname);
		} else { // 페이지가 이동되어도 검색 내용 유지
			searchname = (String) session.getAttribute("searchname");
		}
		
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
		}
		
		EmpList addressBookList = null;
		
		if (searchname == null || searchname.trim().length() == 0 ) {
			int totalCount = mapper.countByDept(deptno);
	
			addressBookList = new EmpList(PageSize, totalCount, currentPage);
	
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", addressBookList.getStartNo());
			hmap.put("endNo", addressBookList.getEndNo());
			hmap.put("deptno", deptno);
	
			addressBookList.setList((ArrayList<EmpVO>) mapper.selectByDept(hmap));
		} else {			
			Param param = new Param();
			param.setSearchdeptno(deptno+"");
			param.setSearchname(searchname);
			
			int totalCount = mapper.countByMultiEmp(param);
			
			addressBookList = new EmpList(PageSize, totalCount, currentPage);
			
			param.setStartNo(addressBookList.getStartNo());
			param.setEndNo(addressBookList.getEndNo());
			
			addressBookList.setList((ArrayList<EmpVO>) mapper.selectByMultiEmp(param));			
		}
		
		model.addAttribute("AddressBookList", addressBookList);
		model.addAttribute("currentPage", currentPage);

		return "team/address_book_view";
	}
	
//	=============================== 실시간 채팅 ==========================================	
	@RequestMapping("/chat.action")
	public String chat (HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "team/chat";
	}

//	=============================== 업무보고 ==========================================
	@RequestMapping("/report_list")
	public String report_list(HttpServletRequest request, Model model, ReportVO reportVO) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		HttpSession session = request.getSession();

		int pageSize = 10;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {	}

		String searchcategory = request.getParameter("searchcategory");
		String searchobj = request.getParameter("searchobj");

		if (searchobj != null) {
			session.setAttribute("searchcategory", searchcategory);
			searchobj = searchobj.trim().length() == 0 ? "" : searchobj;
			session.setAttribute("searchobj", searchobj);
		} else {
			searchcategory = (String) session.getAttribute("searchcategory");
			searchobj = (String) session.getAttribute("searchobj");
		}

		ReportList reportList = null;
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		
		// 검색 내용 없을 경우에 전체 글 목록 얻어오기
		if (searchobj == null || searchobj.trim().length() == 0) {

			int totalCount = mapper.selectReportCount();
			reportList = new ReportList(pageSize, totalCount, currentPage);

			hmap.put("startNo", reportList.getStartNo());
			hmap.put("endNo", reportList.getEndNo());

			reportList.setList(mapper.seletReportList(hmap));

		} else {  // 검색 내용 찾기
			
			reportVO.setSearchobj(searchobj);
			reportVO.setSearchcategory(searchcategory);

			int totalCount = mapper.selectCountSearch(reportVO);

			reportList = new ReportList(pageSize, totalCount, currentPage);

			reportVO.setStartNo(reportList.getStartNo());
			reportVO.setEndNo(reportList.getEndNo());

			reportList.setList(mapper.selectListSearch(reportVO));
		}

		session.setAttribute("searchcategory", null);
		session.setAttribute("searchobj", null);

		request.setAttribute("ReportList", reportList);
		request.setAttribute("currentPage", currentPage);
		return "team/report_view";
	}

	@RequestMapping("/report_content_list")
	public String report_content_list(HttpServletRequest request, HttpServletResponse response, Model model, @CookieValue(value = "coki") String coki, ReportVO vo) throws UnsupportedEncodingException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
	      
		int empno = ((EmpVO) session.getAttribute("EmpVO")).getEmpno();

		int idx = Integer.parseInt(request.getParameter("idx"));
		currentPage = Integer.parseInt(request.getParameter("currentPage"));

		// =============쿠키 ==============
		if (!coki.contains("_idx" + String.valueOf(idx) + "_empno" + String.valueOf(empno) + "_")) {
			coki += "_idx" + request.getParameter("idx") + "_empno" + empno + "_";
			mapper.increment_hit(idx);
			// 한글, 세미콜론, 콤마, 이콜 사인, 공백은 쿠키 값으로 이용될 수 없기 떄문에 쿠키 추가전에 인코딩
			coki = URLEncoder.encode(coki, "utf-8"); 
			response.addCookie(new Cookie("coki", coki));
		}
		// =============쿠키 ==============

		vo = mapper.selectReportByIdx(vo.getIdx());

		model.addAttribute("ReportVO", vo);
		model.addAttribute("currentPage", currentPage);

		return "team/report_content_view";
	}

	@RequestMapping("/report_service")
	public String report_service(HttpServletRequest request, HttpServletResponse response, Model model, ReportVO reportVO) throws IOException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		int mode = Integer.parseInt(request.getParameter("mode"));

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			model.addAttribute("currentPage", currentPage);
		} catch (Exception e) {
		}

		if (mode == 1) {
			return "team/report_insert";
		}

		if (mode == 2) {

			int idx = Integer.parseInt(request.getParameter("idx"));
			reportVO = mapper.selectReportByIdx(idx);
			request.setAttribute("ReportVO", reportVO);
			return "team/report_update";

		} else if (mode == 3) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			mapper.deleteReport(reportVO);
			
			out.println("<script>alert('삭제 완료')</script>");
			out.println("<script>location.href='report_list?currentPage=1'</script>");
			out.flush();

		}

		return "./error";
	}

	@RequestMapping("/report_updateOK")
	public void report_updateOK(MultipartHttpServletRequest request, HttpServletResponse response, Model model,	ReportVO reportVO) throws IOException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {	}
		
		String rootUploarDir = "D:" + File.separator + "upload"; // 업로드하는 파일이 저장될 디렉토리
		File dir = new File(rootUploarDir);
		UUID uuid = UUID.randomUUID();

		if (!dir.exists()) {
			dir.mkdir();
		}

		Iterator<String> iterator = request.getFileNames();
		MultipartFile multipartFile = null;
		String realfilename = ""; // 실제 업로드 파일명
		String attachedfile = ""; // 원본 파일명

		while (iterator.hasNext()) {
			realfilename = iterator.next(); // 실제 업로드 파일명
			multipartFile = request.getFile(realfilename);
			attachedfile = multipartFile.getOriginalFilename();

			if (attachedfile != null && attachedfile.length() != 0) {
				try {
//					MultipartFile 인터페이스 객체에서 transferTo() 메소드로 파일을 File 객체로 만들어 업로드 한다.
					multipartFile.transferTo(new File(dir + File.separator + uuid.toString() + "_" + attachedfile));
					reportVO.setAttachedfile(attachedfile);
					reportVO.setRealfilename(uuid.toString() + "_" + attachedfile);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		if (reportVO.getTitle() != null && reportVO.getTitle().length() != 0 && reportVO.getContent() != null && reportVO.getContent().length() != 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			mapper.updateReport(reportVO);
			model.addAttribute("idx", idx);
			model.addAttribute("currentPage", currentPage);
			out.println("<script>alert('업로드 완료')</script>");
			out.println("<script>location.href='report_content_list?idx=" + idx + "&currentPage=" + currentPage + "'</script>");
			out.flush();
		} else if (reportVO.getTitle() == null || reportVO.getTitle().length() == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('제목을 입력하세요')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (reportVO.getContent() == null || reportVO.getContent().length() == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('내용을 입력하세요')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		}
	}

	@RequestMapping("/report_insertOK")
	public void report_insertOK(MultipartHttpServletRequest request, Model model, ReportVO reportVO, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession();
		reportVO.setEmpno(((EmpVO) session.getAttribute("EmpVO")).getEmpno());
		
		String rootUploarDir = "D:" + File.separator + "upload"; // 업로드하는 파일이 저장될 디렉토리
		File dir = new File(rootUploarDir);
		int	currentPage = 1;
		UUID uuid = UUID.randomUUID();

//	      업로드 디렉토리가 존재하지 않을 경우 업로드 디렉토리를 만든다.
//	      File 클래스 객체 dir에 디렉토리가 존재하지 않을 경우 mkdirs() 메소드로 디렉토리를 만든다.
		if (!dir.exists()) {
			dir.mkdir();
		}

//	      업로드 되는 파일 정보 수집
		Iterator<String> iterator = request.getFileNames();
		MultipartFile multipartFile = null;
		String realfilename = ""; // 실제 업로드 파일명
		String attachedfile = ""; // 원본 파일명

		while (iterator.hasNext()) {
			realfilename = iterator.next(); // 실제 업로드 파일명
			multipartFile = request.getFile(realfilename);
			attachedfile = multipartFile.getOriginalFilename();

			if (attachedfile != null && attachedfile.length() != 0) {
				try {
//	               MultipartFile 인터페이스 객체에서 transferTo() 메소드로 파일을 File 객체로 만들어 업로드 한다.
					multipartFile.transferTo(new File(dir + File.separator + uuid.toString() + "_" + attachedfile)); // C:/Upload/orgFileName, transferTo()로 원하는 위치에 저장
					reportVO.setAttachedfile(attachedfile);
					reportVO.setRealfilename(uuid.toString() + "_" + attachedfile);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		if (reportVO.getTitle() != null && reportVO.getTitle().length() != 0 && reportVO.getContent() != null && reportVO.getContent().length() != 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			mapper.insertReport(reportVO);

			model.addAttribute("currentPage", currentPage);
			out.println("<script>alert('업로드 완료')</script>");
			out.println("<script>location.href='report_list'</script>");
			out.flush();

		} else if (reportVO.getTitle() == null || reportVO.getTitle().length() == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('제목을 입력하세요')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (reportVO.getContent() == null || reportVO.getContent().length() == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('내용을 입력하세요')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		}
	}

}