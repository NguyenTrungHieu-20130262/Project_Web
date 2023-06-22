const initInfo =(user)=>{
    console.log(user)
    document.querySelector(".form_name span").textContent = user.fullName
    document.querySelector(".form_phone span").textContent = user.phone
    document.querySelector(".form_address span").textContent = user.address
    document.querySelector(".name_modal").textContent = user.fullName
    document.querySelector(".phone_modal").textContent = user.phone
    document.querySelector(".address_modal").textContent = user.address
}
const outside = (layout)=>{
    document.addEventListener("click", (evt) => {
        const flyoutEl = document.querySelector(layout);
        let targetEl = evt.target; // clicked element
        do {
            if(targetEl == flyoutEl) {
                // This is a click inside, does nothing, just return.
                console.log("Inside")
                return;
            }
            // Go up the DOM
            targetEl = targetEl.parentNode;
        } while (targetEl);
        // This is a click outside.
        document.querySelector(".div_form_phone").classList.remove("hide")
        document.querySelector(".div_edit_phone").classList.add("hide")
        document.querySelector(".div_form_name").classList.remove("hide")
        document.querySelector(".div_edit_name").classList.add("hide")
    });
}

const getInfo = ()=>{
    $.ajax({
        url: "/profile?action=info",
        method: "GET",
        success: res =>{
            let user = JSON.parse(res)
            console.log(user)
            initInfo(user)
        },
        error: err=>{



        }
    })
}
getInfo()






let editAddress = document.querySelector(".edit_address")
editAddress.addEventListener('click', (e)=>{
    document.querySelector(".form_edit_address").classList.remove("hide")
    document.querySelector(".show_address").classList.add("hide")
    document.addEventListener('click', function handleClickOutsideBox(eventn) {
        const box = document.querySelector('.form_edit_address');
        const box2 = document.querySelector('.show_address');

        if (!box.contains(event.target) && !box2.contains(event.target)  ) {
            document.querySelector(".form_edit_address").classList.add("hide")
            document.querySelector(".show_address").classList.remove("hide")

        }
    });

})
let saveAddress = document.querySelector(".save_address")
saveAddress.addEventListener('click', (e)=>{
    let address =  $( ".ward option:selected" ).text() + " - " + $( ".district option:selected" ).text() + " - " + $( ".province option:selected" ).text();

    $.ajax({
        url: "/profile?action=changeProfileCart",
        method: "POST",
        data: {address: address},
        success: res =>{
            let user = JSON.parse(res)
            console.log(user)
            initInfo(user)
        },
        error: err=>{



        }
    })
    document.querySelector(".form_edit_address").classList.add("hide")
    document.querySelector(".show_address").classList.remove("hide")

})




let editname = document.querySelector(".form_name a")
editname.addEventListener('click', (e)=>{
    let check = true
    document.querySelector(".div_form_name").classList.add("hide")
    document.querySelector(".div_edit_name").classList.remove("hide")
    document.addEventListener('click', function handleClickOutsideBox(eventn) {
        const box = document.querySelector('.edit_name');
        const box2 = document.querySelector('.form_name');

        if (!box.contains(event.target) && !box2.contains(event.target)  ) {
            document.querySelector(".div_form_name").classList.remove("hide")
            document.querySelector(".div_edit_name").classList.add("hide")

        }
    });
})
let save_name = document.querySelector(".edit_name a")
save_name.addEventListener('click', (e)=>{

    let nameNew = document.querySelector(".edit_name input").value
    if(nameNew){
        $.ajax({
            url: "/profile?action=changeProfileCart",
            method: "POST",
            data: {name: nameNew},
            success: res =>{
                let user = JSON.parse(res)
                console.log(user)
                initInfo(user)
            },
            error: err=>{



            }
        })
        document.querySelector(".div_form_name").classList.remove("hide")
        document.querySelector(".div_edit_name").classList.add("hide")
    }else{
        document.querySelector(".edit_name input").style.border = '1px solid red'
    }

})





let editPhone = document.querySelector(".form_phone a")
editPhone.addEventListener('click', (e)=>{
    document.querySelector(".div_form_phone").classList.add("hide")
    document.querySelector(".div_edit_phone").classList.remove("hide")
    document.addEventListener('click', function handleClickOutsideBox(eventn) {
        const box = document.querySelector('.edit_phone');
        const box2 = document.querySelector('.form_phone');

        if (!box.contains(event.target) && !box2.contains(event.target)  ) {
            document.querySelector(".div_form_phone").classList.remove("hide")
            document.querySelector(".div_edit_phone").classList.add("hide")

        }
    });
    // document.addEventListener('click', function handleClickOutsideBox(event) {
    //     const box = document.querySelector('.edit_phone');
    //
    //     if (!box.contains(event.target)) {
    //         document.querySelector(".div_form_phone").classList.remove("hide")
    //         document.querySelector(".div_edit_phone").classList.add("hide")
    //     }
    // });

})
let savePhone = document.querySelector(".edit_phone a")
savePhone.addEventListener('click', (e)=>{

    let phoneNew = document.querySelector(".edit_phone input").value
    if(phoneNew.length >=10){
        $.ajax({
            url: "/profile?action=changeProfileCart",
            method: "POST",
            data: {phone: phoneNew},
            success: res =>{
                let user = JSON.parse(res)
                console.log(user)
                initInfo(user)
            },
            error: err=>{



            }
        })
        document.querySelector(".div_form_phone").classList.remove("hide")
        document.querySelector(".div_edit_phone").classList.add("hide")
    }else{
        document.querySelector(".edit_phone input").style.border = '1px solid red'
    }
})

var provinceData =''
const initProvince =()=>{
    provinceData = JSON.parse(provinceData)
    let elmProvince = document.querySelector(".province")
    provinceData = JSON.parse(provinceData)
    console.log(provinceData)
    provinceData.original.data.map(tmp=>{

        elmProvince.innerHTML += `<option value=${tmp.ProvinceID}>${tmp.ProvinceName}</option>`
    })

}
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






