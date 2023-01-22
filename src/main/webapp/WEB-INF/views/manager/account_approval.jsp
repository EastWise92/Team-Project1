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
    
        <!--menu list-->
        <%@ include file="./manager_menu_bar.jsp" %>
        
        <!-- main -->
        <div class="con_middle">
			<div class="nav">
                <ul>
                    <li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="Manager_Main">관리자</a>&#62;</li>
                    <li><a href="#">인명관리</a>&#62;</li>
                    <li><a href="#">계정승인</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div align="center">   
            
            	<table class="acc_approv_list">
            		<thead>
            			<tr>
            				<th>사원번호</th>
            				<th>이름</th>
            				<th>직급</th>
            				<th>부서</th>
            				<th>전화번호</th>
            				<th>고용일</th>
            				<th>권한</th>
            				<th></th>
            			</tr>
            		</thead>
            		
            		<tbody>
            			<c:set var="list" value="${waitingList.list}"></c:set>
            			
            			<c:if test="${list.size() == 0}">
							<tr>
								<td colspan="7" style="text-align: center;">대기 목록이 없습니다.</td>
							</tr>
						</c:if>
						
						<c:if test="${list.size() != 0}">
							<c:forEach var="vo" items="${list}">
								<tr id="tr${vo.empno}">
									<td>${vo.empno}</td>
									<td>${vo.name}</td>
									<td>
										<select id="position${vo.empno}">
											<option>사원</option>
											<option>대리</option>
											<option>과장</option>
											<option>차장</option>
											<option>팀장</option>
											<option>부장</option>
											<option>전무</option>
											<option>대표이사</option>
										</select>
									</td>
									<td>
										<select id="deptno${vo.empno}">
											<option value="500">경영지원부</option>
											<option value="400">IT부</option>
											<option value="300">상품개발부</option>
											<option value="200">마케팅부</option>
											<option value="100">영업부</option>
										</select>
									</td>
									<td><input id="incnum${vo.empno}" type="text"/></td>
									<td><input id="hiredate${vo.empno}" type="date"/></td>
									<td>
										<input type="radio" name="permission${vo.empno}" checked="checked" value="NO"/> NO
										<input type="radio" name="permission${vo.empno}" value="YES"/> YES
									</td>
									<td><button type="button" onclick="approvalEMP(${vo.empno})" >승인</button>
								</tr>
							</c:forEach>
						</c:if>
            		</tbody>
            		
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