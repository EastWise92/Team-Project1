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
					<li><a href="#">주소록</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="view" value="${AddressBookList.list}"></c:set>

			<div class="content_view">
			
				<div style="display: flex;">
					<h3>${deptname}</h3>
									
					<!-- 검색 -->
	            	<div align="right" style="width: 83%">
	               		<form action="address_book_list" method="post">
	               			<input type="text" name="searchname" placeholder="검색할 이름을 입력해주세요" style="width: 250px"/>
	               			<input type="submit" value="검색" />
	               		</form>
	                </div>
                </div> <hr />
				
				<div class="address_view">
					<table>
						<thead>
							<tr>
								<th width="200">직급</th>
								<th width="200">이름</th>
								<th width="250">전화번호</th>
								<th width="200">이메일</th>
								<th></th>
							</tr>
						</thead>
						<!-- ==================== 주소록 출력 ===================================== -->
						<c:if test="${view.size() == 0}">
							<tr>
								<td colspan="4" style="text-align: center;">주소록이 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${view.size() != 0}">
							<c:forEach var="vo" items="${view}">
								<tr>
									<td>${vo.position}</td>
									<td>
										<c:set var="search" value="<span>${searchname}</span>"></c:set>
										${fn:replace(vo.name, searchname ,search)}
									</td>
									<td>${vo.pernum}</td>
									<td>${vo.email}</td>
									<td onclick="pmPop(${vo.empno}, '${vo.name}')" class="imghover">
										<img src="${path}/images/email.png"/>
										<img src="${path}/images/emailhover.png"/>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
				<!--===========================페이지 이동 버튼 ====================================-->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${AddressBookList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1'"> 처음 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${AddressBookList.currentPage - 1}'"> 이전 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> 이전 </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${AddressBookList.startPage}" end="${AddressBookList.endPage}">
							<c:if test="${i == AddressBookList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != AddressBookList.currentPage}">
								<td class='tda' width='30' align='center'><a href='address_book_list?currentPage=${i}'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${AddressBookList.currentPage < AddressBookList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${AddressBookList.currentPage+1}'"> 다음 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage >= AddressBookList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> 다음 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage < AddressBookList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${AddressBookList.totalPage}'"> 끝 </button></td>
						</c:if>
						<c:if test="${AddressBookList.currentPage >= AddressBookList.totalPage}">
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
	
	<!-- 쪽지 전송 Modal -->
	<%@ include file="../includes/pmModal.jsp" %>

</body>

</html>