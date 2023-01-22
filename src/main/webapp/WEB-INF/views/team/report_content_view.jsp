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
					<li><a href="#">팀 커뮤니티</a>&#62;</li>
					<li><a href="#">업무 보고</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="vo" value="${ReportVO}"></c:set>

			<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>

			<div class="content_view">

				<h1 class="board_content_view_title">${vo.title}</h1>
				<p class="content_writer">${vo.type}</p>
				<div class="board_content_view_undertitle">
					<p class="board_content_view_date" ><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
					<img class="thums" src="${path}/images/thums.png" alt="thums">
					<p>${vo.hit}</p>
				</div>
				<hr/>
				<div style="height: 35%"><p>${content}</p></div>
				
				<c:if test="${vo.attachedfile != null}">
					<div class="attach">
						<img alt="" src="${path}/images/clip.png" width="15x" style="margin: 4px 1px">
						<a href="${path}/Download?filename=${vo.realfilename}">${vo.attachedfile}</a>
					</div>					
				</c:if>
					
				
				<div style="height: 290px">
					<tr>
						<c:if test="${vo.name == EmpVO.name}">
						<%-- <div align="right">
							<td>
								<input type="button" value="수정" onclick="location.href='report_service?mode=2&idx=${vo.idx}&currentPage=${currentPage}'" />
								<input type="button" value="삭제" onclick="location.href='report_service?mode=3&idx=${vo.idx}'" />
							</td>
						</div> --%>
						<div class="delORupdate" style="padding-left:809px;">
							<c:if test="${vo.name == EmpVO.name}">
			                	<input type="button" value="수정" onclick="location.href='report_service?mode=2&idx=${vo.idx}&currentPage=${currentPage}'"/>
			                	<input type="button" value="삭제" onclick="location.href='report_service?mode=3&idx=${vo.idx}'"/>
			                </c:if>
			            </div>
						</c:if>
					</tr>
				<hr/>
				</div>
				<hr/>
				<div style="float:right;">
					<input type="button" value="목록" onclick="location.href='report_list?currentPage=${currentPage}&'"/>
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