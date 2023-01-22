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
            <c:set var="vo" value="${ReportVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>	
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>			
			
             <div class="content_view">
				<div style="display: flex; line-height: 20px">
				</div>
				<form action="report_updateOK?idx=${vo.idx}&currentPage=${currentPage}" method="post" enctype="multipart/form-data">					
		         	<tr>
						<td><input id="title" type="text" name="title" value="${vo.title}" /></td>
					</tr>
					
					<hr>
					
					<td>
						<select id="type" name="type" style="width: 150px;">
							<option value="일일 보고서">일일 보고서</option>
							<option value="주간 보고서">주간 보고서</option>
						</select>
					</td>
					
					<hr/>	
					
					<textarea id="content" name="content" style="resize: none;" rows="9" >${content}</textarea>
						<tr>
							<td><input type="file" name="filename"/></td> 
						</tr>	
	                <div align="right">
		                <input type="reset" value="다시쓰기"/>
						<input type="submit" value="저장"/>
					</div>
					
	               	<hr/>
	               	<div style="height: 230px"></div>
	               	<hr/>
	                <div align="right">
	               		 <input type="button" value="돌아가기" onclick="history.back()"/>
	                </div>
	                
					<input type="hidden" name="attachedfile" value="${vo.attachedfile}"/>
					<input type="hidden" name="realfilename" value="${vo.realfilename}"/>
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