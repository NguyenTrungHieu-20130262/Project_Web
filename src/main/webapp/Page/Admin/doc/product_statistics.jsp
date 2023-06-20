<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/14/2023
  Time: 3:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách sản phẩm | Quản trị Admin</title>
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

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://staticfile.oto.com.vn/dist/web/styles/theme.min.css.gz?v=638029584077979519">
    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"--%>
    <%--          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">--%>
    <link rel="stylesheet"
          href="https://staticfile.oto.com.vn/dist/web/styles/logo-car.min.css.gz?v=638032818151165956">
    <link rel="stylesheet" as="style"
          href="https://staticfile.oto.com.vn/dist/web/styles/slide-brand.min.css.gz?v=638032818151165956">
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>

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
    <jsp:param name="page" value="6"/>
</jsp:include>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Thống kê sản phẩm</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class="icon bx bxs-purchase-tag-alt fa-3x"></i>
                <div class="info">
                    <h4>Tổng sản phẩm</h4>
                    <p><b class="count_all_product"> sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small info coloured-icon"><i class="icon bx bxs-purchase-tag-alt fa-3x"></i>
                <div class="info">
                    <h4>Sản phẩm còn hàng</h4>
                    <p><b class="count_available_product"> sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class="icon fa-3x bx bxs-tag-x"></i>
                <div class="info">
                    <h4>sản phẩm hết hàng</h4>
                    <p><b class="count_unavailable_product">sản phẩm</b></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">Sản phẩm theo hãng</h3>
                </div>
                <div>
                    <select class="form-select" id="company" aria-label="Default select example">

                    </select>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="tableBranchManages">
                        <thead>
                        <tr>
                            <th width="50">STT</th>
                            <th width="280">Tên sản phẩm</th>
                            <th width="180">Ảnh</th>
                            <th width="80">Số lượng</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <%--                            <th>SĐT</th>--%>
                            <th width="120">Tình trạng</th>
                            <th width="100">Giá tiền</th>
                            <th>Nội dung</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <%--                        <c:forEach items="${map.get('managesAccount')}" var="item" varStatus="loop">--%>
                        <%--                            <tr data-id="${item.id}">--%>
                        <%--                                <td>#${item.id}</td>--%>
                        <%--                                <td id="userName">${item.fullName}</td>--%>
                        <%--                                <td><img class="img-card-person" src="${item.avatar}" alt=""></td>--%>
                        <%--                                <td>${item.address}</td>--%>
                        <%--                                <td id="userPhone">${item.phone}</td>--%>
                        <%--                                <c:choose>--%>
                        <%--                                    <c:when test="${item.status==1}">--%>
                        <%--                                        <td><span class="statusActivity isAction">Hoạt động</span></td>--%>
                        <%--                                    </c:when>--%>
                        <%--                                    <c:otherwise>--%>
                        <%--                                        <td><span class="statusActivity isNotAction">Đã khóa</span></td>--%>
                        <%--                                    </c:otherwise>--%>
                        <%--                                </c:choose>--%>
                        <%--                                <td><span class="roleUser isAction" class="userRole">${item.getNameRole()}</span>--%>
                        <%--                                </td>--%>
                        <%--                            </tr>--%>
                        <%--                        </c:forEach>--%>
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
                    <h3 class="tile-title">Sản phẩm theo tình trạng</h3>
                </div>
                <div>
                    <select class="form-select" id="status" aria-label="Default select example">\
                        <option value="all">Tất cả</option>
                        <option value="available">Còn hàng</option>
                        <option value="unavailable">Hết hàng</option>
                    </select>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0" id="tableStatusManages">
                        <thead>
                        <tr>
                            <th width="50">STT</th>
                            <th width="280">Tên sản phẩm</th>
                            <th width="180">Ảnh</th>
                            <th width="80">Số lượng</th>
                            <%--                            <th>Ngày sinh</th>--%>
                            <%--                            <th>Giới tính</th>--%>
                            <%--                            <th>SĐT</th>--%>
                            <th width="120">Tình trạng</th>
                            <th width="100">Giá tiền</th>
                            <th>Nội dung</th>
                            <%--                            <th>Chức vụ</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <%--                        <c:forEach items="${map.get('employeesAccount')}" var="item" varStatus="loop">--%>
                        <%--                            <tr data-id="${item.id}">--%>
                        <%--                                <td>#${item.id}</td>--%>
                        <%--                                <td id="userName">${item.userName}</td>--%>
                        <%--                                <td><img class="img-card-person" src="${item.avatar}" alt=""></td>--%>
                        <%--                                <td>${item.address}</td>--%>
                        <%--                                <td id="userPhone">${item.phone}</td>--%>
                        <%--                                <c:choose>--%>
                        <%--                                    <c:when test="${item.status==1}">--%>
                        <%--                                        <td><span class="statusActivity isAction">Hoạt động</span></td>--%>
                        <%--                                    </c:when>--%>
                        <%--                                    <c:otherwise>--%>
                        <%--                                        <td><span class="statusActivity isNotAction">Đã khóa</span></td>--%>
                        <%--                                    </c:otherwise>--%>
                        <%--                                </c:choose>--%>
                        <%--                                <td><span class="roleUser isAction" class="userRole">${item.getNameRole()}</span>--%>
                        <%--                                </td>--%>
                        <%--                            </tr>--%>
                        <%--                        </c:forEach>--%>
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
<script src="javascrip/productAdmin.js"></script>
<!-- The javascript plugin to display page loading on top-->
<script src="js/plugins/pace.min.js"></script>
<!-- Page specific javascripts-->
<script type="text/javascript" src="js/plugins/chart.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/dataTables.bootstrap.min.js"></script>
<%--<script type="text/javascript">--%>
<%--    var tableCustomers = $('#tableCustomers').DataTable(--%>
<%--    );--%>
<%--    var tableEmployees= $('#tableEmployees').DataTable()--%>

<%--    var tableManages = $('#tableManages').DataTable(--%>

<%--    );--%>


<%--    var data = {--%>
<%--        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],--%>
<%--        datasets: [{--%>
<%--            label: "Dữ liệu đầu tiên",--%>
<%--            fillColor: "rgba(255, 255, 255, 0.158)",--%>
<%--            strokeColor: "black",--%>
<%--            pointColor: "rgb(220, 64, 59)",--%>
<%--            pointStrokeColor: "#fff",--%>
<%--            pointHighlightFill: "#fff",--%>
<%--            pointHighlightStroke: "green",--%>
<%--            // data: [20, 59, 90, 51, 56, 100, 40, 60, 78, 53, 33, 81]--%>
<%--        },--%>
<%--            {--%>
<%--                label: "Dữ liệu kế tiếp",--%>
<%--                fillColor: "rgba(255, 255, 255, 0.158)",--%>
<%--                strokeColor: "rgb(220, 64, 59)",--%>
<%--                pointColor: "black",--%>
<%--                pointStrokeColor: "#fff",--%>
<%--                pointHighlightFill: "#fff",--%>
<%--                pointHighlightStroke: "green",--%>
<%--                // data: [48, 48, 49, 39, 86, 10, 50, 70, 60, 70, 75, 90]--%>
<%--            }--%>
<%--        ]--%>
<%--    };--%>


<%--    var ctxl = $("#lineChartDemo").get(0).getContext("2d");--%>
<%--    var lineChart = new Chart(ctxl).Line(data);--%>

<%--    var ctxb = $("#barChartDemo").get(0).getContext("2d");--%>
<%--    var barChart = new Chart(ctxb).Bar(data);--%>
<%--</script>--%>
<!-- Google analytics script-->
<%--<script type="text/javascript">--%>
<%--    if (document.location.hostname == 'pratikborsadiya.in') {--%>
<%--        (function (i, s, o, g, r, a, m) {--%>
<%--            i['GoogleAnalyticsObject'] = r;--%>
<%--            i[r] = i[r] || function () {--%>
<%--                (i[r].q = i[r].q || []).push(arguments)--%>
<%--            }, i[r].l = 1 * new Date();--%>
<%--            a = s.createElement(o),--%>
<%--                m = s.getElementsByTagName(o)[0];--%>
<%--            a.async = 1;--%>
<%--            a.src = g;--%>
<%--            m.parentNode.insertBefore(a, m)--%>
<%--        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');--%>
<%--        ga('create', 'UA-72504830-1', 'auto');--%>
<%--        ga('send', 'pageview');--%>
<%--    }--%>
<%--</script>--%>

<script>
    var dataMain

    pTable = $('#sampleTable').dataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    const init = ()=>{
        $.ajax({
            url: "/api/product",
            type: "GET",
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {
                // fake data chuyen thanh JSON.parse(data)
                dataMain =  JSON.parse(data)
                console.log(dataMain)
                document.querySelector('.count_all_product').textContent = dataMain.length + " sản phẩm"
                document.querySelector('.count_available_product').textContent = dataMain.filter(tmp => tmp.quantity >0).length + " sản phẩm"
                document.querySelector('.count_unavailable_product').textContent = dataMain.filter(tmp => tmp.quantity ===0).length + " sản phẩm"

                initTable(dataMain)
                initTableStatus(dataMain)
            }
        })};
    init()
    const toUSD = (money)=>{
        return money.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
    }

    const checkStatusCar =(carStatus) => {
        let status
        if (carStatus === 1){
            status = "Còn hàng"
        }else {
            status = "Hết hàng"
        }
    }
    const initTable = (data)=>{
        $('#tableBranchManages').DataTable({
            data: data,
            columns: [
                { data: "id"},
                { data: "name" },
                { data: "images", "render": function (images, type, row, meta) {
                        let rs = `<img src="`+images[0]+`" alt="" width="100px;">`
                        return rs
                    }},
                { data: "quantity"},
                { data: ""
                    , "render": function (data, type, row, meta) {
                        let status;
                        let badge;
                        if (row.quantity > 0){
                            status = "Còn hàng"
                            badge = "available"
                        }else{
                            status = "Hết hàng"
                            badge = "unavailable"
                        }
                        return `<td><span class="`+badge+`">`+status+`</span></td>`;
                    }
                },
                // { data: "total_price", "render": function (data, type, row, meta) {
                //         return toUSD(data);
                //     }},
                { data: "price", "render": function (data, type, row, meta) {
                        return toUSD(data);
                    }},
                {data: "content"}
                <%--                {data:"","render": function (data, type, row, meta) {--%>
                <%--                        return `<button class="btn btn-primary btn-sm trash" type="button" title="Xóa"--%>
                <%--                                            onclick="deleteRow(this, ${row.id})" style="width: 32px; height: 30px"><i class="fas fa-trash-alt"></i>--%>
                <%--                                </button>--%>
                <%--                                <button method="POST" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" style="width: 32px; height: 30px">--%>
                <%--                                  <i class="fas fa-edit" style="margin-left: -2.5px;"></i>--%>
                <%--                                </button>--%>
                <%--                                &lt;%&ndash;<form action="admin?action=editproduct&id= ${row.id}" method="POST" >&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;    <input name="id" value="${row.id}" hidden>&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;    <button class="btn btn-primary btn-sm edit"  type="submit" title="Sửa"   id="show-emp${row.id}" data-toggle="modal"&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;            data-target="#ModalUP2"><i class="fas fa-edit"></i></button>&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;</form>&ndash;%&gt;--%>

                <%--`--%>
                <%--                    }}--%>
            ],
        });
    }

    const initTableStatus = (data)=>{
        $('#tableStatusManages').DataTable({
            data: data,
            columns: [
                { data: "id"},
                { data: "name" },
                { data: "images", "render": function (images, type, row, meta) {
                        let rs = `<img src="`+images[0]+`" alt="" width="100px;">`
                        return rs
                    }},
                { data: "quantity"},
                { data: ""
                    , "render": function (data, type, row, meta) {
                        let status;
                        let badge;
                        if (row.quantity > 0){
                            status = "Còn hàng"
                            badge = "available"
                        }else{
                            status = "Hết hàng"
                            badge = "unavailable"
                        }
                        return `<td><span class="`+badge+`">`+status+`</span></td>`;
                    }
                },
                // { data: "total_price", "render": function (data, type, row, meta) {
                //         return toUSD(data);
                //     }},
                { data: "price", "render": function (data, type, row, meta) {
                        return toUSD(data);
                    }},
                {data: "content"}
                <%--                {data:"","render": function (data, type, row, meta) {--%>
                <%--                        return `<button class="btn btn-primary btn-sm trash" type="button" title="Xóa"--%>
                <%--                                            onclick="deleteRow(this, ${row.id})" style="width: 32px; height: 30px"><i class="fas fa-trash-alt"></i>--%>
                <%--                                </button>--%>
                <%--                                <button method="POST" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" style="width: 32px; height: 30px">--%>
                <%--                                  <i class="fas fa-edit" style="margin-left: -2.5px;"></i>--%>
                <%--                                </button>--%>
                <%--                                &lt;%&ndash;<form action="admin?action=editproduct&id= ${row.id}" method="POST" >&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;    <input name="id" value="${row.id}" hidden>&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;    <button class="btn btn-primary btn-sm edit"  type="submit" title="Sửa"   id="show-emp${row.id}" data-toggle="modal"&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;            data-target="#ModalUP2"><i class="fas fa-edit"></i></button>&ndash;%&gt;--%>
                <%--                                &lt;%&ndash;</form>&ndash;%&gt;--%>

                <%--`--%>
                <%--                    }}--%>
            ],
        });
    }

    document.querySelector("#company").addEventListener('input', (e)=>{
        var e = e.target
        var value = e.value;
        var company = e.options[e.selectedIndex].text;
        let data =dataMain
        if(company !== 'Tất cả'){
           data = dataMain.filter(tmp=>tmp.vendo.name === company)
        }

        $('#tableBranchManages').DataTable().clear().destroy();
        initTable(data)
        console.log(data, company)
    })

    document.querySelector("#status").addEventListener('input', (e)=>{
        var e = e.target
        var value = e.value;
        var status = e.options[e.selectedIndex].text;
        let data =dataMain

        if (status !== 'Tất cả'){
            if (status !== 'Hết hàng'){
                 data = dataMain.filter(tmp=>tmp.quantity > 0)
            } else {
                 data = dataMain.filter(tmp=>tmp.quantity === 0)
            }
        }
        $('#tableStatusManages').DataTable().clear().destroy();
        initTableStatus(data)
        console.log(data)
    })
</script>

</body>
</html>
