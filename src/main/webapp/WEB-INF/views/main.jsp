<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="./includes/head.jsp" %>
</head>

<body>

	<!-- haeder -->
	<%@ include file="./includes/header.jsp" %>

	<!-- contents start -->
	<div class="tjcontainer">
	
		<!-- menu list -->	
		<%@ include file="./includes/menu_bar.jsp" %>
		
		<!-- main -->
		<div class="con_middle">
			<!-- =================================contents================================================= -->
			<div class="con1">
				<div class="calendar">
					<div class="calendar_head">
					
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
						
						<!-- 공개범위 설정 -->
						<div>
							<form action="main">
								<select name="shareset" style="width: 100px;">
									<option></option>
									<option value="NO">비공개</option>
									<option value="TEAM">팀공개</option>
									<option value="ALL">전체공개</option>
								</select>
								<input type="submit" value="검색"/>
							</form>
						</div>
					</div>
					
					<table class="calendar_body">

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
												<td class="today" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div>${date.date}</div>
													<div class="dolist" id="area_${date.date}">
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>
											<c:if test="${date.event != null}">
												<td class="today sun" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
													<div class="dolist" id="area_${date.date}">	
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>

										</c:when>
										<c:when test="${status.index%7==6}">
											<c:if test="${date.event == null}">
												<td class="sat" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div>${date.date}</div>
													<div class="dolist" id="area_${date.date}">
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>
											<c:if test="${date.event != null}">
												<td class="sun" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
													<div class="dolist" id="area_${date.date}">	
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>
										</c:when>
										<c:when test="${status.index%7==0}">
							</tr>
							<tr>
								<td class="sun" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
									<div>
										<div>${date.date}</div>
										<c:if test="${date.event != null}">
											<div>${date.event}</div>
										</c:if>
									</div>
									<div class="dolist" id="area_${date.date}">
										<c:if test="${date.todolist.size() != 0}">
											<c:forEach var="dolist" items="${date.todolist}">
												<p style="background: ${dolist.colorcode}">${dolist.content}</p>
											</c:forEach>
										</c:if>
									</div>
								</td>
										</c:when>
										<c:otherwise>
											<c:if test="${date.event == null}">
												<td onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div>${date.date}</div>
													<div class="dolist" id="area_${date.date}">
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>
											
											<c:if test="${date.event != null}">
												<td class="sun" onclick="todoPop(${date.year}, ${date.month}, ${date.date})">
													<div><div>${date.date}</div> <div>${date.event}</div></div>
													<div class="dolist" id="area_${date.date}">
														<c:if test="${date.todolist.size() != 0}">
															<c:forEach var="dolist" items="${date.todolist}">
																<p style="background: ${dolist.colorcode}">${dolist.content}</p>
															</c:forEach>
														</c:if>
													</div>
												</td>
											</c:if>													
										</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>

					</table>
				</div>
			</div>
			<div class="con_bottom">
				<div class="con2">
					<a href="${path}/board/move_board_list?category=공지사항" class="Marking">공지사항</a>
					<table width = "100%">
						<c:forEach var="notice" items="${noticeList.list}" end="5">
							<tr>
								<td><a href='${path}/board/content_list?idx=${notice.idx}&category=공지사항'>${notice.title}</a></td>
								<td align="right"><fmt:formatDate value="${notice.writedate}" pattern = "yyyy-MM-dd(E)"/></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="con3">
					<a href="${path}/board/move_board_list?category=자료실" class="Marking">자료실</a>
					<table width = "100%">
						<c:forEach var="data" items="${dataList.list}" end="5">
							<tr>
								<td><a href='${path}/board/content_list?idx=${data.idx}&category=자료실'>${data.title}</a></td>
								<td align="right"><fmt:formatDate value="${data.writedate}" pattern = "yyyy-MM-dd(E)"/></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- =================================contents================================================= -->
		</div>
		<!-- main -->
		
		<!-- right -->
		<%@ include file="./includes/con_right.jsp" %>

	</div>
	<!-- contents end -->
	
	<!-- footer -->
	<%@ include file="./includes/footer.jsp" %>

	<!-- 일정 등록 Modal -->
	<%@ include file="./includes/insertTodoModal.jsp" %>

</body>

</html>