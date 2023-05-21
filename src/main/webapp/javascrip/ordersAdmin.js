var dataOrder = []
var provinceData =''
var listProduct = []
const initProvince =()=> {
    provinceData = JSON.parse(provinceData)
    let elmProvince = document.querySelector(".province")
    provinceData = JSON.parse(provinceData)
    console.log(provinceData)
    provinceData.original.data.map(tmp => {

        elmProvince.innerHTML += `<option value=${tmp.ProvinceID}>${tmp.ProvinceName}</option>`
    })
}

const province = ()=>{
    $.ajax({
        url: "/api/address?type=province",
        method: "GET",
        success: res =>{
            provinceData = res
            initProvince()
        },
        error: err=>{



        }
    })
}
province()
const elmProvince = document.querySelector(".province")
elmProvince.addEventListener("input",(e)=>{
    if(e.target.value != '0'){
        let idProvince = e.target.value
        console.log(idProvince)
        let district = document.querySelector(".district")
        district.classList.remove('events_none')
        let ward = document.querySelector(".ward")
        ward.innerHTML = `<option value="0">Xã</option>`

        ward.classList.add('events_none')

        initDistrict(idProvince)
    }else{
        console.log(e.target.value)
        let district = document.querySelector(".district")
        district.innerHTML = `<option value="0">Huyện</option>`
        district.classList.add('events_none')
        let ward = document.querySelector(".ward")
        ward.innerHTML = `<option value="0">Xã</option>`

        ward.classList.add('events_none')


    }
})
document.querySelector(".district").addEventListener("input",(e)=>{
    console.log(e)
    if(e.target.value != '0'){
        let idDistrict = e.target.value
        console.log(idDistrict)
        let ward = document.querySelector(".ward")
        ward.classList.remove('events_none')
        ward.setAttribute('value', '0')
        initWard(idDistrict)
    }else{
        let ward = document.querySelector(".ward")
        ward.innerHTML = `<option value="0">Xã</option>`
        ward.classList.add('events_none')

    }
})
const initDistrict = (idProvince) =>{
    $.ajax({
        url: "/api/address?type=district&idProvince="+idProvince,
        method: "GET",
        success: res =>{
            districtData= JSON.parse(JSON.parse(res))
            console.log(districtData)
            let district = document.querySelector(".district")
            let elms = `<option value="0">Huyện</option>`

            districtData.original.data.map(tmp=>{
                console.log(tmp)
                elms += `<option value=${tmp.DistrictID}>${tmp.DistrictName}</option>`
            })
            district.innerHTML =elms
        },
        error: err=>{



        }
    })
}
const initWard = (idDistrict)=>{
    $.ajax({
        url: "/api/address?type=ward&idDistrict="+idDistrict,
        method: "GET",
        success: res =>{
            dataWard= JSON.parse(JSON.parse(res))
            console.log(dataWard)
            let ward = document.querySelector(".ward")
            let elms = `<option value="0">Xã</option>`

            dataWard.original.data.map(tmp=>{
                console.log(tmp)
                elms += `<option value=${tmp.WardCode}>${tmp.WardName}</option>`
            })
            ward.innerHTML = elms
        },
        error: err=>{



        }
    })
}
const toUSD = (money)=>{
return money.toLocaleString('en-US', { style: 'currency', currency: 'USD' });

}
const init = ()=>{
    $.ajax({
        url: "/api/order",
        type: "GET",
        contentType: 'application/x-www-form-urlencoded',
        success: function (data) {
            console.log(JSON.parse(data))
            // fake data chuyen thanh JSON.parse(data)
            dataOrder = JSON.parse(data)

            $('#myTable').DataTable({
                data: dataOrder,
                columns: [
                    { data: "id" },
                    { data: "user.fullName" },
                    { data: "total_price", "render": function (data, type, row, meta) {
                            return toUSD(data);
                        }},
                    { data: "address"},

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
                            if(row.status == 1){
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
                            
                            <a className="action_order " onclick='viewUpdateOrder(${row.id})' style="color:#28a745;" type="button" data-toggle="modal"
                                    data-target="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i>
                            </a>
                            <a className="action_order" style="color:red;" type="button"
                                    onClick="deleteRow(this, ${row.id})" title="Xóa"><i class="fa-solid fa-trash">
                                    <input hidden value="${row.id}"/> </i></a>                      
</div>
                             
                           `;
                            }else{
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
                            <a className="action_order" style="color:red;" type="button"
                                    onClick="deleteRow(this, ${row.id})" title="Xóa"><i class="fa-solid fa-trash">
                                    <input hidden value="${row.id}"/> </i></a>                      
</div>
                             
                           `;
                            }

                        }}
                ],
                buttons: [
                     'excel', 'pdf'
                ]
            });
        }
    });

}
const initListProduct = ()=>{
    $.ajax({
        url: "/product?action=getlistproduct",
        method: "GET",
        success: res =>{
            listProduct = JSON.parse(res)
        },
        error: err=>{

        }
    })
}
init()
initListProduct()
const viewDetail= (id)=>{
    let order = dataOrder.find(tmp=>{
        return tmp.id === id;
    })
    console.log(order)
    document.querySelector("#orderDetailsModal span.show_detail_orders_name").innerHTML = order.user.fullName
    document.querySelector("#orderDetailsModal span.show_detail_orders_address").innerHTML = order.address
    document.querySelector("#orderDetailsModal span.show_detail_orders_phone").innerHTML = order.user.phone
    document.querySelector("#orderDetailsModal span.show_detail_orders_email").innerHTML = order.user.email

    document.querySelector("#orderDetailsModal span.show_detail_orders_total").innerHTML = toUSD(order.total_price)
    const dateTransport = new Date(order.leadTime);
    const dateNow = new Date();
    let status;
    let badge;
    if(order.status == 0){
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

    document.querySelector("#orderDetailsModal span.show_detail_orders_status").innerHTML = `<span class="${badge}">${status}</span>`
    let table_detail = document.querySelector("#table_orders_detail")
    let tr = ``
    order.orderDetails.map(tmp=>{
        tr+=`<tr>
                            <td>${tmp.product.name}</td>
                            <td><img width="150px" height="100px" src="${tmp.product.images[0]}"/></td>
                            <td>${toUSD(tmp.price)}</td>
                            <td>${tmp.quantity}</td>
                            <td>${toUSD(tmp.price * tmp.quantity)}</td>
                        </tr>`
    })
    table_detail.innerHTML = tr;
    document.querySelector("#orderDetailsModal").style.display = "flex";
    document.querySelector("#orderDetailsModal").classList.remove("fade")
}
var closeBtn = document.querySelector('.close');
closeBtn.addEventListener('click', function() {
    modal.style.display = 'none';
});
document.querySelector("#outside_modal").addEventListener("click",(e)=>{
    document.querySelector("#orderDetailsModal").style.display = "none";
    document.querySelector("#orderDetailsModal").classList.add("fade")
})

document.querySelector(".btn-secondary").addEventListener("click",(e)=>{
    document.querySelector("#orderDetailsModal").style.display = "none";
    document.querySelector("#orderDetailsModal").classList.add("fade")
})

const viewUpdateOrder = (id)=>{
    let order = dataOrder.find(tmp=>{
        return tmp.id === id;
    })
    console.log(order)
    $('#id_order_update').val(id)
    document.querySelector("span.show_detail_orders_name").innerHTML = order.user.fullName + `<input id="idOrderEdit" hidden value="${id}"/>`
    document.querySelector("span.show_detail_orders_address").innerHTML = order.address + `  <i onclick="editAddress()" style="margin-left: 10px;  color: red; cursor: pointer" class="fa-solid fa-pen-to-square"></i>`
    document.querySelector("span.show_detail_orders_phone").innerHTML = order.user.phone
    document.querySelector("span.show_detail_orders_email").innerHTML = order.user.email
    const dateTransport = new Date(order.leadTime);
    const dateNow = new Date();
    let status;
    let badge;


    let table_detail = document.querySelector(".table_orders_detail_edit")
    let tr = ``
    order.orderDetails.map(tmp=>{
        tr+=`<tr>
                            <td style="width: 190px; text-overflow: ellipsis">${tmp.product.name}</td>
                            <td><img width="150px" height="100px" src="${tmp.product.images[0]}"/></td>
                            <td>${toUSD(tmp.price)}</td>
                            <td style="    text-align: center;">
                            <input class="quantity_${tmp.idProduct}" style="width: 50px" oninput="changeQuantity(this)" value="${tmp.quantity}"/> <br/>
                            <input hidden="" class="id_product" value="${tmp.idProduct}"/>
                            <input hidden="" class="price" value="${tmp.price}"/>
                            <input hidden="" class="action" value="default"/>
                            
                            <p class="show_error" style="text-align: center;
    margin: auto;
    font-size: 12px;
    margin-top: 5px;
    color: red;"></p></td>
                            <td class="total_${tmp.idProduct}">${toUSD(tmp.price * tmp.quantity)}</td>
                           <td style="text-align: center"><i onclick="del_order_details(this)" style="color: red" class="fa-solid fa-trash"> </i></td>

                        </tr>`
    })

    table_detail.innerHTML = tr;
    console.log(listProduct)
    let list_product = document.querySelector(".add_prodcut")
    let options = `<option value="-1">Danh sách sản phẩm</option>`
    listProduct.map((tmp=>{
        options +=`<option value="${tmp.id}">${tmp.id +  " - " + tmp.name +  " - " + tmp.price }</option>`
    }))
    list_product.innerHTML = options
    document.querySelector("#editOrderDetailsModal").style.display = "flex";
    document.querySelector("#editOrderDetailsModal").classList.remove("fade")

}

const editAddress = (e)=>{
    console.log(e)
    document.querySelector(".showAddress").classList.add('hide')
    document.querySelector(".form_edit_address").classList.remove('hide')

}

document.querySelector(".save_address").addEventListener("click",(e)=>{
    if($( ".ward option:selected" ).text() !== "Xã" && $( ".district option:selected" ).text() !== "Huyện" && $( ".province option:selected" ).text() !== "Tỉnh" ){
        let address =  $( ".ward option:selected" ).text() + " - " + $( ".district option:selected" ).text() + " - " + $( ".province option:selected" ).text();
        document.querySelector("span.show_detail_orders_address").innerHTML = address + `  <i onclick="editAddress()" style="margin-left: 10px;  color: red; cursor: pointer" class="fa-solid fa-pen-to-square"></i>`
        document.querySelector(".showAddress").classList.remove('hide')
        document.querySelector(".form_edit_address").classList.add('hide')
    }else{
        document.querySelector(".ward").style.border = '1px solid red'
        document.querySelector(".district").style.border = '1px solid red'
        document.querySelector(".province").style.border = '1px solid red'
    }


})
document.querySelector(".close_address").addEventListener("click",(e)=>{
    document.querySelector(".showAddress").classList.remove('hide')
    document.querySelector(".form_edit_address").classList.add('hide')
})
document.querySelector(".exitModal").addEventListener("click",(e)=>{
    document.querySelector("#editOrderDetailsModal").style.display = "none";
    document.querySelector("#editOrderDetailsModal").classList.add("fade")
})

const changeQuantity = (elm)=>{
    if(Number.isInteger(Number(elm.value)) && Number(elm.value) > 0){
        let show_error = elm.parentNode.querySelector(".show_error")
        let id_product = elm.parentNode.querySelector(".id_product").value
        $.ajax({
            url: "/api/order?action=check_add_orders_details&id_product="+id_product,
            method: "POST"
            ,
            success: res =>{
                if(res - Number(elm.value) < 0){
                    show_error.textContent = "Vượt quá số lượng trong kho"
                }else{
                    show_error.textContent = ""
                    elm.setAttribute('value', Number(elm.value))
                    let price = elm.parentNode.querySelector(".price").value
                    document.querySelector(`.total_${id_product}`).textContent = toUSD(Number(elm.value) * Number(price) )
                    setActionChangeOrderDetails(elm, "update")
                }
            },
            error: err=>{



            }
        })
    }
}
const setActionChangeOrderDetails = (elm, action)=>{
    if(elm.parentNode.querySelector(".action").value !== "add"){
        elm.parentNode.querySelector(".action").setAttribute("value", action)

    }
    if(action === "delete"){
        elm.parentNode.querySelector(".action").setAttribute("value", action)

    }
}
const select_add_product = ()=>{
    let id_product = $( ".add_prodcut option:selected" ).val()
    if(id_product != -1){
        document.querySelector(".bt_add_product").style.opacity = 1
        document.querySelector(".bt_add_product").style.pointerEvents = 'auto'

    }

}

const add_product_order = ()=>{
    let id_product = $( ".add_prodcut option:selected" ).val()
    let product = listProduct.filter(tmp=>{
        return tmp.id == id_product
    })
    console.log(product)
    product = product[0]
    let elm;
    document.querySelectorAll(".table_orders_detail_edit tr").forEach(tmp=>{
        if(tmp.querySelector(".id_product").value == product.id){
            elm = tmp.querySelector(".id_product");
        }
    })
    if(elm){
        console.log()
        if(elm.parentNode.querySelector(".action").value === 'delete'){
            elm.parentNode.parentNode.style.display = ''
            elm.parentNode.querySelectorAll("input")[0].value =  1
            elm.parentNode.querySelectorAll("input")[0].setAttribute('value',1)
            setActionChangeOrderDetails(elm, "update")

        }else{
            elm.parentNode.querySelectorAll("input")[0].value =  Number(elm.parentNode.querySelectorAll("input")[0].value )+ 1
            elm.parentNode.querySelectorAll("input")[0].setAttribute('value',Number(elm.parentNode.querySelectorAll("input")[0].value )+ 1)
            setActionChangeOrderDetails(elm, "update")

        }

        changeQuantity(elm.parentNode.querySelectorAll("input")[0])
    }else{
        document.querySelector(".table_orders_detail_edit").innerHTML+=`<tr>
                            <td style="width: 190px; text-overflow: ellipsis">${product.name}</td>
                            <td><img width="150px" height="100px" src="${product.images[0]}"/></td>
                            <td>${toUSD(product.price)}</td>
                            <td style="    text-align: center;">
                            <input style="width: 50px" oninput="changeQuantity(this)" value="${1}"/> <br/>
                            <input hidden="" class="id_product" value="${product.id}"/>
                            <input hidden="" class="price" value="${product.price}"/>
                            <input hidden="" class="action" value="add"/>
                            
                            <p class="show_error" style="text-align: center;
                            margin: auto;
                            font-size: 12px;
                            margin-top: 5px;
                            color: red;"></p></td>
                            <td class="total_${product.id}">${toUSD(product.price )}</td>
                           <td style="text-align: center"><i onclick="del_order_details(this)" style="color: red" class="fa-solid fa-trash"> </i></td>

                        </tr>`
    }

}

const del_order_details=(elm)=>{
    swal({
        title: "Cảnh báo",
        text: "Bạn có chắc chắn là muốn xóa sản phẩm này?",
        buttons: ["Hủy bỏ", "Đồng ý"],
    }).then((willDelete) => {
        if (willDelete) {

            elm.parentNode.parentNode.style.display = 'none'
            setActionChangeOrderDetails(elm.parentNode, 'delete')

        }
    });
}

const saveUpdate = ()=>{
    let idOrder = $('#id_order_update').val()
    let address = $('.show_detail_orders_address').text()


    // console.log(document.querySelector(".form_edit_address").classList, )
    let arrTr = document.querySelectorAll(".table_orders_detail_edit .action")
    let data ='';
    arrTr.forEach(tmp=>{
        if(tmp.value !== "default")
        data+=tmp.parentNode.querySelector(".id_product").value + "-" + tmp.parentNode.querySelectorAll("input")[0].value +"-" +  tmp.value + "|"
    })


    console.log(data, address )
    if(address !== ""|| data !== '' ){
        $.ajax({
            statusCode: {
                401: function() {
                    swal("Bạn không có quyền thực hiện chức năng này.!", {});

                }
            },
            url: "/api/order?action=update",
            method: "POST",
            data:{
              data,
                idOrder,
                address
            },
            success: res =>{
                let order = JSON.parse(res)
                let index = -1;
                for (let i = 0; i < dataOrder.length; i++) {
                    if (dataOrder[i].id === order.id) {
                        dataOrder[i] = order;
                        console.log( dataOrder[i])
                        document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[2].textContent = toUSD(order.total_price)
                        document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[3].textContent = toUSD(order.address)
                        document.querySelector("#editOrderDetailsModal").style.display = "none";
                        document.querySelector("#editOrderDetailsModal").classList.add("fade")
                        break;
                    }
                }


            },
            error: err=>{

            }
        })
    }
}
document.querySelector(".cancelOrder").addEventListener('click',(e)=>{
    let idOrder = $('#id_order_update').val()
    swal({
        title: "Cảnh báo",
        text: "Bạn có chắc chắn là muốn hủy đơn hàng này?",
        buttons: ["Hủy bỏ", "Đồng ý"],
    }).then((willDelete) => {
        if (willDelete) {
            $.ajax({
                statusCode: {
                    401: function() {
                        swal("Bạn không có quyền thực hiện chức năng này.!", {});

                    }
                },
                url: "/api/order?action=update",
                method: "POST",
                data:{
                    idOrder,
                    status: 0
                },
                success: res =>{
                    let order = JSON.parse(res)
                    let index = -1;
                    for (let i = 0; i < dataOrder.length; i++) {
                        if (dataOrder[i].id === order.id) {
                            dataOrder[i] = order;
                            document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[2].textContent = toUSD(order.total_price)
                            document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[3].textContent = toUSD(order.address)
                            const dateTransport = new Date(order.leadTime);
                            const dateNow = new Date();
                            let status;
                            let badge;
                            if(order.status == 0){
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
                            document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[5].innerHTML = `  <div    style="
    display: flex;
    justify-content: center;
    gap: 10px;
">
                            <a className="action_order"
                                    style="color:blue;" type="button"
                                    onclick="viewDetail(${order.id})"
                                    data-toggle="modal" data-target="#orderDetailsModal" title="Xem chi tiết"><i class="fa-solid fa-circle-info"></i>
                            </a>
                            <input hidden="" class="oder${order.id}"/>
                            <a className="action_order" style="color:red;" type="button"
                                    onClick="deleteRow(this, ${order.id})" title="Xóa"><i class="fa-solid fa-trash">
                                    <input hidden value="${order.id}"/> </i></a>                      
</div>
                             
                           `

                            document.querySelector(`.oder${idOrder}`).parentNode.parentNode.parentNode.querySelectorAll("td")[4].innerHTML = `<span class="${badge}">${status}</span>`
                            document.querySelector("#editOrderDetailsModal").style.display = "none";
                            document.querySelector("#editOrderDetailsModal").classList.add("fade")

                            break;
                        }
                    }


                },
                error: err=>{

                }
            })


        }
    });

})