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
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="view" value="${BoardList.list}"></c:set>
			<jsp:useBean id="date" class="java.util.Date" />
			<fmt:formatDate value="${date}" pattern="yyyy/MM/dd(E)" var="today" />

			<div align="right" style="margin-bottom: 15px">
               		<form action="mywrite_view" method="post">
						<select name="searchcategory" style="width:150px;">
	                        <option>제목</option>
	                        <option>내용</option>
	                        <option>제목+내용</option>
                   		</select>
               			<input id="searchobj" type="text" name="searchobj" style="width: 250px"/>
               			<input type="submit" value="검색" />
               		</form>
                </div>
				
				<!-- 반복문 -->
               <div class="list_view">
					<table> 
						<thead>	
							<tr>
								<th width="190px">카테고리</th>
								<th>제목</th>
								<th width="190px">작성일</th>
								<th width="70px">조회수</th>
							</tr>
						</thead>
						<c:if test="${view.size() == 0 }">
							<tr>
								<td colspan="4"><marquee>저장된 글이 없습니다.</marquee></td>
							</tr>
						</c:if>
						
						<!-- 반복문 -->
						<c:if test="${view.size() != 0}">
							<c:forEach var="vo" items="${view}">
								<fmt:formatDate value="${vo.writedate}" pattern="yyyy/MM/dd(E)" var="sdf1date" />
								<fmt:formatDate value="${vo.writedate}" pattern="a h:mm:ss" var="sdf2date" />
								<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;') }"></c:set>
								<c:set var="title" value="${fn:replace(vo.title, '>', '&gt;') }"></c:set>
								<tr onclick="location.href='mywrite_content_view?idx=${vo.idx}'">
									<td>${vo.category}</td>
									<td>${title}</td>
									<td align="right">
										<c:if test="${today == sdf1date}">${sdf2date}</c:if> 
	                       		 		<c:if test="${today != sdf1date}">${sdf1date}</c:if>
	                       		 	</td>
									<td align="center">${vo.hit}</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				<!-- 하단 버튼 부분 -->
				<table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30" style="margin-top:90px;">
					<tr>		
						<c:if test="${BoardList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1'"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage - 10}'"> << </button></td>
						</c:if>
						<c:if test="${BoardList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage - 1}'"> < </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 								
						<c:forEach var="i" begin="${BoardList.startPage}" end="${BoardList.endPage}">
							<c:if test="${i == BoardList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != BoardList.currentPage}">
								<td class='tda' width='30' align='center'><a href='?currentPage=${i}'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage+1}'"> > </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${BoardList.endPage < BoardList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage + 10}'"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.endPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${BoardList.totalPage}'"> 끝 </button></td>
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