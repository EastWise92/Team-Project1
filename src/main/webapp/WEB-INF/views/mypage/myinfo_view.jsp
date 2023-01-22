<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
	<script src="../js/register.js" defer="defer"></script>
	<script src="../js/profile.js" defer="defer"></script>
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
					<li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
					<li><a href="#">마이페이지</a>&#62;</li>
					<li><a href="#">내정보</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<jsp:useBean id="date" class="java.util.Date" />
			<fmt:formatDate value="${EmpVO.hiredate}" pattern="yyyy-MM-dd" var="sdf1date" />
			<div class="content">

				<h1>안녕하세요 ${EmpVO.name}님.</h1>
				<table style="width: 700px;">
					<tr>
						<th>부서명</th>
						<c:if test="${EmpVO.deptno==100}"><c:set var="deptname" value="영업부"></c:set></c:if>
						<c:if test="${EmpVO.deptno==200}"><c:set var="deptname" value="마케팅부"></c:set></c:if>
						<c:if test="${EmpVO.deptno==300}"><c:set var="deptname" value="상품개발부"></c:set></c:if>
						<c:if test="${EmpVO.deptno==400}"><c:set var="deptname" value="IT부"></c:set></c:if>
						<c:if test="${EmpVO.deptno==500}"><c:set var="deptname" value="경영지원부"></c:set></c:if>
						<td>${deptname}</td>
					</tr>
					<tr>
						<th>직급</th>
						<td>${EmpVO.position}</td>
					</tr>
					<tr>
						<th>사원번호</th>
						<td>${EmpVO.empno}</td>
					</tr>
					<tr>
						<th>직통번호</th>
						<td>${EmpVO.incnum}</td>
					</tr>
					<tr>
						<th>입사일</th>
						<td>${sdf1date}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${EmpVO.email}</td>
					</tr>
					<tr>
						<th>고과점수</th>
						<td>5점</td>
					</tr>
				</table>
				<input type="button" class="changeBtn" name="pwchange" value="비밀번호 변경" onclick="changePop()">
				<%-- <input type="button" value="프로필 이미지 변경" onclick="openRegiProfile(${EmpVO.empno})"> --%>
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

	<!-- 비밀번호 변경 Modal -->
	<%@ include file="../includes/changePwModal.jsp" %>
	
	<!-- 프로필 이미지 변경 Modal -->
	<%@ include file="../includes/regiProfile.jsp" %>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/insertTodoModal.jsp" %>
	
</body>
</html>