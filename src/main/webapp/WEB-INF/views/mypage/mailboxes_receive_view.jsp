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
                    <li><a href="mailboxes_receive_view">메일함</a>&#62;</li>
                    <li><a href="mypage_list?category=받은 메일함">받은 메일함</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="view" value="${MailBoxesList.list}"></c:set>
            <jsp:useBean id="date" class="java.util.Date"/>
			<fmt:formatDate value="${date}" pattern = "yyyy-MM-dd(E)" var = "today"/>
            <div class="content">
            	<div align="left" style="float:left;">
            		<ul style="margin-top:10px;">
            			<li style="float:left;margin-right:15px;" class="mailboxes receive">
            				<a href="mailboxes_receive_view">받은 메일함</a>
            			</li>
            			<li style="float:left;margin-right:15px;" class="mailboxes send">
             					<a href="mailboxes_send_view">보낸 메일함</a>
            			</li>
            			<li style="float:left;"class="mailboxes trash">
            				<a href="mailboxes_trash_view">휴지통</a>
            			</li>
            		</ul>
            	</div>
                <div align="right" style="margin-bottom: 15px">
               		<form action="#" method="post">
						<select name="searchcategory" style="width:150px;">
	                        <option>제목</option>
	                        <option>보낸사람</option>
	                        <option>받는사람</option>
                   		</select>
               			<input id="search" type="text" name="search" style="width: 250px"/>
               			<input type="button" value="검색" onclick=""/>
               		</form>
                </div>
                
                <!-- 반복문 -->
                <div style="height: 80%">
					<table style="width: 900px; margin: auto;"> 
 						<c:if test="${view.size() == 0 }">
							<tr><td colspan="6" align="center">받은 메일이 없습니다.</td></tr>
						</c:if>
						<c:if test="${view.size() != 0 }">
							<c:forEach var="mo" items="${view}">
									<fmt:formatDate value="${mo.writedate}" pattern = "yyyy-MM-dd(E)" var = "sdf1date"/>
									<fmt:formatDate value="${mo.writedate}" pattern = "a h:mm:ss" var = "sdf2date"/>
									
									<c:set var="title" value="${fn:replace(mo.title, '<', '&lt;') }"></c:set>
									<c:set var="title" value="${fn:replace(mo.title, '>', '&gt;') }"></c:set>
									<tr>
										<td>
											<div style="width:900px;">
 												<div class="mailDelete">
 													<button onclick="location.href='mailboxes_service?idx=${mo.idx}&currentPage=${currentPage}&mode=2'">삭제</button>
 												</div>

												<div style="margin-top:5px;width:850px;">
													<a href='mailboxes_content_list?idx=${mo.idx}&currentPage=${MailBoxesList.currentPage}&divs=receive'>${mo.title}</a>
												</div>
												<div style="padding-bottom:5px;border-bottom:1px solid black;font-size:8px;width:900px;">
													<c:if test="${mo.attachedfile != null}"><span><img src="./images/clip.png" style="width:15px;"></span></c:if>
													<span class="underText">${mo.transemail} |</span>
													<span class="underText">
														<c:if test="${today == sdf1date}">${sdf2date}</c:if>
														<c:if test="${today != sdf1date}">${sdf1date}</c:if>
													</span>
												</div>
											</div>
										</td>
									</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				<!-- 반복문 -->
				<table style="width: 900px; margin: auto;">
					<tr>
						<td colspan="4" align="right">
                			<input type="button" value="메일 쓰기" onclick="location.href='mailboxes_insert'"/>
                		</td>
					</tr>
                </table>
                
                <!-- 페이지 이동 -->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${MailBoxesList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1&category=메일함'"> 처음 </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${MailBoxesList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${MailBoxesList.currentPage - 10}&category=메일함'"> << </button></td>
						</c:if>
						<c:if test="${MailBoxesList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${MailBoxesList.currentPage - 1}&category=메일함'"> < </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${MailBoxesList.startPage}" end="${MailBoxesList.endPage}">
							<c:if test="${i == MailBoxesList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != MailBoxesList.currentPage}">
								<td class='tda' width='30' align='center'><a href='mypage_list?currentPage=${i}&category=메일함'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${MailBoxesList.currentPage < MailBoxesList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${MailBoxesList.currentPage+1}&category=메일함'"> > </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage >= MailBoxesList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${MailBoxesList.endPage < MailBoxesList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${MailBoxesList.currentPage + 10}&category=메일함'"> >> </button></td>
						</c:if>
						<c:if test="${MailBoxesList.endPage >= MailBoxesList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage < MailBoxesList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${MailBoxesList.totalPage}&category=메일함'"> 끝 </button></td>
						</c:if>
						<c:if test="${MailBoxesList.currentPage >= MailBoxesList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> 끝 </button></td>
						</c:if>
										
					</tr>
					
				</table>
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