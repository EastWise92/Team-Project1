<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/css/profile.css">
</head>
<body>

	<div class="RegiProfileback">
		<div class="RegiProfile">
			<form action="${path}" method="post">
				<div class="change_top">
					<p class="top1">프로필 이미지 등록</p>
					<p class="top2" onclick="closeRegiProfile()">X</p>
				</div>
				<table>
					<tr>
						<td><input type="file" name="filename" /></td>
					</tr>
					<tr>
						<td class="bottonBtn" colspan="2" align="right">
							<input type="button" value="취소" onclick="closeRegiProfile()" /> 
							<input type="submit" value="수정" onclick="todoupdate()" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>