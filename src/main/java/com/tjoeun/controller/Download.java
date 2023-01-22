package com.tjoeun.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Download {

	@RequestMapping("/Download")
	public void download(HttpServletResponse response, HttpServletRequest request) {

		String path = "D:\\upload\\";
		String filename = request.getParameter("filename");
		File file = new File(path + filename);

		byte b[] = null;

		try {
			b = FileUtils.readFileToByteArray(file);
			response.setContentType("application/download");
			response.setContentLength(b.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " "));
		} catch (IOException e) {
			e.printStackTrace();
		}

		response.setHeader("Content-Transfer-Encoding", "binary");
		try {
			response.getOutputStream().write(b);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
