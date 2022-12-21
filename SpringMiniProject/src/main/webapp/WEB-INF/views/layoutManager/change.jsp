<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <title>Insert title here</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"><%--부트 스트랩 icon--%>
    <style type="text/css">
        .usertitle{
            font-size: 40px;
            text-align: center;
        }
        .self-row{
            --bs-gutter-x: 1.5rem;
            --bs-gutter-y: 0;
            display: flex;
            flex-wrap: wrap;
            margin-top: calc(-1 * var(--bs-gutter-y));
            margin-right: calc(-.5 * var(--bs-gutter-x));

        }
        .card-col3{
            display: flex;
            justify-content: space-evenly;

        }
    </style>


</head>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>

<!-- Sidebar -->

<!-- Sidebar -->
<!-- TopBar -->
<!-- Topbar -->

<!-- Container Fluid-->
<div class="container-fluid" id="container-wrapper">

    <div class=" mb-3 row">
        <!-- Card Example-->
        <div><p class="usertitle">매출 현황</p></div>
        <!-- 올 한해의 전체 소득 출력 칸-->

<%--        card 에 정보 출력 --%>
        <div class="card-col3">

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">
                                Incom (<span id ="nowYear"></span> year)
                            </div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="print-total-incom">

                            </div>
                            <%--                                        <div class="mt-2 mb-0 text-muted text-xs">--%>
                            <%--                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>--%>
                            <%--                                            <span>Since last month</span>--%>
                            <%--                                        </div>--%>

                        </div>
                        <div class="col-auto">
                            <i class="bi bi-coin" style="font-size: 30px; color: goldenrod"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 일반 회원 수 출력 란 -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">User</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="print-total-user"></div>
                            ${totalUser}
                            <%--                                        <div class="mt-2 mb-0 text-muted text-xs">--%>
                            <%--                                            <span class="text-success mr-2"><i class="fas fa-arrow-up"></i> 12%</span>--%>
                            <%--                                            <span>Since last years</span>--%>
                            <%--                                        </div>--%>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people-fill" style="font-size: 30px;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 진행중인 강좌 수 출력 란 -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">
                                Lecture (<span id ="nowMonth"></span> month)
                            </div>
                            <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="print-total-lectures"></div>
                            ${totalLecture}
                            <%--                                        <div class="mt-2 mb-0 text-muted text-xs">--%>
                            <%--                                            <span class="text-success mr-2"><i class="fas fa-arrow-up"></i> 20.4%</span>--%>
                            <%--                                            <span>Since last month</span>--%>
                            <%--                                        </div>--%>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-book" style="font-size: 30px; color: green"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- Area Chart -->
        <div class="col-xl-8 col-lg-7" >
            <div class="card mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold" style="color: black">월별 매출 현황</h6>
                </div>
                <div class="card-body">
                    <%--                                <div class="chart-area">--%>
                    <canvas id="myChart"></canvas>
                    <%--                                </div>--%>
                </div>
            </div>
        </div>

        <!-- Pie Chart -->
        <div class="col-xl-4 col-lg-5">
            <div class="card mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold" id="chartPieHead" >과목별 매출 현황</h6>
                </div>
                <div class="card-body">
                    <canvas id="chartPie" height="300px"></canvas>
                </div>
            </div>
        </div>

        <!-- Invoice Example -->
        <!-- Message From Customer-->
        <!--Row-->

    </div>
    <!---Container Fluid-->
</div>
<!-- Footer -->
<!-- Footer -->
</div>
</div>

<!-- Scroll to top -->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<script>

    var date = new Date();
    var year = 2023;
    var month = 10;
    document.getElementById("nowMonth").innerText=month;
    document.getElementById("nowYear").innerText=year;

    var totalincom = ${totalincom};
    var resultTotalIncom = totalincom.toLocaleString('ko-KR');
    $("#print-total-incom").html(resultTotalIncom);


    //페이지 로드 되자마자 출력되는 함수들
    $(function () {
        // chartPieFunction(val0, val1, val2, val3, val4);


        <!-- 차트 script-->
        // 차트를 그럴 영역을 dom요소로 가져온다.
        var chartArea = document.getElementById('myChart').getContext('2d');
        // 차트를 생성한다.
        var myChart = new Chart(chartArea, {
            // ①차트의 종류(String)
            type: 'bar',
            // ②차트의 데이터(Object)
            data: {
                // ③x축에 들어갈 이름들(Array)
                labels: ['1', '2', '3', '4', '5', '6',"7",'8','9','10','11','12'],
                // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
                datasets: [{
                    // ⑤dataset의 이름(String)
                    label: '월별매출(단위:천원)',
                    // ⑥dataset값(Array)
                    data: [${incom1}, ${incom2}, ${incom3}, ${incom4}, ${incom5}, ${incom6},
                        ${incom7}, ${incom8}, ${incom9}, ${incom10}, ${incom11}, ${incom12}],
                    // ⑦dataset의 배경색(rgba값을 String으로 표현)
                    backgroundColor: 'rgba(54, 153, 224, 0.5)',
                    // ⑧dataset의 선 색(rgba값을 String으로 표현)
                    borderColor: 'rgba(54, 153, 224, 0.5)',
                    // ⑨dataset의 선 두께(Number)
                    borderWidth: 1
                }]
            },
            // ⑩차트의 설정(Object)
            options: {
                // ⑪축에 관한 설정(Object)
                scales: {
                    // ⑫y축에 대한 설정(Object)
                    y: {
                        // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                        beginAtZero: true
                    }
                }
            }
        });


        //Pie 차트 생성
        // 차트를 그럴 영역을 dom요소로 가져온다.
        var pieChartArea = document.getElementById('chartPie').getContext('2d');
        // 차트 x 축 데이터 (lectypea)
        var lecType = "${lectureType}".split(",");

        //차트 생성
        var chartPie = new Chart(pieChartArea, {
            // ①차트의 종류(String)
            type: 'pie',
            // ②차트의 데이터(Object)
            data: {
                // ③x축에 들어갈 이름들(Array)
                labels:
                    $.each(lecType,function (idx, ele) {
                    })

                ,
                // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
                datasets: [{
                    // ⑤dataset의 이름(String)
                    label: month+'월 과목별 매출(단위:원)',
                    // ⑥dataset값(Array)
                    data: [${val0},${val1},${val2},${val3},${val4},${val5}],
                    // ⑦dataset의 배경색(rgba값을 String으로 표현)
                    backgroundColor: ['rgba(255, 99, 132, 0.3)','rgba(255, 207, 163, 0.3)','rgba(76, 193, 192, 0.3)','rgba(255, 230, 86, 0.3)','rgba(54, 153, 224, 0.3)','rgba(201, 203, 207, 0.3)'],
                    // ⑧dataset의 선 색(rgba값을 String으로 표현)
                    borderColor: ['rgba(255, 99, 132, 0.3)','rgba(255, 207, 163, 0.3)','rgba(76, 193, 192, 0.3)','rgba(255, 230, 86, 0.3)','rgba(54, 153, 224, 0.3)','rgba(201, 203, 207, 0.3)'],
                    // ⑨dataset의 선 두께(Number)
                    borderWidth: 1
                }]
            },
            // ⑩차트의 설정(Object)
            options: {
                // ⑪축에 관한 설정(Object)
                scales: {
                    // ⑫y축에 대한 설정(Object)
                    y: {
                        // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                        beginAtZero: true
                    }
                }
            }
        });



        // mychart 에서 클릭이벤트 발생시 해당 월의 과목별 매출 띄우기
        document.getElementById("myChart").onclick = function(evt) {
            var activePoints = myChart.getElementsAtEvent(evt);

            if(activePoints.length > 0)
            {
                //선택한 표의 월 데이터 가져오기
                var clickedElementindex = activePoints[0]["_index"];
                var monthDay = myChart.data.labels[clickedElementindex];
                console.log("label : " + monthDay);

                //ajax를 사용해 해당월의 과목별 매출 데이터 출력하기
                $.ajax({
                    type:"get",
                    url:"${root}/manager/incomByType",
                    dataType:"json",
                    data:{"month":monthDay,"year":year},
                    success:function(res){
                        $("#chartPieHead").html("과목별 매출 현황 - "+monthDay+"월");
                        chartPie.data.datasets[0].data=[res.va0, res.va1, res.va2, res.va3, res.va4, res.va5];
                        chartPie.update();
                        // var test = chartPie.data.datasets.data;
                        // chartPie().data.datasets[0].date=[0,0,0,0,0];
                    },
                });


                var value = myChart.data.datasets[0].data[clickedElementindex];
                console.log("value : " + value);
                var temp = 200000;
                // chartPie(temp);
            }
        }

        // var w = $("#myChart").attr("height");
        // console.log(w);
        // $("#chartPie").attr("height",w);
    });//function




    <%--function chartPieFunction(val0, val1, val2, val3, val4) {--%>
    <%--    // 차트를 그럴 영역을 dom요소로 가져온다.--%>
    <%--    var pieChartArea = document.getElementById('chartPie').getContext('2d');--%>
    <%--    // 차트 x 축 데이터 (lectypea)--%>
    <%--    &lt;%&ndash;var lecType = "${lectureType}".split(",");&ndash;%&gt;--%>

    <%--    //차트 생성--%>
    <%--    var chartPie = new Chart(pieChartArea, {--%>
    <%--        // ①차트의 종류(String)--%>
    <%--        type: 'pie',--%>
    <%--        // ②차트의 데이터(Object)--%>
    <%--        data: {--%>
    <%--            // ③x축에 들어갈 이름들(Array)--%>
    <%--            labels:["국어","영어","수학","사회","과학"]--%>
    <%--            // $.each(lecType,function (idx, ele) {--%>
    <%--            // })--%>
    <%--            ,--%>
    <%--            // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.--%>
    <%--            datasets: [{--%>
    <%--                // ⑤dataset의 이름(String)--%>
    <%--                label: month+'월 과목별 매출(단위:원)',--%>
    <%--                // ⑥dataset값(Array)--%>
    <%--                data: [val0, val1, val2, val3, val4],--%>
    <%--                // ⑦dataset의 배경색(rgba값을 String으로 표현)--%>
    <%--                backgroundColor: ['rgba(255, 99, 132, 0.2)','rgba(76, 193, 192, 0.2)','rgba(255, 205, 86, 0.2)','rgba(54, 153, 224, 0.2)','rgba(201, 203, 207, 0.2)'],--%>
    <%--                // ⑧dataset의 선 색(rgba값을 String으로 표현)--%>
    <%--                borderColor: 'rgba(255, 99, 132, 1)',--%>
    <%--                // ⑨dataset의 선 두께(Number)--%>
    <%--                borderWidth: 1--%>
    <%--            }]--%>
    <%--        },--%>
    <%--        // ⑩차트의 설정(Object)--%>
    <%--        options: {--%>
    <%--            // ⑪축에 관한 설정(Object)--%>
    <%--            scales: {--%>
    <%--                // ⑫y축에 대한 설정(Object)--%>
    <%--                y: {--%>
    <%--                    // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)--%>
    <%--                    beginAtZero: true--%>
    <%--                }--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>



</script>
</body>

</html>