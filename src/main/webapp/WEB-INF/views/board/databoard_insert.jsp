<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
</head>

<body>

	<!-- haeder -->
	<%@ include file="../includes/header.jsp"%>

	<!-- contents start -->
	<div class="tjcontainer">

		<!-- menu list -->
		<%@ include file="../includes/menu_bar.jsp"%>

		<!-- content -->
		<div class="con_middle">
			<div class="nav">
				<ul>
					<li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
					<li><a href="board_list?category=자유 게시판">게시판</a>&#62;</li>
					<li><a href="board_list?category=자료실">자료실</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<div class="content">
				<div style="height: 610px">
					<table style="width: 900px; margin: auto;">

						<form action="data_upload" method="post" enctype="multipart/form-data">
							<tr height="50px">
								<th colspan="2" style="font-size: 25px; text-align: center; color: #333333">
									자료실 글쓰기
								</th>
							</tr>

							<tr>
								<th>제목</th>
								<td><input id="title" type="text" name="title" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea id="content" name="content" rows="20"></textarea></td>
							</tr>
							<tr>
								<th>첨부</th>
								<td><input type="file" name="filename" /></td>
							</tr>
							<tr>
								<td colspan="2" align="right">
									<input type="reset"value="다시쓰기" /> 
									<input type="submit" value="저장하기" />
								</td>
							</tr>

							<input id="name" type="hidden" name="name" value="${EmpVO.name}" />
							<input id="empno" type="hidden" name="empno" value="${EmpVO.empno}" /> 
							<input id="deptno" type="hidden" name="deptno" value="${EmpVO.deptno}" /> 
							<input id="category" type="hidden" name="category" value="자료실" />
							<input id="attachedfile" type="hidden" name="attachedfile" value=""/>
							<input id="realfilename" type="hidden" name="realfilename" value=""/>
						</form>
					</table>
				</div>
				<table class="write_back_btn" style="margin-top:10px;">
					<tr>
						<td colspan="2" align="right">
							<input type="button" value="돌아가기"
							onclick="location.href='board_list?currentPage=${currentPage}&category=자료실'" />
						</td>
					</tr>
				</table>
			</div>
			<!-- =================================contents================================================= -->

		</div>

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