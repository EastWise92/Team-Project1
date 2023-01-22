<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
	
	<script src="${path}/js/manager.js" defer="defer"></script>
</head>

<body>

	<!-- haeder -->
	<%@ include file="../includes/header.jsp" %>

    <!-- contents start -->
    <div class="tjcontainer">
    
        <!--menu list-->
        <%@ include file="./manager_menu_bar.jsp" %>
		
		<!-- main -->
        <div class="con_middle">
            <div class="nav">
                <ul>
                    <li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="Manager_Main">관리자</a>&#62;</li>
                    <li><a href="${path}/board/board_list?category=${vo.category}">${vo.category}</a>&#62;</li>
                    <li><a href="#">${vo.idx}번 글</a></li>
                    
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>	
			
			<c:if test="${vo.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
			<c:if test="${vo.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
			<c:if test="${vo.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
			<c:if test="${vo.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
			<c:if test="${vo.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>		
			
            <div class="content_view">
				<a href="${path}/board/board_list?category=${vo.category}">${vo.category}</a>				
	         	<h1 class="board_content_view_title">${vo.title}</h1>
	         	<p class="content_writer">${vo.name}&lpar;${dname}&rpar;</p>
	         	<div class="board_content_view_undertitle">
					<p class="board_content_view_date" ><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
					<img src="${path}/images/thums.png" alt="thums" class="thums">
					<p>${vo.hit}</p>
	         	</div>
				<hr/>	
				<div style="height: 35%">
					<div style="height: 100%">
						<div style="height : 95%">
							<p>${content}</p>
						</div>
						<c:if test="${vo.attachedfile != null}">
							<div class="attach">
								<img alt="" src="${path}/images/clip.png" width="15x" style="margin: 4px 1px">
								<a href="${path}/board/Download?filename=${vo.attachedfile}">${vo.attachedfile}</a>
							</div>
						</c:if>
					</div>
				</div>
				<br/>
				<div align="right">
					<c:if test="${vo.name == EmpVO.name}">
	                	<button type="button" onclick="deletebyMNG(${vo.idx})">삭제</button>
	                </c:if>
	            </div>
                <hr/>
                
                <!-- 댓글 -->
				<c:if test="${vo.category == '자유 게시판'}">
	                <form action="${path}/board/comment_service?currentPage=${currentPage}&category=자유 게시판" method="post" name="commentForm">
	                
	                	<table style="width: 100%">
	                		<tr>
	                			<td align="center">댓글달기</td>
	                			<td width="750"><input id="content" type="text" name="content"/></td>
	                			<td align="center"><input type="submit" name="btntitle" value="저장하기"/></td>
	                		</tr>
	                	</table>
	
						<input id="name" type="hidden" name="name" value="${EmpVO.name}"/>
						<input id="empno" type="hidden" name="empno" value="${EmpVO.empno}"/>
						<input id="deptno" type="hidden" name="deptno" value="${EmpVO.deptno}"/>
						<input id="idx" type="hidden" name="idx" value="${vo.idx}"/>
						<input id="gup"  type="hidden" name="gup" value="${vo.idx}"/>
						<input id="mode" type="hidden" name="mode" value="1"/>
	                
						<hr/>
						<!-- 댓글 반복문 -->
						<c:set var="co" value="${commentList.list}"></c:set>
						<div style="height: 200px">
							<table style="width: 900px; margin: auto;">	
								<c:forEach var="co" items="${co}">	
									
									<c:set var="cocontent" value="${fn:replace(co.content, '<', '&lt;') }"></c:set>
									<c:set var="cocontent" value="${fn:replace(cocontent, '>', '&gt;') }"></c:set>
									<c:set var="cocontent" value="${fn:replace(cocontent, enter, '<br/>') }"></c:set>	
									
									<tr id="comment_${co.idx}">
										<td width="800px">		
											<img alt="화살표" src="${path}/images/arrow.png" width="15"/>		
											<span style="font-weight: bold;">${co.name}</span>(<fmt:formatDate value="${co.writedate}" pattern = "yy/MM/dd a h시 mm분"/>) : ${cocontent}
										</td>
										<c:if test="${EmpVO.name == co.name}">
											<td align="right">
												<button type="button" title="수정" style="font-size: 7px" onclick="commentService(${co.idx},2,'수정','${cocontent}','${vo.idx}')">수정</button>
												<button type="button" title="삭제" style="font-size: 7px" onclick="commentDelete(${co.idx})">삭제</button>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
						</div>
						<!-- 댓글 반복문 -->
					</form>
				</c:if>
				<div style="float:right;">
					<input type="button" value="목록" onclick="location.href='show_all_board?currentPage=${currentPage}'"/>
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

</body>

</html>