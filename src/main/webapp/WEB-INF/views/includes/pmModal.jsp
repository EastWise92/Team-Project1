<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/css/pm.css">
</head>
<body>

	<div class="pmback">
		<div class="transpm">
			<div class="top">
				<p class="top1">쪽지 전송</p>
				<p class="top2" onclick="closePmPop()">X</p>
			</div>
			
			<div class="middle">
				<form action="${path}/mypage/transMessage" method="post" enctype="multipart/form-data">
					<input type="hidden" name="transempno" value="${EmpVO.empno}">
					<input id="attachedfile" type="hidden" name="attachedfile" value=""/>
					<input id="realfilename" type="hidden" name="realfilename" value=""/>
					<table>
						<tr>
							<th>받는 사람</th>
							<td><input id="pmreceiver" name="receiver" type="text" readonly/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input id="pmtitle" name="title" type="text"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="pmcontent" name="content" rows="10"></textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input id="pmfilename" type="file" name="filename" /></td></td>
						</tr>
	
						<tr>
							<td class="bottonBtn" colspan="2" align="right">
								<input type="button" value="닫기" onclick="closePmPop()" /> 
								<input type="submit" value="전송"/>
							</td>
						</tr>
						
					</table>
				</form>
			</div>
		</div>
	</div>

</body>
</html>