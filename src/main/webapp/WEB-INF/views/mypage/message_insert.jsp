<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="./js/register.js"></script>
	<%@ include file="../includes/head.jsp" %>
</head>

<body>

	<!-- haeder -->
	<%@ include file="../includes/header.jsp" %>

	<!-- contents start -->
	<div class="tjcontainer">
	
		<!-- menu list -->	
		<%@ include file="../includes/menu_bar.jsp" %>
		
		<!-- main -->
		<div class="con_middle">
			<div class="nav">
				<ul>
					<li><a href="${path}/main"><img src="${path}/images/home.png" alt="home"
							width="18px"></a>&#62;</li>
					<li><a href="${path}/myinfo_view">마이페이지</a>&#62;</li>
					<li><a href="${path}/message_receive_view">쪽지함</a>&#62;</li>
					<li><a href="#">쪽지 쓰기</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<div class="content">
				<div align="center">
					<h3>쪽지 보내기</h3>
				</div>
				<form id="frm" action="${path}/transMessage" method="post" enctype="multipart/form-data">
					<input type="hidden" name="transempno" value="${EmpVO.empno}">
					<table style="width: 800px;">
					   <tr>
					      <th>받는 사람</th>
					      <td><input id="receiveempno" name="receiveempno" type="text" placeholder="숫자(사원번호)만 입력하세요"/></td>
					   </tr>
					   <tr>
					      <th>제목</th>
					      <td><input id="title" name="title" type="text"/></td>
					   </tr>
					   <tr>
					      <th>내용</th>
					      <td><textarea id="content" name="content" rows="10"></textarea></td>
					   </tr>
					   <tr>
					      <th>첨부파일</th>
					      <td><input id="filename" type="file" name="filename" /></td></td>
					   </tr>
					
					   <tr>
					      <td class="bottonBtn" colspan="2" align="right">
					         <input id="back" class="button" type="button" value="전송" onclick="goToCheckReceiver()"/>
					      </td>
					   </tr>       
				   </table>
				</form>
				<table style="width: 800px;">
					<tr>
						<td colspan="2" align="right"><input type="button"
							value="돌아가기" onclick="location.href = document.referrer;" /></td>
					</tr>
				</table>
			</div>
			<!-- =================================contents================================================= -->
		
		</div>
		<!-- main -->
		
		<!-- right -->
		<%@ include file="../includes/con_right.jsp" %>
		
	</div>
	<!-- contents end -->
	
	<!-- footer -->
	<%@ include file="../includes/footer.jsp" %>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/todoModal.jsp" %>

</body>

</html>