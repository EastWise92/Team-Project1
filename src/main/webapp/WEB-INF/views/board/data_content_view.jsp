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
                   	<li><a href="board_list?category=자료실">게시판</a>&#62;</li>
                    <li><a href="board_list?category=자료실">자료실</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="vo" value="${BoardVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>			
			
			<c:if test="${vo.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
			<c:if test="${vo.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
			<c:if test="${vo.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
			<c:if test="${vo.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
			<c:if test="${vo.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
			
            <div class="content_view">
	         	<h1 class="board_content_view_title">${vo.title}</h1>
				<p class="content_writer">${vo.name}&lpar;${dname}&rpar;</p>
	         	<div class="board_content_view_undertitle">
					<p class="board_content_view_date" ><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
					<img src="${path}/images/thums.png" alt="thums" class="thums">
					<h5>${vo.hit}</h5>
	         	</div>
				<hr/>
				<div style="padding: 2px 10px; height: 50%">	
					<div style="height: 100%">
						<div style="height : 95%">
							<p>${content}</p>
						</div>
						<c:if test="${vo.attachedfile != null}">
							<div class="attach">
								<img alt="" src="${path}/images/clip.png" width="15x" style="margin: 4px 1px">
								<a href="${path}/Download?filename=${vo.realfilename}">${vo.attachedfile}</a>
							</div>
						</c:if>
					</div>
				</div>
				<div class="delORupdate">
	             	<c:if test="${vo.name == EmpVO.name}">
	                	<input type="button" value="수정" onclick="location.href='board_update?idx=${vo.idx}&currentPage=${currentPage}'"/>
	                	<input type="button" value="삭제" onclick="location.href='board_delete?idx=${vo.idx}&currentPage=${currentPage}&category=자료실'"/>
	                </c:if>
	            </div>
                <hr/>
                <div style="height:170px;"></div>
                <hr/>
				<div style="float:right;">
					<input type="button" value="목록" onclick="location.href='board_list?currentPage=${currentPage}&category=자료실'"/>
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