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
					<li><a href="${path}/myinfo_view">마이페이지</a>&#62;</li>
                    <li><a href="${path}/mailboxes_receive_view">메일함</a>&#62;</li>
                    <c:if test="${divs eq 'receive'}"><li><a href="${path}/mailboxes_receive_view">받은 메일함</a></li></c:if>
                    <c:if test="${divs eq 'send'}"><li><a href="${path}/mailboxes_send_view">보낸 메일함</a></li></c:if>
                    
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="mo" value="${MailBoxesVO}"></c:set>
            
        	<c:set var="content" value="${fn:replace(mo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>			
			
            <div class="content_view">
	         	<h1>${mo.title}</h1>
				<p>보낸사람 : <span>${mo.transemail}</span></p>
				<p>받는사람 : <span>${mo.receivemail}</span></p>
				<p style="font-size:8px;color:#b2b2b2;font-weight:light"><fmt:formatDate value="${mo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
				<hr/>	
				<p style="width: 100%; height: 450px;overflow:auto;">${content}</p>
				<br/>
                <hr/>
				<div align="right">
					<input type="button" value="돌아가기" onclick="history.back()"/>
           			<input type="button" value="메일 쓰기" onclick="location.href='mailboxes_insert'"/>
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
	<%@ include file="../includes/todoModal.jsp" %>

</body>

</html>