<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
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
					<li><a href="${path}/mailboxes_receive_view">메일함</a>&#62;</li>
					<li><a href="#">메일 쓰기</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<div class="content">
				<div align="center">
					<h2>메일 작성</h2>
				</div>
				<form action="mailboxes_service?mode=1" method="post">
					<div style="height: 500px; margin-top: 50px;">
						<table style="width: 800px;">
							<tr>
								<th>받는 사람</th>
								<td><input id="receivemail" type="text" name="receivemail" /></td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input id="title" type="text" name="title" /></td>
							</tr>
							<tr>
								<th
									style="vertical-align: top; padding-top: 30px; box-sizing: border-box;">내용</th>
								<td><textarea id="content" name="content" rows="20"></textarea></td>
							</tr>
							<!-- 						<tr>
							<td>첨부</td>
							<td><input id="attachedfile" type="file" name="attachedfile" value="test" /></td>
						</tr> -->
							<tr>
								<td colspan="2" align="right"><input type="reset"
									value="다시쓰기" /> <input type="submit" value="전송하기" /></td>
							</tr>
						</table>

						<input id="transemail" type="hidden" name="transemail" value="${EmpVO.email}" /> 
						<input id="name" type="hidden" name="name" value="${EmpVO.name}" /> 
						<input id="empno" type="hidden" name="empno" value="${EmpVO.empno}" /> 
						<input id="deptno" type="hidden" name="deptno" value="${EmpVO.deptno}" />
					</div>
				</form>
				<table style="width: 800px;">
					<tr>
						<td colspan="2" align="right"><input type="button"
							value="돌아가기" onclick="history.back()" /></td>
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