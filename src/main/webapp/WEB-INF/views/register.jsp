<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1조 팀프로젝트</title>
	<link rel="icon" href="./images/apple.png">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="./css/tjoeun_register.css" />
	<script type="text/javascript" src="./js/jquery-3.6.1.js"></script>
	<script type="text/javascript" src="./js/register.js"></script>
</head>
<body>
	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
			<div class="login-form">
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
					<!-- 중복검사(button) -->
					<button class="check-btn" type="button" onclick="registerCheckFunction()">
						중복검사
					</button>
					<!-- 비밀번호(password1) -->
					<div class="group">
						<label for="password1" class="label">비밀번호</label>
						<input
							  id="password1"
							  class="input"
							  type="password"
							  name="password1"
							  maxlength="16"
							  placeholder="비밀번호(최대 16자리)를 입력하세요."
							  onkeyup="passwordCheckFunction()"
						/>
					</div>					
					<!-- 비밀번호 확인(password2) -->
					<div class="group">
						<label for="password2" class="label">비밀번호 확인</label>
						<input
							  id="password2"
							  class="input"
							  type="password"
							  name="password2" 
							  maxlength="16"
							  placeholder="비밀번호를 한번 더 입력하세요."
							  onkeyup="passwordCheckFunction()"
						/>
						<!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
						<h5 id="passwordCheckMessage" style="color: red; font-weight: bold;"></h5>
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
					
					<!-- 이메일 -->
					<div class="group">
						<label for="email" class="label">이메일</label>
						<input
							  id="email"
							  class="input"
							  type="text"
							  name="email"
							  placeholder="이메일을 입력하세요.(@ 포함)"
							  autocomplete="off"
							  onkeyup="emailCheckFunction()"
						/>
						<!-- 이메일 검사 -->
						<h5 id="emailCheckMessage" style="color: red; font-weight: bold;"></h5>
 					</div>
					
 					<!-- 가입요청 버튼 -->
	 				<div class="group">
 						<input id="error" class="button" type="button" value="가입요청" onclick="userRegister()"/>
 						<input id="back" class="button" type="button" value="돌아가기" onclick="location.href='login'"/>
	 				</div>
	 			    <div class="hr"></div>
        			<div class="foot-lnk">
          				<label for="tab-1"><a href="login">Already Member?</a></label>
        			</div>
						
				<input type="hidden" name="position" id="position"/>
				<input type="hidden" name=deptno id="deptno"/>
				<input type="hidden" name="hiredate" id="hiredate"/>
			</div>
		</div>
	</div>
</div>
  
</body>
</html>