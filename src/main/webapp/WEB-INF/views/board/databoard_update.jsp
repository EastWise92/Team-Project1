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
                    <li><a href="board_list?category=자유 게시판">게시판</a>&#62;</li>
                    <li><a href="board_list?category=자료실">자료실</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="vo" value="${BoardVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>			
			
			<c:if test="${vo.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
			<c:if test="${vo.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
			<c:if test="${vo.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
			<c:if test="${vo.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
			<c:if test="${vo.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
			
            <div class="content_view">
										
				<form action="data_updateOK?currentPage=${currentPage}" method="post" enctype="multipart/form-data">
		         	<input type="text" name="title" value="${vo.title}"/>
					<p class="content_writer">${vo.name}&lpar;${dname}&rpar;</p>
		         	<div class="board_content_view_undertitle" style="display:flex;">
						<p class="board_content_view_date" style="margin-right:730px;"><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
						<img class="thums" src="${path}/images/thums.png" alt="thums">
						<p>${vo.hit}</p>
					</div>
					<hr/>	
					<input type="hidden" name="idx" value="${vo.idx}"/> 
					<input type="hidden" name="category" value="자료실"/> 
					<input type="hidden" name="attachedfile" value="${vo.attachedfile}" />
					
					<textarea id="content" name="content" rows="14" >${content}</textarea>
					<input type="file" name="filename"/>
	                <div align="right">
		                <input type="reset" value="다시쓰기"/>
						<input type="submit" value="저장"/>
					</div>
	                <hr/>
	                <div style="height:160px;"></div>
	                <hr/>
					<div align="right">
						<input type="button" value="돌아가기" onclick="history.back()" />
					</div>
				</form>		  
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