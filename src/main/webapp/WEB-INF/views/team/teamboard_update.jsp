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
					<li><a href="#">게시판</a>&#62;</li>
					<li><a href="#">팀 게시판</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="vo" value="${BoardVO}"></c:set>

			<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>

			<div class="content_view">
				<form action="data_updateOK?idx=${vo.idx}&currentPage=${currentPage}&category=팀 게시판" method="post" enctype="multipart/form-data">
				
					<input type="hidden" name="idx" value="${vo.idx}"/> 
					<input type="hidden" name="category" value="팀 게시판"/> 
					<input type="hidden" name="attachedfile" value="${vo.attachedfile}" />	
									
					<input type="text" name="title" value="${vo.title}"/>
					
					<hr>	
					
					<textarea name="content" style="resize: none;" rows="11" >${content}</textarea>
					<input type="file" name="filename"/>
					
	                <div align="right">
		                <input type="reset" value="다시쓰기"/>
						<input type="submit" value="저장"/>
					</div>
					
	               	<hr/>
	               	<div style="height:270px;"></div>
	                <hr/>
	                <div align="right">
	               		 <input type="button" value="돌아가기" onclick="history.back()"/>
	                </div>
	                
					<input type="hidden" name="attachedfile" value="${vo.attachedfile}" /><br/>
					<input type="hidden" name="realfilename" value="${vo.realfilename}"/>
	            </form>	
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