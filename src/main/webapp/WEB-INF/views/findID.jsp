<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1조 팀프로젝트</title>
	<link rel="icon" href="./images/apple.png">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="./css/tjoeun_find.css" />
	<script type="text/javascript" src="./js/jquery-3.6.1.js"></script>
	<script type="text/javascript" src="./js/register.js"></script>
</head>
<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">아이디 찾기</label>
			<div class="login-form">
			<form method="post" action="findID">
				<!-- 이름 -->
				<div class="group">
					<label for="name" class="label">이름</label>
					<input
						  id="name"
						  class="input"
						  type="text"
						  name="name" 
						  placeholder="이름을 입력하세요"
						  autocomplete="off"
						  onkeyup="nameCheckFunction()"
					/>
					<!-- 이름 검사 -->
					<h5 id="nameCheckMessage" style="color: red; font-weight: bold;"></h5>
				</div>
				
				<!-- 성별 -->
				<div class="group">
					<label for="gender" class="label">성별</label>
					<div class="input" style="text-align: center; margin: 0 auto;">
						<div class="input" data-toggle="buttons">
							<label>
								<input id = "gender" type="radio" name="gender" value="M"/>남자
							</label>
							<label>
								<input id = "gender" type="radio" name="gender" value="F" checked="checked"/>여자
							</label>
						</div>
					</div>
				</div>
				
				<!-- 휴대폰번호 -->
				<div class="group">
					<label for="pernum" class="label">전화번호</label>
					<input
						  id="pernum"
						  class="input"
						  type="text"
						  name="pernum" 
						  placeholder="휴대폰번호를 입력하세요.(- 포함)"
						  autocomplete="off"
						  onkeyup="pernumCheckFunction()"
					/>
						<!-- 휴대폰번호 검사 -->
					<h5 id="pernumCheckMessage" style="color: red; font-weight: bold;"></h5>
				</div>
				
					<!-- 아이디찾기 버튼 -->
 				<div class="group">
					<button id="error" class="button" type="submit">아이디 찾기</button>
					<input id="back" class="button" type="button" value="돌아가기" onclick="location.href='login'"/>
 				</div>
 				</form>
 			    <div class="hr"></div>
 			    <form id="frm" action="findPWpage">
       			<div class="foot-lnk">
       				<div class="group">
					<label for="empno" class="label">사원번호(ID)</label>
					<c:if test="${empVO.empno != null}">
						<c:if test="${empVO.empno != 0}">
							<script type="text/javascript">alert("아이디를 찾았습니다. \n ID : ${empVO.empno}")</script>
						</c:if>
						<input
							  id="back"
							  class="button outputId"
							  type="button"
							  name="empno" 
							  maxlength="5"
							  value="사원번호(ID) : ${empVO.empno}"
							  autocomplete="off"
						/>
					</c:if>
					<c:if test="${empVO.empno == null}">
						<input
							  id="back"
							  class="button outputId"
							  type="button"
							  name="empno" 
							  maxlength="5"
							  readonly="readonly"
							  value="-"
							  autocomplete="off"
						/>
					</c:if>
					</div>
         				<!-- <p><label for="tab-1"><a href="#" onclick="goTofindPWpage">Find Password</a></label></p> -->
         				<p><label for="tab-1"><a href="goToFindPW">Find Password</a></label></p>
       			</div>
       			</form>
			</div>
		</div>
	</div>
</body>
</html>