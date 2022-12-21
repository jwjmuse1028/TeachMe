<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="${root}/css/qna.css">
<link rel="stylesheet" type="text/css" href="${root}/css/taeminfont.css">
<link rel="stylesheet" type="text/css" href="${root}/css/TeachMeStyle.css">
<script src="${pageContext.request.contextPath}/resources/javascript/taemin.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<%--<script src="${pageContext.request.contextPath}/taemin.js"></script>--%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script>
        document.getElementById('vidd').play();
    </script>
</head>


<a href="#" class="btn_gotop">
  <span class="glyphicon glyphicon-chevron-up">
  </span>
</a>


<style>

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


    #go {
        background-color: white;
        border-color: white;
        margin-top: 150px;
        margin-bottom: 100px;
        color: black;
    }

    #tctext {
        background: linear-gradient(to right, #25aae1, #4481eb, #04befe, #3f86ed);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }


    #go:hover {
        background: linear-gradient(to right, #25aae1, #4481eb, #04befe, #3f86ed);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        /*background-color: #3f86ed;*/
        border-color: grey;
        outline-color: grey;
    }

    .wrap {
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        position: absolute;
        text-align: center;

    }

    #dynamic {
        position: relative;
        display: inline-block;
        color: black;
    }

    #dynamic::after {
        content: "";
        display: block;
        position: absolute;
        top: 0;
        right: -10px;
        width: 4px;
        height: 100%;
        background-color: black;
        color: black;
    }

    #dynamic.active::after {
        display: none;

    }

    .lg-text {
        background: linear-gradient(to right, #25aae1, #4481eb, #04befe, #3f86ed);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-top: 100px;
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

    video {
        max-width: 80%;
        display: block;
        margin: 20px auto;
    }


    #dday {
        width: 200px;
        height: 50px;
        bottom: -2%;
        margin-left: 34.5%;
        color: black;
    }

    #chcol:hover {
        color: black;
        font-style: italic;
        font-weight: bold;

    }

</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
<%--<div id="dday"></div>--%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<!--Section-1-->
<section class="section-1">
    <div class="jumbotron d-flex align-items-center">
        <div class="gradient"></div>
        <div class="container-fluid content" style="height: 150px; padding-bottom: 450px;">
            <h1 data-aos="fade-up" data-aos-delay="100"
                style="margin-bottom: 50px; color: white; font-family: 'BM Dohyeon';">국내 최다 합격률 <span
                    style="color:#3f86ed;" id="tctext">티치미</span> 입시학원</h1>
            <h2 data-aos="fade-up" data-aos-delay="300"
                style="margin-bottom: 100px; margin-top: 50px; color: lightgray;">국내 최고의 강사진과 함께하는 체계적인 커리큘럼</h2>
            <div class="wrap">
                <h4 data-aos="fade-up" data-aos-delay="500"
                    style="background-color: white; color: black; margin-top: 450px; border-radius: 15px;" id="tp"><b
                        id="dynamic" class="lg-text"></b></h4>
            </div>
            <p data-aos="fade-up" data-aos-delay="700"><a href="lecture/lectureList" class="btn btn-success" id="go"><b
                    id="count"></b></a></p>

        </div>
        <!--container-fluid end-->
    </div>
</section>


<!--Section-5-->
<section class="section-18" style="padding-bottom: 20px; padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-sm-8">

            </div>

        </div>
    </div>
    <h3 style="text-align: center; margin-bottom: 40px; margin-top: 0px; color: black;">Recommended Lectures</h3>
    <div class="container-fluid" style="height: 450px;">
        <div class="row" data-aos="fade-up" data-aos-delay="300">
            <a href="lecture/lectureDetail?lecdenum=70" target="_blank" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/mh.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="${root}lecture/lectureDetail?lecdenum=70" alt="">
                    <div class="inner-text"><h4>본 강의<span>수강하기</span></h4></div>
                </div>
            </a>
            <a href="lecture/lectureDetail?lecdenum=83" target="_blank" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/engg.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>본 강의<span>수강하기</span></h4></div>
                </div>
            </a>
            <a href="lecture/lectureDetail?lecdenum=79" target="_blank" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/mattt.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>본 강의<span>수강하기</span></h4></div>
                </div>
            </a>
            <a href="lecture/lectureDetail?lecdenum=93" target="_blank" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/kok.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>본 강의<span>수강하기</span></h4></div>
                </div>
            </a>
        </div>
        <!--/row-->
    </div>
    <!--container-->
</section>

<!--Section-2-->
<section class="section-2">
    <div class="container">
        <div class="row">
            <h2 style="text-align: center; margin-bottom: 80px; margin-top: 0px;">What is different?</h2>
            <div class="col-lg-4 col-sm-12 col-12 box-1">
                <div class="row box" data-aos="fade-left" data-aos-delay="300" style="background-color: grey; border-radius: 20px;">
                    <div class="col-lg-2 col-sm-12">
                        <i class="far fa-smile" aria-hidden="true" style="color: white; font-size: 30px;"></i>
                    </div>
                    <div class="col-lg-10 col-sm-12">
                        <h3><b style="color: white;">첫 번째</b></h3>
                        <p style="color: white;"><b>교육의 본질은 쌍방향의 소통입니다. 직업 윤리를 떠나 학생들을 가르침에 따라 모든 선생님들은 보람을 느끼고 힘을 얻습니다.
                            저희는 상호간의 이해와 관계의 공유에서 많은
                            변화를 만들어 낼 것 입니다. </b></p>
                        <p><a href="services.html"></a></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-sm-12 col-12 box-2">
                <div class="row box" data-aos="fade-left" data-aos-delay="500" style="background-color: grey; border-radius: 20px;">
                    <div class="col-lg-2 col-sm-12">
                        <i class="far fa-smile" aria-hidden="true" style="color: white; font-size: 30px;"></i>
                    </div>
                    <div class="col-lg-10 col-sm-12">
                        <h3><b style="color: white;">두 번째</b></h3>
                        <p style="color: white;"><b>내신과 수능 모두를 겸비할 수 있는 학원이 되겠습니다. 한달의 한번씩 있는 학교 자체 모의고사를 통해 현재 자신의 위치와 전략을
                            만들어가면서 향후 미래에 좋은 입시
                            결과를 만들어 낼 것 입니다.</b></p>
                        <p><a href="services.html"></a></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-sm-12 col-12 box-3">
                <div class="row box" data-aos="fade-left" data-aos-delay="700" style="background-color: grey; border-radius: 20px;">
                    <div class="col-lg-2 col-sm-12">
                        <i class="far fa-smile" aria-hidden="true" style="color: white; font-size: 30px;"></i>
                    </div>
                    <div class="col-lg-10 col-sm-12">
                        <h3><b style="color: white;">세 번째</b></h3>
                        <p style="color: white;"><b>매 해 바뀌는 입시제도 하에서 학생 개개인에게 맞는 학습방법과 전략을 짜기 위해선 학생이 원하는 수강 목록과 선생님을 고르되
                            자신이 책임지고 수업에 임해야 한다는 점을
                            강조하며 만든 시스템입니다</b> </p>
                        <%--                            멋진 도전을 위해 함께한다면 결코 후회없는 1년이 될 것 입니다. </p>--%>
                        <p><b></b></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<h2 style="text-align: center;">FIND LECTURE BY KEYWORD</h2>
<br>
<h5 style="text-align: center; color: grey;">키워드에 따라 원하는 강의를 발견해보세요</h5>
<div class="container" style="width: 100%;">
    <div class="myaskbox" style="margin-bottom: 5px;">

        <%--        <button type="button" onclick="location.href='qnaList?'" class="myask" style="width: 100px;">--%>
        <%--            <b>수학강의</b>--%>
        <%--        </button>&nbsp;--%>

        <button type="button" onclick="location.href='lecture/lectureList?lectypeb=국어종합'" class="myask" style="width: 100px;">
            <b>국어강의</b>
        </button>

        <button type="button" onclick="location.href='lecture/lectureList?lectypea=역사'" class="myask" style="width: 100px;">
            <b>사회강의</b>
        </button>

        <button type="button" onclick="location.href='lecture/lectureList?lectypeb=생명과학'" class="myask" style="width: 100px;">
            <b>과학강의</b>
        </button>

        <button type="button" onclick="location.href='lecture/lectureList?lectypeb=아시아'" class="myask" style="width: 100px;">
            <b>제2외국어</b>
        </button>

        <button type="button" onclick="location.href='lecture/lectureList?lectypeb=영어'" class="myask" style="width: 100px;">
            <b>영어강의</b>
        </button>

        <button type="button" onclick="location.href='lecture/lectureList?lectypeb=수학종합'" class="myask" style="width: 100px;">
            <b>수학강의</b>
        </button>


        <button type="button" onclick="location.href='lecture/lectureList'" class="myask" style="width: 100px;">
            <b>전체강의</b>
        </button>


    </div>
</div>
<br><br><br><br><br><br>


<section class="section-3" style="border: 0; padding-bottom: 0;">
    <div class="container">
        <div class="row m-0">
            <div class="col-lg-5 col-md-12 p-0" data-aos="fade-right" data-aos-delay="300">
                <h2 style="color: black;">TeachMe 강의후기 TOP5</h2>
                <ul>
                    <c:forEach var="hotdto" items="${hotlectures}">
                        <li style="font-size: 18px;"><a href="lecture/lectureDetail?lecdenum=${hotdto.lecdenum}" id="chcol"><i class="fa fa-angle-right" aria-hidden="true"></i>${hotdto.lecname}&nbsp;<b style="color: gold">${hotdto.avgstar}점</b> ${hotdto.teaname} 강사</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-lg-7 col-md-12 p-0" data-aos="fade-left" data-aos-delay="300">
                <div style="margin-top: 120px;">
                    <video class="inner-img" src="${root}/css/videos/wr.mp4" controls muted autoplay loop width="100%;"
                           style="border-radius: 20px; margin-left: 50px;" alt="services"></video>
                </div>
                <%--                    <img class="inner-img" src="" alt="services">--%>
                <%--                    <img class="out-sideimg" src="" alt="services">--%>
            </div>
        </div>
    </div>
    <%--            <div class="col-lg-7 col-md-12 p-0" data-aos="fade-left" data-aos-delay="300">--%>
    <%--                <figure>--%>
    <%--                    <video controls width="250" id="vidd" autoplay="autoplay" muted="muted">--%>
    <%--                        source src="videos/wr.mp4" type="video/mp4">--%>
    <%--                    </video>--%>
    <%--&lt;%&ndash;                    <img class="inner-img" src="image/teach.jpg" alt="services" style="border-radius: 20px;">&ndash;%&gt;--%>
    <%--&lt;%&ndash;                    <img class="out-sideimg" src="image/asd.jpg" alt="services" style="border-radius: 20px;">&ndash;%&gt;--%>
    <%--                    <video width="100%" height="auto" autoplay loop muted controls class="out-sideimg"> <source src="video/wr.mp4" type="video/mp4" alt="services">--%>
    <%--                    </video>--%>
    <%--    <video class="out-sideimg" autoplay controls loop muted>--%>
    <%--        <source src="video/wr.mp4" type="video/mp4">--%>
    <%--    </video>--%>
    <%--                </figure>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--    </div>--%>
</section>


<!-- 아래는 원래꺼 위는 새로 추가 -->

<section class="section-5" style="padding-bottom: 20px; padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-sm-8">
                <h3 style="color: black;"><span
                        style="margin-left: 0; display: flex; position: center; padding-bottom: 10px;">Study and Changes Life</span>
                </h3>
            </div>

        </div>
    </div>
    <div class="container-fluid" style="height: 450px;">
        <div class="row" data-aos="fade-up" data-aos-delay="300">
            <a href="https://www.snu.ac.kr/" target="_blank" data-toggle="lightbox" data-gallery="example-gallery"
               class="col-sm-3 box">
                <img src="image/s1.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>2021년도<span>최종합격10명</span></h4></div>
                </div>
            </a>
            <a href="https://www.korea.ac.kr/mbshome/mbs/university/index.do" target="_blank" data-toggle="lightbox"
               data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/55.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>2021년도<span>최종합격15명</span></h4></div>
                </div>
            </a>
            <a href="https://www.yonsei.ac.kr/sc/" target="_blank" data-toggle="lightbox" data-gallery="example-gallery"
               class="col-sm-3 box">
                <img src="image/2323.png" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>2021년도<span>최종합격11명</span></h4></div>
                </div>
            </a>
            <a href="https://www.sogang.ac.kr/index.do" target="_blank" data-toggle="lightbox"
               data-gallery="example-gallery" class="col-sm-3 box">
                <img src="image/nm.jpg" class="img-fluid">
                <div class="overlay">
                    <img src="" alt="">
                    <div class="inner-text"><h4>2021년도<span>최종합격12명</span></h4></div>
                </div>
            </a>
        </div>
    </div>
</section>

</footer>
</section>

<nav class="cuz">
    <ul id="main_menu">
        <div class="btn_gotop"><a href="#"><img src="image/tttt.png"
                                                style="width: 70%; background-color:transparent; color: black;"></a>
        </div>
        <br>
        <br>
        <li><a href="javascript:dos()" style="color: black;"><img src="image/pointt.png"
                                                                  style="width: 80%; background-color:transparent; color: black;"></a>
            <ul class="snd_menu sub_menu" style=" background-color:transparent;">
                <br>
                <li><a href="${root}/lecture/lectureList"><img src="image/yu.png"
                                                               style="width: 100%; background-color:transparent; color: black;">강의</a>
                </li>
                <br>
                <li><a href="${root}/board/boardFree"><img src="image/cccb.png"
                                                           style="width: 100%;padding-left:10px;  ">커뮤니티</a></li>
                <br>
                <li><a href="${root}/qna/qnaList"><img src="image/1ask.png" style="width:130%; padding-right: 25px;">문의하기</a>
                </li>
            </ul>
        </li>
    </ul>
</nav>


<%--</span><!-- /top-link-block -->--%>

<%--<!--퀵메뉴바-->--%>
<%--  <span id="top-link-block" class="hidden">--%>
<%--  <div id="test_obj" style="border: none;"><b style="margin-left:18px; padding-top: 20px; display: inline-block; text-align: center; vertical-align: center; color: black;"><a href="#" class="well well-sm" onclick="$('html,body').animate({scrollTop:0},fast);return false;" id="toptop">--%>
<%--      <img src="image/tttt.png" style="width: 130%;">--%>
<%--  </a></b><br><br><br><b style="font-size: 15px; color: black; margin-left: 6px; padding-top: 15px;"></b><a href="${root}/qna/qnaList"><img src="image/1ask.png" style="width: 130%; "></a><br><br><br><b style="font-size: 15px; color: black; margin-left: 8px; padding-top: 40px; margin-top: 10px;" id="comu"><a href="${root}/board/boardFree"><img src="image/comu.png" style="width: 80%;margin-left: 16px; "></a></b></div>--%>
<%--</span><!-- /top-link-block -->--%>


</body>


<script>

    $(document).ready(function dos() {
        $('#main_menu > li > a').click(function () {
            $(this).next($('.snd_menu sub_menu')).slideToggle('fast');
            // $(this).show($('.snd_menu sub_menu')("slide",{direction:'left'},1000));
        })
        // e.stopPropagation();

    })

    let target = document.querySelector("#dynamic");


    function randomString() {
        let stringArr = ["대한민국 입시 부동의 1위", "Study and Changes Life", "2021년도 합격률 98%",
            "학생 맞춤형 공부법", "최고의 강사 최고의 커리큘럼", "10년 연속 합격률 95% 달성"];
        let selectString = stringArr[Math.floor(Math.random() * stringArr.length)];
        let selectStringArr = selectString.split("");

        return selectStringArr;
    }


    function resetTyping() {
        target.textContent = "";

        dynamic(randomString());
    }


    function dynamic(randomArr) {

        if (randomArr.length > 0) {
            target.textContent += randomArr.shift();
            setTimeout(function () {
                dynamic(randomArr);
            }, 80);
        } else {
            setTimeout(resetTyping, 3000);
        }

    }

    dynamic(randomString());


    function blink() {
        target.classList.toggle("active");

    }

    setInterval(blink, 500);


    //
    //     if ( ($(window).height() + 100) < $(document).height() ) {
    //     $('#top-link-block').removeClass('hidden').affix({
    //         // how far to scroll down before link "slides" into view
    //         offset: {top:100}
    //     });
    // }


    // 퀵메뉴바

    //
    // $(document).ready(function () {
    //     var tmp = parseInt($("#test_obj").css('top'));
    //
    //     $(window).scroll(function () {
    //         var scrollTop = $(window).scrollTop();
    //         var obj_position = scrollTop + tmp + "px";
    //
    //         $("#test_obj").stop().animate({
    //             "top": obj_position
    //         }, 500);
    //
    //     }).scroll();
    // });


    var dday = new Date("November 17, 2023, 0:00:00").getTime();

    setInterval(function () {

        var today = new Date().getTime();
        var gap = dday - today;
        var day = Math.ceil(gap / (1000 * 60 * 60 * 24));
        var hour = Math.ceil((gap % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var min = Math.ceil((gap % (1000 * 60 * 60)) / (1000 * 60));
        var sec = Math.ceil((gap % (1000 * 60)) / 1000);
        document.getElementById("count").innerHTML = "<b>2023년도 수능 D-DAY&nbsp;</b>  " + day + "일 " + hour + "시간 " + min + "분 " + sec + "초";
    }, 1000);


    // var now = new Date();
    // var then = new Date('nov 17,2022');
    // var gap = now.getTime() - then.getTime();
    // gap = Math.floor(gap / (1000 * 60 * 60 * 24)) * -1;
    // document.write('<div id="dday" style="text-align: center; width: 550px; position: absolute; font-size: 25px; padding-top: 5px; color: black;">2022년도 수능 D-<span style="font-size:25px; text-align: center; color: black; ">' + gap + '</span></div>');

    //


</script>


</html>