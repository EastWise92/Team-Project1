<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="../css/passwordChange.css">
</head>
<body>

	<div class="background">
		<div class="pwchange">
			<form>
				<div class="change_top">
					<p class="top1">비밀번호 변경</p>
					<p class="top2" onclick="closePop()">X</p>
				</div>
				<table>
					<tr>
						<th>현재 비밀번호</th>
						<td><input id="checkPassword"
							class="checkPassword inputpassword" type="password"
							name="checkPassword" /></td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">비밀번호</th>
						<td colspan="2"><input id="password1"
							class="form-control inputpassword" type="password"
							name="password1" maxlength="16"
							placeholder="비밀번호(최대 16자리)를 입력하세요."
							onkeyup="passwordCheckFunction()" /></td>
					</tr>

					<!-- 비밀번호 확인(userPassword2) -->
					<tr>
						<th class="pwcheck" style="vertical-align: middle;">비밀번호 확인</th>
						<td colspan="2"><input id="password2"
							class="form-control inputpassword" type="password"
							name="password2" maxlength="16" placeholder="비밀번호를 한번 더 입력하세요."
							onkeyup="passwordCheckFunction()" /> <!-- 비밀번호 일치 검사 결과 메시지가 출력될 영역 -->
							<h5 id="passwordCheckMessage"
								style="color: red; font-weight: bold; font-size:12px;"></h5></td>
					</tr>
					<tr>
						<td class="bottonBtn" colspan="2" align="right"><input
							class="cancel" type="button" value="취소" onclick="closePop()" />
							<input class="change" type="button" value="변경"
							onclick="changePassword()" disabled="disabled" /></td>
					</tr>
				</table>
				<input id="password" type="hidden" value="${EmpVO.password}" name="password" /> 
				<input id="empno" type="hidden" value="${EmpVO.empno}" name="empno" />
			</form>
		</div>
	</div>

</body>
</html>