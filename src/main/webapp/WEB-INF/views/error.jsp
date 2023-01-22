<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="./includes/head.jsp" %>
</head>

<body>

	<!-- haeder -->
	<header>
		<c:if test="${EmpVO.empno == null}"><c:redirect url="./login"></c:redirect> </c:if>
		<c:if test="${EmpVO.deptno == 500}"><c:set var="deptname" value="경영지원부"></c:set></c:if>
		<c:if test="${EmpVO.deptno == 400}"><c:set var="deptname" value="IT부"></c:set></c:if>
		<c:if test="${EmpVO.deptno == 300}"><c:set var="deptname" value="상품개발부"></c:set></c:if>
		<c:if test="${EmpVO.deptno == 200}"><c:set var="deptname" value="마케팅부"></c:set></c:if>
		<c:if test="${EmpVO.deptno == 100}"><c:set var="deptname" value="영업부"></c:set></c:if>
		<h1>
			<a href="${path}/main">TJ INTRANET</a>
		</h1>
		<ul>
			<li>
				${deptname} / ${EmpVO.name}&lpar;${EmpVO.deptno}&rpar; <a href="${path}/logout"> 로그아웃</a><a href="#"> 시간연장</a>
			</li>
		</ul>
	</header>

	<!-- contents start -->
	<div class="tjcontainer">

		<!-- menu list -->
		<%@ include file="./includes/menu_bar.jsp"%>

		<!-- main -->
		<div class="con_middle">
			<div class="nav"></div>
			<!-- =================================contents================================================= -->
			<div align="center">
				<h1 style="line-height: 600px">잘못된 접근입니다.</h1>
			</div>
			<!-- =================================contents================================================= -->
		</div>
		<!-- main -->

	</div>
	<!-- contents end -->

	<!-- footer -->
	<%@ include file="./includes/footer.jsp"%>

</body>

</html>