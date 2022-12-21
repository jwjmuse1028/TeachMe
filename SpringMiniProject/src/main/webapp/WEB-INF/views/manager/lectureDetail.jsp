<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/manager/lectureDetail.css">
    <style>
        .container {
            height: 90vh;
        }

        .right-box {
            padding-left: 60px;
        }

        .member-details {
            padding-top: 50px;
            padding-bottom: 0;
        }

        .add-Detail {
            cursor: pointer;
        }

        .button-box {
            display: flex;
            justify-content: end;
        }

        .button-container {
            display: flex;
            justify-content: end;
        }

        .typeb {
            font-size: 20px;
            color: #5a5c69;
        }

        .lecture-info{
            width: 160px;
        }
    </style>
</head>
<body>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<div class="container">
    <section class="member-details">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="img-container">
                        <c:if test="${dto.lecphoto!=null}">
                            <img src="upload/lecture/${dto.lecphoto}" class="img-full">
                        </c:if>
                        <c:if test="${dto.lecphoto==null}">
                            <img src="resources/image/noimage2.png" class="img-full">
                        </c:if>
                    </div>
                </div>
                <!-- 강좌 정보 -->
                <div class="col-lg-9 col-md-8 right-box">
                    <div class="member_designation">
                        <h2>${dto.lectypea}</h2>
                        <span class="typeb">${dto.lectypeb}</span>
                        <span class="button-container">
                            <button type="button"
                                    onclick="location.href='${root}/updateLectureForm?lecnum=${dto.lecnum}'"
                                    class="btn btn-outline-dark btn-sm">강좌 수정</button>
                            <button type="button" id="delete-lecture"
                                    class="btn btn-outline-secondary btn-sm">강좌 삭제</button>
                            <script>
                                 //강좌 삭제
                                 $("#delete-lecture").click(function () {
                                     var a = confirm("강의를 삭제하시겠습니까?");
                                     if (a) {
                                         location.href = "${root}/deleteLecture?lecnum=${dto.lecnum}";
                                     }
                                 });
                            </script>
                        </span>
                    </div>
                    <span class="member_desc">
                        <ul class="styled_list">
                            <li class="">
                                <h5>
                                <i class="fa fa-chevron-circle-right" aria-hidden="true"></i>
                                ${dto.lecname}
                                </h5>
                            </li>
                        </ul>
                    </span>
                    <span class="button-box">
                        <button class="btn btn-social outlined"
                                onclick="location.href='${root}/insertLectureDetailForm?lecnum=${dto.lecnum}'">
                            <label class="add-Detail">강의 추가<i class="fa fa-plus"
                                                              style="font-size:24px;color:#007bff"></i></label>
                        </button>
                    </span>
                    <!-- 개설된 강의 목록 출력 -->
                    <c:forEach var="dtolist" items="${list}">
                        <div class="bg-image "
                             style="background-image: url('https://www.bootdey.com/img/Content/bg_element.jpg');">
                            <div class="member_contact">
                                <div class="row">
                                    <div class="col-lg-4  mb-3 mb-lg-0 lecture-info">
                                        <div class="media-box">
                                            <div class="media-icon">
                                                <i class="fa fa-desktop" style="font-size:40px;"></i>
                                            </div>
                                            <div class="media-content text-white lecture-present1${dtolist.lecdenum}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4  mb-3 mb-lg-0 lecture-info">
                                        <div class="media-box">
                                            <div class="media-icon">
                                                <i class="fa fa-folder-open-o" style="font-size:40px;"></i>
                                            </div>
                                            <div class="media-content lecture-present2${dtolist.lecdenum}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4  mb-3 mb-lg-0 lecture-info">
                                        <div class="media-box">
                                            <div class="media-icon">
                                                <i class="fa fa-handshake-o" style="font-size:40px"></i>
                                            </div>
                                            <div class="media-content">
                                                <h5>${dtolist.lecyear}년</h5>
                                                <p>${dtolist.lecmonth}월</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="social-icons">
                                            <button class="btn btn-social outlined"
                                                    onclick="location.href='${root}/updateLectureDetailForm?lecdenum=${dtolist.lecdenum}'">
                                                <i class="fa fa-pencil-square-o" style="font-size:24px"></i>
                                            </button>
                                            <button id="deleteLecDetail${dtolist.lecdenum}"
                                                    class="btn btn-social outlined">
                                                <i class="fa fa-trash-o" style="font-size:24px"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>
                            //현재 년월과 비교해서 수강 중인 강의만 출력
                            var date = new Date();
                            var year = date.getFullYear();
                            var month = date.getMonth() + 1;
                            <%--var updateButton = <button type="button" class="btn btn-outline-info" onclick="location.href='${root}/updateLectureDetail?lecdenum=${dtolist.lecdenum}'">강의 수정</button>;--%>
                            <%--var deleteButton = <button type="button" id="delete-lecde" class="btn btn-outline-danger delete-button" onclick="location.href='${root}/deleteLectureDetail?lecdenum=${dtolist.lecdenum}'">강의 삭제</button>;--%>
                            var presentlectureA = "";
                            var presentlectureB = "";
                            if ("${dtolist.lecyear}" == 2023 && "${dtolist.lecmonth}" == month) {
                                presentlectureA += "${dtolist.teaname} (${dtolist.roomnum}호)"
                                presentlectureB += " <h5 class='show-lecday${dtolist.lecdenum}'></h5>";
                                presentlectureB += " <p>${dtolist.lectime}교시</p>";
                                // presentlecture += updateButton;
                                // presentlecture += deleteButton;
                            }
                            $(".lecture-present1${dtolist.lecdenum}").html(presentlectureA);
                            $(".lecture-present2${dtolist.lecdenum}").html(presentlectureB);

                            // DB에서 숫자로 가져오는 요일을 한글로 바꿔주기
                            var temp = "";
                            var lecday = "${dtolist.lecday}".split(',');
                            for (var yoil = 0; yoil < lecday.length; yoil++) {
                                // console.log("lecday"+lecday[yoil]);
                                if (lecday[yoil] == "1") {
                                    temp += "<span>[월]</span>";
                                } else if (lecday[yoil] == "2") {
                                    temp += "<span>[화]</span>";
                                } else if (lecday[yoil] == "3") {
                                    temp += "<span>[수]</span>";
                                } else if (lecday[yoil] == "4") {
                                    temp += "<span>[목]</span>";
                                } else if (lecday[yoil] == "5") {
                                    temp += "<span>[금]</span>";
                                } else if (lecday[yoil] == "6") {
                                    temp += "<span>[토]</span>";
                                } else if (lecday[yoil] == "7") {
                                    temp += "<span>[일]</span>";
                                }
                            }

                            //쓰레기통 버튼 누르면 삭제하기
                            $("#deleteLecDetail${dtolist.lecdenum}").click(function () {
                                var a = confirm("강의를 삭제하시겠습니까?");
                                if (a) {
                                    location.href = "${root}/deleteLectureDetail?lecdenum=${dtolist.lecdenum}&lecnum=${dto.lecnum}"
                                }
                            });

                            var result = "${temp}";
                            $(".show-lecday${dtolist.lecdenum}").html(temp);
                        </script>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</div>
</body>