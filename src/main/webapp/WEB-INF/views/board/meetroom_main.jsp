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
                    <li><a href="#">회의실 예약</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="calendar">
				<div style="padding: 20px;">
					<!--날짜 네비게이션  -->
					<div class="navigation">
						<a href="?year=${datedata.year-1}&month=${datedata.month}">
							&lt;&lt;
						</a> 
						<a href="?year=${datedata.year}&month=${datedata.month - 1}">
							&lt;
						</a> 
						<span>
							&nbsp;${datedata.year}. <c:if
								test="${datedata.month + 1 <10}">0</c:if>${datedata.month + 1}
						</span> 
						<a href="?year=${datedata.year}&month=${datedata.month+1}">
							&gt;
						</a> 
						<a href="?year=${datedata.year+1}&month=${datedata.month}">
							&gt;&gt;
						</a>
					</div>

					<table class="calendar_body" style="height: 600px">

						<thead>
							<tr bgcolor="#CECECE">
								<td class="sun">일</td>
								<td>월</td>
								<td>화</td>
								<td>수</td>
								<td>목</td>
								<td>금</td>
								<td class="sat">토</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:forEach var="date" items="${dateList}" varStatus="status">
									<c:choose>
										<c:when test="${date.status == 'today'}">
											<c:if test="${date.event == null}">
												<td class="today" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div>${date.date}</div>
												</td>
											</c:if>
											<c:if test="${date.event != null}">
												<td class="today sun" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
												</td>
											</c:if>

										</c:when>
										<c:when test="${status.index%7==6}">
											<c:if test="${date.event == null}">
												<td class="sat" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div>${date.date}</div>
												</td>
											</c:if>
											<c:if test="${date.event != null}">
												<td class="sun" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
												</td>
											</c:if>
										</c:when>
										<c:when test="${status.index%7==0}">
							</tr>
							<tr>
								<td class="sun" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
									<div>
										<div>${date.date}</div>
										<c:if test="${date.event != null}">
											<div>${date.event}</div>
										</c:if>
									</div>
								</td>
										</c:when>
										<c:otherwise>
											<c:if test="${date.event == null}">
												<td onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div>${date.date}</div>
												</td>
											</c:if>
											
											<c:if test="${date.event != null}">
												<td class="sun" onclick="location.href='meetroom_select?year=${date.year}&month=${date.month+1}&date=${date.date}'">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
												</td>
											</c:if>													
										</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>

					</table>

				</div>
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