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
                    <li><a href="#">인명관리</a>&#62;</li>
                    <li><a href="move_emp_list">직원조회</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="content">
            
            	<!-- 검색 -->
            	<div align="right">
               		<form action="emp_list" method="post">
						<select name="searchdeptno" style="width:150px;">
	                        <option value= "">부서</option>
	                        <option value="100">영업부</option>
	                        <option value="200">마케팅부</option>
	                        <option value="300">상품개발부</option>
	                        <option value="400">IT부</option>
	                        <option value="500">경영지원부</option>
                   		</select>
               			<input type="text" name="searchname" placeholder="이름을 입력해주세요" style="width: 200px"/>
               			<input type="submit" value="검색" />
               		</form>
                </div>
	
				<!-- 직원 목록 -->
				<div class="address_view" style="height: 550px"> 
	            	<table>
	            		<thead>
	            			<tr>
	            				<th width="90px">사원번호</th>
	            				<th width="100px">이름</th>
	            				<th width="80px">직급</th>
	            				<th width="140px">부서</th>
	            				<th width="120px">직통번호</th>
	            				<th width="160px">이메일</th>
	            				<th width="110px">고용일</th>	
	            				<th width="60px">권한</th>	
	            				<th></th>							
	            			</tr>
	            		</thead>
	            		
	            		<tbody>
	            			<c:set var="list" value="${empList.list}"></c:set>
	            			<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="8" style="text-align: center;">조회된 사원이 없습니다.</td>
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
										<td>${vo.position}</td>
										<td>${dname}</td>
										<td>${vo.incnum}</td>
										<td>${vo.email}</td>
										<td><fmt:formatDate value="${vo.hiredate}" pattern = "yyyy-MM-dd"/></td>
										<td>
											<c:if test="${vo.permission eq 'NO'}">
												<input id="${vo.empno}status" type="checkbox" onclick="updatePMS(${vo.empno},'YES')"/>
											</c:if>
											<c:if test="${vo.permission eq 'YES'}">
												<input id="${vo.empno}status" type="checkbox" checked="checked" onclick="updatePMS(${vo.empno}, 'NO')"/>
											</c:if>
										</td>
										<td onclick="pmPop(${vo.empno}, '${vo.name}')" class="imghover">
											<img src="${path}/images/email.png"/>
											<img src="${path}/images/emailhover.png"/>
										</td>
									</tr>	
								</c:forEach>
							</c:if>
	            		</tbody>	            		
	            	</table>
	            	
	            </div>
	            
	            <!-- 페이지 이동 -->
                <table class="pagebutton" align="center" border="0" cellpadding="0" cellspacing="0" height="30">
					<tr>		
						<c:if test="${empList.currentPage > 1 }">
							<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1'"> 처음 </button></td>
						</c:if>
						<c:if test="${empList.currentPage <= 1 }">
							<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
						</c:if>
						<c:if test="${empList.currentPage > 1}">
							<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${empList.currentPage - 1}'"> < </button></td>
						</c:if>
						<c:if test="${empList.currentPage <= 1}">
							<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
						</c:if>
			 			
						<c:forEach var="i" begin="${empList.startPage}" end="${empList.endPage}">
							<c:if test="${i == empList.currentPage}">
								<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
							</c:if>
							<c:if test="${i != empList.currentPage}">
								<td class='tda' width='30' align='center'><a href='?currentPage=${i}'>${i}</a></td>
							</c:if>
						</c:forEach>	
						
						<c:if test="${empList.currentPage < empList.totalPage}">
							<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${empList.currentPage+1}'"> > </button></td>
						</c:if>
						<c:if test="${empList.currentPage >= empList.totalPage}">
							<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
						</c:if>
						<c:if test="${empList.currentPage < empList.totalPage}">
							<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${empList.totalPage}'"> 끝 </button></td>
						</c:if>
						<c:if test="${empList.currentPage >= empList.totalPage}">
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