var arrCart = []
document.querySelector("#loading").style.display = "block";

const USDollar = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});
const getPriceTransport = (data)=>{
}
const render =(data, feeTransport = 0)=>{
    let tableComfrimOrder = ``
    let tableBody = ``
    let bill = ``
    let total = 0
    let checkNowPay = true;
    if(data.length === 0) checkNowPay = false;
    console.log(data)
    data.map((tmp, index)=>{
        console.log(tmp)
        if(tmp.status === 1 || tmp.status === 2){
            checkNowPay = false;
        }

        total += tmp.product.price * tmp.quantity
        tableBody += ` <tr class="rem0" id="item-cart-${tmp.product.id}">
                            <td class="invert">${index + 1}</td>
                            <td class="invert-image"><a href="#" ><img src="${tmp.product.images[0]}" alt=" " class="img-responsive"></a></td>
                            <td class="invert">
                                <div class="quantity">
                                    <div class="quantity-select">
                                            <div class="${tmp.quantity <= 1 || tmp.status === 1? "entry value-minus events-none" : "entry value-minus"}" id="decrease"  onclick="decrease(${tmp.id})">&nbsp;</div>
                                       
                                        <div class="entry value "><span class="amount">${tmp.quantity}</span></div>
                                            <div class="${tmp.status === 1 || tmp.status === 4|| tmp.status === 2 ? "entry value-plus events-none" : "entry value-plus"}" onclick="increase(${tmp.id})">&nbsp;</div>

                                    </div>
                                </div>
                                <p style="margin-top: 10px; color: red;">${tmp.status === 1 || tmp.status === 2 ? tmp.messStatus:""}</p>
                            </td>
                            <td class="invert">${tmp.product.name}</td>

                            <td class="invert price">${USDollar.format(tmp.product.price * tmp.quantity)}</td>
                            <td class="invert">
                                <div class="rem0">
                                    <div class="closeItem closeItem0" onclick="removeCart(${tmp.id})"> <i class="fas fa-times"></i> </div>
                                </div>

                            </td>
                        </tr>`
        bill += `                            
           <li>${tmp.product.name} <i>-</i> <span>${USDollar.format(tmp.product.price * tmp.quantity)}</span></li>
            `
        tableComfrimOrder += `<tr>
                        <th scope="row">${index+1}</th>
                        <td>${tmp.product.name}</td>
                        <td>${tmp.quantity}</td>
                        <td>${USDollar.format(tmp.product.price * tmp.quantity)}</td>
                    </tr>`

    })

    bill += `<hr>
          <li>Tổng cộng <i>-</i> <span>${USDollar.format(total)}</span></li>`
    document.getElementById("table-item").innerHTML = tableBody
    document.querySelector(".body_table_confirm").innerHTML = tableComfrimOrder

    document.querySelector(".total_price").innerHTML = USDollar.format(total)


    document.getElementById("list-bill").innerHTML = bill
    if(checkNowPay){
        document.querySelector(".nowpay").style.opacity = 1;
        document.querySelector(".nowpay").style.pointerEvents = 'auto';

    }else{
        document.querySelector(".nowpay").style.opacity = 0.6;
        document.querySelector(".nowpay").style.pointerEvents = 'none';
    }


}
const getCart = ()=>{

    $.ajax({
        url: "/cart?action=listcart",
        type: 'GET',
        success: function(res) {
            arrCart = JSON.parse(res);
            document.querySelector("#loading").style.display = "none";
            render(arrCart)
        }
    });
}
getCart();


increase = (idCart) =>{
    $.ajax({
        url: "cart?action=increase&idCart="+idCart,
        type: 'POST',
        success: function(res) {
            console.log()

            if(typeof JSON.parse(res) === "object"){
                console.log()
                for( var i = 0; i < arrCart.length; i++){
                    if ( arrCart[i].product.id === JSON.parse(res).product.id ) {
                        arrCart[i] = JSON.parse(res)
                    }
                }
                render(arrCart)
            }else{
                window.location = window.location.origin + "/login"
            }



        }
    });

}
decrease = (idCart) =>{
    $.ajax({
        url: "cart?action=decrease&idCart="+idCart,
        type: 'POST',
        success: function(res) {
            console.log(res)
            if(typeof JSON.parse(res) === "object"){
            for( var i = 0; i < arrCart.length; i++){
                if ( arrCart[i].product.id === JSON.parse(res).product.id ) {
                    arrCart[i] = JSON.parse(res)
                }
            }
            render(arrCart)
        }else{
            window.location = window.location.origin + "/login"
        }
        }
    });

}

const removeCart = (idCart)=>{
    let new_arr =[]


    console.log(arrCart)

    $.ajax({
        url: "/cart?action=remove&idCart="+idCart,
        type: 'POST',
        success: function(res) {
            if(typeof JSON.parse(res) === "number"){
            if(JSON.parse(res) === 1){
                for( var i = 0; i < arrCart.length; i++){
                    if (arrCart[i].id === idCart) {
                        arrCart.splice(i, 1);
                        break
                    }

                }
                render(arrCart)

            }else{
                window.location = window.location.origin + "/login"

            }
            }
        }
    });
}

document.querySelector(".note_text").addEventListener("input",(e)=>{
    document.querySelector(".note").value =encodeURI(e.target.value)
})