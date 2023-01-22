<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
</head>

<body>
    
	<!--menu list start-->
	<div class="con_left">
	    <ul class="menu_box" style="height: 650px;">
	    <!-- 
	        <li class="menu_under">
	            <div class="menu">
	                <span>결재</span>
	            </div>
	            <ul class="menuSub">
	               <li><a href="#">결재진행</a></li>
	               <li><a href="#">결재완료</a></li>
	            </ul>
	        </li>
	     -->    
	        <li class="menu_under">
	            <div class="menu">
	                <span>인명관리</span>
	            </div>
	            <ul class="menuSub">
	               <li><a href="account_approval">계정승인</a></li>
	               <li><a href="move_emp_list">직원조회</a></li>
	            </ul>
	        </li>

			<li class="menu_under">
				<div class="menu">
					<span onclick="location.href='move_attend_list?'">직원 근태현황</span>
				</div>
			</li>

			<li class="menu_under">
	            <div class="menu">
	                <span onclick="location.href='move_show_all_board?'">게시글 관리</span>
	            </div>
	        </li>
	        
	    </ul>
	    
	    <div align="center">
			<button onclick="location.href='${path}/main'">EXIT</button>
		</div>
	    
	</div>
        <!-- menu list end -->
        
</body>

</html>