    const toUSD = (money)=>{
    return money.toLocaleString('en-US', { style: 'currency', currency: 'USD' });

}
var dataOrder = []
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
    var dataMain =[]

    const initTopTotal = (data)=>{
    let totalPrice = 0
    let totalDelivered = 0
    let totalProcessing = 0
    let totalCancel = 0

    data.map(tmp=>{

    if(tmp.status === 0){
    totalCancel++
}else{
    totalPrice += tmp.total_price
    var mydate = new Date().getTime() - new Date(tmp.leadTime).getTime()
    if(mydate >= 0)totalDelivered++
    else totalProcessing++
}
})
    document.querySelector(".total_price").textContent = toUSD(totalPrice)
    document.querySelector(".total_dec").textContent = totalDelivered
    document.querySelector(".total_process").textContent = totalProcessing
    document.querySelector(".total_canel").textContent = totalCancel

}
    const initChart = (data) =>{
    let objDelivered = {}
    let objProcessing = {}
    let objCancel = {}

    data.map(tmp=>{

    if(tmp.status == 0){
    var mydate = new Date(tmp.createAt);
    if(objCancel[mydate.getMonth() + 1]){
    objCancel[mydate.getMonth() + 1] = objCancel[mydate.getMonth() + 1] + 1
}else{
    objCancel[mydate.getMonth() + 1] = 1
}
}else{
    mydate = new Date(tmp.leadTime)
    var time = new Date().getTime() - new Date(tmp.leadTime).getTime()
    if(time >= 0){
    if(objDelivered[mydate.getMonth() + 1]){
    objDelivered[mydate.getMonth() + 1] = objDelivered[mydate.getMonth() + 1] + 1
}else{
    objDelivered[mydate.getMonth() + 1] = 1
}
}else{
    if(objProcessing[mydate.getMonth() + 1]){
    objProcessing[mydate.getMonth() + 1] = objProcessing[mydate.getMonth() + 1] + 1
}else{
    objProcessing[mydate.getMonth() + 1] = 1
}
}
}


})


    const cvChartByMonth = document.querySelector('#chart_by_month')
    new Chart(cvChartByMonth,{
    type:'bar',
    data:{
    labels: ['January ','February ','March ','April ','May ','June ','July ','August ','September ','October ','November ', 'December '],
    datasets:[{
    label: 'Đơn hàng đang xử lý',
    data: [objProcessing[1],objProcessing[2],objProcessing[3],objProcessing[4],objProcessing[5], objProcessing[6],objProcessing[7],objProcessing[8],objProcessing[9],objProcessing[10],objProcessing[11],objProcessing[12]],
    borderWidth: 1
},
{
    label: 'Đơn hàng đã giao',
    data: [objDelivered[1],objDelivered[2],objDelivered[3],objDelivered[4],objDelivered[5], objDelivered[6],objDelivered[7],objDelivered[8],objDelivered[9],objDelivered[10],objDelivered[11],objDelivered[12]],
    borderWidth: 1
},

{
    label: 'Đơn hàng đã hủy',
    data: [objCancel[1],objCancel[2],objCancel[3],objCancel[4],objCancel[5], objCancel[6],objCancel[7],objCancel[8],objCancel[9],objCancel[10],objCancel[11],objCancel[12]],
    borderWidth: 1
}]
},
    options:{
    scales:{
    y:{
    beginAtZero:true
}
}
}
})
}
    function htmlTableToExcel(name){
    var data = document.getElementById('myTable');
    var excelFile = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
    XLSX.write(excelFile, { type: 'xlsx', bookSST: true, type: 'base64' });
    XLSX.writeFile(excelFile, name + '.xlsx' );
}
    const initTable = (data)=>{
    $('#myTable').DataTable({
        data: data,
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
                                    style="color:blue; cursor: pointer;" type="button"
                                    onclick="viewDetail(${row.id})"
                                    data-toggle="modal" data-target="#orderDetailsModal" title="Xem chi tiết"><i class="fa-solid fa-circle-info"></i>
                            </a>
                            <input hidden="" class="oder${row.id}"/>


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
    const initPieChart = (data)=>{
    let decPie ={}
    let arrLabels = []
    data.map(tmp=>{
    tmp.orderDetails.map(tmp2=>{

    if(decPie[tmp2.product.vendo.name]){
    decPie[tmp2.product.vendo.name] = decPie[tmp2.product.vendo.name] + 1
}else{
    decPie[tmp2.product.vendo.name] = 1
    arrLabels.push(tmp2.product.vendo.name)
}
})

})

    var array = Object.keys(decPie)
    .map(function(key) {
    return decPie[key];
});
    const dataPie = {
    labels: arrLabels,
    datasets: [{
    label: arrLabels,
    data: array,
    backgroundColor: ['#FF6633', '#FFB399', '#FF33FF', '#FFFF99', '#00B3E6',
    '#E6B333', '#3366E6', '#999966', '#99FF99', '#B34D4D',
    '#80B300', '#809900', '#E6B3B3', '#6680B3', '#66991A',
    '#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A', '#33FFCC',
    '#66994D', '#B366CC', '#4D8000', '#B33300', '#CC80CC',
    '#66664D', '#991AFF', '#E666FF', '#4DB3FF', '#1AB399',
    '#E666B3', '#33991A', '#CC9999', '#B3B31A', '#00E680',
    '#4D8066', '#809980', '#E6FF80', '#1AFF33', '#999933',
    '#FF3380', '#CCCC00', '#66E64D', '#4D80CC', '#9900B3',
    '#E64D66', '#4DB380', '#FF4D4D', '#99E6E6', '#6666FF']
}]
};
    const config = {
    type: 'doughnut',
    data: dataPie,
};
    var countries= document.getElementById("countries")

    new Chart(countries,config)
}
    const init = ()=>{
    $.ajax({
        url: "/api/order",
        type: "GET",
        contentType: 'application/x-www-form-urlencoded',
        success: function (data) {
            // fake data chuyen thanh JSON.parse(data)
            dataMain =  JSON.parse(data)
            dataOrder = dataMain
            initTopTotal(dataMain)
            initChart(dataMain)
            initPieChart(dataMain)
            initTable(dataMain)
            initStatisBottom(dataMain)
        }
    });

}
    var closeBtn = document.querySelector('.close_detail');
    closeBtn.addEventListener('click', function() {
    document.querySelector("#orderDetailsModal").style.display = "none";
    document.querySelector("#orderDetailsModal").classList.add("fade")
});
    document.querySelector("#outside_modal").addEventListener("click",(e)=>{
    document.querySelector("#orderDetailsModal").style.display = "none";
    document.querySelector("#orderDetailsModal").classList.add("fade")
})
    init()
    const initStatisBottom = (data)=>{
        const dateNow = new Date();

        $('.totalOrders').text(data.length)
        $('.totalOrdersCanel').text( data.filter(tmp=> tmp.status ===0).length)
        $('.totalOrdersProcessing').text( data.filter(tmp=> {
            tmp.status ===1
            const dateTransport = new Date(tmp.leadTime);
            return tmp.status === 1 && dateTransport >= dateNow

        }).length)
        $('.totalOrdersDelivery').text( data.filter(tmp=> {
            const dateTransport = new Date(tmp.leadTime);
            return tmp.status === 1 && dateTransport < dateNow
        }).length)
        $('.totalOrdersOnline').text( data.filter(tmp=>tmp.payment.type === 1).length)
        $('.totalOrdersReceived').text( data.filter(tmp=>tmp.payment.type === 0).length)
        $('.totalPriceReceived').text( toUSD(data.reduce((sum, tmp)=>{
            return sum + tmp.payment.amount
        },0)))
        let totalPriceTransport = data.reduce((sum, tmp)=>{
            return sum + tmp.payment.amount
        },0)

        data.map(tmp=>{
            tmp.orderDetails.map(tmp2=>{
                totalPriceTransport -= (tmp2.price * tmp2.quantity)
            })
        })
        $('.totalPriceTransport').text(toUSD(totalPriceTransport))


        $('.totalOrdersOnlineDelivery').text(
            data.filter(tmp=>{
                const dateTransport = new Date(tmp.leadTime);
                return tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 1
            }).length
        )
        $('.totalPriceReceivedOnlineDelivery').text(toUSD(
            data.reduce((sum, tmp)=>{
                const dateTransport = new Date(tmp.leadTime);
                if(tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 1)
                    return sum + tmp.payment.amount
                return sum
            },0))

        )
        totalPriceTransport = data.reduce((sum, tmp)=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 1)
                return sum + tmp.payment.amount
            return sum
        },0)
        data.map(tmp=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 1)
                tmp.orderDetails.map(tmp2=>{
                    totalPriceTransport -= (tmp2.price * tmp2.quantity)
                })
        })
        $('.totalPriceTransportOnlineDelivery').text(
            toUSD(totalPriceTransport)
        )



        $('.totalOrdersOnlineProcessing').text(
            data.filter(tmp=>{
                const dateTransport = new Date(tmp.leadTime);
                return tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1
            }).length
        )

        $('.totalPriceReceivedOnlineProcessing').text(toUSD(
            data.reduce((sum, tmp)=>{
                const dateTransport = new Date(tmp.leadTime);
                if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1)
                    return sum + tmp.payment.amount
                return sum
            },0))
        )
        totalPriceTransport = data.reduce((sum, tmp)=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1)
                return sum + tmp.payment.amount
            return sum
        },0)
        data.map(tmp=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1)
                tmp.orderDetails.map(tmp2=>{
                    totalPriceTransport -= (tmp2.price * tmp2.quantity)
                })
        })
        $('.totalPriceTransportOnlineProcessing').text(
            toUSD(totalPriceTransport)

        )


        $('.totalOrdersReceivedDelivery').text(
            data.filter(tmp=>{
                const dateTransport = new Date(tmp.leadTime);
                return tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 0
            }).length
        )

        $('.totalPriceReceivedDelivery').text(toUSD(
            data.reduce((sum, tmp)=>{
                const dateTransport = new Date(tmp.leadTime);
                if(tmp.status === 1 && dateTransport < dateNow && tmp.payment.type === 0)
                    return sum + tmp.payment.amount
                return sum
            },0))
        )
        totalPriceTransport = data.reduce((sum, tmp)=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1)
                return sum + tmp.payment.amount
            return sum
        },0)
        data.map(tmp=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 1)
                tmp.orderDetails.map(tmp2=>{
                    totalPriceTransport -= (tmp2.price * tmp2.quantity)
                })
        })
        $('.totalPriceTransportReceivedDelivery').text(
            toUSD(totalPriceTransport)

        )

        $('.totalOrdersReceivedProcessing').text(
            data.filter(tmp=>{
                const dateTransport = new Date(tmp.leadTime);
                return tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 0
            }).length
        )

        $('.totalPriceReceivedProcessing').text(
            toUSD(
            data.reduce((sum, tmp)=>{
                const dateTransport = new Date(tmp.leadTime);
                if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 0)
                    return sum + tmp.payment.amount
                return sum
            },0))
        )
        totalPriceTransport = data.reduce((sum, tmp)=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 0)
                return sum + tmp.payment.amount
            return sum
        },0)
        data.map(tmp=>{
            const dateTransport = new Date(tmp.leadTime);
            if(tmp.status === 1 && dateTransport >= dateNow && tmp.payment.type === 0)
                tmp.orderDetails.map(tmp2=>{
                    totalPriceTransport -= (tmp2.price * tmp2.quantity)
                })
        })
        $('.totalPriceTransportProcessing').text(
            toUSD(totalPriceTransport)
        )


    }
