<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<!-- jstl 사용 선언 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="path" value="${pageContext.request.contextPath}" />

<meta charset="UTF-8">
<title>1조 팀프로젝트</title>
<link rel="icon" href="${path}/images/apple.png">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/css/tjeoun_reset.css">
<link rel="stylesheet" href="${path}/css/tjoeun_main.css">
<link rel="stylesheet" href="${path}/css/tjoeun_layout.css">
<link rel="stylesheet" href="${path}/css/calendar.css">
<link rel="stylesheet" href="${path}/css/todo.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script src="${path}/js/jquery-3.6.1.js"></script>
<script src="${path}/js/tjeoun_menu.js" defer="defer"></script>
<script src="${path}/js/todo.js" defer="defer"></script>
<script src="${path}/js/pm.js" defer="defer"></script>
<script src="${path}/js/commentService.js" defer="defer"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

</head>

</html>