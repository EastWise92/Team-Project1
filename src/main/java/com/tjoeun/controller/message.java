package com.tjoeun.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.MessageVO;

@Controller
public class message {

	private static final Logger logger = LoggerFactory.getLogger(message.class);

	@Autowired
	private SqlSession sqlSession;

	// 쪽지 전송
	@RequestMapping("/transMessage")
	public void transMessage(MultipartHttpServletRequest request, HttpServletResponse response, Model model,
			MessageVO vo) throws IOException {

		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);

		String receiver = request.getParameter("receiver");
		try {
			int empno = Integer.parseInt(receiver.split("[\\(\\)]")[1]);
			vo.setReceiveempno(empno);
		} catch (NullPointerException e) {

		}

		String rootUploarDir = "D:" + File.separator + "upload"; // 업로드하는 파일이 저장될 디렉토리
		File dir = new File(rootUploarDir);
		
		// 업로드 디렉토리가 존재하지 않을 경우 업로드 디렉토리를 만든다.
		// File 클래스 객체 dir에 디렉토리가 존재하지 않을 경우 mkdirs() 메소드로 디렉토리를 만든다.
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		// 업로드 되는 파일 정보 수집
		Iterator<String> iterator = request.getFileNames();
		MultipartFile multipartFile = null;
		String realfilename = ""; // 실제 업로드 파일명
		String attachedfile = ""; // 원래 파일명
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		while (iterator.hasNext()) {
			realfilename = iterator.next(); // 실제 업로드 파일명
			multipartFile = request.getFile(realfilename);
			attachedfile = multipartFile.getOriginalFilename();
		}
		
		vo.setRealfilename(realfilename);
		vo.setAttachedfile(attachedfile);

		if (vo.getTitle() == null || vo.getTitle().length() == 0) {
			out.println("<script>alert('제목을 입력하세요.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (vo.getContent() == null || vo.getContent().length() == 0) {
			out.println("<script>alert('내용을 입력하세요.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		} else if (vo.getReceiveempno() == 0) {
			out.println("<script>alert('받는사람을 입력하세요.')</script>");
			out.println("<script>history.back(-1);</script>");
			out.flush();
		}else { 
			mapper.sendmessage(vo);
			out.println("<script>alert('전송 완료');</script>");
			if (receiver == null) { // 쪽지함 -> 쪽지 전송으로 넘어온 경우
				out.println("<script>location.href='message_send_view');</script>");
			} else {
				out.println("<script>history.back(-1);</script>");
			}
			out.flush();
		}

	}

}
