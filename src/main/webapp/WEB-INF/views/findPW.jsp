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
			<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">비밀번호 찾기</label>
			<div class="login-form">
			<form id="frm" method="post" action="findPW">
				<!-- 사원번호 -->
				<div class="sign-up-htm">
					<div class="group">
						<label for="empno" class="label">사원번호(ID)</label>
							<input
								  id="empno"
								  class="input"
								  type="text"
								  name="empno" 
								  maxlength="5"
								  placeholder="사원번호(ID) 5자리를 입력하세요."
								  autocomplete="off"
							/>
					</div>
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
					
					
 					<!-- 비밀번호 찾기 버튼 -->
	 				<div class="group">
		 				<!-- <button id="error" class="button" type="submit">비밀번호 찾기</button> -->
		 				<input id="back" class="button" type="button" value="비밀번호 찾기" onclick="goToCheckPW()"/>
 						<input id="back" class="button" type="button" value="아이디 찾기" onclick="location.href='findIDpage'"/>
	 				</div>
 				</div>
			</form>
		    	<div class="hr"></div>
       			<div class="foot-lnk">
        			<div class="group">
	        			<label for="empno" class="label">임시 비밀번호</label>
 	        			<c:if test="${empVO.empno != null}">
 						<script type="text/javascript">alert("임시비밀번호로 변경되었습니다. \n ${empVO.password}")</script>
							<input
								  id="back"
								  class="button outputId"
								  type="button"
								  name="temporaryPassword" 
								  maxlength="5"
								  readonly="readonly"
 								  value="임시 비밀번호 : ${empVO.password}"
								  autocomplete="off"
							/>
 						</c:if>
 	        			<c:if test="${empVO.empno == null}">
							<input
								  id="back"
								  class="button outputId"
								  type="button"
								  name="temporaryPassword" 
								  maxlength="5"
								  readonly="readonly"
								  value="-"
								  autocomplete="off"
							/>
 						</c:if>
					</div>
       				<label for="tab-1"><a href="login">Go to Login</a></label>
       			</div>
			</div>
		</div>
	</div>
  
</body>
</html>