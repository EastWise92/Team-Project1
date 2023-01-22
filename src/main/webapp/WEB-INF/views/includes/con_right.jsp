<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

</head>

<script>
	var tid;

	counter_init();
	
	function counter_init() {
		tid = setInterval("counter_run()", 1000);
	}
	
	function counter_reset() {
		clearInterval(tid);
		sessionStorage.setItem("count", 1800);
		counter_init();
	}
	
	function counter_run() {
		cnt = sessionStorage.getItem("count")
		sessionStorage.setItem("count", --cnt);
		document.all.counter.innerText = time_format(cnt);
		
		if (cnt == 29) {
			alert('자동로그아웃까지 30초 남았습니다.');
		}
		
		if(cnt < 0) {
			clearInterval(tid);
			self.location = "/Intranet_Project/logout";
		}
	}
	
	// 시간 포맷
	function time_format(s) {
		var nHour=0;
		var nMin=0;
		var nSec=0;
		if(s>0) {
			nMin = parseInt(s/60);
			nSec = s%60;
	
			if(nMin>60) {
				nHour = parseInt(nMin/60);
				nMin = nMin%60;
			}
		} 
		if(nSec<10) nSec = "0"+nSec;
		if(nMin<10) nMin = "0"+nMin;
	
		return ""+nHour+":"+nMin+":"+nSec;
	}
</script>
<body>
	<div class="con_right">
		<div class="todolist">
			<div style="height: 40px;">
				<h2>TodoList</h2>
			</div>
			<div class="todoarea">
				<c:if test="${todoList.list.size() != 0}">
					<c:forEach var="vo" items="${todoList.list}">
						<div id="right_todo_div${vo.idx}">
							<c:if test="${vo.status == false}">
								<input id="${vo.idx}status2" type="checkbox" onclick="updatestatus(${vo.idx},${EmpVO.empno},2)"/>
							</c:if>
							<c:if test="${vo.status != false}">
								<input id="${vo.idx}status2" type="checkbox" checked="checked" onclick="updatestatus(${vo.idx},${EmpVO.empno},2)"/>
							</c:if>
							<p style="background: ${vo.colorcode}">${vo.content}</p>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div style="height: 7%;" align="center">
				<button onclick="openInsertTodo(${datedata.year},${datedata.month},${datedata.date})">일정등록</button>
			</div>
		</div>
		
		<!-- <div class="weather"> </div>  -->
		<div class="Session">
			<p id="counter"> -:--:-- </p> 
			<input type="button" value="연장" onclick="counter_reset()">
			<input type="button" value="로그아웃" onclick="location.href='${path}/logout'"/>
		</div>
	</div>
</body>
</html>