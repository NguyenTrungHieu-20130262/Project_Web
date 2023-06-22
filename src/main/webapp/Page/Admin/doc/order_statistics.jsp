<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="Model.Oder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách đơn hàng | Quản trị Admin</title>
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <style>
        .top_oders_statis{
            display: flex;

        }
        .box_statis{
            display: flex;
            justify-content: space-between;
            gap: 50px;
        }
        .item_box{
            flex: 1;
            padding: 10px;
            border: 1px solid lightgray;
            padding: 20px;

            border-radius: 10px;
            padding-right: 40px;
            color: white;
        }
        .item_box p{
            font-size: 30px;
            text-align: right;
            margin: 0;
        }
        .item_box .p2{
            font-size: 15px;
            margin: 5px;
            text-align: right;
        }
        .item_box.box1{
            background-color: rgb(250 104 105);
        }
        .item_box.box2{
            background-color:rgb(7 215 157);
        }
        .item_box.box3{
            background-color: rgb(57 139 247);
        }

        .item_box.box4{
            background-color: rgb(141 68 173);
        }
        .box_order_bottom >div{
            border: 1px solid lightgray;
            padding: 0 15px;

        }
        .box_order_bottom >div div{
            display: flex;
            justify-content: space-between;
        }
        .box_order_bottom >div >p{
            padding: 20px 0px;
            font-weight: bold;
            border-bottom: 1px solid black;
        }
    </style>


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
    <jsp:param name="page" value="8"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Thống kê đơn hàng</b></a></li>
        </ul>
        <div id="clock"><span class="date"> </span></div>
    </div>
<div class="box_statis">
    <div class="item_box box1">
        <p class="total_price">$523000</p>
        <p class="p2">Doanh thu</p>
    </div>
    <div class="item_box box2">
        <p class="total_dec">240</p>
        <p class="p2">Đơn hàng đã giao</p>

    </div>
    <div class="item_box box3">
        <p class="total_process">23</p>
        <p class="p2">Đơn hàng đang xử lý</p>

    </div>
    <div class="item_box box4">
        <p class="total_canel">43</p>
        <p class="p2">Đơn hàng đã hủy</p>

    </div>
</div>
<hr/>
<br/>
<br/>
<br/>

<div class="top_oders_statis">
    <div style="flex: 2;">
        <canvas id=chart_by_month></canvas>
        <p style="text-align: center;    margin-top: 20px;">Thống kê đơn hàng theo năm</p>

    </div>
    <hr/>
    <div style="flex: 1">
        <canvas id="countries"></canvas>
        <p style="text-align: center;    margin-top: 20px;">Thống kê đơn hàng theo hãng</p>

    </div>
</div>
<div>
    <div class="tile">
        <div class="tile-body">
            <div class="row element-button">


                <div class="col-sm-2" onclick='htmlTableToExcel("order_statis")'>
                    <a class="btn btn-excel btn-sm" title="In"><i class="fas fa-file-excel"
                    ></i> Xuất
                        Excel</a>
                </div>


            </div>
            <table class="table table-hover table-bordered" id="myTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Khách hàng</th>
                    <th>Tổng tiền</th>
                    <th>Địa chỉ</th>
                    <th>Tình trạng</th>
                    <th>Tính năng</th>

                </tr>
                </thead>
                <tbody id="body_table_orders">

                </tbody>






                </tbody>


            </table>
            </div>
        </div>
    </div>
    <div >
        <h4>Thống kê đơn hàng và phí vận chuyển
        </h4>
        <div class="box_order_bottom" style="display: grid; grid-template-columns: auto auto auto; gap: 30px;">
            <div style="grid-row: span 2;">
                <p>Tổng số lượng đơn</p>
                <hr/>
                <div><p>Số Lượng Đơn Hàng</p> <p class="totalOrders">208</p></div>
                <div><p>Số Lượng Đơn Hàng Đã Hủy</p> <p class="totalOrdersCanel">208</p></div>
                <div><p>Số Lượng Đơn Hàng Đang Xử Lý</p> <p class="totalOrdersProcessing">208</p></div>
                <div><p>Số Lượng Đơn Hàng Đã Giao</p> <p class="totalOrdersDelivery">208</p></div>
                <div><p>Số Lượng Đơn Hàng Thanh Toán Online</p> <p class="totalOrdersOnline">108</p></div>
                <div><p>Số Lượng Đơn Hàng Thanh Toán Khi Nhận Hàng</p> <p class="totalOrdersReceived">100</p></div>
                <div><p>Tổng thu người nhận</p> <p class="totalPriceReceived">208</p></div>
                <div><p>Tổng phí vận chuyển</p> <p class="totalPriceTransport">208</p></div>

            </div>
            <div>
                <p>Đơn hàng đã giao (Thanh Toán Online)</p>
                <hr/>
                <div><p>Số Lượng Đơn Hàng</p> <p class="totalOrdersOnlineDelivery">208</p></div>
                <div><p>Tổng thu người nhận</p> <p class="totalPriceReceivedOnlineDelivery">108</p></div>
                <div><p>Tổng phí vận chuyển</p> <p class="totalPriceTransportOnlineDelivery">100</p></div>


            </div>
            <div>
                <p>Đơn hàng đang xử lý (Thanh Toán Online)</p>
                <hr/>
                <div><p>Số Lượng Đơn Hàng</p> <p class="totalOrdersOnlineProcessing">208</p></div>
                <div><p>Tổng thu người nhận</p> <p class="totalPriceReceivedOnlineProcessing">108</p></div>
                <div><p>Tổng phí vận chuyển</p> <p class="totalPriceTransportOnlineProcessing">100</p></div>
            </div>
            <div>
                <p>Đơn hàng đã giao (Thanh Toán Khi Nhận Hàng)</p>
                <hr/>
                <div><p>Số Lượng Đơn Hàng</p> <p class="totalOrdersReceivedDelivery">208</p></div>
                <div><p>Tổng thu người nhận</p> <p class="totalPriceReceivedDelivery">108</p></div>
                <div><p>Tổng phí vận chuyển</p> <p class="totalPriceTransportReceivedDelivery">100</p></div>
            </div>
            <div>
                <p>Đơn hàng đang xử lý (Thanh Toán Khi Nhận Hàng)</p>
                <hr/>
                <div><p>Số Lượng Đơn Hàng</p> <p class="totalOrdersReceivedProcessing">208</p></div>
                <div><p>Tổng thu người nhận</p> <p class="totalPriceReceivedProcessing">108</p></div>
                <div><p>Tổng phí vận chuyển</p> <p class="totalPriceTransportProcessing">100</p></div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailsModalLabel" aria-hidden="true">
        <div id="outside_modal" style="position: fixed; top: 0; left: 0;right: 0; bottom: 0; z-index: 998">

        </div>
        <div class="modal-dialog modal-dialog-centered modal-xl" style="z-index: 999" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailsModalLabel">Order Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div>
                        <p><strong>Tên khách hàng: </strong><span class="show_detail_orders_name"></span></p>
                        <p><strong>Địa chỉ: </strong><span class="show_detail_orders_address"></span></p>
                        <p><strong>Số điện thoại: </strong><span class="show_detail_orders_phone"></span></p>
                        <p><strong>Email: </strong><span class="show_detail_orders_email"></span></p>

                        <p><strong>Tổng tiền: </strong><span class="show_detail_orders_total"></span></p>
                        <p><strong>Trạng thái: </strong><span class="show_detail_orders_status"></span></p>

                    </div>
                    <div class="table-details">
                        <table>
                            <thead>
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody id="table_orders_detail">

                            </tbody>
                        </table>
                    </div>

                    <table class="table">

                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close_detail" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

<script src="javascrip/ordersStatis.js"></script>

</html>