<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách nhân viên | Quản trị Admin</title>
    <!-- Main CSS-->
    <link rel="stylesheet" href="/css/main.css">
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
    <jsp:param name="page" value="3"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách nhân viên</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất
                                Excel</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>

                    </div>
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           border="0"
                           id="sampleTable">
                        <thead>
                        <tr>
                            <th width="10"><input type="checkbox" id="all"></th>
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
                            <th width="100">Tính năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listUser}" var="item" varStatus="loop">
                            <tr data-id="${item.id}">
                                <td width="10"><input type="checkbox" name="check2" value="2"></td>
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
                                <td><span class="roleUser isAction" id="userRole">${item.getNameRole()}</span>

                                </td>

                                <td>
                                    <c:choose>
                                    <c:when test="${item.status==1}">
                                    <button id="trash-${item.id}" class="btn btn-primary btn-sm trash" type="button"
                                            title="Xóa"><i class="fas fa-trash-alt"></i>
                                    </button>
                                    <button style="margin-right: 3px; display: none" id="unlock-${item.id}"
                                            class="btn btn-primary btn-sm unlock" type="button"
                                            title="Xóa"><i class="fas fa-lock-open"></i>
                                        </c:when>
                                        <c:otherwise>
                                        <button style="display: none" id="trash-${item.id}"
                                                class="btn btn-primary btn-sm trash" type="button"
                                                title="Xóa"><i class="fas fa-trash-alt"></i>
                                        </button>
                                        <button style="margin-right: 3px" id="unlock-${item.id}"
                                                class="btn btn-primary btn-sm unlock" type="button"
                                                title="Xóa"><i class="fas fa-lock-open"></i>
                                            </c:otherwise>
                                            </c:choose>

                                            <button class="btn btn-primary btn-sm edit show-emp" type="submit"
                                                    title="Sửa"
                                                    id="show-emp||${item.id}" data-toggle="modal"
                                                    data-target="#ModalUP"><i
                                                    class="fas fa-edit"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:forEach begin="1"
                           end="${size}"
                           step="1" varStatus="loop">
                    <div class="col-sm-2">
                        <a class="btn btn-excel btn-sm" href="/managerUSer?page=${loop.index}" title="In"><i
                                class="fas fa-file-excel"></i> Next</a>
                    </div>

                </c:forEach>

            </div>
        </div>

    </div>
</main>
<!--
MODAL
-->
<div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content" style="width: 500px">

            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
              <span class="thong-tin-thanh-toan">
                <h5>Chỉnh sửa thông tin nhân viên cơ bản</h5>
              </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label">ID nhân viên</label>
                        <input class="form-control" id="idUser" type="text" required disabled>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Họ và tên</label>
                        <input class="form-control" id="fullName" type="text" required>
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Số điện thoại</label>
                        <input class="form-control" id="phoneNumber" type="number" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Địa chỉ email</label>
                        <input class="form-control" id="emailUser" type="text" required disabled>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Trạng thái tài khoản</label>
                        <input class="form-control" id="statusAccount" type="text" required disabled>
                    </div>
                    <div class="form-group  col-md-6">
                        <label for="author" class="control-label">Chức vụ</label>
                        <input class="form-control" id="author" type="text" required disabled>
                    </div>
                </div>
                <BR>
                <button class="btn btn-save" type="button">Lưu lại</button>
                <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                <BR>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<script src="jsadmin/jquery-3.2.1.min.js"></script>
<script src="jsadmin/popper.min.js"></script>
<script src="jsadmin/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="src/jquery.table2excel.js"></script>
<script src="jsadmin/main.js"></script>
<script src="jsadmin/plugins/pace.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/dataTables.bootstrap.min.js"></script>
<script type="application/javascript">
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

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
    //Modal

    var oTable = $('#sampleTable').DataTable();
    oTable.on('click', '.trash', function () {
        swal({
            title: "Cảnh báo",
            text: "Bạn có chắc chắn là muốn khóa tài khoản này?",
            buttons: ["hủy bỏ", "oke"],
        })
            .then((willDelete) => {
                if (willDelete) {
                    let id = $(this).attr('id').split("-")[1];
                    let status = 0;
                    fetch("/user?choose=changeStatus&id=" + id + "&status=" + status)
                        .then((resp) => {
                            $('.unlock#unlock-' + id).css("display", "inline");
                            $('.trash#trash-' + id).css("display", "none");
                            $(this).closest('tr').find(".statusActivity").removeClass('isAction').addClass('isNotAction').text('Đã khóa');
                            swal("Đã xóa thành công.!", {});
                        })
                        .catch(() => {
                            swal("Xóa không thành công!", {});
                        })
                }
            })
    });
    oTable.on('click', '.unlock', function () {
        swal({
            title: "Cảnh báo",
            text: "Bạn muốn mở khóa lại tài khoản này",
            buttons: ["hủy bỏ", "oke"],
        })
            .then((willDelete) => {
                if (willDelete) {
                    let id = $(this).attr('id').split("-")[1];
                    let status = 1;
                    fetch("/user?choose=changeStatus&id=" + id + "&status=" + status)
                        .then((resp) => {
                            $('.unlock#unlock-' + id).css("display", "none");
                            $('.trash#trash-' + id).css("display", "inline");
                            $(this).closest('tr').find(".statusActivity").removeClass('isNotAction').addClass('isAction').text('Hoạt động');
                            swal("Đã mở khóa thành công tài khoản.!", {});
                        })
                        .catch(() => {
                            swal("Mở khóa không thành công!", {});
                        })
                }
            })
    });

    oTable.on('click', '.show-emp', function () {
        var element = $(this).attr("id");
        var id = (element.split("||")[1])
        $.ajax({
            url: "/user?choose=getInfoUser&id=" + id,
            type: "Get",
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {
                $(".btn-save").attr("id", element)
                $("#idUser").val(data.id);
                $("#fullName").val(data.fullName);
                $("#phoneNumber").val(data.phone);
                $("#emailUser").val(data.email);
                $("#author").val(data.role);
                $("#statusAccount").val(data.status);
            }
        })
        $("#ModalUP").modal({backdrop: false, keyboard: false})
    })
    $('.btn-save').on('click', function () {
        console.log(1238)
        const id = $(this).attr("id").split("||")[1]
        var name = $("#fullName").val() ? $("#fullName").val() : ""
        var phone = $("#fullName").val() ? $("#phoneNumber").val() : ""
        var data = {
            name,
            phone,
            id
        };
        $.ajax({
            url: "/user",
            type: "Post",
            data: data,
            contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
            success: function (data) {
                if (data.status == "ok") {
                    document.querySelector("tr[data-id=" + "'" + id + "'" + "] #userName").textContent = name
                    document.querySelector("tr[data-id=" + "'" + id + "'" + "] #userPhone").textContent = phone
                    swal("Sửa thành công.!", {});
                } else {
                    swal("Sửa không thành công.!", {});
                }

            },
            error: function (xhr, status, error) {
                swal("Số điện thoại khong hợp lệ!", {});
            }
        })
    });


</script>
</body>

</html>