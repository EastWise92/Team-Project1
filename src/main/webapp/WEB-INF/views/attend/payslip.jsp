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
    
		<!-- menu list -->	
		<%@ include file="../includes/menu_bar.jsp" %>
        
        <!-- main -->
        <div class="con_middle">
			<div class="nav">
                <ul>
                    <li><a href="${path}/main"><img src="${path}/images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="move_attend_list">근태관리</a>&#62;</li>
                    <li><a href="move_left_dayoff_list">개인 연차 현황</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div class="content_view">
            	
            	<!-- 검색 -->
            	<div align="right">
               		<form action="payslip" method="post">
                   		<select name="year" style="width: 80px">
                   			<c:forEach begin="1" end="22" var="i"><option>${2024 - i}</option></c:forEach>
                   		</select>
                   		<select name="month" style="width: 50px">
                   			<c:forEach begin="1" end="12" var="i"><option>${i}</option></c:forEach>
                   		</select>
               			<input type="submit" value="검색" />
               		</form>
                </div> <hr>

				<div class="payslip">
					<table width="100%"> 
						<thead>
							<tr>
								<td width="185px">성명 : ${EmpVO.name}</td>
								<td width="240px">부서 : ${deptname}</td>
								<td width="185px">직책 : ${EmpVO.position}</td>
								<td width="240px" align="right">지급일 : ${year}-${month}-10</td>
							</tr>
						</thead>
						<tbody>
							<tr class="back">
								<th>지급 항목</th>
								<th>지급액</th>
								<th>공제 항목</th>
								<th>공제액</th>
							</tr>
							<tr>
								<td>기본급</td>
								<td>${payslip.basepay}</td>
								<td>소득세</td>
								<td>${payslip.incometax}</td>
							</tr>
							<tr>
								<td>직책 수당</td>
								<td>${payslip.posallow}</td>
								<td>지방세</td>
								<td>${payslip.localtax}</td>
							</tr>
							<tr>
								<td>근속 수당</td>
								<td>${payslip.annualpay}</td>
								<td>국민연금</td>
								<td>${payslip.nationpen}</td>
							</tr>
							<tr>
								<td>연장 수당</td>
								<td>${payslip.extpay}</td>
								<td>고용보험</td>
								<td>${payslip.empinsure}</td>
							</tr>
							<tr>
								<td>야간 수당</td>
								<td>${payslip.nightpay}</td>
								<td>건강보험</td>
								<td>${payslip.healthinsure}</td>
							</tr>
							<tr>
								<td>주말 수당</td>
								<td>${payslip.holypay}</td>
								<td>기타 공제</td>
								<td>${payslip.etcdeduce}</td>
							</tr>
							<tr>
								<td>상여금</td>
								<td>${payslip.bonus}</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>기타</td>
								<td>${payslip.etcpay}</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>식대</td>
								<td>${payslip.foodfee}</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>교통비</td>
								<td>${payslip.transefee}</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<th class="back">공제 합계</th>
								<td>${deducesum}</td>
							</tr>
							<tr>
								<th class="back">급여 합계</th>
								<td>${paysum}</td>
								<th class="back">수령액</th>
								<td>${paysum - deducesum}</td>
							</tr>
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
	
	<!-- 쪽지 전송 Modal -->
	<%@ include file="../includes/pmModal.jsp" %>

</body>

</html>