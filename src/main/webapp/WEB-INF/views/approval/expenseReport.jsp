<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../includes/head.jsp"%>
	<link rel="stylesheet" href="${path}/css/approvalStyle.css">
	<link rel="stylesheet" href="${path}/css/appAutocomplete.css">
	<link rel="stylesheet" href="${path}/css/approval.css">
	<% Calendar today =  Calendar.getInstance(); %>
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
					<li><a href="${path}/approval/expenseReport">지출결의서 작성</a></li>
				</ul>
			</div>
			
			<div class="cash-form-section">
				<form action="${path}/approval/expenseReport_insert" method="POST" id = "erWriteForm" name="erWriteForm" onsubmit="check_onclick()">
					<div class="cash-disbursement">
						<table>
							<thead>
								<tr>
									<td rowspan="2" colspan="4" class="appformtitle">지 출 결 의 서</td>
									<td rowspan="2" >결 <br> 재</td>
									<td style="height: 30px; width: 100px;">최초승인자</td>
									<td style="width: 100px;">중간승인자</td>
									<td style="width: 100px;">최종승인자</td>
								</tr>
								<tr>
									<td style="">
										<input type="hidden" value="" id="firstApprover" name="firstApprover" readonly class="nameView">
										<input type="text" value="" id="firstApproverName" name="firstApproverName" readonly class="nameView">
										<input type="button" value="검색" class="searchMember" id="firstBtn" name="firstApprover" onclick="showEmployeeSearchForm(this)">
									</td>
									<td>
										<input type="hidden" value="" id="interimApprover" name="interimApprover" readonly class="nameView">
										<input type="text" value="" id="interimApproverName" name="interimApproverName" readonly class="nameView">
										<input type="button" value="검색" class="searchMember" id="secondBtn" name="interimApprover" onclick="showEmployeeSearchForm(this)">
									</td>
									<td>
										<input type="hidden" value="" id="finalApprover" name="finalApprover" readonly class="nameView">
										<input type="text" value="" id="finalApproverName" name="finalApproverName" readonly class="nameView">
										<input type="button" value="검색" class="searchMember" id="thirdBtn" name="finalApprover" onclick="showEmployeeSearchForm(this)">
									</td>
								</tr>
								<tr class="formrefer">
									<td>
										<button class="send-open" type="button">수신참조자 +</button>
									</td>
									<td colspan="7">
										<textArea readonly name="referList" id="referList" rows="1"></textArea>
									</td>
								</tr>
							</thead>
							
							<tbody>
								<tr class="writeinfo">
									<td colspan="8">	
										<div>							
											<p>성명</p>			
											<p><input type="text" name="writeName" value="${EmpVO.name}" readonly/></p>			
											<p>부서</p>			
											<p><input type="text" value="${deptname}" readonly></p>			
											<p>성명</p>			
											<p><input type="text" value="${EmpVO.position}" readonly></p>		
										</div>	
									</td>
								</tr>
								<tr class="writeamount">
									<td colspan="1">지출금액</td>
									<td colspan="7">
										<input type="text" name="allAmount" id="allAmount">
										<select id="moneytaryUnit" name="moneytaryUnit">
											<option value="">화폐단위</option>
											<option value="KRW">KRW</option>
											<option value="USD">USD</option>
											<option value="CNY">CNY</option>
											<option value="JPY">JPY</option>
										</select>
									</td>
								</tr>
								<tr>
									<td width="100px">제 목</td>
									<td colspan="7"><input type="text" name="erTitle" id="erTitle"></td>
								</tr>
								<tr>
									<td rowspan="10" style="width: 80px; height: 100%">내 역</td>
									<td colspan="2">적 요</td>
									<td colspan="2">금 액</td>
									<td colspan="3">비 고</td>
								</tr>
								<tr id="putContents">
									<td colspan="2"><input type="text" name="erDetail" id="erDetail"></td>
									<td colspan="2"><input type="text" name="erAmount" id="erAmount"></td>
									<td colspan="3"><input type="text" name="erReference" id="erReference" value="-"></td>
								</tr>
								<tr>
									<td colspan="8" height="100px">위 금액을 청구하오니 결재바랍니다.</td>
								</tr>
								<tr>
									<td colspan="8" height="150px">
										<%= today.get(java.util.Calendar.YEAR) %> 년 &nbsp; 
										<%= today.get(java.util.Calendar.MONTH) + 1 %> 월 &nbsp; 
										<%= today.get(java.util.Calendar.DATE) %> 일 &nbsp;
									</td>
								</tr>
								<tr class="signup">
				                    <td colspan="8">
					                    <div>
					                        <input type="button" name="proposer" id="proposer" value="서명" />
					                        <span>영수인 :  </span><textArea name="proposerText" id="proposerText"></textArea> <span>(인)</span>
				                        </div>
				                    </td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="button">
					<input type="hidden" name="appKinds" value="지출결의서">
						<button type="submit">등록</button>
						<button type="reset">취소</button>
					</div>
				</form>
			</div>

			<script>
			function check_onclick() {
				
			    if ($('#allAmount').val() == "" || $('#erTitle').val() == "") {
			    	alert('지출금액 또는 제목란이 비어있습니다.');
			    	$('#erTitle').focus();
				    return false;
				    
			    } if ($('#proposerText').val() == "") {
			       	alert("서명 후 등록을 완료해주세요.");
			       return false;
			       
			    }  if($('#moneytaryUnit').val() == "") {
			    	alert("화폐단위를 선택해주세요.");
				    return false;
				    
			    } else {
					return true;
				}
			}
			</script>
			
			
			<script>
				$(document).ready(function(){
				    //키를 누르거나 떼었을때 이벤트 발생
				    $("#allAmount").bind('keyup keydown',function(){
				        inputNumberFormat(this);
				    });
				
				    //입력한 문자열 전달
				    function inputNumberFormat(obj) {
				        obj.value = comma(uncomma(obj.value));
				    }
				      
				    //콤마찍기
				    function comma(str) {
				        str = String(str);
				        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
				    }
				
				    //콤마풀기
				    function uncomma(str) {
				        str = String(str);
				        return str.replace(/[^\d]+/g, '');
				    }
				
				    //숫자만 리턴(저장할때)
				    //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
				    function cf_getNumberOnly (str) {
				        var len      = str.length;
				        var sReturn  = "";
				
				        for (var i=0; i<len; i++){
				            if ( (str.charAt(i) >= "0") && (str.charAt(i) <= "9") ){
				                sReturn += str.charAt(i);
				            }
				        }
				        return sReturn;
				    }
				});
			</script>
			
			<!-- 서명 클릭 스크립트  -->
			<script>
				$("#proposer").one("click",function(){
			 		var proposerValue = $("input[name='writeName']").val();
			 	
			 		$("#proposerText").append(proposerValue);
				});
			</script>
			
			<!-- 적요 금액 비고 칸 추가 및 삭제 -->
			<script>
				$("#addRow").on("click", function() {
					
					$('#putContents').after(
						 '<tr id="putContents">'
			            +'<td colspan="2"><input type="text" name="erDetail" id="erDetail"></td>'
			            +'<td colspan="2"><input type="text" name="erAmount" id="erAmount"></td>'
			            +'<td colspan="3"><input type="text" name="erReference" id="erReference" value="-"></td>'
			        	+'</tr> '
			        )
				}); 
				$('#deleteRow').on('click', function() {
					$('#putContents').detach();
				});
			</script>

		</div>
		<!-- right -->
		<%@ include file="../includes/con_right.jsp"%>
	</div>

	<!-- 수신참조자 modal/script/ajax -->
	<%@ include file="../approval/selectReferList.jsp"%>

	<!-- 사원 검색  -->
	<%@ include file="../approval/searchEmployee.jsp"%>

 	<!-- footer -->
	<%@ include file="../includes/footer.jsp"%>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/todoModal.jsp"%>
</body>
</html>
