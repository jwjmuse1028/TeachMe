<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&family=Yeon+Sung&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<style>
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
</style>
<body>
<c:set var="root" value="<%=request.getContextPath() %>"/>
<div class="container" style="width: 800px; padding: 50px; font-family: Noto Sans KR;">
  <form action="update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="boardnum" value="${dto.boardnum}">
    <input type="hidden" name="currentPage" value="${currentPage}">
    <input type="hidden" name="usernum" value="${sessionScope.usernum}">
    <table class="table table-bordered">
      <tr>
        <th style="text-align: center;">유형</th>
        <td>
          <label><input type="radio" name="boardtype" value="free" ${dto.boardtype.equals("free")?"checked":""}>&nbsp;자유</label>
          <label><input type="radio" name="boardtype" value="ask" ${dto.boardtype.equals("ask")?"checked":""}>&nbsp;질문</label>
        </td>
      </tr>
      <tr>
        <th style="width: 100px; text-align: center;">제목</th>
        <td>
          <input type="text" name="subject" class="form-control" required="required" value="${dto.subject}">
        </td>
      </tr>
      <tr>
        <th style="width: 100px; text-align: center;">사진</th>
        <td>
          <div class="phototag">
            <input type="file" name="upload" class="form-control" multiple="multiple" id="upload" value="${dto.photo}">
          </div>
        </td>
      </tr>
      <tr>
        <td colspan="2">
					<textarea name="content" class="form-control" required="required"
                              style="height: 400px;">${dto.content}</textarea>
        </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <button type="submit" class="boardbtn">수정하기</button>
          <button type="button" class="boardbtn" onclick="history.back();">뒤로가기</button>
        </td>
      </tr>
    </table>
  </form>
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