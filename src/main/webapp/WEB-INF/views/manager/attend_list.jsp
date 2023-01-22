<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp" %>
	
	<script src="${path}/js/manager.js" defer="defer"></script>
</head>

<body>

	<!-- haeder -->
	<%@ include file="../includes/header.jsp" %>

    <!-- contents start -->
    <div class="tjcontainer">
    
        <!--menu list start-->
        <%@ include file="./manager_menu_bar.jsp" %>
        <!-- menu list end -->
        
        <!-- main -->
        <div class="con_middle">
			<div class="nav">
                <ul>
                    <li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="Manager_Main">관리자</a>&#62;</li>
                    <li><a href="move_attend_list">근태관리</a>&#62;</li>
                    <li><a href="move_attend_list">조회</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="content">
            
            	<!-- 검색 -->
            	<div align="right">
               		<form action="attend_list" method="post">
						<select name="searchdeptno" style="width:150px;">
	                        <option value= "">부서</option>
	                        <option value="100">영업부</option>
	                        <option value="200">마케팅부</option>
	                        <option value="300">상품개발부</option>
	                        <option value="400">IT부</option>
	                        <option value="500">경영지원부</option>
                   		</select>
                   		<input type="date" name="searchdate" placeholder="날짜" style="width: 200px"/>
               			<input type="text" name="searchname" placeholder="이름을 입력해주세요" style="width: 200px"/>
               			<input type="submit" value="검색" />
               		</form>
                </div>
	
				<!-- 직원 목록 -->
				<div class="address_view" style="height: 560px"> 
	            	<table>
	            		<thead>
	            			<tr>
	            				<th width="100px">사원번호</th>
	            				<th width="110px">이름</th>
	            				<th width="120px">부서</th>
	            				<th width="130px">출근날짜</th>
	            				<th width="130px">출근시간</th>
	            				<th width="130px">퇴근시간</th>
	            				<th width="130px">근무시간</th>
	            				<th width="65px">구분</th>								
	            			</tr>
	            		</thead>
	            		
	            		<tbody style="font-size: 15px;">
	            			<c:set var="list" value="${attendList.list}"></c:set>
	            			<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="9" style="text-align: center;">조회된 내역이 없습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${list.size() != 0}">
								<c:forEach var="vo" items="${list}">
								
									<c:if test="${vo.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
									<c:if test="${vo.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
									<c:if test="${vo.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
									<c:if test="${vo.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
									<c:if test="${vo.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
									
									<tr>
										<td>${vo.empno}</td>
										<td>
											<c:set var="search" value="<span>${searchname}</span>"></c:set>
											${fn:replace(vo.name, searchname ,search)}
										</td>
										<td>${dname}</td>
										<td><fmt:formatDate value="${vo.attdate}" pattern = "yyyy-MM-dd"/></td>
										<td><fmt:formatDate value="${vo.intime}" pattern = "HH:mm:ss"/></td>
										<td><fmt:formatDate value="${vo.outtime}" pattern = "HH:mm:ss"/></td>
										<td><fmt:formatDate value="${vo.worktime}" pattern = "HH:mm:ss"/></td>
										<td>${vo.etc}</td>
									</tr>	
								</c:forEach>
							</c:if>
	            		</tbody>	            		
	            	</table>
	            	
	            </div>
	            
	            <!-- 페이지 이동 -->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${attendList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1'"> 처음 </button></td>
						</c:if>
						<c:if test="${attendList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${attendList.startPage > 1 }">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${attendList.currentPage - 10}'"> << </button></td>
						</c:if>
						<c:if test="${attendList.startPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
						</c:if>
						<c:if test="${attendList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${attendList.currentPage - 1}'"> < </button></td>
						</c:if>
						<c:if test="${attendList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${attendList.startPage}" end="${attendList.endPage}">
							<c:if test="${i == attendList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != attendList.currentPage}">
								<td class='tda' width='30' align='center'><a href='?currentPage=${i}'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${attendList.currentPage < attendList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${attendList.currentPage+1}'"> > </button></td>
						</c:if>
						<c:if test="${attendList.currentPage >= attendList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${attendList.endPage < attendList.totalPage}">
							<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${attendList.currentPage + 10}'"> >> </button></td>
						</c:if>
						<c:if test="${attendList.endPage >= attendList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
						</c:if>
						<c:if test="${attendList.currentPage < attendList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${attendList.totalPage}'"> 끝 </button></td>
						</c:if>
						<c:if test="${attendList.currentPage >= attendList.totalPage}">
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