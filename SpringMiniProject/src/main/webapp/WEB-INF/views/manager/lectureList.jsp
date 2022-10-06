<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="css/magager/lectureList.css">
    <style type="text/css">
        ul.pagination{
            justify-content: center;
        }

        .possible-list{
            margin-top: 30px;
            margin-bottom: 30px;
            font-size: 33px;
        }

        .col{
            margin-bottom: 10%;
        }

        .search-container{
            display: flex;
            justify-content: space-between;
        }

        .search-item1{
            display: flex;
            flex-grow: 1;
        }

        .search-item2{
            display: flex;
            flex-grow: 2;
        }

        .search-item3{
            display: flex;
            flex-grow: 1;
        }

        .lecture-count{
            display: flex;
            flex-direction: row-reverse;
        }
    </style>
</head>

<body>
    <div class="possible-list">
        개설 가능한 강의 목록
    </div>
    <!-- 검색창 -->
    <div>
        <form action="lecturelist">
            <div class="search-container">
                <div class="search-item1"> <!-- 기간 선택 -->
                    <select class="form-select" style="width: 150px;" name="searchcolumn">
                        <option value="1">전체 강의</option>
                        <option value="2">현재 진행 중인 강의</option>
                        <option value="3">기간 만료된 강의</option>
                    </select>
                </div>
                <div class="input-group search-item2"> <!-- 검색 -->
                    <input type="text" name="searchword" class="form-control" style="width: 100px;">
                    <button type="submit" class="btn btn-primary">검색</button>
                </div>
                <div class="search-item3"> <!-- 강의 등록 버튼 -->
                    <button type="button" class="btn btn-primary" onclick="location.href='/mini/addlectureform'">강의 등록</button>
                </div>
            </div>
        </form>
    </div>
    <br>
    <!-- 리스트 출력 창 -->
    <div class="lecture-count">
        총 과목 수 : ${totalCount}
    </div>
    <br>
    <div class="container">
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4">

            <c:if test="${totalCount>0}">
                <c:forEach var="dto" items="${list}">
                    <c:if test="${dto.lectypea=='국어'}">
                        <div class="col">
                            <div class="card radius-10 border-start border-0 border-3 border-info">
                                <div class="card-body">
                                    <p class="mb-0 text-secondary">[${dto.lectypea}]-${dto.lectypeb}</p>
                                    <p class="my-1 text-info">${dto.lecname}</p>
                                    <p class="mb-0 font-13">${dto.teaname}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${dto.lectypea=='수학'}">
                        <div class="col">
                            <div class="card radius-10 border-start border-0 border-3 border-primary">
                                <div class="card-body">
                                    <p class="mb-0 text-secondary">[${dto.lectypea}]-${dto.lectypeb}</p>
                                    <p class="my-1 text-primary">${dto.lecname}</p>
                                    <p class="mb-0 font-13">${dto.teaname}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${dto.lectypea=='영어'}">
                        <div class="col">
                            <div class="card radius-10 border-start border-0 border-3 border-success">
                                <div class="card-body">
                                    <p class="mb-0 text-secondary">[${dto.lectypea}]-${dto.lectypeb}</p>
                                    <p class="my-1 text-success">${dto.lecname}</p>
                                    <p class="mb-0 font-13">${dto.teaname}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${dto.lectypea=='사회'}">
                        <div class="col">
                            <div class="card radius-10 border-start border-0 border-3 border-warning">
                                <div class="card-body">
                                    <p class="mb-0 text-secondary">[${dto.lectypea}]-${dto.lectypeb}</p>
                                    <p class="my-1 text-warning">${dto.lecname}</p>
                                    <p class="mb-0 font-13">${dto.teaname}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${dto.lectypea=='과학'}">
                        <div class="col">
                            <div class="card radius-10 border-start border-0 border-3 border-danger">
                                <div class="card-body">
                                    <p class="mb-0 text-secondary">[${dto.lectypea}]-${dto.lectypeb}</p>
                                    <p class="my-1 text-danger">${dto.lecname}</p>
                                    <p class="mb-0 font-13">${dto.teaname}</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>


    <!-- 페이징 -->
    <div class="paging">
        <ul class="pagination">
            <c:if test="${startPage>1}">
                <li class="page-item"><a href="lecturelist?currentPage=${startPage-1}" class="page-link">이전</a></li>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach var="pp" begin="${startPage}" end="${endPage}">
                <c:if test="${pp==currentPage}">
                    <li class="page-item active"><a href="lecturelist?currentPage=${pp}" class="page-link">${pp}</a></li>
                </c:if>
                <c:if test="${pp!=currentPage}">
                    <li class="page-item"><a href="lecturelist?currentPage=${pp}" class="page-link">${pp}</a></li>
                </c:if>
            </c:forEach>

            <c:if test="${endPage<totalPage}">
                <li class="page-item"><a href="lecturelist?currentPage=${endPage+1}" class="page-link">다음</a></li>
            </c:if>
        </ul>
    </div>
</body>
</html>