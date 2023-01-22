<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
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
                    <li><a href="${path}/mypage/myinfo_view">마이페이지</a>&#62;</li>
                    <li><a href="${path}/mypage/todo_view">오늘 할 일</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="content">		
           		<div class="todo_view">
           			<div>
           				<h2>TODO</h2>
           			</div>
           			<div class="todo_view_area">
           				<c:if test="${todoList.list.size() != 0}">
							<c:forEach var="vo" items="${todoList.list}">
								<div id="todo_view_div${vo.idx}">
									<c:if test="${vo.status == false}">
										<input id="${vo.idx}status1" type="checkbox" onclick="updatestatus(${vo.idx},${EmpVO.empno},1)"/>
									</c:if>
									<c:if test="${vo.status != false}">
										<input id="${vo.idx}status1" type="checkbox" checked="checked" onclick="updatestatus(${vo.idx},${EmpVO.empno},1)"/>
									</c:if>
									<h5 style="background: ${vo.colorcode}">${vo.content}</h5>
									<div>
										<div class="imghover">
											<img src="${path}/images/edit.png" onclick="openUpdateTodo(${vo.idx},'${vo.content}','${vo.colorcode}','${vo.shareset}')">
											<img src="${path}/images/edithover.png">
										</div>
									</div>
									<div style="margin-left: 30px;">
										<div class="imghover">
											<img src="${path}/images/trash.png" onclick="deletetodo(${vo.idx})">
											<img src="${path}/images/trashhover.png">
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
           			</div>
           		</div>
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
	
	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/updateTodoModal.jsp" %>

</body>

</html>