<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách nhân viên | Quản trị Admin</title>
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- or -->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
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
    <jsp:param name="page" value="4"/>
</jsp:include>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Thống kê tài khoản </b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon  bx bxs-user fa-3x'></i>
                <div class="info">
                    <h4>Tổng tài khoản</h4>
                    <p><b>${map.get("sizeAllUser").size()} tài khoản</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small info coloured-icon"><i class='icon bx bxs-user-x fa-3x'></i>
                <div class="info">
                    <h4>Tài khoản đã khóa</h4>
                    <p><b>${map.get("blockAccount")!=null?map.get("blockAccount").size():0} tài khoản</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon  bx bxs-user-check fa-3x'></i>
                <div class="info">
                    <h4>Tài khoản hoạt động</h4>
                    <p><b>${map.get("activeAccount")!=null?map.get("activeAccount").size():0} tài khoản</b></p>
                </div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user fa-3x'></i>
                <div class="info">
                    <h4>Tài khoản Admin</h4>
                    <p><b>${map.get("adminAccount")!=null?map.get("adminAccount").size():0} tài khoản</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon  bx bxs-user fa-3x'></i>
                <div class="info">
                    <h4>Tài khoản nhân viên</h4>
                    <p><b>${map.get("employeesAccount")!=null?map.get("employeesAccount").size():0} tài khoản</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-user'></i>
                <div class="info">
                    <h4>Tài khoản quản lý</h4>
                    <p><b>${map.get("managesAccount")!=null?map.get("managesAccount").size():0} tài khoản</b></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">Tài khoản quản lý</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableManages">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Họ và tên</th>
                            <th width="20">Ảnh thẻ</th>
                            <th width="300">Địa chỉ</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th>SĐT</th>
                            <th width="300">Tình trạng</th>
                            <th width="300">Chức vụ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('managesAccount')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="userName">${item.fullName}</td>
                                <td><img class="img-card-person" src="${item.avatar}" alt=""></td>
                                <td>${item.address}</td>
                                <td id="userPhone">${item.phone}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span class="statusActivity isAction">Hoạt động</span></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><span class="statusActivity isNotAction">Đã khóa</span></td>
                                    </c:otherwise>
                                </c:choose>
                                <td><span class="roleUser isAction" class="userRole">${item.getNameRole()}</span>
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
                    <h3 class="tile-title">Tài khoản nhân viên</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0" id="tableEmployees">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Họ và tên</th>
                            <th width="20">Ảnh thẻ</th>
                            <th width="300">Địa chỉ</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th>SĐT</th>
                            <th width="300">Tình trạng</th>
                            <th width="300">Chức vụ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('employeesAccount')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="userName">${item.userName}</td>
                                <td><img class="img-card-person" src="${item.avatar}" alt=""></td>
                                <td>${item.address}</td>
                                <td id="userPhone">${item.phone}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span class="statusActivity isAction">Hoạt động</span></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><span class="statusActivity isNotAction">Đã khóa</span></td>
                                    </c:otherwise>
                                </c:choose>
                                <td><span class="roleUser isAction" class="userRole">${item.getNameRole()}</span>
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
                    <h3 class="tile-title">Tài khoản Admin</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableCustomers">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th width="150">Họ và tên</th>
                            <th width="20">Ảnh thẻ</th>
                            <th width="300">Địa chỉ</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <th>SĐT</th>
                            <th width="300">Tình trạng</th>
                            <th width="300">Chức vụ</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${map.get('adminsAccount')}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td>#${item.id}</td>
                                <td id="userName">${item.userName}</td>
                                <td><img class="img-card-person" src="${item.avatar}" alt=""></td>
                                <td>${item.address}</td>
                                <td id="userPhone">${item.phone}</td>
                                <c:choose>
                                    <c:when test="${item.status==1}">
                                        <td><span class="statusActivity isAction">Hoạt động</span></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><span class="statusActivity isNotAction">Đã khóa</span></td>
                                    </c:otherwise>
                                </c:choose>
                                <td><span class="roleUser isAction" class="userRole">${item.getNameRole()}</span>
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
    var tableCustomers = $('#tableCustomers').DataTable(
    );
    var tableEmployees= $('#tableEmployees').DataTable()

    var tableManages = $('#tableManages').DataTable(

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
</script>
<!-- Google analytics script-->
<script type="text/javascript">
    if (document.location.hostname == 'pratikborsadiya.in') {
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
            a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-72504830-1', 'auto');
        ga('send', 'pageview');
    }
</script>
</body>

</html>