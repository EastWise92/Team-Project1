<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/head.jsp"%>
</head>

<body>

	<!-- haeder -->
	<%@ include file="../includes/header.jsp"%>

	<!-- contents start -->
	<div class="tjcontainer">

		<!-- menu list -->
		<%@ include file="../includes/menu_bar.jsp"%>

		<!-- main -->
		<div class="con_middle">
			<div class="nav">
				<ul>
					<li><a href="${path}/main"><img
							src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
					<li><a href="report_list">팀 커뮤니티</a>&#62;</li>
					<li><a href="report_list">업무 보고</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<div class="content">
				<c:set var="vo" value="${ReportVO}"></c:set>
				<div style="height: auto;">
					<table style="width: 900px; margin: auto;">

						<form action="report_insertOK" method="post" enctype="multipart/form-data">
							<tr height="50px">
								<th colspan="2" style="font-size: 25px; text-align: center; color: #333333">업무보고</th>
							</tr>

							<tr>
								<td>작성자</td>
								<td>
									<input id="name" type="text" name="name" value="${EmpVO.name}" style="width: 150px;" readonly />
								</td>
							</tr>

							<tr>
								<td>보고서</td>
								<td><select id="type" name="type" style="width: 150px;">
										<option value="일일 보고서">일일 보고서</option>
										<option value="주간 보고서">주간 보고서</option>
										<option value="일일 보고서">일일 표고버섯</option>
								</select></td>
							</tr>

							<tr>
								<td>제목</td>
								<td><input id="title" type="text" name="title" /></td>
							</tr>

							<tr>
								<td>내용</td>
								<td><textarea id="content" name="content" rows="15"></textarea></td>
							</tr>

							<tr>
								<td>첨부</td>
								<td><input type="file" name="filename" /></td>
							</tr>

							<tr>
								<td colspan="2" align="right">
									<input type="reset" value="다시쓰기" /> 
									<input type="submit" value="저장하기" />
								</td>
							</tr>

							<input id="attachedfile" type="hidden" name="attachedfile" value="${BoardVO.attachedfile}"/>
							<input id="realfilename" type="hidden" name="realfilename" value="${BoardVO.realfilename}"/>

						</form>
					</table>
				</div>
				<table class="write_back_btn" style="margin-top:10px;">
					<tr>
						<td colspan="2" align="right"><input type="button"
							value="돌아가기"
							onclick="location.href='report_list?currentPage=${currentPage}'" />
						</td>
					</tr>
				</table>
			</div>
			<!-- =================================contents================================================= -->
		</div>
		<!-- main -->

		<!-- right -->
		<%@ include file="../includes/con_right.jsp"%>

	</div>
	<!-- contents end -->

	<!-- footer -->
	<%@ include file="../includes/footer.jsp"%>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/insertTodoModal.jsp"%>

</body>

</html>