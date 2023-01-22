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
					<li><a href="board_list?category=공지사항">게시판</a>&#62;</li>
                    <li><a href="board_list?category=공지사항">공지사항</a></li>
                </ul>
            </div>
            
            <!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8"/>
			<c:set var="view" value="${BoardList.list}"></c:set>
			
			<jsp:useBean id="date" class="java.util.Date"/>			
			<fmt:formatDate value="${date}" pattern = "yyyy-MM-dd(E)" var = "today"/>
			
			<div class="content">
            
                <div align="right" style="margin-bottom: 15px">
               		<form action="board_list?category=공지사항" method="post">
						<select name="searchcategory" style="width:150px;">
	                        <option>제목</option>
	                        <option>작성자</option>
	                        <option>제목+작성자</option>
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
								<th width="160">부서</th>
			           	 		<th width="120">작성자</th>
			           	 		<th width="360">제목</th>
			           	 		<th width="170">작성일</th>
								<th width="100">조회수</th>
							</tr>
						</thead>
						
						<c:if test="${view.size() == 0 }">
							<tr><td colspan="6"><marquee>저장된 글이 없습니다.</marquee></td></tr>
						</c:if>
						<c:if test="${view.size() != 0}">					
							<c:forEach var="vo" items="${view}">
							
								<fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd(E)" var = "sdf1date"/>
								<fmt:formatDate value="${vo.writedate}" pattern = "a h:mm:ss" var = "sdf2date"/>
								
								<c:if test="${vo.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${vo.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${vo.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${vo.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${vo.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
								
								<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;') }"></c:set>
								<c:set var="title" value="${fn:replace(vo.title, '>', '&gt;') }"></c:set>
								
								<tr>
									<td align="center">${dname}</td>
									<td align="center">
										<c:if test="${searchcategory == null || searchcategory == '제목'}">${vo.name}</c:if>
										<c:if test="${searchcategory == '작성자' || searchcategory == '제목+작성자'}">
											<c:set var="search" value="<span>${searchobj}</span>"></c:set>
											${fn:replace(vo.name, searchobj ,search)}
										</c:if>
									</td>
									<td onclick="location.href='content_list?idx=${vo.idx}&currentPage=${BoardList.currentPage}&category=공지사항'">
										<c:if test="${searchcategory == null || searchcategory == '작성자'}">${title}</c:if>
										<c:if test="${searchcategory == '제목' || searchcategory == '제목+작성자'}">
											<c:set var="search" value="<span>${searchobj}</span>"></c:set>
											${fn:replace(title, searchobj ,search)}
										</c:if>
									</td>
									
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
				<!-- 반복문 -->
				
				<c:if test="${EmpVO.permission == 'YES'}">
					<table style="width: 900px; margin: auto;">
	
						<tr>
							<td colspan="4" align="right">
	                			<input type="button" value="글쓰기" onclick="location.href='noticeboard_insert'"/>
	                		</td>
						</tr>
	
	                </table>
				</c:if>
				
			 	<!-- 페이지 이동 -->		
				<table align="center" class="pagebutton" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${BoardList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1&category=공지사항'"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${BoardList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage - 10}&category=공지사항'"> << </button></td>
						</c:if>
						<c:if test="${BoardList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage - 1}&category=공지사항'"> < </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${BoardList.startPage}" end="${BoardList.endPage}">
							<c:if test="${i == BoardList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != BoardList.currentPage}">
								<td class='tda' width='30' align='center'><a href='board_list?currentPage=${i}&category=공지사항'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${BoardList.currentPage+1}&category=공지사항'"> > </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${BoardList.endPage < BoardList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${BoardList.currentPage + 10}&category=공지사항'"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.endPage >= BoardList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${BoardList.currentPage < BoardList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${BoardList.totalPage}&category=공지사항'"> 끝 </button></td>
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