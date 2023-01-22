<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<body>

	<div class="con_left">
		<ul class="menu_box" style="height: 650px;">
			<li class="menu_under">
				<div class="menu">
					<span>게시판</span>
					<!-- <img src="images/menu_arrow.png" alt="arrow"> -->
				</div>
				<ul class="menuSub">
					<li><a href="${path}/board/move_board_list?category=자유 게시판">자유게시판</a></li>
					<li><a href="${path}/board/move_board_list?category=공지사항">공지사항</a></li>
					<li><a href="${path}/board/move_board_list?category=자료실">자료실</a></li>
					<li><a href="${path}/board/move_board_list?category=QNA&currentPage=1">Q&A</a></li>
					<li><a href="${path}/board/groupchart_main">조직도</a></li>
					<li><a href="${path}/board/meetroom_main">회의실</a></li>
				</ul>
			</li>
			<li class="menu_under">
				<div class="menu">
					<span>전자결재</span>
					<!-- <img src="images/menu_arrow.png" alt="arrow"> -->
				</div>
				<ul class="menuSub">
					<li><a href="${path}/approval/approvalMain">전자결재 홈</a></li>
				    <li>
				    	<span class="menu2">
							<a>양식작성</a>
						</span>
						<ul class="menuSub2">
			                <li><a href="${path}/approval/letterOfApproval">-품의서</a></li>
			                <li><a href="${path}/approval/expenseReport">-지출결의서</a></li>
			                <li><a href="${path}/approval/leaveApplication">-휴가신청서</a></li>
						</ul>		 
				    </li>				    
				    <li><a href="${path}/approval/approvalList">결재리스트</a></li>		
				    <li>
				    	<span class="menu2">
							<a>보관함</a>
						</span>
						<ul class="menuSub2">
				             <li><a href="${path}/approval/approvalList?approvalStatus=결재대기">-결재대기</a></li>
				             <li><a href="${path}/approval/approvalList?approvalStatus=결재중">-결재중</a></li>
				             <li><a href="${path}/approval/approvalList?approvalStatus=결재완료">-결재완료</a></li>
						</ul>		 
				    </li>	 		    			
				</ul>
			</li>
			<li class="menu_under">
				<div class="menu">
					<span>팀 커뮤니티</span>
				</div>
				<ul class="menuSub">
					<li><a href="${path}/board/move_board_list?category=팀 게시판&currentPage=1">팀 게시판</a></li>
					<!-- <li><a href="#">팀 일정</a></li> -->
					<li><a href="${path}/team/chat.action">라이브 채팅</a></li>
					<li><a href="${path}/team/move_address_book_list?currentPage=1">주소록</a></li>
					<li><a href="${path}/team/report_list?currentPage=1">업무보고</a></li>
				</ul>
			</li>
			<li class="menu_under">
				<div class="menu">
					<span>근태관리</span>
				</div>
				<ul class="menuSub">
					<li><a href="${path}/attend/move_attend_list">근태 조회</a></li>
					<li><a href="${path}/attend/move_left_dayoff_list">개인 연차 현황</a></li>
					<li><a href="${path}/attend/payslip">급여명세서</a></li>
				</ul>
			</li>
			<li class="menu_under">
				<div class="menu">
					<span>마이페이지</span>
				</div>
				<ul class="menuSub">
					<li><a href="${path}/mypage/myinfo_view">내정보</a></li>
					<li><a href="${path}/mypage/mywrite_view">내가 쓴 글</a></li>
					<li><a href="${path}/mypage/message_receive_view">쪽지함<c:if test="${noRead!=0}"><span style="font-size:12px;">(${noRead})</span></c:if></a>
					<li><a href="${path}/mypage/todo_view">오늘 할 일</a></li>
				</ul>
			</li>

		</ul>

		<c:if test="${EmpVO.permission eq 'YES'}">
			<div align="center">
				<button onclick="location.href='${path}/manager/Manager_Main'">관리자</button>
			</div>
		</c:if>
	</div>

</body>

</html>