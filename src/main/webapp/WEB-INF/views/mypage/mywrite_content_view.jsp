<%@page import="com.tjoeun.vo.BoardVO"%>
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
                    <li><a href="myinfo_view">마이페이지</a>&#62;</li>
                    <li><a href="#">내가 쓴 글</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="vo" value="${BoardVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(vo.content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(vo.content, enter, '<br/>') }"></c:set>			
			
			<div class="content_view">
										
	         	<h1>${vo.title}</h1>
	         	<div style="display: flex; line-height: 20px">
					<h5 style="width: 95%"><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></h5>
					<div style="display: flex ">
						<img src="${path}/images/thums.png" alt="thums" width="22px" style="padding: 3px">
						<h5>${vo.hit}</h5>
					</div>
				</div>
				<hr/>	
				<div style="height: 45%"><p>${content}</p></div>
				<c:if test="${vo.attachedfile != null}">
					<div class="attach">
						<img alt="" src="./images/clip.png" width="15x" style="margin: 4px 1px">
						<a href="${path}/upload/${vo.realfilename}" download="${vo.attachedfile}">${vo.attachedfile}</a>
					</div>
				</c:if>
				<br/>
				<div style="padding-left:809px;">
					<c:if test="${vo.name == EmpVO.name}">
	                	<input type="button" value="수정" onclick="location.href='mywrite_update?idx=${vo.idx}&currentPage=${currentPage}&category=${vo.category}'"/>
	                	<input type="button" value="삭제" onclick="location.href='mywrite_delete?idx=${vo.idx}&category=${vo.category}'"/>
	                </c:if>
	            </div>
                <hr/>
                <div style="height:180px;"></div>
                <hr/>
                <div style="float:right;">
					<input type="button" value="목록" onclick="history.back()"/>
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