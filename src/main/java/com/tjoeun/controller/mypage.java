package com.tjoeun.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.BoardList;
import com.tjoeun.vo.BoardVO;
import com.tjoeun.vo.EmpVO;
import com.tjoeun.vo.MessageList;
import com.tjoeun.vo.MessageVO;
import com.tjoeun.vo.Param;

@Controller
@RequestMapping("/mypage")
public class mypage {

	private static final Logger logger = LoggerFactory.getLogger(mypage.class);

	AbstractApplicationContext CTX = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
	Param param = CTX.getBean("param", Param.class);

	private int currentPage = 1;

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/myinfo_view")
	public String myinfo_view(HttpServletRequest request, Model model) {

		return "mypage/myinfo_view";
	}

	@RequestMapping("/mywrite_view")
	public String mywrite_view(HttpServletRequest request, Model model) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		HttpSession session = request.getSession();
		EmpVO vo = (EmpVO) session.getAttribute("EmpVO");

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {

		}

		int PageSize = 10;

		int totalCount = mapper.mywrite_selectCount(vo.getEmpno());

		BoardList boardlist = new BoardList(PageSize, totalCount, currentPage);

		HashMap<String, Integer> myhmap = new HashMap<String, Integer>();
		myhmap.put("startNo", boardlist.getStartNo());
		myhmap.put("endNo", boardlist.getEndNo());
		myhmap.put("empno", vo.getEmpno());

		boardlist.setList(mapper.mywrite_selectList(myhmap));

		model.addAttribute("BoardList", boardlist);

		return "mypage/mywrite_view";
	}

	// ?????? ??? ??? ??????
		@RequestMapping("/mywrite_content_view")
		public String mywrite_content_view(HttpServletRequest request, Model model) {
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

			int idx = Integer.parseInt(request.getParameter("idx"));

			BoardVO boardvo = mapper.selectContentByIdx(idx);

			model.addAttribute("BoardVO", boardvo);
			model.addAttribute("enter", "\r\n");

			return "mypage/mywrite_content_view";
		}
		// ??? ??????
		@RequestMapping("/mywrite_delete")
		public String contentdelete(HttpServletRequest request, Model model) {
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			int idx = Integer.parseInt(request.getParameter("idx"));
			BoardVO vo = mapper.selectContentByIdx(idx);
			mapper.contentdelete(vo);
			
			HttpSession session = request.getSession();
			EmpVO mo = (EmpVO) session.getAttribute("EmpVO");
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) {

			}

			int PageSize = 10;

			int totalCount = mapper.mywrite_selectCount(mo.getEmpno());

			BoardList boardlist = new BoardList(PageSize, totalCount, currentPage);

			HashMap<String, Integer> myhmap = new HashMap<String, Integer>();
			myhmap.put("startNo", boardlist.getStartNo());
			myhmap.put("endNo", boardlist.getEndNo());
			myhmap.put("empno", mo.getEmpno());

			boardlist.setList(mapper.mywrite_selectList(myhmap));

			model.addAttribute("BoardList", boardlist);
			
			
			return "mypage/mywrite_view";
		}
		
		// ??? ?????? ??? ??????
		@RequestMapping("/mywrite_update")
		public String board_update(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

			int idx = Integer.parseInt(request.getParameter("idx"));

			BoardVO boardvo = mapper.selectContentByIdx(idx);
			
			String category = request.getParameter("category");
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("BoardVO", boardvo);
			model.addAttribute("enter", "\r\n");
			
			if (category.equals("?????? ?????????")) {
				/* return "board/freeboard_update"; */
				return "mypage/mywrite_update";
			} else if (category.equals("????????????")) {
				/* return "board/noticeboard_update"; */
				return "mypage/mywrite_update";
			} else if (category.equals("?????????")) {
				/* return "board/databoard_update"; */
				return "mypage/mywrite_update";
			} else if (category.equals("??? ?????????")) {
				/* return "team/teamboard_update"; */
				return "mypage/mywrite_update";
			}else {
				response.setContentType("text/html; charset=euc-kr");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('QNA??? ????????? ??? ????????????.'); </script>");
				out.println("<script>history.back(-1);</script>");
				out.flush();
				return "board/QNAboard_view";
			}
		}
		// ??? ??????
		@RequestMapping("/mywrite_updateOK")
		public String mywrite_updateOK(HttpServletRequest request, Model model, BoardVO vo) {
			MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
			mapper.boardupdate(vo);
			
			model.addAttribute("idx", vo.getIdx());
			model.addAttribute("currentPage", request.getParameter("currentPage"));
			model.addAttribute("category", request.getParameter("category"));
			
			return "redirect:mywrite_content_view";
		}

	// ?????? ??????
	@RequestMapping("/message_receive_view")
	public String message_receive_view(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		
		EmpVO vo = (EmpVO) session.getAttribute("EmpVO");
		String searchcategory = request.getParameter("searchcategory");
		String searchobj = request.getParameter("searchobj");
		
		currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {

		}

		int pageSize = 8;
		int noreadCount = mapper.noreadCount(vo.getEmpno());
		int recieveCount = mapper.receiveMessageSelectCount(vo.getEmpno());
		
		if (searchobj != null) { 
			session.setAttribute("searchcategory", searchcategory);
			searchobj = searchobj.trim().length() == 0 ? "" : searchobj;
			session.setAttribute("searchobj", searchobj);
		} else { 
			searchcategory = (String) session.getAttribute("searchcategory");
			searchobj = (String) session.getAttribute("searchobj");
		}

		MessageList messageList = null;

		// ?????? ?????? ?????? ????????? ?????? ??? ?????? ????????????
		if (searchobj == null || searchobj.trim().length() == 0) { 

			int totalCount = mapper.receiveMessageSelectCount(vo.getEmpno());

			messageList = new MessageList(pageSize, totalCount, currentPage);

			param.setEmpno(vo.getEmpno());
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());

			messageList.setList(mapper.receiveMessageSelectList(param));
			
		} else { // ?????? ?????? ??????

			param.setSearchobj(searchobj);
			param.setSearchcategory(searchcategory);
			param.setEmpno(vo.getEmpno());

			int totalCount = mapper.selectReceiveMessageCountMulti(param);

			messageList = new MessageList(pageSize, totalCount, currentPage);
			
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());
			
			messageList.setList(mapper.selectReceiveMessageListMulti(param));
			
		}
		
		model.addAttribute("recieveCount",recieveCount);
		model.addAttribute("Read",noreadCount);
		model.addAttribute("MessageList", messageList);
		
		return "mypage/message_receive_view";
	}
		
			
		
	// ?????? ??????
	@RequestMapping("/message_send_view")
	public String message_send_view(HttpServletRequest request, Model model) {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		EmpVO vo = (EmpVO) session.getAttribute("EmpVO");
		
		String searchcategory = request.getParameter("searchcategory");
		String searchobj = request.getParameter("searchobj");
		
		currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {
			
		}
		
		int pageSize = 8;
		int noreadCount = mapper.noreadCount(vo.getEmpno());
		int recieveCount = mapper.receiveMessageSelectCount(vo.getEmpno());
		
		if (searchobj != null) { 
			session.setAttribute("searchcategory", searchcategory);
			searchobj = searchobj.trim().length() == 0 ? "" : searchobj;
			session.setAttribute("searchobj", searchobj);
		} else { 
			searchcategory = (String) session.getAttribute("searchcategory");
			searchobj = (String) session.getAttribute("searchobj");
		}
		
		MessageList messageList = null;
		
		// ?????? ?????? ?????? ????????? ?????? ??? ?????? ????????????
		if (searchobj == null || searchobj.trim().length() == 0) { 
			
			int totalCount = mapper.sendMessageSelectCount(vo.getEmpno());
			
			messageList = new MessageList(pageSize, totalCount, currentPage);
			
			param.setEmpno(vo.getEmpno());
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());
			
			messageList.setList(mapper.sendMessageSelectList(param));
			
		} else { // ?????? ?????? ??????
			
			param.setSearchobj(searchobj);
			param.setSearchcategory(searchcategory);
			param.setEmpno(vo.getEmpno());
			
			int totalCount = mapper.selectSendMessageCountMulti(param);
			
			messageList = new MessageList(pageSize, totalCount, currentPage);
			
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());
			
			messageList.setList(mapper.selectSendMessageListMulti(param));
			
		}
		
		
		model.addAttribute("recieveCount",recieveCount);
		model.addAttribute("Read",noreadCount);
		model.addAttribute("MessageList", messageList);
		return "mypage/message_send_view";
	}
		
		
	// ?????????
	@RequestMapping("/message_trash_view")
	public String message_trash_view(HttpServletRequest request, Model model) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		HttpSession session = request.getSession();
		
		EmpVO vo = (EmpVO) session.getAttribute("EmpVO");
		String searchcategory = request.getParameter("searchcategory");
		String searchobj = request.getParameter("searchobj");
		
		currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {
			
		}
		
		int pageSize = 8;
		int noreadCount = mapper.noreadCount(vo.getEmpno());
		int recieveCount = mapper.receiveMessageSelectCount(vo.getEmpno());
		
		if (searchobj != null) { 
			session.setAttribute("searchcategory", searchcategory);
			searchobj = searchobj.trim().length() == 0 ? "" : searchobj;
			session.setAttribute("searchobj", searchobj);
		} else { 
			searchcategory = (String) session.getAttribute("searchcategory");
			searchobj = (String) session.getAttribute("searchobj");
		}
		
		MessageList messageList = null;
		
		// ?????? ?????? ?????? ????????? ?????? ??? ?????? ????????????
		if (searchobj == null || searchobj.trim().length() == 0) { 
			
			int totalCount = mapper.trashMessageSelectCount(vo.getEmpno());
			
			messageList = new MessageList(pageSize, totalCount, currentPage);
			
			param.setEmpno(vo.getEmpno());
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());
			
			messageList.setList(mapper.trashMessageSelectList(param));
			
		} else { // ?????? ?????? ??????
			
			param.setSearchobj(searchobj);
			param.setSearchcategory(searchcategory);
			param.setEmpno(vo.getEmpno());
			
			int totalCount = mapper.selectTrashMessageCountMulti(param);
			
			messageList = new MessageList(pageSize, totalCount, currentPage);
			
			param.setStartNo(messageList.getStartNo());
			param.setEndNo(messageList.getEndNo());
			
			messageList.setList(mapper.selectTrashMessageListMulti(param));
		}
		
		model.addAttribute("recieveCount",recieveCount);
		model.addAttribute("Read",noreadCount);
		model.addAttribute("MessageList", messageList);
		
		return "mypage/message_trash_view";
	}
		
	// ?????? ??? ??????
	@RequestMapping("/message_content_list")
	public String message_content_list(HttpServletRequest request, Model model) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));

		MessageVO messageVO = mapper.messageSelectByIdx(idx);

		model.addAttribute("divs", request.getParameter("divs"));
		request.setAttribute("currentPage", Integer.parseInt(request.getParameter("currentPage")));
		request.setAttribute("MessageVO", messageVO);
		request.setAttribute("enter", "\r\n");
		
		return "mypage/message_content_view";
	}
		
	// ?????? ??????????????? ??? ??????(status ??????)
	@RequestMapping("/read_message_content_list")
	public String read_message_content_list(HttpServletRequest request, Model model) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		MessageVO messageVO = mapper.messageSelectByIdx(idx);
		mapper.updateStatus(idx);
		
		model.addAttribute("divs", request.getParameter("divs"));
		request.setAttribute("currentPage", Integer.parseInt(request.getParameter("currentPage")));
		request.setAttribute("MessageVO", messageVO);
		request.setAttribute("enter", "\r\n");
		
		
		return "mypage/message_content_view";
	}
		
	// ?????? ????????????
	@RequestMapping("/message_service")
	public String mailboxes_service(HttpServletRequest request, Model model, MessageVO meo) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
				
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		if(mode == 2){ // ?????? ??????
			
			mapper.messageGoTrash(meo);
			return "redirect:message_receive_view";
			
		}else if(mode == 3){ // ?????? ??????
			
			mapper.messageRestore(meo);
			return "redirect:message_trash_view";
			
		}else if(mode == 4){ // ?????? ?????????
			
			mapper.messageDelete(meo);
			return "redirect:message_trash_view";

		}
		
		return "error";
	}
	
	@RequestMapping("/message_insert")
	public String mailboxes_insert(HttpServletRequest request, Model model) {
		return "mypage/message_insert";
	}

	// ?????? ??????
	@RequestMapping("/transMessage")
	public void transMessage(MultipartHttpServletRequest request, HttpServletResponse response, Model model, MessageVO vo) throws IOException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String receiver = request.getParameter("receiver");
		try {
			int empno = Integer.parseInt(receiver.split("[\\(\\)]")[1]);
			vo.setReceiveempno(empno);
		} catch (NullPointerException e) {

		}

		String rootUploarDir = "D:" + File.separator + "upload"; // ??????????????? ????????? ????????? ????????????
		File dir = new File(rootUploarDir);
		UUID uuid = UUID.randomUUID();

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// ????????? ??????????????? ???????????? ?????? ?????? ????????? ??????????????? ?????????.
		// File ????????? ?????? dir??? ??????????????? ???????????? ?????? ?????? mkdirs() ???????????? ??????????????? ?????????.
		if (!dir.exists()) {
			dir.mkdir();
		}

		// ????????? ?????? ?????? ?????? ??????
		Iterator<String> iterator = request.getFileNames();
		MultipartFile multipartFile = null;
		String realfilename = ""; // ?????? ????????? ?????????
		String attachedfile = ""; // ?????? ?????????

		while (iterator.hasNext()) {
			realfilename = iterator.next(); // ?????? ????????? ?????????
			multipartFile = request.getFile(realfilename);
			attachedfile = multipartFile.getOriginalFilename();
			
			if (attachedfile != null && attachedfile.length() != 0) {
				try {
					// MultipartFile ??????????????? ???????????? transferTo() ???????????? ????????? File ????????? ????????? ????????? ??????.
					// C:/Upload/orgFileName, transferTo()??? ????????? ????????? ??????
					multipartFile.transferTo(new File(dir + File.separator + uuid.toString() + "_" + attachedfile)); 
					vo.setAttachedfile(attachedfile);
					vo.setRealfilename(uuid.toString() + "_" + attachedfile);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		if (vo.getTitle() == null || vo.getTitle().length() == 0) {
			out.println("<script>alert('????????? ???????????????.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (vo.getContent() == null || vo.getContent().length() == 0) {
			out.println("<script>alert('????????? ???????????????.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (vo.getReceiveempno() == 0) {
			out.println("<script>alert('??????????????? ???????????????.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else {
			mapper.sendmessage(vo);
			out.println("<script>alert('?????? ??????');</script>");
			if (receiver == null) { // ????????? -> ?????? ???????????? ????????? ??????
				out.println("<script>location.href='message_send_view';</script>");
			} else { // ?????? ?????? ????????? ????????? ??????
				out.println("<script>history.back(-1);</script>");
			}
			out.flush();
		}

	}

	// ?????? ??? ???
	@RequestMapping("/todo_view")
	public String todo_view(HttpServletRequest request, Model model) {
		return "mypage/todo_view";
	}

}
