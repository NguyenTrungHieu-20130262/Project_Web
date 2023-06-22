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
    <jsp:param name="page" value="5"/>
</jsp:include>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Danh sách sản phẩm</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">

                            <a class="btn btn-add btn-sm" href="admin?page=post" title="Thêm"><i
                                    class="fas fa-plus"></i>
                                Tạo mới sản phẩm</a>
                        </div>

                        <div class="col-sm-2">
                            <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất
                                Excel</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"
                               onclick="myFunction(this)"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>

                    </div>
                    <table class="table table-hover table-bordered" id="myTable">
                        <thead>
                        <tr>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Ảnh</th>
                            <th>Số lượng</th>
                            <th>Tình trạng</th>
                            <th>Giá tiền</th>
                            <th>Chức năng</th>
                        </tr>
                        </thead>
                        <%--                            <tbody>--%>

                        <%--                            <%--%>
                        <%--                                ProductDAO productDAO = new ProductDAO();--%>

                        <%--                                Locale localeVN = new Locale("vi", "VN");--%>
                        <%--                                NumberFormat vn = NumberFormat.getInstance(localeVN);--%>
                        <%--                                double doubleNumber1 = 10.17d;--%>

                        <%--                                for(int i = 0; i < products.size();i++){--%>
                        <%--                                Product tmp = products.get(i);--%>
                        <%--                                int quantityProduct = productDAO.getQuantityProduct(tmp.getId());--%>
                        <%--                                String status;--%>
                        <%--                                if (quantityProduct > 0){--%>
                        <%--                                    status = "Còn hàng";--%>
                        <%--                                }else {--%>
                        <%--                                    status = "Hêt hàng";--%>
                        <%--                                }--%>
                        <%--                            %>--%>
                        <%--                            <tr id="row<%=tmp.getId()%>">--%>
                        <%--                                <td width="10"><input type="checkbox" name="check<%=i + 1%>" value="<%=i + 1%>"></td>--%>
                        <%--                                <td><%=tmp.getId()%></td>--%>
                        <%--                                <td><%=tmp.getName()%></td>--%>
                        <%--                                <td><img src="<%=tmp.getImages().get(0)%>" alt="" width="100px;"></td>--%>
                        <%--                                <td><%=quantityProduct%></td>--%>
                        <%--                                <td><span class= " <%=(quantityProduct> 0) ? "badge bg-success": "badge bg-info"%>"><%=(quantityProduct> 0) ? "Còn hàng":"Hết hàng"%></span></td>--%>
                        <%--                                <td><%=vn.format(tmp.getPrice())%> USD</td>--%>

                        <%--                                <td><button class="btn btn-primary btn-sm trash" type="button" title="Xóa"--%>
                        <%--                                            onclick="deleteRow(this, <%=tmp.getId()%>)"><i class="fas fa-trash-alt"></i>--%>
                        <%--                                </button>--%>
                        <%--                                <form action="admin?action=editproduct&id=<%=tmp.getId()%>" method="POST" >--%>
                        <%--                                    <input name="id" value="<%=tmp.getId()%>" hidden>--%>
                        <%--                                    <button class="btn btn-primary btn-sm edit"  type="submit" title="Sửa"   id="show-emp<%=tmp.getId()%>" data-toggle="modal"--%>
                        <%--                                            data-target="#ModalUP2"><i class="fas fa-edit"></i></button>--%>
                        <%--                                </form>--%>
                        <%--                                </td>--%>
                        <%--                            </tr>--%>
                        <%--                            <%}%>--%>
                        <%--                            </tbody>--%>

                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
<%@include file="/Component/loading/Loading.jsp" %>
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content" style="width: 600px">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
          <span class="thong-tin-thanh-toan">
            <h5>Chỉnh sửa thông tin sản phẩm</h5>
          </span>
                    </div>
                </div>
                <%@include file="/Page/Admin/doc/PostStatus/changeProduct/index.jsp" %>
                <style>
                    .inp:focus {
                        border: 1px solid #56A1EE;
                    }

                    .group-bt.two-bt .btn-send {
                        float: right;
                        background: #4DB848;
                    }

                    .clear {
                        color: #56A1EE;
                        margin-left: 200px;
                        cursor: pointer;
                    }

                    .form-select {
                        display: block;
                        width: 100%;
                        padding: 0.375rem 2.25rem 0.375rem 0.75rem;
                        -moz-padding-start: calc(0.75rem - 3px);
                        font-size: 1rem;
                        font-weight: 400;
                        line-height: 1.5;
                        color: #212529;
                        background-color: #fff;
                        background-repeat: no-repeat;
                        background-position: right 0.75rem center;
                        background-size: 16px 12px;
                        border: 1px solid #ced4da;
                        border-radius: 0.25rem;
                        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
                        -webkit-appearance: none;
                        -moz-appearance: none;
                        appearance: none;
                    }

                    .form-select {
                        z-index: 0;
                    }

                    .year-item {
                        border-radius: 15px;
                    }

                    .select_kt {
                        width: 150px;
                        padding: 5px;
                    }

                    .main_kt {
                        position: relative;
                        margin-bottom: 20px;

                    }

                    .main_kt label {
                        background-color: white;
                        padding: 0 10px;
                        position: absolute;
                        top: -10px;
                        left: 10px;
                    }

                    .fileupload {
                        display: none;
                    }

                    .inp:focus {
                        border: 1px solid #56A1EE;
                    }

                    .group-bt.two-bt .btn-send {
                        float: right;
                        background: #4DB848;
                    }

                    .control-last {
                        display: flex;
                        align-items: center;
                    }

                    .fileupload {
                        display: none;
                    }

                    .inp:focus {
                        border: 1px solid #56A1EE;
                    }

                    .group-bt.two-bt .btn-send {
                        float: right;
                        background: #4DB848;
                    }

                    .control-last {
                        display: flex;
                        align-items: center;
                    }

                </style>
                <form class="editForm ng-untouched ng-pristine ng-invalid" novalidate="">
                    <div class="container postnews">
                        <div class="gr-heading-post"><h2 class="heading "> Tiêu đề - nội dung </h2><span
                                class="status-per per3"></span>
                        </div>
                        <div class="control mt-20"><label class="lbl-form" for="">Tiêu đề</label>
                            <div class="prefix-title" style="margin: -10px 0 10px 195px"> Toyota Vios 1.5E MT 2017 -
                            </div>
                            <input id="tilte123" class="inp ng-untouched ng-pristine ng-invalid" formcontrolname="Title"
                                   placeholder="Ngắn gọn, đầy đủ, từ khóa quan trọng gây chú ý "
                                   style="margin-left: 190px;"
                                   type="text"><!----><!----><!----><!----></div>
                        <div class="control box-des"><label class="lbl-form" for="">Nội dung</label><textarea
                                id="content"
                                class="multi-row ng-untouched ng-pristine ng-invalid" formcontrolname="Description"
                                placeholder="Nhập nội dung. Tối thiểu 50 ký tự. Tối đa 3000 ký tự"></textarea><!---->
                            <div class="txt-right"> 0/3000</div><!----><!----><!----></div><!---->

                    </div>
                </form>

                <BR>
                <%--                <a href="#" style="    float: right;--%>
                <%--    font-weight: 600;--%>
                <%--    color: #ea0000;">Chỉnh sửa sản phẩm nâng cao</a>--%>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="updateBasic()">Lưu lại</button>
                <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                <BR>
            </div>
        </div>
    </div>
</div>
<!--
  MODAL
-->

<div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
          <span class="thong-tin-thanh-toan">
            <h5>Chỉnh sửa thông tin sản phẩm</h5>
          </span>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label class="control-label" name="idpost">Mã sản phẩm </label>
                        <input class="form-control" disabled type="number" id="car_id">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên sản phẩm</label>
                        <input class="form-control" name="title" type="text"/>
                    </div>
                    <div class="form-group  col-md-6">
                        <label class="control-label">Số lượng</label>
                        <input class="form-control" name="quantity" type="number" required>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="control-label">Giá bán</label>
                        <input class="form-control" name="price" type="number" required>
                    </div>
                </div>
                <BR>
                <a href="#" style="    float: right;
    font-weight: 600;
    color: #ea0000;">Chỉnh sửa sản phẩm nâng cao</a>
                <BR>
                <BR>
                <button class="btn btn-save" type="button" onclick="updateBasic()">Lưu lại</button>
                <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                <BR>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!--
MODAL
-->

<!-- Essential javascripts for application to work-->
<script src="jsadmin/jquery-3.2.1.min.js"></script>
<script src="jsadmin/popper.min.js"></script>
<script src="jsadmin/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<%--    <script src="src/jquery.table2excel.js"></script>--%>
<script src="jsadmin/main.js"></script>
<!-- The javascript plugin to display page loading on top-->
<script src="jsadmin/plugins/pace.min.js"></script>
<!-- Page specific javascripts-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
<!-- Data table plugin-->
<script type="text/javascript" src="jsadmin/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="jsadmin/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">


    $('#sampleTable').DataTable();

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
</script>
<script>
    var dataMain

    function deleteRow(r, idPost) {
        var i = r.parentNode.parentNode.rowIndex;
        console.log(123)
        console.log(i)
        swal({
            title: "Cảnh báo",
            text: "Bạn có chắc chắn là muốn xóa sản phẩm này?",
            buttons: ["Hủy bỏ", "Đồng ý"],
        })
            .then((willDelete) => {
                if (willDelete) {
                    $.ajax({
                        url: "/product?action=delete&&id=" + idPost,
                        type: "POST",
                        contentType: 'application/x-www-form-urlencoded',
                        success: function (data) {
                            console.log(data)
                            if (JSON.parse(data) === 1)
                                document.getElementById("myTable").deleteRow(i);

                        }
                    });
                    swal("Đã xóa thành công.!", {});
                }
            });
    }

    const getStatus = () => {
        let arr = []
        $(".status-group li").each(function () {
            $(this).each(function (index) {
                if ($(this)[0].querySelector("input").checked) {
                    arr.push($(this)[0].querySelector("input").getAttribute("value"))
                }
            })

        });
        return arr
    }

    const fillInfoP = (product) => {
        $("#yearOfManufacture").val(product[0].yearOfManuFacture)
        $("#height").val(product[0].height);
        $("#width").val(product[0].width);
        $("#weight").val(product[0].weight);
        $("#length").val(product[0].length);
        $("#Price").val(product[0].price)
        $("#quantity").val(product[0].quantity)
        $("#body").val(product[0].body)
        $("#tilte123").val(product[0].name)
        $("#content").val(product[0].content)
        $(".btn-save").attr("id", product[0].id)
    }
    const getYear = () => {
        let year;
        $(".list-year span").each(function () {
            $(this).each(function (index) {
                if ($(this)[0].querySelector("input").checked) {
                    year = $(this)[0].querySelector("label").textContent

                }
            })

        });
        return year;

    }
    const loading = document.getElementById("loading");
    document.querySelector(".btn-save").addEventListener("click", () => {
        console.log(123)
        let form = document.querySelector(".modal-content");
        const arr = getStatus()
        const formData = new FormData();
        formData.append("nameCompany", $('.form-select option:selected').text());
        formData.append("title", $("#tilte123").val());
        formData.append("content", $("#content").val());
        formData.append("yearofmanufacture", getYear() || new Date().getFullYear());
        formData.append("made", arr[0]);
        formData.append("gear", arr[1]);
        formData.append("status", arr[3]);
        formData.append("price", $("#Price").val());
        formData.append("body", $("#body").val());
        formData.append("quantity", $("#quantity").val());
        formData.append("height", $("#height").val());
        formData.append("length", $("#length").val());
        formData.append("width", $("#width").val());
        formData.append("weight", $("#weight").val());
        formData.append("id", $(".btn-save").attr("id"));
        formData.append("fuel", arr[2]);
        if (
            true
        ) {
            if ($("#tilte123").val() === "" || $("#content").val() === "" ||  $("#Price").val() === "" || $("#body").val() === "" || $("#quantity").val() === ""){
                alert("Vui lòng điền đủ các trường!")
            }else {
                loading.style.display = "block";
                console.log($("#quantity").val());
                $.ajax({
                    url: "/product",
                    type: "Put",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        swal({
                            title: "Thành công",
                            text: "Thay đổi thong tin sản phẩm thành công",
                        }).then(() => {
                            loading.style.display = "none";
                            form.style.display = "none";
                        });
                    }
                });
            }
        } else {
            swal({
                title: 'Lỗi ',
                text: 'Thông tin không chính xác',
                content: "form",
                buttons: {
                    cancel: "Cancel",
                }
            }).then((value) => {
                loading.style.display = "none";
            });
        }
    })

    function editRow(r, idPost) {
        console.log(dataMain)
        var i = r.parentNode.parentNode.rowIndex;
        const product = dataMain.filter((item) => {
            return item.id == idPost
        })
        fillInfoP(product)


    }


    pTable = $('#sampleTable').dataTable();
    $('#all').click(function (e) {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    const init = () => {
        $.ajax({
            url: "/product?action=getlistproduct",
            type: "GET",
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {
                // fake data chuyen thanh JSON.parse(data)
                dataMain = JSON.parse(data)
                console.log(dataMain)
                initTable(dataMain)
            }
        })
    };
    init()
    const toUSD = (money) => {
        return money.toLocaleString('en-US', {style: 'currency', currency: 'USD'});
    }

    const checkStatusCar = (carStatus) => {
        let status
        if (carStatus === 1) {
            status = "Còn hàng"
        } else {
            status = "Hết hàng"
        }
    }
    const initTable = (data) => {
        $('#myTable').DataTable({
            data: data,
            columns: [
                {data: "id"},
                {data: "name"},
                {
                    data: "images", "render": function (data, type, row, meta) {
                        return '<img src="' + data[0] + '" alt="" width="100px;">';
                    }
                },
                {data: "quantity"},
                {
                    data: "", "render": function (data, type, row, meta) {
                        let status;
                        let badge;
                        if (row.status === 1) {
                            status = "Còn hàng"
                            badge = "available"
                        } else {
                            status = "Hết hàng"
                            badge = "unavailable"
                        }
                        return '<td><span class="' + badge + '">' + status + '</span></td>';
                    }
                },
                // { data: "total_price", "render": function (data, type, row, meta) {
                //         return toUSD(data);
                //     }},
                {
                    data: "price", "render": function (data, type, row, meta) {
                        return toUSD(data);
                    }
                },
                {

                    data: "", "render": function (data, type, row, meta) {

                        return '<button class="btn btn-primary btn-sm trash" type="button" title="Xóa" ' +
                            'onclick="deleteRow(this, ' + row.id + ')" style="width: 32px; height: 30px">' +
                            '<i class="fas fa-trash-alt"></i>' +
                            '</button>' +
                            '<button onclick="editRow(this, ' + row.id + ')"  type="button" class="btn btn-primary" ' +
                            'data-toggle="modal" data-target="#exampleModalCenter" style="width: 32px; height: 30px">' +
                            '<i class="fas fa-edit" style="margin-left: -2.5px;"></i>' +
                            '</button>';
                    }
                }
            ],
        })

    }
</script>

<script>
    document.querySelector(".upload-item").addEventListener("click", (e) => {
        document.querySelector(".fileupload").click()
    })
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<script>
    var handleItemImg = (e) => {
        var item = e.target.value;
        console.log(item)
        var id = item.getAttribute("id")
        $("#contain" + id).remove();
    }

    var imgRequest = '';
    var listImg = ""
    var count = 0;
    $(".fileupload").bind("change", (e) => {
        var file = document.querySelector(".fileupload").files[0];
        var reader = new FileReader();
        reader.onloadend = function () {
            imgRequest = reader.result
            listImg += reader.result + "||"
            let html = `<div id="contain\${count}" class="imgContainer" style="position: relative">
                  <img id="img\${count}" class="uploadImg" src="\${imgRequest}" alt="Vui lòng chọn ảnh">
                  <i id="\${count}" onClick="()=>{console.log(123)}" style="width: 20px;height: 20px; position: absolute; top: 10px;right: 20px;cursor: pointer; color:red " class="fa-solid fa-trash"></i>
                  <i id="\${count}" onClick="(e)=>handleItemImg(e)" style="width: 20px;height: 20px;position: absolute ;top: 10px;right: 50px; cursor: pointer; color:red" class="fa-solid fa-pen"></i>
                </div>`
            console.log(html)
            $('#uploadimage').append(html)
            count++;
        }
        reader.readAsDataURL(file);
    })

    const getStatus = () => {
        let arr = []
        $(".status-group li").each(function () {
            $(this).each(function (index) {
                if ($(this)[0].querySelector("input").checked) {
                    arr.push($(this)[0].querySelector("input").getAttribute("value"))
                }
            })

        });
        return arr
    }




</script>
<script src="/javascrip/index.js"></script>
</body>

</html>