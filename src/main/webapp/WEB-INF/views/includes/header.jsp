<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<header>
	
		<c:if test="${EmpVO.empno == null}"><c:redirect url="${path}/login"></c:redirect> </c:if>
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
				${deptname} / ${EmpVO.name}&lpar;${EmpVO.empno}&rpar;
			</li>
		</ul>
		
	</header>

</body>
</html>