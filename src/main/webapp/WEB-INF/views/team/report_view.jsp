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
					<li><a href="#">팀 커뮤니티</a>&#62;</li>
					<li><a href="#">업무 보고</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="view" value="${ReportList.list}"></c:set>
			<!-- 오늘 날짜 기억하는 Date 클래스 객체를 useBean으로 만든다. -->
			<jsp:useBean id="date" class="java.util.Date"/>
			<fmt:formatDate value="${date}" pattern = "yyyy-MM-dd(E)" var = "today"/>
			
            <div class="content">
				<!-- 검색 -->
                <div align="right" style="margin-bottom: 15px">
               		<form action="#" method="post">
						<select name="searchcategory" style="width:150px;">
	                        <option>제목</option>
                   		</select>
               			<input id="searchobj" type="text" name="searchobj" style="width: 250px"/>
               			<input type="submit" value="검색" />
               		</form>
                </div>
				<!-- 검색 -->
				
				<div class="list_view">
					<table>
						<thead>
							<tr>
								<th width="150">보고서</th>
								<th width="410">제목</th>
								<th width="190">작성자</th>
								<th width="100">작성일</th>
								<th width="100">조회수</th>
							</tr>
						</thead>
						
						<tbody>
							<!--=========================== 글 출력 =====================================-->
							<c:if test="${view.size() == 0}">
								<tr>
									<td colspan="4" style="text-align: center;">저장된 글이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${view.size() != 0}">
								<c:forEach var="vo" items="${view}">
									<fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd(E)" var = "sdf1date"/>
									<fmt:formatDate value="${vo.writedate}" pattern = "a h:mm:ss" var = "sdf2date"/>
									
									<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;') }"></c:set>
									<c:set var="title" value="${fn:replace(title, '>', '&gt;') }"></c:set>
									
									<tr>
										<td style="text-align: center;">${vo.type}</td>
	
										<td style="text-align: left;" onclick="location.href='report_content_list?idx=${vo.idx}&currentPage=${currentPage}'">
											<p>${vo.title}</p>
										</td>
	
										<td style="text-align: center;">${vo.name}</td>
										<td style="text-align: center;">
											<fmt:formatDate value="${vo.writedate}" pattern="yyyy.MM.dd(E)" />
										</td>
										<td style="text-align: center;">${vo.hit}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				<!-- ============================= 글쓰기 버튼 ============================================= -->
				<table style="width: 900px; margin: auto;">
					<tr>
						<td colspan="4" align="right">
							<input type="button" value="글쓰기" onclick="location.href='report_service?mode=1'"/>
						</td>
					</tr>
				</table>

				<!--===========================페이지 이동 버튼 ====================================-->
				<table class="pagebutton" align="center" border="0" cellpadding="0"	cellspacing="0" height="30">
					<tr>
						<!-- 처음으로 -->
						<c:if test="${ReportList.currentPage > 1}">
							<td><button class="button1" type="button" title="첫 페이지로." onclick="location.href='?currentPage=1'">처음</button></td>
						</c:if>
						<c:if test="${ReportList.currentPage <= 1}">
							<td><button class="button1_1" type="button" disabled="disabled" title="현재 페이지입니다.">처음</button></td>
						</c:if>
						<!-- 10페이지 앞으로 -->
						<c:if test="${ReportList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동"
									onclick="location.href='?currentPage=${ReportList.currentPage - 10}'">
									<<</button></td>
						</c:if>
						<c:if test="${ReportList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다"
									disabled="disabled"><<</button></td>
						</c:if>
						<!-- 1페이지 앞으로 -->
						<c:if test="${ReportList.startPage > 1}"> <td><button class="button1" type="button"	title="이전 10페이지로 이동합니다."	onclick="location.href='?currentPage=${ReportList.startPage-1}'"><</button></td>
						</c:if>
						<c:if test="${ReportList.startPage <= 1}">
							<td><button class="button1_1" type="button" title="이미 첫 페이지 입니다." disabled="disabled"><</button></td>
						</c:if>

						<!-- 숫자 페이지 이동 버튼 -->
						<c:forEach var="i" begin="${ReportList.startPage}"	end="${ReportList.endPage}" step="1">
							<c:if test="${ReportList.currentPage == i}">
								<td width='30' align='center'
									style='background: #D8D2CB; border: 1px;'>${i}</td>
							</c:if>
							<c:if test="${ReportList.currentPage != i}">
								<td class='tda' width='30' align='center'><a href='#'  onclick="location.href='?currentPage=${i}'">${i}</a></td>
							</c:if>
						</c:forEach>

						<!-- 1페이지 뒤로 -->
						<c:if test="${ReportList.endPage < ReportList.totalPage}">
							<td><button class="button1" type="button" title="다음 페이지로 이동합니다." onclick="location.href='?currentPage=${ReportList.endPage + 1}'">></button></td>
						</c:if>
						<c:if test="${ReportList.endPage >= ReportList.totalPage}">
							<td><button class="button1_1" type="button"	title="이미 마지막 페이지 입니다." disabled="disabled">></button></td>
						</c:if>
						<!-- 10페이지 뒤로 -->
						<c:if test="${ReportList.endPage < ReportList.totalPage}">
							<td><button type="button" title="10페이지 이동"
									onclick="location.href='?currentPage=${ReportList.currentPage + 10}'">
									>></button></td>
						</c:if>
						<c:if test="${ReportList.endPage >= ReportList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다"
									disabled="disabled">>></button></td>
						</c:if>
						<!-- 마지막으로 -->
						<c:if test="${ReportList.currentPage < ReportList.totalPage}">
							<td><button class="button1" type="button" title="마지막 페이지로 이동합니다." onclick="location.href='?currentPage=${ReportList.totalPage}'">끝</button></td>
						</c:if>
						<c:if test="${ReportList.currentPage >= ReportList.totalPage}">
							<td><button type="button" disabled="disabled" title="이미 마지막 10페이지 입니다." class="button1_1">끝</button></td>
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