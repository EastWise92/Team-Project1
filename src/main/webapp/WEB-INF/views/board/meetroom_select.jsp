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
                    <li><a href="${path}/meetroom_main">회의실 예약</a>&#62;</li>
                    <li><a href="#">${meetdata.year}/${meetdata.month}/${meetdata.date}</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="select_room">
            
            	<table>
            		<thead>
            			<tr><th>103호</th></tr>
            		</thead>
            		<tbody>
            			<c:forEach var="li103" items="${list103.list}">
            				<tr>
            					<c:if test="${li103.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${li103.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${li103.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${li103.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${li103.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
            					<td style="border-bottom: 2px solid #D8D2CB; height: 55px">
									<div style="display: flex;">
										<div style="line-height: 50px; width: 55%">${dname}</div>
										<div  style="line-height: 25px; width: 45%">
											<div>${li103.starttime}</div>
											<div>${li103.endtime}</div>
										</div>
									</div>
								</td>
            				</tr>
            			</c:forEach>	
            			<c:forEach begin="1" end="${5 - list103.list.size()}">	
	            				<tr><td style="border-bottom: 2px solid #D8D2CB; height: 55px"></td></tr>
            			</c:forEach>
            		</tbody>
            		<tfoot>
            			<tr>
            				<td>
            					<button onclick="location.href='meetroom_reserve?roomnum=103&deptno=${EmpVO.deptno}&year=${meetdata.year}&month=${meetdata.month}&date=${meetdata.date}'">예약하기</button>
            				</td>
            			</tr>
            		</tfoot>
            	</table>
            	
            	<table>
            		<thead>
            			<tr><th>222호</th></tr>
            		</thead>
            		<tbody>
            			<c:forEach var="li222" items="${list222.list}">
            				<tr>
            					<c:if test="${li222.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${li222.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${li222.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${li222.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${li222.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
            					<td style="border-bottom: 2px solid #D8D2CB; height: 55px">
									<div style="display: flex;">
										<div style="line-height: 50px; width: 55%">${dname}</div>
										<div  style="line-height: 25px; width: 45%">
											<div>${li222.starttime}</div>
											<div>${li222.endtime}</div>
										</div>
									</div>
								</td>
            				</tr>
            			</c:forEach>	
            			<c:forEach begin="1" end="${5 - list222.list.size()}">	
	            				<tr><td style="border-bottom: 2px solid #D8D2CB; height: 55px"></td></tr>
            			</c:forEach>	
            		</tbody>
            		<tfoot>
            			<tr>
            				<td>
            					<button onclick="location.href='meetroom_reserve?roomnum=222&deptno=${EmpVO.deptno}&year=${meetdata.year}&month=${meetdata.month}&date=${meetdata.date}'">예약하기</button>
            				</td>
            			</tr>
            		</tfoot>
            	</table>
            	
            	<table>
            		<thead>
            			<tr><th>503호</th></tr>
            		</thead>
            		<tbody>
            			<c:forEach var="li503" items="${list503.list}">
            				<tr>
            					<c:if test="${li503.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${li503.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${li503.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${li503.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${li503.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
								<td style="border-bottom: 2px solid #D8D2CB; height: 55px">
									<div style="display: flex;">
										<div style="line-height: 50px; width: 55%">${dname}</div>
										<div  style="line-height: 25px; width: 45%">
											<div>${li503.starttime}</div>
											<div>${li503.endtime}</div>
										</div>
									</div>
								</td>
            				</tr>
            			</c:forEach>
            			<c:forEach begin="1" end="${5 - list503.list.size()}">	
	            				<tr><td style="border-bottom: 2px solid #D8D2CB; height: 55px"></td></tr>
            			</c:forEach>		
            		</tbody>
            		<tfoot>
            			<tr>
            				<td>
            					<button onclick="location.href='meetroom_reserve?roomnum=503&deptno=${EmpVO.deptno}&year=${meetdata.year}&month=${meetdata.month}&date=${meetdata.date}'">예약하기</button>
            				</td>
            			</tr>
            		</tfoot>
            	</table>
            	
            	<table>
            		<thead>
            			<tr><th>710호</th></tr>
            		</thead>
            		<tbody>
            			<c:forEach var="li710" items="${list710.list}">
            				<tr>        				
            					<c:if test="${li710.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${li710.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${li710.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${li710.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${li710.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
            					<td style="border-bottom: 2px solid #D8D2CB; height: 55px">
									<div style="display: flex;">
										<div style="line-height: 50px; width: 55%">${dname}</div>
										<div  style="line-height: 25px; width: 45%">
											<div>${li710.starttime}</div>
											<div>${li710.endtime}</div>
										</div>
									</div>
								</td>
            				</tr>
            			</c:forEach>	
            			<c:forEach begin="1" end="${5 - list710.list.size()}">	
	            				<tr><td style="border-bottom: 2px solid #D8D2CB; height: 55px"></td></tr>
            			</c:forEach>	
            		</tbody>
            		<tfoot>
            			<tr>
            				<td>
            					<button onclick="location.href='meetroom_reserve?roomnum=710&deptno=${EmpVO.deptno}&year=${meetdata.year}&month=${meetdata.month}&date=${meetdata.date}'">예약하기</button>
            				</td>
            			</tr>
            		</tfoot>
            	</table>
            	
            	<table>
            		<thead>
            			<tr><th>901호</th></tr>
            		</thead>
            		<tbody>
            			<c:forEach var="li901" items="${list901.list}">
            				<tr>
            				
            					<c:if test="${li901.deptno == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
								<c:if test="${li901.deptno == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
								<c:if test="${li901.deptno == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
								<c:if test="${li901.deptno == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
								<c:if test="${li901.deptno == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
            					<td style="border-bottom: 2px solid #D8D2CB; height: 55px">
									<div style="display: flex;">
										<div style="line-height: 50px; width: 55%">${dname}</div>
										<div style="line-height: 25px; width: 45%">
											<div>${li901.starttime}</div>
											<div>${li901.endtime}</div>
										</div>
									</div>
								</td>
            				</tr>
            			</c:forEach>
            			<c:forEach begin="1" end="${5 - list901.list.size()}">	
	            				<tr><td style="border-bottom: 2px solid #D8D2CB; height: 55px"></td></tr>
            			</c:forEach>		
            		</tbody>
            		<tfoot>
            			<tr>
            				<td>
            					<button onclick="location.href='meetroom_reserve?roomnum=901&deptno=${EmpVO.deptno}&year=${meetdata.year}&month=${meetdata.month}&date=${meetdata.date}'">예약하기</button>
            				</td>
            			</tr>
            		</tfoot>
            	</table>
            </div>
            <div>
            	<button onclick="history.back()">돌아가기</button>
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