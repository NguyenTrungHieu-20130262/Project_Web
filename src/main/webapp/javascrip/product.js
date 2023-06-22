var dataFilter = []
var dataCompany = []
var indexNumber = 1;
var quantityProductOnPage = 10
var dataAll = []
let filter
const loading = document.getElementById("loading");

const changeNumberPage = (n, e)=>{
    //indexNumber = n

    document.querySelectorAll(".pagination a").forEach(tmp=>{
        tmp.classList.remove('active')
    })
    e.classList.add("active")

    if(filter){
        getProdutWithPageAndFilter(n)

    }else{
        getProdutWithPage(n)
    }
}
const showData = (arr) =>{
    console.log(indexNumber)

}

const renderProduct= (arr)=>{
    let rs =``
    arr.forEach((tmp, index)=>{
        if(index <= indexNumber * quantityProductOnPage && index >= (indexNumber - 1) *  quantityProductOnPage){
            rs += `
        <div class="item-car vipprior dev-item-car" >
           <button class="button-item-car" onclick="addToCart(${tmp.id})">Thêm giỏ hàng</button>
  <div class="photo"><a href="details?id=${tmp.id}" class="rt pdt-per-74">
    
    <img class="lozad" src="${tmp.images[0]}" width="230" height="172" data-loaded="true"> </a> <span
          class="box-icon"> </span></div>
  <div class="info">
    <h3 class="title ">
      <a href="details?id=${tmp.id}">
    ${tmp.name}
      </a>
    </h3>
    <p class="price redprice">${tmp.price} USD<br>
<!--      <span class="old-price">140 triệu</span>-->
      <span class="b-promotion ">Tiền đô</span></p>
    <ul class="info-car">
      <li>${tmp.yearOfManuFacture}</li>
      
    </ul>
    <ul class="info-car">
      <li>Nhiên liệu: <b>${tmp.fuel == 1 ? "Xăng" : "Điện"  }</b></li>
      
    </ul>   
      
      
  </div>
</div>
        `
        }
    })
    if(rs === ``){
        document.querySelector("#box-list-car").innerHTML = `<img src="https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg?w=2000"/>`

    }else{
        document.querySelector("#box-list-car").innerHTML = rs

    }

}
const initPagination = ()=>{
    let numberPage = ` <a >&laquo;</a>`
    let number = Number(document.querySelector(".number_pagination").value)
    for (let i = 1; i <= number; i++) {
        i === indexNumber ? numberPage += `<a class="active" onclick="changeNumberPage(${i}, this)" >${i}</a>` : numberPage += `<a onclick="changeNumberPage(${i}, this)" >${i}</a>`

    }
    document.querySelector(".pagination").innerHTML =numberPage
}
initPagination()

document.querySelector(".box-search-head2").addEventListener("input", (e)=>{
    handleFilter()
})
const handleFilter = ()=>{
    let totalFilter = []
    indexNumber = 1
    let companySel =  document.querySelector("#company").value
    let year =  document.querySelector("#year").value
    let name =  document.querySelector(".box-search-head2").value
    console.log(name)
    dataFilter = dataAll
    totalFilter.push(companySel)
    totalFilter.push(year)
    totalFilter.push(name)
    if(companySel === "all"){
        dataFilter = dataAll
    }else{
        dataFilter = dataAll.filter((tmp)=>{
            return Number(companySel) === tmp.vendo.id
        })
    }
    if(name.length == 0){
        dataFilter = dataAll
    }else{
        dataFilter = dataFilter.filter((tmp)=>{
            return tmp.name.toLowerCase().includes(name.toLowerCase())
        })
    }
    let priceMin = document.querySelector(".text-min").textContent.replace(",","").replace(".","")
    let priceMax = document.querySelector(".text-max").textContent.replace(",","").replace(".","")
    dataFilter = dataFilter.filter((tmp)=>{
        return Number(priceMin)<= tmp.price && Number(priceMax)>= tmp.price
    })
    console.log(parseInt(year))

    if(year === "all"){
        dataFilter = dataFilter
    }else{
        dataFilter = dataFilter.filter((tmp)=>{
            return parseInt(year) === tmp.yearOfManuFacture

        })
    }

    let xang = document.querySelector('#xang')
    let dien = document.querySelector('#dau')
    if(xang.checked){

        console.log(xang.checked, xang.value)
        dataFilter = dataFilter.filter((tmp)=>{
            console.log(
                decodeURI(tmp.fuel)
            )
            return decodeURI(tmp.fuel) == xang.value
        })
    }
    if(dien.checked){

        xang.checked = false

        dataFilter = dataFilter.filter((tmp)=>{
            return decodeURIComponent(tmp.fuel) == dien.value
        })
    }
    console.log(year, companySel,Number(priceMin),priceMin, priceMax, Number(priceMax))

    showData(dataFilter)
}

document.querySelector('#xang').addEventListener("input", ()=>{
    {document.querySelector('#xang').checked ? document.querySelector('#dau').checked = false : ""}
})
document.querySelector('#dau').addEventListener("input", ()=>{
    {document.querySelector('#dau').checked ? document.querySelector('#xang').checked = false : ""}
})
const getCompany = ()=>{
    $.ajax({
        url: "/company",
        type: 'GET',
        success: function(res) {
            dataCompany = JSON.parse(res)
            console.log(dataCompany)
            let compantElm = document.querySelector("#company")
            let rs = `<option value="">Tất cả</option>`
            dataCompany.map((tmp)=>{
                rs += `<option value="${tmp.id}">${tmp.name}</option>`
            })
            compantElm.innerHTML = rs
            compantElm.addEventListener(("input"), handleFilter)

        }
    });
}
const init = ()=>{
    $.ajax({
        url: "/product?action=getlistproduct",
        type: 'GET',
        success: function(res) {
            dataFilter = JSON.parse(res)
            dataAll =JSON.parse(res)
            showData(JSON.parse(res))


        }
    });
}
const addToCart = (id)=>{
    $.ajax({
        url: "/cart?action=addtocart&idpost="+id,
        type: 'POST',
        success: function(res) {
            console.log(res)
            console.log(typeof  res)
            if(res =='1' || res =='0'){
                if(res !='1'){
                    swal("Sản phẩm đã hết", {
                        buttons: false,
                        timer: 500,
                    });
                }else{
                    console.log(res)
                    swal("Đã thêm sản phẩm vào giỏ hàng", {
                        buttons: false,
                        timer: 500,
                    });
                }
            }else{
                window.location = '/login'
            }





        }
    });
    console.log(id)


}

const getProdutWithPage = (page)=>{
    loading.style.display = 'block'
    $.ajax({
        url: `/product?action=products&page=${page}`,
        type: 'get',
        success: function(res) {
            renderProduct(JSON.parse(res))
            $('html, body').animate({
                scrollTop: 300
            }, 500);
            loading.style.display = 'none'

        }
    });
}
const getProdutWithPageAndFilter = (page)=>{
    loading.style.display = 'block'

    let urlReq = `/product?action=filter&page=${page}`
    for (const property in filter) {
        urlReq += `&${property}= ${filter[property]}`
    }
    console.log(filter)
    $.ajax({
        url: urlReq,
        type: 'get',
        success: function(res) {
            let data = JSON.parse(res)
            renderProduct(data)
            $('html, body').animate({
                scrollTop: 300
            }, 500);
            loading.style.display = 'none'

        }
    });
}
const initYear = ()=>{

    let year = `<option value="">Tất cả</option>`
    for (let i = 1990; i < 2024; i++) {
        year += `<option value="${i}">${i}</option>`
    }
    document.querySelector("#year").innerHTML = year
    document.querySelector("#year").addEventListener("input", handleFilter)
    document.querySelectorAll('#collapse_aside4 input').forEach((tmp)=>{
        tmp.addEventListener("input", handleFilter)
    })
}
const filterHandle = ()=>{
    loading.style.display = 'block'

    let totalFilter = []
    let company =  document.querySelector("#company").value
    let year =  document.querySelector("#year").value
    let name =  document.querySelector(".box-search-head2").value
    let priceMin = document.querySelector(".text-min").textContent.replace(",","").replace(".","")
    let priceMax = document.querySelector(".text-max").textContent.replace(",","").replace(".","")
    let xang = document.querySelector('#xang').checked
    let dien = document.querySelector('#dau').checked
    let fuel = ''
    if(xang){
        fuel = 'xang'
    }
    if(dien){
        fuel = 'dien'
    }
     filter ={
        name,
        year,
        company,
        priceMin,
        priceMax,
        fuel
    }
    let urlReq = `/product?action=filter`

    for (const property in filter) {
        urlReq += `&${property}= ${filter[property]}`
    }

    $.ajax({
        url: urlReq,
        type: 'get',
        success: function(res) {
            res = JSON.parse(res)
            console.log(res)
            document.querySelector(".number_pagination").value = res.totalPages
            initPagination()
            let data = JSON.parse(res.data)
            renderProduct(data)
            loading.style.display = 'none'

        }
    });
}






getCompany()
initYear()
getProdutWithPage(1)

