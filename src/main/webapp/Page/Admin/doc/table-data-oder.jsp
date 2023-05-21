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
    <style>
        .table-details {
            position: relative;
            max-height: 300px;
            overflow: auto;
        }
        .address {
            padding: 4px ;
            border-radius:5px ;
        }
        .table-details table {
            width: 100%;
            border-collapse: separate;
        }

        .table-details th {
            position: sticky;
            top: -1px;
            background-color: white;
            z-index: 1;
            border: 1px solid #ddd;
        }
        .hide{
            display: none;
        }
        .table-details td,.table-details th {
            padding: 8px;
            border: 1px solid #ddd;
        }

    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- or -->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">


    <style>
        .action_order{
            cursor: pointer;
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
    <jsp:param name="page" value="6"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách đơn hàng</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">


                        <div class="col-sm-2" onclick='htmlTableToExcel("order")'>
                            <a class="btn btn-excel btn-sm" title="In"><i class="fas fa-file-excel"
                                                                          ></i> Xuất
                                Excel</a>
                        </div>
                        <div class="col-sm-2" onclick="exportTableToPDF('order')">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
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
    </div>
    <div class="modal fade" id="editOrderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="editOrderDetailsModal" aria-hidden="true">
        <div class="outside_modal" style="position: fixed; top: 0; left: 0;right: 0; bottom: 0; z-index: 998">

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
                        <p><strong>Tên khách hàng: </strong><span type="text" class="show_detail_orders_name"></span></p>
                        <p class="showAddress"><strong>Địa chỉ: </strong><span type="text" class="show_detail_orders_address"></span></p>

                        <div class="form_edit_address hide">
                            <label class="form-label" for="address"><strong>Địa chỉ: </strong></label>
                            <div id="order" style="display: flex; flex-direction: column;     gap: 10px">
                                <select class="address province">
                                    <option value="0">Tỉnh</option>
                                </select>
                                <select class="address district events_none" >
                                    <option value="0">Huyện</option>
                                </select>
                                <select class="address ward events_none" style="    margin-bottom: 0;">
                                    <option value="0">Xã</option>
                                </select>
                                <a  class="save_address" style="color: #3399cc; font-weight: 600; cursor: pointer;">Xác nhân</a>
                                <a  class="close_address" style="color: #3399cc; font-weight: 600; cursor: pointer;">Hủy</a>

                            </div>
                        </div>
                    </p>
                        <p><strong>Số điện thoại: </strong><span type="text" class="show_detail_orders_phone"></span></p>
                        <p><strong>Email: </strong><span type="text" class="show_detail_orders_email"></span></p>


                    </div>
                    <div class="table-details">
                        <table>
                            <thead>
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Giá tiền</th>
                                <th>Thao tác</th>

                            </tr>
                            </thead>
                            <tbody class="table_orders_detail_edit">

                            </tbody>
                        </table>
                    </div>

                    <table class="table">

                    </table>
                    <p><strong>Thêm sản phẩm cho đơn hàng</strong></p>
                    <div>
                        <select oninput='select_add_product()' class="address add_prodcut" style="width: 100%">
                            <option value="0">Chọn sản phẩm thêm vào đơn hàng</option>
                        </select>

                        <button style="margin-top: 10px; opacity: 0.6; pointer-events: none" type="button" onclick="add_product_order()" class="btn btn-success bt_add_product " data-dismiss="modal">Thêm sản phẩm</button>

                    </div>
                </div>
                <div class="modal-footer">
                    <input hidden="" value="" id="id_order_update"/>
                    <button style="background-color: #bb1818" type="button" class="btn btn-secondary cancelOrder"  data-dismiss="modal">Hủy đơn hàng</button>

                    <button type="button" class="btn btn-secondary saveEdit" onclick="saveUpdate()" data-dismiss="modal">Lưu</button>
                    <button type="button" class="btn btn-secondary exitModal" data-dismiss="modal">Thoát</button>
                </div>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="jsadmin/popper.min.js"></script>
<script src="jsadmin/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="jsadmin/jquery.table2excel.js"></script>
<script src="jsadmin/main.js"></script>
<!-- The javascript plugin to display page loading on top-->
<script src="jsadmin/plugins/pace.min.js"></script>
<!-- Page specific javascripts-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- Data table plugin-->

<script type="text/javascript" src="jsadmin/plugins/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>

<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

<script>
    const exportExel = (name) => {
        console.log(name)
        $("#myTable").table2excel({
            name: name,
            filename: "FileExcel",
            fileext: ".xls"
        })

    }


    function deleteRow(r, id) {

        swal({
            title: "Cảnh báo",
            text: "Bạn có chắc chắn là muốn xóa đơn hàng này?",
            buttons: ["Hủy bỏ", "Đồng ý"],
        }).then((willDelete) => {
            if (willDelete) {
                $.ajax(

                    {
                        statusCode: {
                            401: function() {
                                swal("Bạn không có quyền thực hiện chức năng này.!", {});

                            }
                        },
                    url: "/api/order?action=delete&id=" + id,
                    type: "POST",
                    contentType: 'application/x-www-form-urlencoded',
                    success: function (data) {
                        console.log(data)
                        console.log(data)
                        if (JSON.parse(data) === 1)
                            r.parentNode.parentNode.parentNode.remove()
                        swal("Đã xóa thành công.!", {});
                    }
                });

            }
        });
    }

    oTable = $('#sampleTable').dataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    //EXCEL
    // $(document).ready(function () {
    //   $('#').DataTable({

    //     dom: 'Bfrtip',
    //     "buttons": [
    //       'excel'
    //     ]
    //   });
    // });


    //Thời Gian
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

    //In dữ liệu
    var myApp = new function () {
        this.printTable = function () {
            var tab = document.getElementById('sampleTable');
            var win = window.open('', '', 'height=700,width=700');
            win.document.write(tab.outerHTML);
            win.document.close();
            win.print();
        }
    }
    //     //Sao chép dữ liệu
    //     var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

    // copyTextareaBtn.addEventListener('click', function(event) {
    //   var copyTextarea = document.querySelector('.js-copytextarea');
    //   copyTextarea.focus();
    //   copyTextarea.select();

    //   try {
    //     var successful = document.execCommand('copy');
    //     var msg = successful ? 'successful' : 'unsuccessful';
    //     console.log('Copying text command was ' + msg);
    //   } catch (err) {
    //     console.log('Oops, unable to copy');
    //   }
    // });

    function htmlTableToExcel(name){
        var data = document.getElementById('myTable');
        var excelFile = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
        XLSX.write(excelFile, { type: 'xlsx', bookSST: true, type: 'base64' });
        XLSX.writeFile(excelFile, name + '.xlsx' );
    }
    function exportTableToPDF(name) {
            var pdf = new jsPDF('p', 'pt', 'letter');

            source = $('#myTable');

            margins = {
                top: 80,
                bottom: 60,
                left: 40,
                width: 522
            };

            pdf.fromHTML(
                source,
                margins.left,
                margins.top, {
                    'width': margins.width,
                    'elementHandlers': source
                },
                function(dispose) {

                    pdf.save('Test.pdf');
                }
                , margins);

    }

    //Modal
    $("#show-emp").on("click", function () {
        $("#ModalUP").modal({backdrop: false, keyboard: false})
    });
</script>
<script src="javascrip/ordersAdmin.js"></script>
</body>

</html>