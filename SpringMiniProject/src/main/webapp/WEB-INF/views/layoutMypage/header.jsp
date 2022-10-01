<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap"
            rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <style type="text/css">
        *{
            font-family: 'Jua';
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .header div {
            flex: 1;
        }

        .logo {
            flex: 1;
            color: white;
            height: 150px;
            margin-left: 60px;
        }

        .header-mid {
            flex: 5;
        }

        .header-right {
            flex: 1;
            font-size: 20px;
            color: white;
        }
    </style>
</head>
<body>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<div class="header">
    <div class="logo">
        <h1 id="main-text">학원이름</h1>
    </div>
    <div class="header-mid"></div>
    <div class="header-right">
            <span>수능 D-Day</span>
            <span>username님 화이팅</span>
        <c:if test="${sessionScope.loginok==null }">
            <button type="button" id="btnloginMain">로그인</button>
        </c:if>

        <c:if test="${sessionScope.loginok!=null }">
            <b>${sessionScope.loginname}님</b>
            &nbsp;&nbsp;
            <button type="button" id="btnlogoutMain" >로그아웃</button>
        </c:if>
    </div>
</div>

<script>
    $("#btnloginMain").click(function () {
        location.href="${root}/loginF";
    });

    $("#btnlogoutMain").click(function () {
        $.ajax({
            type:"get",
            url:"${root}/logout",
            dataType:"text",
            success:function(res){
                location.reload();
            },
        });
    })
</script>
</body>
</html>