<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/head.jsp"%>
<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<link rel="stylesheet" href="${path}/css/appAutocomplete.css">
<link rel="stylesheet" href="${path}/css/approval.css">
</head>

<body>
	<!-- header -->
	<%@ include file="../includes/header.jsp"%>
	<!-- contents start -->
	<div class="tjcontainer">
		<!-- menu list -->
		<%@ include file="../includes/menu_bar.jsp"%>

		<!-- main -->
		<div class="con_middle">
			<div class="nav">
				<ul>
					<li><a href="${path}/approval/approvalMain"><img src="${path}/images/home.png" width="18px"></a>&#62;</li>
					<li><a href="${path}/approval/approvalMain">전자결재</a>&#62;</li>
					<li><a href="${path}/approval/leaveApplicationView">휴가신청서 수신</a></li>
				</ul>
			</div>
			
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="view" value="${approval}"/>
			<c:if test="${view.deptName == 500}"><c:set var="dname" value="경영지원부"></c:set></c:if>
			<c:if test="${view.deptName == 400}"><c:set var="dname" value="IT부"></c:set></c:if>
			<c:if test="${view.deptName == 300}"><c:set var="dname" value="상품개발부"></c:set></c:if>
			<c:if test="${view.deptName == 200}"><c:set var="dname" value="마케팅부"></c:set></c:if>
			<c:if test="${view.deptName == 100}"><c:set var="dname" value="영업부"></c:set></c:if>
											
			<div class="cash-form-section">
				<div class="cash-disbursement">
					<table>
						<thead>
							<tr>
								<td rowspan="3" colspan="4" class="appformtitle">휴 가 신 청 서</td>
								<td rowspan="3" >결 <br> 재</td>
								<td style="height: 30px; width: 100px;">최초승인자</td>
								<td style="width: 100px;">중간승인자</td>
								<td style="width: 100px;">최종승인자</td>
							</tr>
							<tr class="signImg">
								<c:choose>
									<c:when test="${approval.appPresent eq 'A'}">
										<td name="firstA" id="firstA">${approval.firstApprover}</td>
										<td name="interimA" id="interimA">${approval.interimApprover}</td>
										<td name="finalA" id="finalA">${approval.finalApprover}</td>
									</c:when>
									<c:when test="${approval.appPresent eq 'B'}">
										<td name="firstA" id="firstA">${approval.firstApprover}
											<img src="${path}/images/${signImg}"/></td>
										<td name="interimA" id="interimA">${approval.interimApprover}</td>
										<td name="finalA" id="finalA">${approval.finalApprover}</td>
									</c:when>
									<c:when test="${approval.appPresent eq 'C'}">
										<td name="firstA" id="firstA">${approval.firstApprover}
											<img src="${path}/images/approved.png" /><td>
										<td name="interimA" id="interimA">${approval.interimApprover}
											<img src="${path}/images/${signImg}" /></td>
										<td name="finalA" id="finalA">${approval.finalApprover}</td>
									</c:when>
									<c:when test="${approval.appPresent eq 'D'}">
										<td name="firstA" id="firstA">${approval.firstApprover}
											<img src="${path}/images/approved.png" /></td>
										<td name="interimA" id="interimA">${approval.interimApprover}
											<img src="${path}/images/approved.png"/></td>
										<td name="finalA" id="finalA">${approval.finalApprover}
											<img src="${path}/images/${signImg}"/></td>
									</c:when>
									<c:otherwise>
										<td name="firstA" id="firstA">${approval.firstApprover}</td>
										<td name="interimA" id="interimA">${approval.interimApprover}</td>
										<td name="finalA" id="finalA">${approval.finalApprover}</td>
									</c:otherwise>
								</c:choose>
							</tr>
							<tr class="singBtn">
								<c:choose>
									<c:when test="${empVO.empno eq approval.firstApprover && approval.appPresent eq 'A'}">
										<td><input type="button" name="Approver1" id="Approver1" value="결재서명" /></td>
										<td><input type="button" name="Approver2" id="Approver2" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver3" id="Approver3" value="결재서명" disabled /></td>
									</c:when>
									<c:when test="${empVO.empno eq approval.interimApprover && approval.appPresent eq 'B'}">
										<td><input type="button" name="Approver1" id="Approver1" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver2" id="Approver2" value="결재서명" /></td>
										<td><input type="button" name="Approver3" id="Approver3" value="결재서명" disabled /></td>
									</c:when>
									<c:when test="${empVO.empno eq approval.finalApprover && approval.appPresent eq 'C'}">
										<td><input type="button" name="Approver1" id="Approver1" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver2" id="Approver2" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver3" id="Approver3" value="결재서명" /></td>
									</c:when>
									<c:otherwise>
										<td><input type="button" name="Approver1" id="Approver1" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver2" id="Approver2" value="결재서명" disabled /></td>
										<td><input type="button" name="Approver3" id="Approver3" value="결재서명" disabled /></td>
									</c:otherwise>
								</c:choose>
							</tr>
							<tr class="formrefer">
								<td width="120px"> 수신참조자 </td>
								<td colspan="7">
									<textArea readonly name="referList" id="referList" rows="1">${approval.referList}</textArea>
								</td>
							</tr>
						</thead>
						<tbody></tbody>
						<tr class="writeinfo">
							<td colspan="8">
								<div>
									<p>성명</p>
									<p><input type="text" name="writeName" value="${approval.userName}" readonly /></p>
									<p>부서</p>
									<p><input type="text" value="${dname}" readonly></p>
									<p>성명</p>
									<p><input type="text" value="${approval.rank}" readonly></p>
								</div>
							</td>
						</tr>
						<tr class="bisang">
							<td colspan="3">비 상 연 락 망</td>
							<td colspan="5">${approval.appEmergncyCall}</td>
						</tr>
						<tr class="gigan">
							<td colspan="3">기 간</td>
							<td colspan="5">
								<fmt:formatDate value="${approval.leaveStart}" pattern="yyyy 년 MM 월 dd 일" />
								&nbsp;&nbsp; ~ &nbsp;&nbsp;
								<fmt:formatDate value="${approval.leaveFinish}" pattern="yyyy 년 MM 월 dd 일" />
							</td>
						</tr>
						<tr>
							<td height="40px">휴가 구분</td>
							<td colspan="7">${ approval.leaveClassify }</td>
						</tr>
						<tr class="contentarea">
							<td>세부사항</td>
							<td colspan="7">
								<input style="height: 100px; overflow: auto;" type="text" value="${ approval.leaveDetail}" readonly>
							</td>
						</tr>
						<tr>
							<td colspan="8" height="50px">위와 같이 휴가를 신청하오니 결재 바랍니다.</td>
						</tr>
						<tr>
							<td colspan="8" height="50px">
							<fmt:formatDate value="${approval.appWriteDate}" pattern="yyyy 년 MM 월 dd 일" /></input>
							</td>
						</tr>
						<tr class="signName">
							<td colspan="8" > 신청자 : ${approval.userName} (인)</td>
						</tr>
					</table>
				</div>


				<div id="button">
					<input type="hidden" name="appNo" value = "${approval.appNo}"/>
					<c:choose>
						<c:when test="${(empVO.empno eq approval.firstApprover && approval.appPresent eq 'A') ||
		        						(empVO.empno eq approval.interimApprover && approval.appPresent eq 'B')}">
							<button type="submit" id="approveddone">결재</button>
							<button type="submit" id="canceldone" onclick="showCancelForm(${approval.appNo}, '${approval.appPresent}')">반려</button>
						</c:when>
						<c:otherwise>
							<button type="submit" id="approveddone" disabled>결재</button>
							<button type="submit" id="canceldone" disabled>반려</button>
						</c:otherwise>
					</c:choose>
	
					<button><a href="${path}/approval/approvalMain" style="color:black">취소</a></button>
				</div>
			</div>

			<!-- 결재승인버튼 스크립트 -->
			<script>
				$("#Approver1").one("click",function(){
	          
					$.ajax({
						type: "post",
						url: "${path}/approval/loaApproved1?appNo="+${approval.appNo},
						success: function(){
							Swal.fire({
								icon: 'success',
								title: '결재서명이 \n완료되었습니다.'
		 	     			})
							$("#firstA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
		               }, error: function(){ alert("잠시 후 다시 시도해주세요."); }
					});
				});
	       
				$("#Approver2").one("click",function(){
			          
					$.ajax({
						type: "post",
						url: "${path}/approval/loaApproved2?appNo="+${approval.appNo},
						success: function(){
							Swal.fire({
								icon: 'success',
								title: '결재서명이 \n완료되었습니다.'
							})
							$("#interimA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
						}, error: function(){ alert("잠시 후 다시 시도해주세요."); }
					});
				});
			      
				$("#Approver3").one("click",function(){
				    
				    $.ajax({
				          type: "post",
				          url: "${path}/approval/loaApproved3?appNo="+${approval.appNo},
				          success: function(){
				          	Swal.fire({
				 			   icon: 'success',
				 			   title: '결재서명이 \n완료되었습니다.'
				 			})
				            $("#finalA").append('<img src="${path}/images/approved.png" id="checkIfApproved" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />');
				         },
				          error: function(){ alert("잠시 후 다시 시도해주세요."); }
				    });
				 });
	      	</script>
	
			<!-- 하단 결재버튼 -->
			<script>
		   		$("#approveddone").click(function() {
		   			if($('#checkIfApproved').length > 0) {
		   				var url = "${path}/approval/approvalMain";
			   			alert("결재가 완료되었습니다.");
			   	        $(location).attr('href', url);  			
		   			} else {
		   				var url = "${path}/approval/letterOfApprovalView?appNo="+${approval.appNo};
		   				alert("결재서명 후 결재를 진행해주세요.");
		   			}
		   		});
			</script>
	
			<script type="text/javascript">
				function leaveStartAndFinish() {
					var StartDate = document.getElementById('hiddenStartDate');
					var leaveFinish = document.getElementById('leaveFinish');
					var leaveDate = document.getElementById('leaveDate');
				   
					StartDate = ${approval.leaveStart};
					leaveFinish = ${approval.leaveFinish};
				   
					leaveDate.innerHTML += StartDate + "  ~  " + leaveFinish;
				}
			</script>

		</div>
		
		<!-- right -->
		<%@ include file="../includes/con_right.jsp"%>
		
	</div>

	<%@ include file="../approval/cancel.jsp"%>

	<!-- footer -->
	<%@ include file="../includes/footer.jsp"%>
	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/todoModal.jsp"%>
</body>
</html>