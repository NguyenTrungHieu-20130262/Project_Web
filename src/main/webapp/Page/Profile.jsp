<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: 84348
  Date: 1/4/2023
  Time: 3:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en"><head>
  <meta charset="utf-8">

  <title>Profile</title>
  <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
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
</head>
<body style="">
<jsp:include page="../Component/header/Header.jsp"/>

<div class="container">
  <br>
  <% User user = (User) request.getAttribute("userInfo") ;%>
  <div class="row flex-lg-nowrap">

    <div class="col">
      <div class="row">
        <div class="col mb-3">
          <div class="card">
            <div class="card-body">
              <div class="e-profile">
                <div class="row">
                  <div class="col-12 col-sm-auto mb-3">
                    <div class="mx-auto" style="width: 140px;">
                      <div class="d-flex justify-content-center align-items-center rounded" style="height: 140px; background-color: rgb(233, 236, 239);">
                        <span style="color: rgb(166, 168, 170); border: 1px solid black; font: bold 8pt Arial;"><img src="<%=user.getAvatar()%>" id="" alt="" width="140px" height="140px" srcset=""></span>
                      </div>
                    </div>
                  </div>
                  <div class="col d-flex flex-column flex-sm-row justify-content-center mb-3">
                    <div class="text-center text-sm-left mb-2 mb-sm-0">
                      <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap"><%=user.getFullName()%></h4>
                      <p class="mb-0">@<%=user.getUserName()%></p>
                      <div class="mt-2">

                        <button class="btn btn-primary" type="button" style="width: 100%; position: relative;">
                          <i class="fa fa-fw fa-camera"></i>
                          <div >
                            <form action="profile?action=changeAvatar" method="POST" enctype="multipart/form-data">
                              <input type="file" id="uploadFile" name="file" oninput="handleAvatar(this)" style="position: absolute; top: 0; bottom: 0; left: 0; right: 0; opacity: 0;">

                              <span>Change Photo</span>
                              <div id="applyChange" class="hide" style="position: fixed; top: 0; left: 0;right: 0; bottom: 0; z-index: 9999; background-color: rgba(142,142,142,0.46); display: flex; justify-content: center; align-items: center">
                                <div style="width: 400px; height: 300px; box-shadow: #8B8B8B 5px 5px 5px; border-radius: 10px; background-color: white; padding: 10px">
                                  <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;"><img src="" id="imgAvatar" alt="" width="200px" height="200px" srcset="">
                                  </span>
                                  <br>
                                  <br>
                                  <br>
                                  <div style="display: flex; justify-content: center; gap: 20px; margin-top: 10px">
                                    <input type="button" onclick="cannel()" class="btn btn-primary" value="Cannel">
                                    <input type="submit" class="btn btn-primary" value="Apply">
                                  </div>
                                </div>
                              </div>
                            </form>

                          </div>
                        </button>
                      </div>
                    </div>
                    <div class="text-center text-sm-right">
                      <span class="badge badge-secondary"></span>
                      <div class="text-muted"><small></small></div>
                    </div>
                  </div>
                </div>
                <ul class="nav nav-tabs">
                  <li class="nav-item"><a href="#oder" class="active nav-link" data-toggle="tab">Order</a></li>
                  <li class="nav-item"><a href="#edit" class=" nav-link" data-toggle="tab">Settings</a></li>


                </ul>
                <div class="tab-content pt-3">
                  <div  class="tab-pane " id="edit">
                    <form class="form" novalidate="" style="width: 100%" id="editProfile">
                      <div class="row">
                        <div class="col">
                          <div class="row">
                            <div class="col">
                              <div class="form-group">
                                <label>Full Name</label>
                                <input class="form-control" type="text" name="fullName" placeholder="John Smith" value="<%=user.getFullName()%>">
                              </div>
                            </div>
                            <div class="col">
                              <div class="form-group">
                                <label>Username</label>
                                <input class="form-control" type="text" name="username" disabled placeholder="johnny.s" value="<%=user.getUserName()%>">
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col">
                              <div class="form-group">
                                <label>Email</label>
                                <input class="form-control" type="text" name="email" placeholder="abc@gmail.com" value="<%=user.getEmail()%>">
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col">
                              <div class="form-group">
                                <label>Phone</label>
                                <input class="form-control" type="text" name="phone" value="<%=user.getPhone()%>">
                              </div>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col">
                              <div class="form-group">
                                <label>Address</label>
                                <input class="form-control" type="text" name="address" placeholder="Phù Cát - Bình Định" value="<%=user.getAddress()%>">
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row " id="changlePass">


                      </div>
                      <div class="row">

                        <div class="col">
                          <div class="form-group">
                            <button class="btn btn-primary changlePass" type="button" onclick="openFormChanglePass(this)">Thay đổi mật khẩu</button>
                          </div>
                        </div>

                      </div>
                      <hr>
                      <div class="row">
                        <div class="col d-flex justify-content-end">
                          <button class="btn btn-primary" onclick="formEdit()" type="button">Save Changes</button>
                        </div>
                      </div>
                    </form>

                  </div>
                  <div class="tab-pane active" id="oder">
                    <div class="tile">
                      <h3 class="tile-title">Đơn hàng của bạn</h3>
                      <div>
                        <table class="table table-bordered" id="table_orders">
                          <thead>
                          <tr>
                            <th>Mã vận chuyển</th>
                            <th>Số lượng sản phản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>

                          </tr>
                          </thead>
                          <tbody id="table-oder">




                          </tbody>
                        </table>
                      </div>

                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-12 col-md-3 mb-3">
          <div class="card mb-3">
            <div class="card-body">
              <div class="px-xl-3">
                <button class="btn btn-block btn-secondary" onclick="logout()">
                  <i class="fa fa-sign-out"></i>
                  <span>Logout</span>
                </button>
              </div>
            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
</div>
<div class="modal fade" id="editOrderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="editOrderDetailsModal" aria-hidden="true">
  <div class="outside_modal" style="position: fixed; top: 0; left: 0;right: 0; bottom: 0; z-index: 998">

  </div>
  <div class="modal-dialog modal-dialog-centered modal-xl" style="z-index: 999; max-width: 750px" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ssss">Order Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div>
          <p><strong>Tên khách hàng: </strong><span type="text" class="show_detail_orders_name"></span></p>
          <p class="showAddress"><strong>Địa chỉ: </strong><span type="text" class="show_detail_orders_address"></span></p>

          <div class="form_edit_address hide">
            <label class="form-label" for="ss"><strong>Địa chỉ: </strong></label>
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
          <p><strong>Thời gian dự kiến: </strong><span type="text" class="show_detail_orders_leadtime"></span></p>


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

        <button type="button" class="btn btn-secondary saveEdit" onclick="saveUpdate()" data-dismiss="modal">Lưu</button>
        <button type="button" class="btn btn-secondary exitModal" data-dismiss="modal">Thoát</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailsModalLabel" aria-hidden="true">
  <div id="outside_modal" style="position: fixed; top: 0; left: 0;right: 0; bottom: 0; z-index: 998">

  </div>
  <div class="modal-dialog modal-dialog-centered modal-xl" style="z-index: 999; max-width: 750px" role="document">
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
          <p><strong>Mã vận chuyển: </strong><span class="show_detail_orders_idTransport"></span></p>
          <p><strong>Thời gian dự kiến: </strong><span type="text" class="show_detail_orders_leadtime"></span></p>
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
        <input hidden="" value="" id="id_order_update"/>
        <button style="background-color: #bb1818" type="button" class="btn btn-secondary cancelOrder"  data-dismiss="modal">Hủy đơn hàng</button>

        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
<script src="../javascrip/profileEdit.js"></script>
<script src="./javascrip/ordersUser.js"></script>

<script >
  var changePass = false
  var statusLogin;
  var pass;
  const openFormChanglePass = async (ele)=>{
    changePass = !changePass
    await $.ajax({
      url: "/check/UserIsExist",
      type: 'Get',
      success: function(res) {
        statusLogin=res.statusLogin
        pass=res.pass
      }
    });
    console.log(statusLogin)
    console.log(pass)
    let rs=``;
    if(statusLogin==1&&pass==null){
      rs+=`<div class="col">
        <div class="mb-2"><b>Change Password</b></div>
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label>New Password</label>
              <input class="form-control" type="password" name="passnew" placeholder="••••••">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label>Confirm <span class="d-none d-xl-inline">Password</span></label>
              <input class="form-control" name="repassnew" type="password" placeholder="••••••"></div>
          </div>
        </div>
      </div>`
    }else {
      rs+=`<div class="col">
    <div class="mb-2"><b>Change Password</b></div>
    <div class="row">
      <div class="col">
        <div class="form-group">
          <label>Current Password</label>
          <input class="form-control" type="password" name="oldpass" placeholder="••••••" value="">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <div class="form-group">
          <label>New Password</label>
          <input class="form-control" type="password" name="passnew" placeholder="••••••">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <div class="form-group">
          <label>Confirm <span class="d-none d-xl-inline">Password</span></label>
          <input class="form-control" name="repassnew" type="password" placeholder="••••••"></div>
      </div>
    </div>
  </div>`
    }
    if(changePass){
      document.querySelector("#changlePass").innerHTML = rs
      ele.textContent = "Hủy"
    }else{
      document.querySelector("#changlePass").innerHTML = ``
      ele.textContent = "Thay đổi mật khẩu"

    }

  }
  const formEdit = ()=>{
    let checkNull= true;
    const form = document.getElementById("editProfile")
    const formData = new FormData(form);
    const formDataObject = Object.fromEntries(formData.entries());
    let notify = ''
    let changlePass = false;
    for (const property in formDataObject) {
      if(property == 'phone' && document.querySelector(`input[name ='${property}']`).value.length > 11){
        notify += 'Số điện thoại không hợp lệ.!'
        document.querySelector(`input[name ='${property}']`).style.border = 'solid 1px red'

        checkNull = false

      }
      if(formDataObject[property] === ""){

        document.querySelector(`input[name ='${property}']`).style.border = 'solid 1px red'
        if(!notify.includes("Thông tin không được để trống"))
        notify += `\nThông tin không được để trống.!`

        checkNull = false
      }
    }
    if(changePass){
      changlePass = true
      if(formDataObject.passnew != formDataObject.repassnew ){
        document.querySelector(`input[name ='passnew']`).style.border = 'solid 1px red'
        document.querySelector(`input[name ='repassnew']`).style.border = 'solid 1px red'
        notify += '\nMật khẩu không trung nhau.!'

        checkNull = false
      }
      if( formDataObject.passnew.length<8){
        document.querySelector(`input[name ='passnew']`).style.border = 'solid 1px red'
        document.querySelector(`input[name ='repassnew']`).style.border = 'solid 1px red'
        notify += '\nMật khẩu phải có hơn 8 ký tự.!'
        checkNull = false
      }

    }
    if(checkNull){
      formDataObject.fullName = encodeURIComponent(formDataObject.fullName)
      formDataObject.address = encodeURIComponent(formDataObject.address)
      $.ajax({
        url: "/profile?action=changeProfile",
        type: 'POST',
        data: formDataObject,
        contentType: 'application/x-www-form-urlencoded',
        success: function(res) {
          if(res == -2){
            swal("Mật khẩu cũ không chính xác.!", {});
          return;
          }
          if(res == -1){
            swal("Có lỗi trong quá trình cập nhập.!", {});
            return;
          }
          let rs = JSON.parse(res)
          if(changlePass){
            document.querySelector(".changlePass").click()
          }
          swal({
            text: "Cập nhập thành công.!",
            timer: 400
          });

        }
      });
    }else{
      swal(notify , {});

    }
  }


  const handleAvatar =(e)=>{
    const file = e.files[0];
    let image = document.querySelector("#imgAvatar")
    if(file){
      const src = URL.createObjectURL(file);
      image.src = src;
      document.querySelector("#applyChange").classList.remove("hide")
    }
  }
  const cannel = ()=>{
    document.querySelector("#applyChange").classList.add("hide")

  }
  const logout = ()=>{
    $.ajax({
      type: "GET",
      url: "/session/del",
      success: function(data){
      }
    });
    window.location.pathname="/"
  }
  function del_cookie(name) {
    document.cookie = name +
            '=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
  }

  const getOrder = ()=>{
    let rs = ``
    $.ajax({
      url: "/user/order",
      type: 'GET',

      contentType: 'application/x-www-form-urlencoded',
      success: function(res) {
        let arrOrder  = JSON.parse(res).reverse()
        console.log(arrOrder)
        dataOrder = arrOrder
        initTable(arrOrder)
      }
    });


  }

    const initTable = (dataOrders)=>{
    $('#table_orders').DataTable({
      data: dataOrders,
      columns: [
        { data: "idTransport" , defaultContent: "N/A"},
        { data: "orderDetails", "render": function (data, type, row, meta) {
            return data.length;
          } },
        { data: "total_price", "render": function (data, type, row, meta) {
            return toUSD(data);
          }},

        { data:"leadTime",
          "render": function (data, type, row, meta) {

            const dateTransport = new Date(data);
            const dateNow = new Date();
            let status;
            let badge;
            if(row.status == 0){
              status = "Đã hủy";
              badge = "badge badge-danger";
            }else{
              if (dateTransport < dateNow) {
                status = "Đã giao";
                badge = "badge bg-success";
              } else{
                status = "Đang xử lý";
                badge = "badge bg-info";
              }
            }

            return `<td><span class="${badge}">${status}</span></td>`;
          }},
        {data:"","render": function (data, type, row, meta) {
              return `
                            <div    style="
    display: flex;
    justify-content: center;
    gap: 10px;
">
                            <a className="action_order"
                                    style="color:blue;" type="button"
                                    onclick="viewDetail(${row.id})"
                                    data-toggle="modal" data-target="#orderDetailsModal" title="Xem chi tiết"><i class="fa-solid fa-circle-info"></i>
                            </a>
                            <input hidden="" class="oder${row.id}"/>

</div>

                           `;

          }}
      ],
      buttons: [
        'excel', 'pdf'
      ]
    });
  }
  getOrder()
</script>

</html>