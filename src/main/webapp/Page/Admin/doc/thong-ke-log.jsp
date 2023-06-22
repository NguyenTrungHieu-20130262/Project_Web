<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Thống Kê LOG</title>
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- or -->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <!-- Font-icon css-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <%@ include file="./header.jsp" %>
</header>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<jsp:include page="SideBar.jsp">
    <jsp:param name="page" value="10"/>
</jsp:include>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Thống Kê </b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-4">
            <div class="widget-small primary coloured-icon"><i class="icon fa-sharp fa-solid fa-circle-info"></i>
                <div class="info">
                    <h4>INFO</h4>
                    <p><b>${map.get("Info")!=null?map.get("Info").size():0} log</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-4">
            <div class="widget-small info coloured-icon"><i class="icon fa-solid fa-triangle-exclamation"></i>
                <div class="info">
                    <h4>ALERT</h4>
                    <p><b>${map.get("Alert")!=null?map.get("Alert").size():0} log</b></p>
                </div>
            </div>
        </div>

    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-4">
            <div class="widget-small warning coloured-icon"><i class="icon fa-sharp fa-solid fa-triangle-exclamation"></i>
                <div class="info">
                    <h4>WARNING</h4>
                    <p><b>${map.get("Warning")!=null?map.get("Warning").size():0} log</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-4">
            <div class="widget-small danger coloured-icon"><i class="icon fa-sharp fa-solid fa-skull-crossbones"></i>
                <div class="info">
                    <h4>DANGER</h4>
                    <p><b>${map.get("Danger")!=null?map.get("Danger").size():0} log</b></p>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">WARNING LOG</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableWarning">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Mức độ</th>
                            <th width="100">Id tài khoản</th>
                            <th width="300">Nguồn gốc</th>
                            <th width="300">Nội dung</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th width="300">Thời gian tạo</th>
                            <th width="300">Mức độ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('Warning')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="levelLog">${item.level}</td>
                                <td id="idUser">${item.userID}</td>
                                <td id="srcLog">${item.src}</td>
                                <td id="contentLog">${item.content}</td>
                                <td id="creatAt">${item.createAt}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span style="background-color:#ff8b07 " class="statusActivity">Warning</span></td>
                                    </c:when>
                                </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">INFO LOG</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableInfo">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Mức độ</th>
                            <th width="100">Id tài khoản</th>
                            <th width="300">Nguồn gốc</th>
                            <th width="300">Nội dung</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th width="300">Thời gian tạo</th>
                            <th width="300">Mức độ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('Info')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="levelLog">${item.level}</td>
                                <td id="idUser">${item.userID}</td>
                                <td id="srcLog">${item.src}</td>
                                <td id="contentLog">${item.content}</td>
                                <td id="creatAt">${item.createAt}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span style="background-color: #22ad56" class="statusActivity ">Info</span></td>
                                    </c:when>
                                </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">ALERT LOG</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableAlert">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Mức độ</th>
                            <th width="100">Id tài khoản</th>
                            <th width="300">Nguồn gốc</th>
                            <th width="300">Nội dung</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th width="300">Thời gian tạo</th>
                            <th width="300">Mức độ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('Alert')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="levelLog">${item.level}</td>
                                <td id="idUser">${item.userID}</td>
                                <td id="srcLog">${item.src}</td>
                                <td id="contentLog">${item.content}</td>
                                <td id="creatAt">${item.createAt}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span class="statusActivity " style="background-color: #1d5aab">Alert</span></td>
                                    </c:when>
                                </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">DANGER LOG</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableDanger">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Mức độ</th>
                            <th width="100">Id tài khoản</th>
                            <th width="300">Nguồn gốc</th>
                            <th width="300">Nội dung</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th width="300">Thời gian tạo</th>
                            <th width="300">Mức độ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('Danger')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="levelLog">${item.level}</td>
                                <td id="idUser">${item.userID}</td>
                                <td id="srcLog">${item.src}</td>
                                <td id="contentLog">${item.content}</td>
                                <td id="creatAt">${item.createAt}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span class="statusActivity " style="background-color: #de2222">Danger</span></td>
                                    </c:when>
                                </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</main>
<!-- Essential javascripts for application to work-->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<!-- The javascript plugin to display page loading on top-->
<script src="js/plugins/pace.min.js"></script>
<!-- Page specific javascripts-->
<script type="text/javascript" src="js/plugins/chart.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">


    var tableWarning = $('#tableWarning').DataTable(

    );
    var tableDanger = $('#tableDanger').DataTable(

    );
    var tableInfo = $('#tableInfo').DataTable(

    );
    var tableAlert = $('#tableAlert').DataTable(

    );

    var data = {
        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
        datasets: [{
            label: "Dữ liệu đầu tiên",
            fillColor: "rgba(255, 255, 255, 0.158)",
            strokeColor: "black",
            pointColor: "rgb(220, 64, 59)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "green",
            data: [20, 59, 90, 51, 56, 100, 40, 60, 78, 53, 33, 81]
        },
            {
                label: "Dữ liệu kế tiếp",
                fillColor: "rgba(255, 255, 255, 0.158)",
                strokeColor: "rgb(220, 64, 59)",
                pointColor: "black",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "green",
                data: [48, 48, 49, 39, 86, 10, 50, 70, 60, 70, 75, 90]
            }
        ]
    };


    var ctxl = $("#lineChartDemo").get(0).getContext("2d");
    var lineChart = new Chart(ctxl).Line(data);

    var ctxb = $("#barChartDemo").get(0).getContext("2d");
    var barChart = new Chart(ctxb).Bar(data);
    function time() {
        var today = new Date();
        var weekday = new Array(7);
        weekday[0] = "Chủ Nhật";
        weekday[1] = "Thứ Hai";
        weekday[2] = "Thứ Ba";
        weekday[3] = "Thứ Tư";
        weekday[4] = "Thứ Năm";
        weekday[5] = "Thứ Sáu";
        weekday[6] = "Thứ Bảy";
        var day = weekday[today.getDay()];
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        nowTime = h + " giờ " + m + " phút " + s + " giây";
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        today = day + ', ' + dd + '/' + mm + '/' + yyyy;
        tmp = '<span class="date"> ' + today + ' - ' + nowTime +
            '</span>';
        document.getElementById("clock").innerHTML = tmp;
        clocktime = setTimeout("time()", "1000", "Javascript");

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
    }
</script>
<!-- Google analytics script-->

</body>

</html>