<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="Model.Oder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Phân quyền | Quản trị Admin</title>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
    <style>
        .multiselect-dropdown{
            display: inline-block;
            padding: 2px 5px 0px 5px;
            border-radius: 4px;
            border: solid 1px #ced4da;
            background-color: white;
            position: relative;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right .75rem center;
            background-size: 16px 12px;
        }
        .multiselect-dropdown span.optext, .multiselect-dropdown span.placeholder{
            margin-right:0.5em;
            margin-bottom:2px;
            padding:1px 0;
            border-radius: 4px;
            display:inline-block;
        }
        a{
            text-decoration: none;
        }
        .multiselect-dropdown span.optext{
            background-color:lightgray;
            padding:1px 0.75em;
        }
        .multiselect-dropdown span.optext .optdel {
            float: right;
            margin: 0 -6px 1px 5px;
            font-size: 0.7em;
            margin-top: 2px;
            cursor: pointer;
            color: #666;
        }
        .multiselect-dropdown span.optext .optdel:hover { color: #c66;}
        .multiselect-dropdown span.placeholder{
            color:#ced4da;
        }
        .multiselect-dropdown-list-wrapper{
            box-shadow: gray 0 3px 8px;
            z-index: 100;
            padding:2px;
            border-radius: 4px;
            border: solid 1px #ced4da;
            display: none;
            margin: -1px;
            position: absolute;
            top:0;
            left: 0;
            right: 0;
            background: white;
        }
        .multiselect-dropdown-list-wrapper .multiselect-dropdown-search{
            margin-bottom:5px;
        }
        .multiselect-dropdown-list{
            padding:2px;
            height: 15rem;
            overflow-y:auto;
            overflow-x: hidden;
        }
        .multiselect-dropdown-list::-webkit-scrollbar {
            width: 6px;
        }
        .multiselect-dropdown-list::-webkit-scrollbar-thumb {
            background-color: #bec4ca;
            border-radius:3px;
        }

        .multiselect-dropdown-list div{
            padding: 5px;
        }
        .multiselect-dropdown-list input{
            height: 1.15em;
            width: 1.15em;
            margin-right: 0.35em;
        }
        .multiselect-dropdown-list div.checked{
        }
        .multiselect-dropdown-list div:hover{
            background-color: #ced4da;
        }
        .multiselect-dropdown span.maxselected {width:100%;}
        .multiselect-dropdown-all-selector {border-bottom:solid 1px #999;}
    </style>
</head>
<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<header class="app-header">
<a class="app-sidebar__toggle" href="#" data-toggle="sidebar"  aria-label="Hide Sidebar"></a>
    <%@ include file="./header.jsp" %>
</header>
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<jsp:include page="SideBar.jsp">
    <jsp:param name="page" value="9"/>
</jsp:include>
<main class="app-content" style="position: relative">
    <%@include file="/Component/loading/Loading.jsp" %>

    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Phân quyền người dùng</b></a></li>
        </ul>
        <div id="clock"><span class="date"> </span></div>
    </div>
    <div style="display: flex; justify-content: center; gap: 20px">

        <div style="flex: 1; padding: 20px; border: 1px solid lightgray">
            <table class="table table-hover table-bordered" id="myTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên vai trò</th>
                    <th>Tác vụ</th>
                </tr>
                </thead>
                <tbody id="body_table_orders">
                </tbody>
                </tbody>
            </table>
        </div>
        <div style="flex: 1; padding: 20px; border: 1px solid lightgray">
            <h5>
                Thêm nhóm quyền
            </h5>
            <hr/>
            <form>
                <div class="form-group">
                    <label for="name_role">Tên nhóm quyền</label>
                    <input type="text" class="form-control" id="name_role" aria-describedby="emailHelp" placeholder="Tên nhóm quyền">
                </div>
                <div class="form-group">
                    <label>Quyền</label>
                    <br/>
                    <select name="field2" id="field2" style="width: 100%" multiple multiselect-search="true" multiselect-select-all="true" multiselect-max-items="3" onchange="console.log(this.selectedOptions)">
                    </select>
                </div>

                <button type="button"  class="btn btn-primary insert_role">Thêm</button>
            </form>
        </div>
    </div>
    <div>
        <table class="table table-hover table-bordered" id="tableUser">
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Họ và tên</th>
                <th>Ảnh thẻ</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody id="body_table_users">
            </tbody>
            </tbody>
        </table>
    </div>
</main>
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="width: 500px" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: black" id="exampleModalLongTitle">Chi tiết</h5>
                <button type="button" style="color: black" class="closeModal" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"  style="color: black">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="card-body">
                    <div class="row">
                        <div class="">
                            <div class="form-group">
                                <label for="role-id">ID:</label>
                                <input type="text" class="form-control" id="role-id" readonly>
                            </div>
                            <div class="form-group">
                                <label for="role-name">Tên vai trò:</label>
                                <input type="text" class="form-control" id="role-name" readonly>
                            </div>
                            <div class="form-group">
                                <label for="role-name">Các quyền:</label>
                                <ul id="permissions" style="height: 200px; overflow: auto">
                                </ul>

                            </div>
                        </div>

                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary closeModal"  data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle2" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="width: 500px" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: black" id="exampleModalLongTitle2">Chi tiết</h5>
                <button type="button" style="color: black" class="closeModal" data-dismiss="modal" onclick="closeModalEdit()"  aria-label="Close">
                    <span aria-hidden="true"  style="color: black">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="overflow: auto; height: 570px">
                <input hidden id="index_role_eidt"/>
                <div class="card-body">
                    <div class="row">
                        <div class="">
                            <div class="form-group">
                                <label for="role-id">ID:</label>
                                <input type="text" class="form-control" id="role-id-edit" readonly>
                            </div>
                            <div class="form-group">
                                <label for="role-name">Tên vai trò:</label>
                                <input type="text" class="form-control" id="role-name-edit" >
                            </div>
                            <div class="form-group">
                                <label for="role-name">Các quyền:</label>
                                <ul id="permissions_edit" style="height: 200px; overflow: auto; list-style-type: none; padding: 0 10px; display: grid; grid-template-columns:auto auto auto; gap:10px">
                                </ul>
                            </div>

                        </div>

                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary closeModalEdit" onclick="closeModalEdit()" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-success save_edit"  data-dismiss="modal">Save</button>

            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalCenterAddRole" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitleAddRole" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="width: 460px" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" style="color: black" id="exampleModalLongTitleAddRole">Cấp quyền</h5>
                <button type="button"  onclick="closeAddRoleUser()" class="close" style="color: black" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" style="color: black" >&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input hidden id="index_user_eidt">
                <label>Chọn vai trò</label>
                <select style="width: 100%" class="addRole"></select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeAddRoleUser()" data-dismiss="modal">Close</button>
                <input hidden id="id_user">
                <button type="button" class="btn btn-primary" onclick="saveRole()">Save changes</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    const loading = document.getElementById("loading");
    loading.style.display = 'block'
    loading.style.backgroundColor = " rgb(28 25 25 / 87%)"
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
<script src="javascrip/roleAdmin.js"></script>
<script>
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
</html>