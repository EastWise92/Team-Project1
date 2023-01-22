<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/head.jsp"%>
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
					<li><a href="#">게시판</a>&#62;</li>
					<li><a href="#">팀게시판</a></li>
				</ul>
			</div>
			<!-- =================================contents================================================= -->
			<fmt:requestEncoding value="UTF-8" />
			<c:set var="vo" value="${BoardVO}"></c:set>

			<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;') }"></c:set>
			<c:set var="content" value="${fn:replace(content, enter, '<br/>') }"></c:set>

			<div class="content_view">

				<h1 class="board_content_view_title">${vo.title}</h1>
				<div class="board_content_view_undertitle">
					<p class="board_content_view_date" ><fmt:formatDate value="${vo.writedate}" pattern = "yyyy-MM-dd aa h시 mm분"/></p>
					<img class="thums" src="${path}/images/thums.png" alt="thums">
					<p>${vo.hit}</p>
				</div>
				<hr />
				<div style="height: 35%">
					<p>${content}</p>
				</div>

				<c:if test="${vo.attachedfile != null}">
					<div class="attach">
						<img alt="" src="${path}/images/clip.png" width="15x" style="margin: 4px 1px">
						<a href="${path}/Download?filename=${vo.realfilename}">${vo.attachedfile}</a>
					</div>
				</c:if>

				<div class="delORupdate">
					<c:if test="${vo.name == EmpVO.name}">
						<input type="button" value="수정" onclick="location.href='board_update?idx=${vo.idx}&currentPage=${currentPage}'" />
						<input type="button" value="삭제" onclick="location.href='board_delete?idx=${vo.idx}&currentPage=${currentPage}&category=팀 게시판'" />
					</c:if>
				</div>
				<hr />
                <!-- 댓글 폼 -->
                <form action="comment_service?currentPage=${currentPage}&category=팀 게시판" method="post" name="commentForm">
                
                	<table style="width: 100%">
                		<tr>
                			<td align="center">댓글작성</td>
                			<td width="750"><input id="content" type="text" name="content"/></td>
                			<td align="center"><input type="submit" name="btntitle" value="저장하기"/></td>
                		</tr>
                	</table>

					<input id="name" type="hidden" name="name" value="${EmpVO.name}"/>
					<input id="empno" type="hidden" name="empno" value="${EmpVO.empno}"/>
					<input id="deptno" type="hidden" name="deptno" value="${EmpVO.deptno}"/>
					<input id="idx" type="hidden" name="idx" value="${vo.idx}"/>
					<input id="gup"  type="hidden" name="gup" value="${vo.idx}"/>
					<input id="mode" type="hidden" name="mode" value="1"/>
                
					<hr/>
					<!-- 댓글 반복문 -->
					<c:set var="colist" value="${commentList.list}"></c:set>
					<div style="height:170px">
						<input type="hidden" value="${currentPage}" id="rcurrentPage">
						<input type="hidden" value="${BoardVO.idx}" id="contentidx">
						<table style="width: 900px; margin: auto;">	
						
							<c:if test="${colist.size() == 0 }">
								<tr><td colspan="4" align="center">저장된 글이 없습니다.</td></tr>
							</c:if>
							<c:if test="${colist.size() != 0}">
								<c:forEach var="co" items="${colist}">	
									
									<c:set var="cocontent" value="${fn:replace(co.content, '<', '&lt;') }"></c:set>
									<c:set var="cocontent" value="${fn:replace(cocontent, '>', '&gt;') }"></c:set>
									<c:set var="cocontent" value="${fn:replace(cocontent, enter, '<br/>') }"></c:set>	
									
									<tr id="deleteAjax-${co.idx}">
										<td width="800px">		
											<img alt="화살표" src="${path}/images/arrow.png" width="15"/>		
											<span style="font-weight: bold;">${co.name}</span>(<fmt:formatDate value="${co.writedate}" pattern = "yy/MM/dd a h시 mm분"/>) : ${cocontent}
										</td>
										<c:if test="${EmpVO.name == co.name}">
											<td align="right">
												<button type="button" title="수정" style="font-size: 7px" onclick="commentService(${co.idx},2,'수정','${cocontent}','${vo.idx}')">수정</button>
												<button type="button" style="font-size: 7px" class="deleteAjax" id="deleteAjaxIdx-${co.idx}">삭제</button>
											</td>
										</c:if>
									</tr>
									
								</c:forEach>
							</c:if>
						</table>
						<!-- 댓글 반복문 -->
					</form>
				</div>
				
				<div>
					<!-- 페이지 이동 -->
	                <table class="content_pageBtn" style="margin-bottom:0;">
	                <tr>
						<td>		
							<c:if test="${commentList.currentPage > 1 }">
								<td><button type="button" title="첫 페이지로" onclick="location.href='?currentPage=1&idx=${vo.idx}&category=팀 게시판'"> 처음 </button></td>
							</c:if>
							<c:if test="${commentList.currentPage <= 1 }">
								<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> 처음 </button></td>
							</c:if>
							<c:if test="${commentList.startPage > 1 }">
								<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${commentList.currentPage - 10}&idx=${vo.idx}&category=팀 게시판'"> << </button></td>
							</c:if>	
							<c:if test="${commentList.startPage <= 1 }">
								<td><button type="button" title="이미 첫 페이지입니다" disabled="disabled"> << </button></td>
							</c:if>
							<c:if test="${commentList.currentPage > 1}">
								<td><button type="button" title="전 페이지로" onclick="location.href='?currentPage=${commentList.currentPage - 1}&idx=${vo.idx}&category=팀 게시판'"> < </button></td>
							</c:if>
							<c:if test="${commentList.currentPage <= 1}">
								<td><button type="button" title="이미 전 페이지 입니다." disabled="disabled"> < </button></td>
							</c:if>
				 			
							<c:forEach var="i" begin="${commentList.startPage}" end="${commentList.endPage}">
								<c:if test="${i == commentList.currentPage}">
									<td width='30' align='center' style='background: #D8D2CB; border:1px;'>${i}</td>
								</c:if>
								<c:if test="${i != commentList.currentPage}">
									<td class='tda' width='30' align='center' onclick="location.href='?currentPage=${i}&idx=${vo.idx}&category=팀 게시판'">${i}</td>
								</c:if>
							</c:forEach>	
							
							<c:if test="${commentList.currentPage < commentList.totalPage}">
								<td><button type="button" title="다음 페이지로" onclick="location.href='?currentPage=${commentList.currentPage+1}&idx=${vo.idx}&category=팀 게시판'"> > </button></td>
							</c:if>
							<c:if test="${commentList.currentPage >= commentList.totalPage}">
								<td><button type="button" title="이미 마지막 페이지 입니다." disabled="disabled"> > </button></td>
							</c:if>
							<c:if test="${commentList.endPage < commentList.totalPage}">
								<td><button type="button" title="10페이지 이동" onclick="location.href='?currentPage=${commentList.currentPage + 10}&idx=${vo.idx}&category=팀 게시판'"> >> </button></td>
							</c:if>
							<c:if test="${commentList.endPage >= commentList.totalPage}">
								<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> >> </button></td>
							</c:if>
							<c:if test="${commentList.currentPage < commentList.totalPage}">
								<td><button type="button" title="마지막 페이지로" onclick="location.href='?currentPage=${commentList.totalPage}&idx=${vo.idx}&category=팀 게시판'"> 끝 </button></td>
							</c:if>
							<c:if test="${commentList.currentPage >= commentList.totalPage}">
								<td><button type="button" title="이미 마지막 페이지입니다" disabled="disabled"> 끝 </button></td>
							</c:if>
										
						</td>
						<%-- <td width="200px;" align="right">
							<input type="button" value="돌아가기" onclick="location.href='board_list?currentPage=${currentPage}&category=팀 게시판'"/>
						</td> --%>
					</table>
					<div style="float:right;">
						<input type="button" value="목록" onclick="location.href='board_list?currentPage=${currentPage}&category=팀 게시판'"/>
	                </div>
                </div>
            </div>
			<!-- =================================contents================================================= -->

		</div>
		<!-- main -->

		<!-- right -->
		<%@ include file="../includes/con_right.jsp"%>

	</div>
	<!-- contents end -->

	<!-- footer -->
	<%@ include file="../includes/footer.jsp"%>

	<!-- 일정 등록 Modal -->
	<%@ include file="../includes/insertTodoModal.jsp"%>
	
	<script>
		// 팀 게시판 댓글 아작스
		onload = () => {
			{
				const currentPage = document.querySelector("#rcurrentPage").value; // 댓글의 현재 페이지
				const idx = document.querySelector("#contentidx").value; // 글 idx 
				console.log(idx)
				
				const DeleteButtons = document.querySelectorAll(".deleteAjax"); // 삭제 버튼 선택
				DeleteButtons.forEach(btn => {
					// 삭제 이벤트 처리
					btn.addEventListener("click", event => {
						const DeleteButton = event.target;
						
						let ridx = btn.id.substring(14);
		//				const url = "teamboard_reply_delete/" + ridx + "?currentPage=" + currentPage  + "&idx=" + idx + "&category=" + category;
						const url = "teamboard_reply_delete/" + ridx + "/" + currentPage + "/" + idx;
						console.log(url);
						
						fetch(url, {
							method: "GET"
						}).then(response => {
							// 삭제 실패 처리
							if (!response.ok) {
								alert("댓글 삭제 실패");
								return;
							}
							alert("댓글 삭제 완료");
							
							// 현재 페이지를 새로고침 한다.
		//						location.reload();
							
							// then()으로 왔다면 댓글이 이미 삭제가 된 상태이므로 댓글을 표시한 객체를 화면에서 지운다.
		//						let deleteOK = "#deleteAjax-"
							const target = document.querySelector("#deleteAjax-" + ridx);
							console.log(target)
							
							// remove() 함수를 사용하면 화면을 새로고침하지 않고 댓글이 삭제된 결과가 표시된다.
							target.remove();
						})
					});
				});
			}
		}
	</script>

</body>

</html>