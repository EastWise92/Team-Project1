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
                    <li><a href="#">게시판</a>&#62;</li>
                    <li><a href="#">자유게시판</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="vo" value="${BoardVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>			

            <div class="content_view">
	         	<h1 class="board_content_view_title">${vo.title}</h1>
	         	<div class="board_content_view_undertitle">
					<p class="board_content_view_date" ><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
					<img class="thums" src="${path}/images/thums.png" alt="thums">
					<p>${vo.hit}</p>
				</div>
				<hr/>	
				<div class="board_content_view_content"><p>${content}</p></div>
				<br/>
				<div class="delORupdate">
					<c:if test="${vo.name == EmpVO.name}">
	                	<input type="button" value="수정" onclick="location.href='board_update?idx=${vo.idx}&currentPage=${currentPage}'"/>
	                	<input type="button" value="삭제" onclick="location.href='board_delete?idx=${vo.idx}&currentPage=${currentPage}&category=자유 게시판'"/>
	                </c:if>
	            </div>
                <hr/>
                <form action="comment_service?currentPage=${currentPage}&category=자유 게시판" method="post" name="commentForm">
                
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
				</form>
				<!-- 댓글 반복문 -->
				
				<hr/>
				<div style="float:right;">
					<input type="button" value="목록" onclick="location.href='board_list?currentPage=${currentPage}&category=자유 게시판'"/>
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