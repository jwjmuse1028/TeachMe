<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&family=Yeon+Sung&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style type="text/css">

        #main_menu {
            position: fixed;
            width: 70px;
            height: 210px;
            right: 60px;
            border-radius: 70px;
            top: 35%;
            text-align: center;

        }
        .cuz {
            width: 100px;
        }

        ul {
            padding: 0;
        }

        li {
            list-style: none;
            line-height: 34px;
        }

        a {
            text-decoration: none;
            color: black;
            text-align: center;
        }

        .snd_menu {
            background: #efefef;
        }

        .sub_menu {
            display: none;
        }

        #test_obj {
            position: fixed;
            width: 70px;
            height: 210px;
            right: 50px;
            border-radius: 70px;
            top: 550px;
            border: 1px solid;
            border-color: grey;
        }
        .boardbtn{
            width: 100px;
            height: 40px;
            border-radius: 15px;
            background-color: white;
            border: 1px solid black;
        }
        .boardbtn:hover {
            background-color: lightgrey;
        }
    </style>
</head>
<body>
<div class="container" style="width: 1000px; padding: 50px; font-family: Noto Sans KR;">
    <c:set var="root" value="<%=request.getContextPath() %>"/>
    <h1 style="text-align: center;">${boardtype.equals('free')?"자유게시판":"질문게시판"}</h1><br>
    <div class="btn-group" style="align-content: center;">
        <button type="button" class="boardbtn" onclick="location.href='${root}/board/boardFree?boardtype=free'">자유</button>&nbsp;
        <button type="button" class="boardbtn" onclick="location.href='${root}/board/boardFree?boardtype=ask'">질문</button>
    </div>
                <button onclick="if(${sessionScope.loginok==null}){alert('로그인 후 이용해주세요')}
                        else{location.href='${root}/board/boardForm'}" style="float: right;" class="boardbtn">글쓰기</button><br><br>
                <div style="margin: 10px;">
                    <table class="table table-bordered">
                        <tr>
                            <td colspan="5" align="center">
                                <b>이번주 인기게시물 <b style="color: #4481eb;">TOP5</b></b>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 300px; text-align: center;">제목</th>
                            <th style="width: 80px; text-align: center;">작성자</th>
                            <th style="width: 120px; text-align: center;">작성일</th>
                            <th style="width: 50px; text-align: center;">좋아요</th>
                            <th style="width: 50px; text-align: center;">조회</th>
                        </tr>
                        <c:forEach var="hotdto" items="${hotlist}">
                            <tr>
                                <td>
                                    <a href="${root}/board/boardDetail?boardnum=${hotdto.boardnum}&currentPage=1" style="text-decoration: none; color: black;">${hotdto.subject}</a>
                                    <c:if test="${hotdto.photo!='no'}">
                                        <i class="fa fa-image" style="font-size:20px"></i>
                                    </c:if>
                                    <c:if test="${hotdto.reboardcount>0}">
                                        <b>[${hotdto.reboardcount}]</b>
                                    </c:if>
                                </td>
                                <td style="text-align: center;">${hotdto.nickname}</td>
                                <td style="text-align: center;">
                                    <fmt:formatDate value="${hotdto.writeday}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td style="text-align: center;">${hotdto.likes}</td>
                                <td style="text-align: center;">${hotdto.readcount}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <br>
                <div class="boardlist" style="margin: 10px;">
                    <c:set var="root" value="<%=request.getContextPath() %>"/>
                    <table class="table table-bordered" style="width: 100%;">
                        <tr>
                            <th style="width:50px; text-align: center;">번호</th>
                            <th style="width: 300px; text-align: center;">제목</th>
                            <th style="width: 80px; text-align: center;">작성자</th>
                            <th style="width: 120px; text-align: center;">작성일</th>
                            <th style="width: 50px; text-align: center;">조회</th>
                        </tr>
                        <c:forEach var="dto" items="${list}">
                            <tr>
                                <td style="text-align: center;">${no}</td>
                                <c:set var="no" value="${no-1}"/>
                                <td>
                                    <a href="${root}/board/boardDetail?boardnum=${dto.boardnum}&currentPage=${currentPage}" style="text-decoration: none; color: black;">${dto.subject}</a>
                                    <c:if test="${dto.photo!='no'}">
                                        <i class="fa fa-image" style="font-size:20px"></i>
                                    </c:if>
                                    <c:if test="${dto.reboardcount>0}">
                                        <b style="color: #4481eb;">[${dto.reboardcount}]</b>
                                    </c:if>
                                </td>
                                <td style="text-align: center;">${dto.nickname}</td>
                                <td style="text-align: center;">
                                    <fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td style="text-align: center;">${dto.readcount}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="searcharea">
                    <form action="boardFree">
                        <div class="input-group" style="justify-content: center;">
                            <select style="width: 100px; text-align: center;" name="searchcolumn">
                                <option value="subject">제목</option>
                                <option value="nickname">작성자</option>
                                <option value="content">내용</option>
                            </select>
                            <input type="text" name="searchword" style="width: 200px; border-width: thin thin thin thin;" placeholder="검색어" value="${param.searchword}">
                            <button type="submit" class="boardbtn" style="border-radius: inherit;">검색</button>
                        </div>
                    </form>
                </div><br>
                <!--페이징-->
                <div class="paging">
                    <ul class="pagination" style="justify-content: center;">
                        <c:if test="${startPage>1}">
                            <li class="page-item"><a href="boardFree?boardtype=${boardtype}&currentPage=${startPage-1}" class="page-link boardbtn" style="color: black;">이전</a></li>
                        </c:if>

                        <!-- 페이지번호 -->
                        <c:forEach var="pp" begin="${startPage}" end="${endPage}">
                            <c:if test="${pp==currentPage}">
                                <li class="page-item"><a class="page-link boardbtn" href="boardFree?boardtype=${boardtype}&currentPage=${pp}" style="color: black; background-color: lightgrey; border-radius: inherit; box-shadow: none;">${pp}</a></li>
                            </c:if>
                            <c:if test="${pp!=currentPage}">
                                <li class="page-item"><a class="page-link boardbtn" href="boardFree?boardtype=${boardtype}&currentPage=${pp}" style="color: black; border-radius: inherit; box-shadow: none;">${pp}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${endPage<totalPage}">
                            <li class="page-item"><a href="boardFree?boardtype=${boardtype}&currentPage=${endPage+1}" class="page-link boardbtn" style="color: black;">다음</a></li>
                        </c:if>
                    </ul>
                </div>
        </div>

<nav class="cuz">
    <ul id="main_menu">
        <div class="btn_gotop"><a href="#"><img src="../image/tttt.png"
                                                style="width: 70%; background-color:transparent; color: black;"></a>
        </div>
        <br>
        <br>
        <li><a href="javascript:dos()" style="color: black;"><img src="../image/pointt.png"
                                                                  style="width: 80%; background-color:transparent; color: black;"></a>
            <ul class="snd_menu sub_menu" style=" background-color:transparent;">
                <br>
                <li><a href="${root}/lecture/lectureList"><img src="../image/yu.png"
                                                               style="width: 100%; background-color:transparent; color: black;">강의</a>
                </li>
                <br>
                <li><a href="${root}/board/boardFree"><img src="../image/cccb.png"
                                                           style="width: 100%;padding-left:10px;">커뮤니티</a></li>
                <br>
                <li><a href="${root}/qna/qnaList"><img src="../image/1ask.png" style="width:130%; padding-right: 25px;">문의하기</a>
                </li>
            </ul>
        </li>
    </ul>
</nav>

<script>
    $(document).ready(function dos() {
        $('#main_menu > li > a').click(function () {
            $(this).next($('.snd_menu sub_menu')).slideToggle('fast');
        })
    })
</script>
    </body>
</html>