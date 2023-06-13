var dataFilter = []
var dataCompany = []
var indexNumber = 1;
var quantityProductOnPage = 10
var dataAll = []
const changeNumberPage = (n)=>{
    indexNumber = n
    window.scrollTo(0, 300);
    showData(dataFilter)
}



const getCompany = ()=>{
    $.ajax({
        url: "/company",
        type: 'GET',
        success: function(res) {
            dataCompany = JSON.parse(res)
            console.log(dataCompany)
            let compantElm = document.querySelector("#company")
            let rs = `<option value="all">Tất cả</option>`
            dataCompany.map((tmp)=>{
                rs += `<option value="${tmp.id}">${tmp.name}</option>`
                console.log("added!")
            })
            compantElm.innerHTML = rs

        }
    });
}


// init()
getCompany()