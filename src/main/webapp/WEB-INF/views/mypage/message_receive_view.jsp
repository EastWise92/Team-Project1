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
                    <li><a href="message_receive_view">쪽지함</a>&#62;</li>
                    <li><a href="message_receive_view">받은 쪽지함</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="view" value="${MessageList.list}"></c:set>
            <jsp:useBean id="date" class="java.util.Date"/>
			<fmt:formatDate value="${date}" pattern = "yyyy-MM-dd(E)" var = "today"/>
            <div class="content">
            	<div align="left" style="float:left;">
            		<ul style="margin-top:10px;">
            			<li style="float:left;margin-right:15px;" class="mailboxes receive">
            				<a href="message_receive_view">
	            				받은 쪽지함
								<c:if test="${noRead!=0}"><span style="font-size:12px;">(${noRead}/${recieveCount})</span></c:if>
							</a>
            			</li>
            			<li style="float:left;margin-right:15px;" class="mailboxes send">
             					<a href="message_send_view">보낸 쪽지함</a>
            			</li>
            			<li style="float:left;"class="mailboxes trash">
            				<a href="message_trash_view">휴지통</a>
            			</li>
            		</ul>
            	</div>
                <div align="right" style="margin-bottom: 15px">
               		<form action="message_receive_view" method="post">
						<select id="searchcategory" name="searchcategory" style="width:100px;">
	                        <option value="writer">보낸사람</option>
	                        <option value="title">제목</option>
	                        <option value="titcont">제목+내용</option>
                   		</select>
               			<input id="searchobj" type="text" name="searchobj" style="width: 250px"/>
               			<input type="submit" value="검색" />
               		</form>
                </div>
                <!-- 반복문 -->
                <div style="height: 80%">
					<table style="width: 900px; margin: auto;"> 
 						<c:if test="${view.size() == 0 }">
							<tr><td colspan="6" align="center">받은 메일이 없습니다.</td></tr>
						</c:if>
						<c:if test="${view.size() != 0 }">
							<c:forEach var="meo" items="${view}">
									<fmt:formatDate value="${meo.writedate}" pattern = "yyyy-MM-dd(E)" var = "sdf1date"/>
									<fmt:formatDate value="${meo.writedate}" pattern = "a h:mm:ss" var = "sdf2date"/>
									
									<c:set var="title" value="${fn:replace(meo.title, '<', '&lt;') }"></c:set>
									<c:set var="title" value="${fn:replace(meo.title, '>', '&gt;') }"></c:set>
									<tr>
										<td>
											<div style="width:900px;">
 												<div class="mailDelete">
 													<button onclick="location.href='message_service?idx=${meo.idx}&currentPage=${currentPage}&mode=2'">삭제</button>
 												</div>

												<div style="margin-top:5px;width:850px;">
													<a href='read_message_content_list?idx=${meo.idx}&currentPage=${MessageList.currentPage}&divs=receive'>${meo.title}</a>
													<c:if test="${meo.read == 'NO'}">
														<span><img src="${path}/images/new.png" style="width:30px;"></span>
													</c:if>
												</div>
												<div style="padding-bottom:5px;border-bottom:1px solid black;font-size:8px;width:900px;">
													<span class="underText">보낸사람 : ${meo.transempno} |</span>
													<span class="underText">
														<c:if test="${today == sdf1date}">${sdf2date}</c:if>
														<c:if test="${today != sdf1date}">${sdf1date}</c:if>
													</span>
													<c:if test="${meo.attachedfile != null}">
														<span><img src="${path}/images/clip.png" style="width:15px;"></span>
													</c:if>
												</div>
											</div>
										</td>
									</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				
				<table style="width: 900px; margin: auto;">
					<tr>
						<td colspan="4" align="right">
                			<input type="button" value="쪽지 쓰기" onclick="location.href='message_insert'"/>
                		</td>
					</tr>
                </table>
                
                <!-- 페이지 이동 -->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${MessageList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1 '"> 처음 </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${MessageList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${MessageList.currentPage - 10} '"> << </button></td>
						</c:if>
						<c:if test="${MessageList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${MessageList.currentPage - 1} '"> < </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${MessageList.startPage}" end="${MessageList.endPage}">
							<c:if test="${i == MessageList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != MessageList.currentPage}">
 								<td class='tda' width='30' align='center'><a href='?currentPage=${i}'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${MessageList.currentPage < MessageList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${MessageList.currentPage+1} '"> > </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage >= MessageList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${MessageList.endPage < MessageList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${MessageList.currentPage + 10} '"> >> </button></td>
						</c:if>
						<c:if test="${MessageList.endPage >= MessageList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage < MessageList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${MessageList.totalPage} '"> 끝 </button></td>
						</c:if>
						<c:if test="${MessageList.currentPage >= MessageList.totalPage}">
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