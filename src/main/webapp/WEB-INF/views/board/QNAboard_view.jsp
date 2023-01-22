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
                    <li><a href="board_list?category=QNA">Q&A</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <fmt:requestEncoding value="UTF-8"/>
            <c:set var="view" value="${BoardList.list}"></c:set>
            
            <jsp:useBean id="date" class="java.util.Date"/>

			<fmt:formatDate value="${date}" pattern = "yyyy-MM-dd(E)" var = "today"/>
			
            <div class="content">
                
                <!-- 반복문 -->
                <div class="list_view list_view_noSearch">
					<table> 
						<thead>	
							<tr>
								<th width="150">작성자</th>
								<th width="550">제목</th>
								<th width="200">작성일</th>
							</tr>
						</thead>
						
						<c:if test="${view.size() == 0 }">
							<tr><td colspan="6"><marquee>저장된 글이 없습니다.</marquee></td></tr>
						</c:if>
						<c:if test="${view.size() != 0}">					
							<c:forEach var="vo" items="${view}">
							
								<fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd(E)" var = "sdf1date"/>
								<fmt:formatDate value="${vo.writedate}" pattern = "a h:mm:ss" var = "sdf2date"/>
								
								<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;') }"></c:set>
								<c:set var="title" value="${fn:replace(title, '>', '&gt;') }"></c:set>
								
								<tr>
									<td align="center">${vo.name}</td>
									<c:if test="${vo.seq == 0}">
										<td onclick="location.href='content_list?idx=${vo.idx}&currentPage=${BoardList.currentPage}&category=QNA'">
											<a>Q.&nbsp;${title}</a>
										</td>
									</c:if>
									<c:if test="${vo.seq == 1}">
										<td>&nbsp;&nbsp;<img alt="화살표" src="${path}/images/arrow.png" width="15" height="110%"/>&nbsp;A.&nbsp;${title}</td>
									</c:if>
				 					<td align="right" style="padding-right: 30px">
					
										<c:if test="${today == sdf1date}">${sdf2date}</c:if>
										
										<c:if test="${today != sdf1date}">${sdf1date}</c:if>
								
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
                			<input type="button" value="질문하기" onclick="location.href='QNAboard_insert'"/>
                		</td>
					</tr>

                </table>
                
                <!-- 페이지 이동 -->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${BoardList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1&category=QNA'"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage - 10}&category=QNA'"> << </button></td>
						</c:if>
						<c:if test="${BoardList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage - 1}&category=QNA'"> < </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${BoardList.startPage}" end="${BoardList.endPage}">
							<c:if test="${i == BoardList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != BoardList.currentPage}">
								<td class='tda' width='30' align='center'><a href='board_list?currentPage=${i}&category=QNA'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage+1}&category=QNA'"> > </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${BoardList.endPage < BoardList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage + 10}&category=QNA'"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.endPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${BoardList.totalPage}&category=QNA'"> 끝 </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage >= BoardList.totalPage}">
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
	<%@ include file="../includes/insertTodoModal.jsp" %>

</body>

</html>