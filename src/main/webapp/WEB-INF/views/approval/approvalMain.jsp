<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp"%>
	<link rel="stylesheet" href="${path}/css/approval.css">
</head>

<body>
	<!-- haeder -->
	<%@ include file="../includes/header.jsp"%>

	<!-- contents start -->
	<div class="tjcontainer">

		<!-- menu list -->
		<%@ include file="../includes/menu_bar.jsp"%>

		<!-- main -->
		<div class="con_middle">
			<div class="nav">
				<ul>
					<li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
					<li><a href="${path}/approval/approvalMain">전자결재</a>&#62;</li>
					<li><a href="${path}/approval/approvalMain">전자결재 홈</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />

			<div class="content">
				<div style="text-align: left;">
					<h4>결재현황</h4>
				</div>
				<div class="approval_main_head">

					<div>
						<div>
							<h3>결재대기 : ${countYet}건</h3>
						</div>
						<div>
							<button onclick="location.href='${path}/approval/approvalList?approvalStatus=결재대기&userNo=${EmpVO.empno}'">결재대기</button>
						</div>
					</div>


					<div>
						<div>
							<h3>결재중 : ${countUnder}건</h3>
						</div>
						<div>
							<button onclick="location.href='${path}/approval/approvalList?approvalStatus=결재중&userNo=${EmpVO.empno}'">결재중</button>
						</div>
					</div>

					<div>
						<div>
							<h3>결재완료 : ${countDone}건</h3>
						</div>
						<div>
							<button onclick="location.href='${path}/approval/approvalList?approvalStatus=결재완료&userNo=${EmpVO.empno}'">결재완료</button>
						</div>
					</div>

				</div>
				<hr />
				<!-- 목록view -->
				<div style="text-align: left; height: auto;">
					<h4>결재 수신목록</h4>
				</div>
				<form>
					<table>
						<c:if test="${empty mainList}">
						</table>
							<tr><td colspan="7"><marquee>조회된 결재목록이 없습니다.</marquee></td></tr>
						</c:if>

						<c:if test="${mainList != null}">
							<c:forEach var="list" items="${mainList}">
								<c:if test="${list.deptName == 500}"><c:set var="deptName" value="경영지원부"></c:set></c:if>
								<c:if test="${list.deptName == 400}"><c:set var="deptName" value="IT부"></c:set></c:if>
								<c:if test="${list.deptName == 300}"><c:set var="deptName" value="상품개발부"></c:set></c:if>
								<c:if test="${list.deptName == 200}"><c:set var="deptName" value="마케팅부"></c:set></c:if>
								<c:if test="${list.deptName == 100}"><c:set var="deptName" value="영업부"></c:set></c:if>
								
								<c:choose>
									<c:when test="${list.appKinds eq '품의서'}">
										<c:set var="apptitle" value="${list.loaTitle}"></c:set>
										<c:set var="appmove" value="${path}/approval/letterOfApprovalView?appNo=${list.appNo}"></c:set>
									</c:when>
									<c:when test="${list.appKinds eq '휴가신청서'}">
										<c:set var="apptitle" value="${list.leaveClassify}"></c:set>
										<c:set var="appmove" value="${path}/approval/leaveApplicationView?appNo=${list.appNo}"></c:set>
									</c:when>
									<c:when test="${list.appKinds eq '지출결의서'}">
										<c:set var="apptitle" value="${list.erTitle}"></c:set>
										<c:set var="appmove" value="${path}/approval/expenseReportView?appNo=${list.appNo}"></c:set>
									</c:when>
								</c:choose>
											
								<tr onclick="location.href='${appmove}'">
									<td>${list.rowNum}</td>
									<td>${list.appKinds}</td>
									<td>${apptitle}</td>
									<td>${list.userName}</td>
									<td>${deptName}</td>
									<td><fmt:formatDate value="${list.appWriteDate}" pattern="yyyy/MM/dd" /></td>
									<td>${list.appCheckProgress}</td>
								</tr>
								
							</c:forEach>
						</c:if>
					</table>
				</form>

				<hr/>

				<div class="myDraftDocumentArea">
					<h4>내가 작성한 결재 목록</h4>
					<table>
						<c:if test="${empty mainList1}">
							<tr><td colspan="7"><marquee>조회된 결재목록이 없습니다.</marquee></td></tr>
						</c:if>
	
						<c:if test="${mainList1 != null}">
							<c:forEach var="list" items="${mainList1}">
								<c:if test="${list.deptName == 500}"><c:set var="deptName" value="경영지원부"></c:set></c:if>
								<c:if test="${list.deptName == 400}"><c:set var="deptName" value="IT부"></c:set></c:if>
								<c:if test="${list.deptName == 300}"><c:set var="deptName" value="상품개발부"></c:set></c:if>
								<c:if test="${list.deptName == 200}"><c:set var="deptName" value="마케팅부"></c:set></c:if>
								<c:if test="${list.deptName == 100}"><c:set var="deptName" value="영업부"></c:set></c:if>
								
								<c:choose>
									<c:when test="${list.appKinds eq '품의서'}">
										<c:set var="apptitle" value="${list.loaTitle}"></c:set>
										<c:set var="appmove" value="${path}/approval/letterOfApprovalView?appNo=${list.appNo}"></c:set>
									</c:when>
									<c:when test="${list.appKinds eq '휴가신청서'}">
										<c:set var="apptitle" value="${list.leaveClassify}"></c:set>
										<c:set var="appmove" value="${path}/approval/leaveApplicationView?appNo=${list.appNo}"></c:set>
									</c:when>
									<c:when test="${list.appKinds eq '지출결의서'}">
										<c:set var="apptitle" value="${list.erTitle}"></c:set>
										<c:set var="appmove" value="${path}/approval/expenseReportView?appNo=${list.appNo}"></c:set>
									</c:when>
								</c:choose>
											
								<tr onclick="location.href='${appmove}'">
									<td>${list.rowNum}</td>
									<td>${list.appKinds}</td>
									<td>${apptitle}</td>
									<td>${list.userName}</td>
									<td>${deptName}</td>
									<td><fmt:formatDate value="${list.appWriteDate}" pattern="yyyy/MM/dd" /></td>
									<td>${list.appCheckProgress}</td>
								</tr>
								
							</c:forEach>
						</c:if>
					</table>
				</div>

			</div>
		</div>
		<!-- right -->
		<%@ include file="../includes/con_right.jsp"%>

	</div>

	<!-- footer -->
	<%@ include file="../includes/footer.jsp"%>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/todoModal.jsp"%>

</body>
</html>