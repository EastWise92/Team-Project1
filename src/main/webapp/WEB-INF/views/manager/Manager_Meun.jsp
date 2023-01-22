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
    
        <!--menu list start-->
        <div class="con_left">
            <ul class="menu_box" style="height: 650px;">
                <li class="menu_under">
                    <div class="menu">
                        <span>관리자</span>
                    </div>
                    <ul class="menuSub">
                       <li><a href="#">결재진행</a></li>
                       <li><a href="#">권한설정</a></li>
                       <li><a href="#">인명관리</a></li>
                       <li><a href="#">직원 근태현황</a></li>
                       <li><a href="#">공지사항 작성/관리</a></li>
                    </ul>
                </li>
                
                <li class="menu_under">
                    <div class="menu">
                        <span>인명관리</span>
                    </div>
                    <ul class="menuSub">
                       <li><a href="account_approval">계정승인</a></li>
                       <li><a href="#">사원조회</a></li>
                       <li><a href="#">사원등록</a></li>
                    </ul>
                </li>
                
                <li class="menu_under">
                    <div class="menu">
                        <span>게시글 관리</span>
                    </div>
                    <ul class="menuSub">
                       <li><a href="#">자유게시판</a></li>
                       <li><a href="#">공지사항</a></li>
                       <li><a href="#">자료실</a></li>
                       <li><a href="#">Q&A</a></li>
                    </ul>
                </li>
                
            </ul>
            
        </div>
        <!-- menu list end -->
        
        <!-- main -->
        <div class="con_middle">
            <div class="nav">
                <ul>
                	<li><a href="../main"><img src="../images/home.png" alt="home" width="18px"></a>&#62;</li>
                    <li><a href="Manager_Menu">관리자</a></li>
                </ul>
            </div>
            <!-- =================================contents================================================= -->
            <div align="center">   
            
            	<h1 style="line-height: 600px">추 후 공 개</h1>	
     
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
	<%@ include file="../includes/todoModal.jsp" %>

</body>

</html>