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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

        span.likes {
            cursor: pointer;
        }

        .likeusericon{
            cursor: pointer;
        }
        .redelete{
            cursor: pointer;
        }
        .report{
            cursor: pointer;
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
    <script>

        $(function(){

            list();

            initlike();
            //좋아요 숫자 클릭시 좋아요 누른 아이디+닉네임 보이게 하기
            $(".likeusericon").click(function(){
                var boardnum=${dto.boardnum};
                $.ajax({
                    type : "get",
                    url : "likesuser",
                    dataType : "json",
                    data : {"boardnum":boardnum},
                    success : function(res) {
                        var s="";
                        $.each(res,function(i,ids){

                            s+=ids+"<br><br>";
                        });
                        if(res.length==0){
                            s="좋아요한 회원이 없습니다";
                        }
                        Swal.fire({

                            title: "좋아요한 회원들: ${dto.likes}명<br>",

                            html:s,

                            confirmButtonText: "닫기",

                        });

                    }
                });
            });
            $(document).on("click",".redelete", function (){ //댓글삭제
                var reboardnum=$(this).attr("reboardnum");
                var ans=confirm("댓글을 삭제하시겠습니까?");
                if(ans){
                    $.ajax({
                        type:"get",
                        url:"../reboard/delete",
                        dataType:"text",
                        data:{"reboardnum":reboardnum},
                        success:function(res){
                            list();
                        }
                    });
                }
            });
            $(document).on("click",".report", function (){ //게시글 신고
                var boardnum=${dto.boardnum};
                var a='${sessionScope.loginok}';
                if(a==''){
                    alert("로그인 후 이용해주세요");
                    return;
                }
                var ans=confirm("해당 게시글을 신고하시겠습니까?");
                if(ans){
                    $.ajax({
                        type:"get",
                        url:"report",
                        dataType:"text",
                        data:{"boardnum":boardnum},
                        success:function(res){
                            // alert(res);
                            if(res==-1){
                                alert("이미 신고하신 게시글입니다");
                            }
                            else {
                                alert("신고가 접수되었습니다");
                            }
                        }
                    });
                }
            });
        });

        function initlike(){ //좋아요를 한 게시글에 들어갔을때 좋아요가 눌러져있는 상태를 출력하기
            var boardnum=${dto.boardnum};
            var loginok='${sessionScope.loginok}';
            if(loginok=='')
                return;
            $.ajax({
                type : "get",
                url : "likesstate",
                dataType : "json",
                data : {"boardnum":boardnum},
                success : function(res) {
                    if(res==1){

                        $("span.likes i").attr("class","fa fa-thumbs-up").css("color","#4481eb");

                    }
                }
            });
        }
        function list(){
            var loginok = '${sessionScope.loginok}';
            var usernum = '${sessionScope.usernum}';
            var writeuser = '${dto.usernum}';
            var boardnum = ${dto.boardnum};

            var s = "";
            $.ajax({ //댓글댓글댓글댓글댓글댓글
                type : "get",
                url : "../reboard/list",
                dataType : "json",
                data : {"boardnum":boardnum},
                success : function(res) {
                    $("b.banswer").text(res.length);
                    $.each(res, function (i, elt){
                        s+="<div>"
                        if(elt.nickname=='(탈퇴회원)') {
                            s+="<img src='../image/noprofilepicture.png' style='width: 30px; height: 30px;' class='rounded-circle' hspace='10'>";
                        }else{
                            if(elt.userphoto==null) { //댓글프사 없으면 기본프사
                                s+="<img src='../image/noprofilepicture.png' style='width: 30px; height: 30px;' class='rounded-circle' hspace='10'>";
                            }
                            if(elt.userphoto!=null) { //댓글프사 있으면 특정프사
                                s+="<img src='../upload/"+elt.userphoto+"' style='width: 30px; height: 30px;' class='rounded-circle' hspace='10'>";
                            }
                        }
                        s+="<b>"+elt.nickname+"</b>";
                        if (writeuser==elt.usernum){
                            s+="<span class='writer'>(작성자)</span><br>";
                        }
                        s+="<pre>&nbsp;&nbsp;<p style='font-size: 15px; font-family: Noto Sans KR!important;'>"+elt.recontent+"&nbsp;&nbsp;";
                        s+="</p><span class='day' style='color:gray; font-family: Noto Sans KR;!important;'>"+elt.writeday+"&nbsp;";
                        if(loginok=='yes' && usernum==elt.usernum){
                            s+='<i class="fa fa-close redelete" style="font-size:15px; color: black" reboardnum='+elt.reboardnum+'></i>';
                        }
                        s+="</span></pre></div><hr>"
                    });
                    $("div.alist").html(s);
                }
            });
        }
    </script>
</head>
<body>
<c:set var="root" value="<%=request.getContextPath() %>"/>
<div class="container" style="width: 1000px; padding: 100px; font-family: Noto Sans KR;">
    <table class="table table-bordered" style="width: 100%;">
        <tr>
            <td style="padding: 30px;">
                <h2><b>${dto.subject}</b></h2><br>
                <c:if test="${userphoto!='no'}"> <!--작성자의 프사-->
                    <img src="../upload/${userphoto}" width="40" height="40" class="rounded-circle"
                         onerror="this.src='../image/noprofilepicture.png'" hspace="10">
                </c:if>
                <c:if test="${userphoto=='no'}"> <!--작성자의 프사-->
                    <img src="../image/noprofilepicture.png" width="40" height="40" class="rounded-circle" hspace="10">
                </c:if>
                <b>${dto.nickname}</b>
                <span style="color: gray; font-size: 12px;">
					<fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd HH:mm"/>
					&nbsp;&nbsp;
					조회&nbsp; ${dto.readcount}
				</span>
            </td>
        </tr>
        <tr height="200">
            <td style="padding: 30px;">
                <pre style="margin: 15px;"><p style="font-size: 17px; font-family: Noto Sans KR;!important;">${dto.content}</p></pre> <!--작성글 내용-->
                <c:if test="${dto.photo!='no'}">    <!--작성글 첨부사진-->
                    <c:forTokens var="photo" items="${dto.photo}" delims=",">
                        <img src="../upload/${photo}" style="max-width: 400px;"
                             onerror="this.style.display='none'">
                    </c:forTokens>
                </c:if>
                <br><br>
                <span class="likes" style="margin: 10px;">
                <%--<i class='far fa-thumbs-up'></i>--%>
                    <i class="fa fa-thumbs-o-up" style="font-size:24px"><b style="font-size: 15px">
                &nbsp;좋아요</b></i>
				</span>
                &nbsp;
                <span class="likeusericon" data-bs-toggle="modal" data-bs-target="#likeuserModal">
                <%--<i class='fas fa-user-alt' style='font-size:16px'></i>--%>
                    <i class="fa fa-user luser" style="font-size:24px">&nbsp;<b class="likesuser" style="font-size: 15px">
                    ${dto.likes}</b></i>
                </span>

                &nbsp;&nbsp;
                <i class="fa fa-commenting-o" style="font-size:24px">&nbsp;<b class="banswer" style="font-size: 15px">0</b></i>
                <i class="fa fa-warning report" style="font-size:24px; float: right; color: red"><b style="font-size: 15px; color: black;">&nbsp;신고하기</b></i>
                <br><hr>
                <div class="alist"></div>
                <div class="aform">
                    <form id="aform">
                        <input type="hidden" name="boardnum" value="${dto.boardnum}">
                        <input type="hidden" name="usernum" value="${sessionScope.usernum}">
                        <div class="input-group">
                            <c:if test="${sessionScope.loginok!=null}">
                            <textarea name="recontent" id="recontent" style="width: 400px; height: 100px; box-shadow: none;" class="form-control" placeholder="댓글을 입력해주세요"></textarea>
                            <button type="button" class="btn btn-outline-dark" id="btnreboard" style="background-color: whitesmoke; color: black; box-shadow: none;">등록</button>
                            </c:if>
                            <c:if test="${sessionScope.loginok==null}">
                                <textarea name="recontent" id="recontent" style="width: 400px; height: 100px;" class="form-control" placeholder="로그인 후 이용해주세요"></textarea>
                            </c:if>
                        </div>
                    </form>
                </div>
                <div style="text-align: center; float: bottom;"><hr>

                <c:if test="${sessionScope.loginok!=null && sessionScope.usernum==dto.usernum}">
                <button type="button" class="boardbtn" onclick="location.href='boardUpdate?boardnum=${dto.boardnum}&currentPage=${currentPage}'">수정</button>
                <button type="button" class="boardbtn" onclick="if(confirm('게시글을 삭제하시겠습니까?')) location.href='delete?boardnum=${dto.boardnum}&currentPage=${currentPage}'">삭제</button>
<%--                    <button class="boarddelete" type="button">삭제</button>--%>
                </c:if>
                <button type="button" class="boardbtn" onclick="location.href='boardFree?boardtype=${dto.boardtype}&currentPage=${currentPage}'">목록</button>

                </div>
            </td>
        </tr>
    </table>
    <c:if test="${dto.boardnum<maxboardnum}">
        <a href="nextboard?boardnum=${dto.boardnum}&currentPage=${currentPage}" style="color: black; text-decoration: none;">다음글&nbsp;
            <i class="fa fa-chevron-up" style="font-size:24px"></i>&nbsp;&nbsp;${nextboardsub}</a><hr>
    </c:if>
    <c:if test="${dto.boardnum>minboardnum}">
        <a href="prevboard?boardnum=${dto.boardnum}&currentPage=${currentPage}" style="color: black; text-decoration: none;">이전글&nbsp;
            <i class="fa fa-chevron-down" style="font-size:24px;cursor: pointer"></i>&nbsp;&nbsp;${prevboardsub}</a>
    </c:if>
    <script>
        $("span.likes").click(function() {
            var a='${sessionScope.loginok}';
            if(a==''){
                alert("로그인 후 이용해주세요");
                return;
            }
            var thumbs = $(this).find("i").attr("class");
            var likestate;
            if(thumbs=='fa fa-thumbs-o-up'){ //좋아요없음
                $(this).find("i").attr("class","fa fa-thumbs-up").css("color","#4481eb"); //좋아요O
                likestate=1;
            } else { //좋아요있음
                $(this).find("i").attr("class","fa fa-thumbs-o-up").css("color","black"); //좋아요X
                likestate=0;
            }

            var boardnum=${dto.boardnum}; //좋아요 누른 사람들 아이콘 클릭시
            $.ajax({
                type : "get",
                url : "likes",
                dataType : "json",
                data : {"boardnum":boardnum,"likestate":likestate},
                success : function(res) {
                    $("b.likesuser").text(res);
                }
            });
        });
        //댓글저장
        $("#btnreboard").click(function() {
            if ($("#recontent").val()=='') {
                alert("댓글을 입력 후 등록해주세요");
                return;
            }
            var fdata = $("#aform").serialize();
            $.ajax({
                type : "post",
                url : "../reboard/insert",
                dataType : "text",
                data : fdata,
                success : function(res) {
                    list();
                    $("#recontent").val("");
                }
            });
        });
    </script>
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