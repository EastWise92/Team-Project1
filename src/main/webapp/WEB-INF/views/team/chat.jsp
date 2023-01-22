<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
    <script src="${path}/js/chat.js"></script>
</head>

<body>
	<!-- haeder -->
	<%@ include file="../includes/header.jsp" %>

	<!-- contents start -->
	<div class="tjcontainer">
	
		<!-- menu list -->	
		<%@ include file="../includes/menu_bar.jsp" %>
		
		<!-- main -->
        <div class="con_middle">
            <div class="nav">
                <ul>
                    <li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="#">팀 커뮤니티</a>&#62;</li>
                    <li><a href="chat.action">라이브 채팅</a></li>
                </ul>
            </div>
            
            <!-- =================================contents================================================= -->

			<div class="container">
				<h1 class="page-header">라이브 채팅</h1>

				<table class="table table-bordered">
					<tr>
						<td><input type="text" name="user" id="user"
							class="form-control" value="${EmpVO.name}" disabled="disabled"></td>
						<td>
							<button type="button" class="btn btn-default" id="btnConnect">연결</button>
							<button type="button" class="btn btn-default" id="btnDisconnect"
								disabled>종료</button>
						</td>
					</tr>
					<tr>
						<td colspan="2"><div id="list"></div></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" name="msg" id="msg"
							placeholder="대화 내용을 입력하세요." class="form-control" disabled></td>
					</tr>
				</table>
			</div>
			<!-- =================================contents================================================= -->
			
		</div>
		<!-- main -->
		
		<!-- right -->
		<%@ include file="../includes/con_right.jsp" %>
		
	</div>
	<!-- contents end -->
	
	<!-- footer -->
	<%@ include file="../includes/footer.jsp" %>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/insertTodoModal.jsp" %>

</body>
</html>