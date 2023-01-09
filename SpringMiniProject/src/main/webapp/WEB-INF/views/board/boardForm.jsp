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
<script>
            $(function () {

                // 업로드 된 파일명
                $("#file").on("change",function(){
                    fileName=$("#file")[0].files;
                    fileList="";
                    // 최대 업로드 이미지 수 제한
                    if(fileName.length>5){
                        alert("이미지는 최대 5장까지 첨부 가능합니다.");
                        return false;
                    }
                    var vaildchk=1;      // 유효성 검증 값
                    for(i=0; i<fileName.length; i++){
                        if(checkFileName(fileName[i].name)==true) {      // 파일명 검증
                            fileList +=fileName[i].name+", ";
                        } else {
                            vaildchk=0;      // 유효성 검증 실패
                            break;
                        }
                    }
                    if(vaildchk==1) {
                        fileList=fileList.slice(0, -2);
                        $("input.filename_list").val(fileList);
                    } else {   // vaildchk==0
                        fileList="";
                        $("input.filename_list").val("파일명(확장자)를 확인 후 재업로드 해주세요");
                    }
                });
            });

            //파일명 검증
            function checkFileName(str){
                var ext=str.split(".").pop().toLowerCase();
                var pattern =   /[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi;
                if($.inArray(ext, ["bmp","jpg","png","jpeg","gif"]) == -1) {    // 파일 확장자 체크
                    //alert(ext);
                    alert("이미지 파일만 업로드 가능합니다.\n(업로드 가능 확장자: jpg, png, bmp, gif)");
                    return false;
                } else if(pattern.test(str)){    // 파일명에 특수문자 체크
                    alert("파일명에 특수문자를 제거해주세요.");
                    return false;
                } else {
                    return true;
                }
            }
</script>
    <style>

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
<c:set var="root" value="<%=request.getContextPath() %>"/>
<div class="container" style="width: 800px; padding: 50px; font-family: Noto Sans KR;">
<form action="insert" method="post" enctype="multipart/form-data">
<%--    <input type="hidden" name="email" value="${sessionScope.loginid}">--%>
        <input type="hidden" name="usernum" value="${sessionScope.usernum}">
    <table class="table table-bordered">
        <tr>
            <th style="text-align: center;">유형</th>
            <td>
            <label><input type="radio" name="boardtype" value="free" checked="checked">&nbsp;자유</label>
                <label><input type="radio" name="boardtype" value="ask">&nbsp;질문</label>
            </td>
        </tr>
        <tr>
            <th style="width: 100px; text-align: center;">제목</th>
            <td>
                <input type="text" name="subject" class="form-control" required="required" style="box-shadow: none;">
            </td>
        </tr>
        <tr>
            <th style="width: 100px; text-align: center;">사진</th>
            <td>
                <div class="phototag">
<%--                    <input type='file' name='files' accept='image/jpeg,image/gif,image/png' onchange='chk_file_type(this)' multiple="multiple">--%>
<%--                    <input class="filename_list" readonly="readonly">--%>
                    <input type="file" name="upload" class="form-control" multiple="multiple" id="file" style="box-shadow: none;">
<%--                        <i class="fa fa-plus photoadd" style="font-size:14px"></i>--%>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
					<textarea name="content" class="form-control" required="required"
                              style="height: 400px; box-shadow: none;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit" class="boardbtn">업로드</button>
                <button type="button" class="boardbtn" onclick="history.back()">뒤로가기</button>
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
