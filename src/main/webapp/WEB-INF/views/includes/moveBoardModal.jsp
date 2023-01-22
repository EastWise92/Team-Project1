<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/css/moveboard.css">
</head>
<body>

	<div class="moveboardback">
		<div class="moveboarddiv">
			<div class="top">
				<p class="top1">카테고리 이동</p>
				<p class="top2" onclick="closeMoveBoardPop()">X</p>
			</div>
			
			<div class="middle">
				<form action="${path}/moveboard" method="post">
					<input type="hidden" id="idxs">
					<table>
						<tr>
							<th>카테고리</th>
							<td>
								<select id="movecategory" >
									<option>자유 게시판</option>
									<option>자료실</option>
									<option>공지사항</option>
									<option>팀 게시판</option>
								</select>
							</td>
						</tr>
	
						<tr>
							<td colspan="2" align="right">
								<input type="button" value="닫기" onclick="closeMoveBoardPop()" /> 
								<input type="button" value="이동" id="moveboard" />
							</td>
						</tr>						
					</table>
				</form>
			</div>
		</div>
	</div>

</body>
</html>