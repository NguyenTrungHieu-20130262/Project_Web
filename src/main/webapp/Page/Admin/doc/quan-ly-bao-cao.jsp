<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="Model.Oder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Product" %>
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
    <jsp:param name="page" value="1"/>
</jsp:include>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Báo cáo doanh thu </b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon  bx bxs-user fa-3x'></i>
                <div class="info">
                    <h4>Tổng khách hàng</h4>
                    <p><b>${countUser} nhân viên</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small info coloured-icon"><i class='icon bx bxs-purchase-tag-alt fa-3x'></i>
                <div class="info">
                    <h4>Tổng sản phẩm</h4>
                    <p><b>${countProduct} sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-shopping-bag-alt'></i>
                <div class="info">
                    <h4>Tổng đơn hàng</h4>
                    <p><b>${countOrder} đơn hàng</b></p>
                </div>
            </div>
        </div>
    </div>
    <div style="display: flex;align-items: center;justify-content: space-around" class="row">
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon fa-3x bx bxs-chart'></i>
                <div class="info">
                    <h4>Tổng thu nhập</h4>
                    <p><b>${getPriceRevenue} đ</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-tag-x'></i>
                <div class="info">
                    <h4>Hết hàng</h4>
                    <p><b>${countPOut} sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div style="width: 30px" class="col-md-6 col-lg-3">
            <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-receipt'></i>
                <div class="info">
                    <h4>Đơn hàng hủy</h4>
                    <p><b>${countOrderOut} đơn hàng</b></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">SẢN PHẨM HẾT HÀNG</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="myTable">
                        <thead>
                        <tr>
                            <th width="10"><input type="checkbox" id="all2"></th>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Ảnh</th>
                            <th>Số lượng</th>
                            <th>Tình trạng</th>
                            <th>Giá tiền</th>
                            <th>Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products"); %>

                        <%
                            Locale localeUSD = new Locale("US", "US");
                            NumberFormat usd = NumberFormat.getInstance(localeUSD);
                            double doubleNumber1 = 10.17d;

                            for (int i = 0; i < products.size(); i++) {
                                Product tmp = products.get(i);
                        %>
                        <tr id="row<%=tmp.getId()%>">
                            <td width="10"><input type="checkbox" name="check<%=i + 1%>" value="<%=i + 1%>"></td>
                            <td><%=tmp.getId()%>
                            </td>
                            <td><%=tmp.getName()%>
                            </td>
<%--                            <td><img src="<%=tmp.arrayImg()[0]%>" alt="" width="100px;"></td>--%>
                            <td><%=0%>
                            </td>
                            <td><span
                                    class="badge bg-info">Hết hàng</span>
                            </td>
                            <td><%=usd.format(tmp.getPrice())%> đ</td>

                            <td>
                                <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                        onclick="deleteRow(this, <%=tmp.getId()%>)"><i class="fas fa-trash-alt"></i>
                                </button>
                                <form action="admin?action=editproduct&id=<%=tmp.getId()%>" method="POST">
                                    <input name="id" value="<%=tmp.getId()%>" hidden>
                                    <button class="btn btn-primary btn-sm edit" type="submit" title="Sửa"
                                            id="show-emp<%=tmp.getId()%>" data-toggle="modal"
                                            data-target="#ModalUP2"><i class="fas fa-edit"></i></button>
                                </form>


                            </td>
                        </tr>
                        <%}%>
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
                    <h3 class="tile-title">ĐƠN HÀNG ĐÃ BỊ HỦY</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="myTable">
                        <thead>
                        <tr>
                            <th width="10"><input type="checkbox" id="all1"></th>
                            <th>ID đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Đơn hàng</th>
                            <th>Số lượng</th>
                            <th>Tổng tiền</th>
                            <th>Tình trạng</th>
                            <th>Tính năng</th>
                        </tr>
                        </thead>
                        <%ArrayList<Oder> oders = (ArrayList<Oder>) request.getAttribute("oders");%>
                        <tbody>
                        <%
                            NumberFormat vn1 = NumberFormat.getInstance(localeUSD);
                            for (int i = 0; i < oders.size(); i++) {
                                Oder tmp = oders.get(i);
                        %>
                        <tr>
                            <td width="10"><input type="checkbox" name="check<%=tmp.getId()%>" value="<%=i%>"></td>
                            <td><%=tmp.getId()%>
                            </td>
                            <td><%=tmp.getIdTransport()%>
                            </td>
                            <td><%=tmp.getNote()%>
                            </td>
                            <td><%=tmp.getIdUser()%>
                            </td>
                            <td><%=vn1.format(tmp.getTotal_price())%></td>
                            <%
                                String status = "Đã hủy";
                                String badge = "badge badge-danger";
                            %>
                            <td><span class="<%=badge%>"><%=status%></span></td>
                            <td>
                                <button class="btn btn-primary btn-sm trash" type="button"
                                        onclick="deleteRow(this, <%=tmp.getId()%>)" title="Xóa"><i
                                        class="fas fa-trash-alt"><input hidden value="<%=tmp.getId()%>"/> </i></button>
                                <button class="btn btn-primary btn-sm edit" type="button" data-toggle="modal"
                                        data-target="#ModalUP<%=tmp.getId()%>" title="Sửa"><i class="fa fa-edit"></i>
                                </button>
                                <button class="btn btn-primary btn-sm edit"
                                        style="background-color: #1e7e34; color:white;" type="button"
                                        data-toggle="modal"
                                        data-target="#ModalView<%=tmp.getId()%>" title="Sửa"><i class="fa fa-info"></i>
                                </button>
                            </td>

                        </tr>
                        <div class="modal fade" id="ModalUP<%=tmp.getId()%>" tabindex="-1" role="dialog"
                             aria-hidden="true"
                        >
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group  col-md-12">
          <span class="thong-tin-thanh-toan">
            <h5>Chỉnh sửa thông tin đơn hàng</h5>
          </span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label class="control-label" name="idpost">Mã đơn hàng </label>
                                                <input class="form-control" disabled value="<%=tmp.getId()%>"
                                                       type="number">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Tên khách hàng</label>
                                                <input class="form-control" value="<%=tmp.getIdUser()%>"
                                                       name="fullname" type="text"/>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Tên sản phẩm</label>
                                                <input class="form-control" disabled value="<%=tmp.getIdTransport()%>"
                                                       name="title" type="text"/>
                                            </div>
                                            <div class="form-group  col-md-6">
                                                <label class="control-label">Số lượng</label>
                                                <input class="form-control" name="quantity"
                                                       value="<%=tmp.getTotal_price()%>" type="number" required>
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label class="control-label">Địa chỉ</label>
                                                <input class="form-control" name="address" value="<%=tmp.getAddress()%>"
                                                       type="text">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Phone</label>
                                                <input class="form-control" name="phone" value="<%=tmp.getAddress()%>"
                                                       type="text">
                                            </div>
                                            <div class="form-group col-md-12">
                                                <label class="control-label">Trạng thái</label>
                                                <select class="form-control" name="status">
                                                    <option value="0" <%=tmp.getStatus() == 0 ? "selected" : ""%>>Đang
                                                        xử lý
                                                    </option>
                                                    <option value="1" <%=tmp.getStatus() == 1 ? "selected" : ""%>>Đã
                                                        hoàn thành
                                                    </option>
                                                    <option value="2" <%=tmp.getStatus() == 2 ? "selected" : ""%>>Đã
                                                        hủy
                                                    </option>

                                                </select>
                                            </div>


                                        </div>
                                        <br>
                                        <br>
                                        <button class="btn btn-save" type="button" onclick="updateOder(this)">Lưu lại
                                        </button>
                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                        <br>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="ModalView<%=tmp.getId()%>" tabindex="-1" role="dialog"
                             aria-hidden="true"
                        >
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">

                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="form-group  col-md-12">
          <span class="thong-tin-thanh-toan">
            <h5>Thông tin chi tiết đơn hàng</h5>
          </span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label class="control-label" name="idpost">Mã đơn hàng </label>
                                                <input class="form-control" disabled value="<%=tmp.getId()%>"
                                                       type="number">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Tên khách hàng</label>
                                                <input class="form-control" value="<%=tmp.getTotal_price()%>" disabled
                                                       name="fullname" type="text"/>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Địa chỉ</label>
                                                <input class="form-control" name="address" disabled
                                                       value="<%=tmp.getAddress()%>" type="text">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Phone</label>
                                                <input class="form-control" name="phone" disabled
                                                       value="<%=tmp.getAddress()%>" type="text">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Username</label>
                                                <input class="form-control" name="Username" disabled
                                                       value="<%=tmp.getNote()%>" type="text">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Tên sản phẩm</label>
                                                <input class="form-control" disabled value="<%=tmp.getIdTransport()%>"
                                                       name="title" type="text"/>
                                            </div>

                                            <div class="form-group  col-md-6">
                                                <label class="control-label">Số lượng</label>
                                                <input class="form-control" name="quantity" disabled
                                                       value="<%=tmp.getStatus()%>" type="number" required>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="control-label">Tổng tiền</label>
                                                <input class="form-control" disabled value="<%=tmp.getIdTransport()%>"
                                                       name="total" type="text"/>
                                            </div>

                                            <div class="form-group col-md-12">
                                                <label class="control-label">Trạng thái</label>
                                                <input class="form-control" name="status" disabled value="<%=status%>"
                                                       type="text">

                                            </div>


                                        </div>
                                        <BR>
                                        <BR>
                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                        <BR>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>

                        </tbody>

                    </table>
                    <%--        <div class="row">--%>
                    <%--                <div class="col-md-12">--%>
                    <%--                    <div class="tile">--%>
                    <%--                        <div>--%>
                    <%--                            <h3 class="tile-title">SẢN PHẨM ĐÃ HẾT</h3>--%>
                    <%--                        </div>--%>
                    <%--                        <div class="tile-body">--%>
                    <%--                            <table class="table table-hover table-bordered" id="sampleTable">--%>
                    <%--                                <thead>--%>
                    <%--                                    <tr>--%>
                    <%--                                            <th>Mã sản phẩm</th>--%>
                    <%--                                            <th>Tên sản phẩm</th>--%>
                    <%--                                            <th>Ảnh</th>--%>
                    <%--                                            <th>Số lượng</th>--%>
                    <%--                                            <th>Tình trạng</th>--%>
                    <%--                                            <th>Giá tiền</th>--%>
                    <%--                                            <th>Danh mục</th>--%>
                    <%--                                    </tr>--%>
                    <%--                                </thead>--%>
                    <%--                                <tbody>--%>
                    <%--                                    <tr>--%>
                    <%--                                            <td>83826226</td>--%>
                    <%--                                            <td>Tủ ly - tủ bát</td>--%>
                    <%--                                            <td><img src="/img-sanpham/tu.jpg" alt="" width="100px;"></td>--%>
                    <%--                                            <td>0</td>--%>
                    <%--                                            <td><span class="badge bg-danger">Hết hàng</span></td>--%>
                    <%--                                            <td>2.450.000 đ</td>--%>
                    <%--                                            <td>Tủ</td>--%>
                    <%--                                    </tr>--%>
                    <%--                                </tbody>--%>
                    <%--                            </table>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <%--                </div>--%>
                    <%--            </div>--%>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="tile">
                                <h3 class="tile-title">DỮ LIỆU HÀNG THÁNG</h3>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="lineChartDemo"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="tile">
                                <h3 class="tile-title">THỐNG KÊ DOANH SỐ</h3>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="barChartDemo"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-right" style="font-size: 12px">
                        <p><b>Hệ thống quản lý V2.0 | Code by Trường</b></p>
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
<script type="text/javascript">
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


    var ctxl = $("#lineChartDemo").get(0).getContext("2d");
    var lineChart = new Chart(ctxl).Line(data);

    var ctxb = $("#barChartDemo").get(0).getContext("2d");
    var barChart = new Chart(ctxb).Bar(data);
</script>

</body>

</html>