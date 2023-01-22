package com.tjoeun.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.dao.MyBatisDAO;
import com.tjoeun.vo.DateData;
import com.tjoeun.vo.TodoVO;

public class getCalendar {
	

	// 한달 필드를 생성하는 메소드
	public static List<DateData> month_info(DateData date, SqlSession sqlSession, TodoVO todo) {
		
		MyBatisDAO mapper = sqlSession.getMapper(MyBatisDAO.class);
		
		List<DateData> dateList = new ArrayList<DateData>();
		DateData calendarData;

		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(date.getYear()), Integer.parseInt(date.getMonth()), 1);

		int endDate = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 달의 마지막 날
		int start = cal.get(Calendar.DAY_OF_WEEK); // 시작 요일

		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
		SimpleDateFormat msdf = new SimpleDateFormat("M");

		int curr_year = Integer.parseInt(ysdf.format(todayCal.getTime()));
		int curr_month = Integer.parseInt(msdf.format(todayCal.getTime()));

		int today = -1;
		if (curr_year == Integer.parseInt(date.getYear()) && curr_month == Integer.parseInt(date.getMonth()) + 1) {
			SimpleDateFormat dsdf = new SimpleDateFormat("dd");
			today = Integer.parseInt(dsdf.format(todayCal.getTime()));
		}

		// 달력 앞 빈곳 빈 데이터 삽입
		for (int i = 1; i < start; i++) {
			calendarData = new DateData();
			dateList.add(calendarData);
		}

		// 날짜 삽입
		for (int i = 1; i <= endDate; i++) {
			if (i == today) {
				calendarData = new DateData(date.getYear(), date.getMonth(), i, "today", null);
			} else {
				calendarData = new DateData(date.getYear(), date.getMonth(), i, "normal_date", null);
			}

			int month = Integer.parseInt(date.getMonth()) + 1;

			// 공휴일 지정
			if (month == 1 && i == 1) {calendarData.setEvent("신정");} 
			else if (month == 3 && i == 1) {calendarData.setEvent("3.1절");} 
			else if (month == 5 && i == 1) {calendarData.setEvent("근로자의 날");} 
			else if (month == 5 && i == 5) {calendarData.setEvent("어린이 날");} 
			else if (month == 6 && i == 6) {calendarData.setEvent("현충일");} 
			else if (month == 8 && i == 15) {calendarData.setEvent("광복절");} 
			else if (month == 10 && i == 3) {calendarData.setEvent("개천절");} 
			else if (month == 10 && i == 9) {calendarData.setEvent("한글날");} 
			else if (month == 11 && i == 7) {calendarData.setEvent("창립기념일");} 
			else if (month == 12 && i == 25) {calendarData.setEvent("크리스마스");}
			
			month = Integer.parseInt(date.getMonth()) + 1;
			String setdate = date.getYear() + "-" + month + "-" + i;
			if (month < 10) {
				setdate = date.getYear() + "-0" + month + "-" + i;
			} 			
			if (i < 10) {
				setdate = date.getYear() + "-0" + month + "-0" + i;
			}
			
			todo.setSetdate(setdate);
			
			System.out.println(todo);

			if (todo.getShareset() == null || todo.getShareset().trim().length() == 0) {
				calendarData.setTodolist(mapper.caltodolist(todo));
			} else {
				calendarData.setTodolist(mapper.caltodolistShareset(todo));
			}
			dateList.add(calendarData);
		}

		// 달력 뒤 빈곳 빈 데이터 삽입
		int index = 7 - dateList.size() % 7;

		if (dateList.size() % 7 != 0) {

			for (int i = 0; i < index; i++) {
				calendarData = new DateData();
				dateList.add(calendarData);
			}
		}

		return dateList;
	}
	
}
