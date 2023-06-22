var dataMain = []
var dataUser = []
var permission = []

const getData = ()=>{
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        url: "/api/role",
        method: "GET",
        success: res =>{
            dataMain = JSON.parse(res)
            let dataFilter = dataMain.filter(tmp=>tmp.type === 0)
            initTable(dataFilter)
            let modal = document.querySelector('.addRole')
            let elm = ``
            dataMain.forEach(tmp=>{
                elm += `<option value='${tmp.id}' >${tmp.name}</option>`
            })
            modal.innerHTML = elm
            loading.style.display = 'none'

        },
        error: err=>{

        }
    })
}
const getDataUser = ()=>{
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        url: "/api/role?action=get_account",
        method: "POST",
        success: res =>{
            console.log(JSON.parse(res))
            dataUser = JSON.parse(res)
            console.log(dataUser)
            initTableUser(dataUser)
        },
        error: err=>{

        }
    })
}
getDataUser()
const getPermission = ()=>{
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        url: "/api/permission",
        method: "GET",
        success: res =>{
            permission = JSON.parse(res)
            let data = JSON.parse(res)
            let elm = ``
            data.map(tmp=>{
                elm += `<option value="${tmp.id}">${tmp.name}</option>`
            })
            console.log(data, elm)
            document.querySelector('#field2').innerHTML = elm
            MultiselectDropdown(window.MultiselectDropdownOptions);

        },
        error: err=>{

        }
    })
}
getPermission()
const initTable = (data)=>{
    $('#myTable').DataTable({
        data: data,
        columns: [
            { data: "id" },
            { data: "name" },
            {data:"","render": function (data, type, row, meta) {

                        return `
                                <div style="text-align: center">
                                <button class="btn btn-success" style="font-size: 10px" onclick="details(${row.id})">Chi tiết</button>
                                <button class="btn btn-success" style="font-size: 10px" onclick="edit(${row.id}, this)">Cập nhập</button>
                                <button class="btn btn-danger delete_role" style="font-size: 10px" >Xóa</button>
</div>`;


                }}
        ],
        buttons: [
            'excel', 'pdf'
        ]
    });

}
const editRole = (id,e)=>{
    let table =  $('#tableUser').DataTable()
    let rowIdx = table.row($(e).parents('tr')).index();
    document.querySelector('#index_user_eidt').value = rowIdx
    let modal = document.querySelector('#exampleModalCenterAddRole')
    modal.style.display = 'flex'
    modal.style.opacity = 1
    modal.classList.remove('fade')
    document.querySelector('#id_user').value = id

}
const saveRole = ()=>{
    loading.style.display = 'block'

    let idUser =  document.querySelector('#id_user').value

    let modal = document.querySelector('#exampleModalCenterAddRole')
    let idRole = modal.querySelector("select").value
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        data:{idUser, idRole},
        url: "/api/role?action=set_role",
        method: "POST",
        success: res =>{
            if(res == 1){
                let role = dataMain.filter(tmp=>tmp.id == idRole)[0]
                for (let i = 0; i < dataUser.length; i++) {
                    if(dataUser[i].id == idUser){
                        dataUser[i] = {...dataUser[i], role: role}
                        let index = document.querySelector('#index_user_eidt').value
                        let table =  $('#tableUser').DataTable()
                        table.row(index).data(dataUser[i]).draw();
                        swal("Cấp quyền thành công.!", {});
                        loading.style.display = 'none'

                        break;
                    }
                }

            }

        },
        error: err=>{

        }
    })
    modal.style.display = 'none'
    modal.style.opacity = 0
    modal.classList.add('fade')

}
const closeAddRoleUser = ()=>{
    let modal = document.querySelector('#exampleModalCenterAddRole')
    modal.style.display = 'none'
    modal.style.opacity = 0
    modal.classList.add('fade')
}
const initTableUser = (data)=>{
    $('#tableUser').DataTable({
        data: data,
        columns: [
            { data: "id",  "defaultContent": "" },
            { data: "userName" ,  "defaultContent": ""},
            { data: "fullName" ,  "defaultContent": ""},
            { data: "avatar",  "defaultContent": "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png" ,"render": function (data, type, row, meta) {
                   if(data === undefined)

                    return `<img width="70px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png"/>`;
                   else
                       return `<img width="70px" src="${data}"/>`;

                }},
            { data: "email" ,  "defaultContent": ""},
            { data: "role" ,"render": function (data, type, row, meta) {
                    return data.name;
                },  "defaultContent": ""},
            {data:"","render": function (data, type, row, meta) {

                    return `
                                <div style="text-align: center">
                                <button class="btn btn-success" onclick="editRole(${row.id}, this)" style="font-size: 10px" >Cấp quyền</button>
</div>`;


                }}
        ],
        buttons: [
            'excel', 'pdf'
        ]
    });

}
const details = (id)=>{
    let obj = dataMain.filter(tmp => tmp.id === id)[0]
    console.log(obj)
    document.querySelector('#role-id').value = obj.id
    document.querySelector('#role-name').value = obj.name
    let elm = ``
    obj.arrPermission.map(tmp=>{
        elm += `<li>${tmp.name}</li>`
    })
    document.querySelector('#permissions').innerHTML = elm

    let modal =     document.querySelector('#exampleModalCenter')
    modal.classList.remove('fade')
    modal.style.display = 'flex'
    modal.style.opacity = 1

}
const edit = (id ,e)=>{
    let table =  $('#myTable').DataTable()
    let rowIdx = table.row($(e).parents('tr')).index();
    document.querySelector('#index_role_eidt').value = rowIdx
    let obj = dataMain.filter(tmp => tmp.id === id)[0]
    let newArr = [...permission]
    newArr.forEach((tmp, index)=>{
        let filter = obj.arrPermission.filter(tmp2=>tmp2.id === tmp.id)
        if(filter.length >0){
            newArr[index] = {...newArr[index], status: 1}
        }else{
            newArr[index] = {...newArr[index], status: 0}

        }
    })
    console.log(newArr)
    document.querySelector('#role-id-edit').value = obj.id
    document.querySelector('#role-name-edit').value = obj.name
    let elm = ``
    newArr.map(tmp=>{
        if(tmp.status === 1){
            elm += `<li onclick="changeSelectPermission(this)"><button  class="btn btn-outline-primary" style="font-size: 12px; width: 100%;   text-align: center;
    padding: 6px;
    border-radius: 20px;"><input  value="${tmp.id}" hidden/>${tmp.name}</button> </li>`
        }else{
            elm += `<li onclick="changeSelectPermission(this)"><button class="btn btn-outline-secondary" style=" font-size: 12px; width: 100%;   text-align: center;
    padding: 6px;
    border-radius: 20px;"><input  value="${tmp.id}" hidden/>${tmp.name}</button> </li>`
        }

    })
    document.querySelector('#permissions_edit').innerHTML = elm

    let modal = document.querySelector('#exampleModalCenter2')
    modal.classList.remove('fade')
    modal.style.display = 'flex'
    modal.style.opacity = 1

}
const closeModalEdit = ()=>{
    let modal = document.querySelector('#exampleModalCenter2')
    modal.classList.add('fade')
    modal.style.display = 'none'
    modal.style.opacity = 0
}
document.querySelector('.save_edit').addEventListener('click',(e)=>{
    let idPermissions = []
    let name = document.querySelector('#role-name-edit').value
    let id = document.querySelector('#role-id-edit').value

    loading.style.display = 'block'

    let permissions = document.querySelectorAll('#permissions_edit button.btn-outline-primary')
    console.log(permissions)
    permissions.forEach(tmp=>{
        let input = tmp.querySelector('input')
        idPermissions.push(Number(input.value))
    })
    console.log(idPermissions, name, id)
    idPermissions = JSON.stringify(idPermissions)

    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        url: "/api/role?action=update",
        method: "POST",
        data:{
            idPermissions, name, id
        },
        success: res =>{
            let rs = JSON.parse(res)
            for (let i = 0; i < dataMain.length; i++) {
                if(dataMain[i].id === rs.id)
                    dataMain[i] = rs
            }
            let index_edit = Number(document.querySelector('#index_role_eidt').value)
            let table =  $('#myTable').DataTable()
            table.row(index_edit).data(rs).draw();
            closeModalEdit()
            loading.style.display = 'none'

        },
        error: err=>{

        }
    })

})
const changeSelectPermission = (e)=>{
    e = e.querySelector('button')
    if(e.className.includes('btn-outline-primary')){
        e.classList.remove('btn-outline-primary')
        e.classList.add('btn-outline-secondary')
    }else{
        e.classList.add('btn-outline-primary')
        e.classList.remove('btn-outline-secondary')
    }
}

const delPermission = (id_role, id_permission, e)=>{

    swal({
        title: "Cảnh báo",
        text: "Bạn có chắc chắn là muốn xóa quyền này?",
        buttons: ["Hủy bỏ", "Đồng ý"],
    }).then((willDelete) => {
        if (willDelete) {
            loading.style.display = 'block'

            $.ajax({
                statusCode: {
                    401: function() {
                        swal("Bạn không có quyền thực hiện chức năng này.!", {});
                        loading.style.display = 'none'

                    }
                },
                url: "/api/role?action=delete_permission",
                method: "POST",
                data:{
                    id_role, id_permission
                },
                success: res =>{
                  e.parentNode.style.display = 'none'
                    loading.style.display = 'none'

                },
                error: err=>{

                }
            })


        }
    });
}
getData()
$('#myTable tbody').on('click', '.delete_role', function(e) {
    ///.parentNode.parentNode.parentNode.querySelector('.sorting_1')
    let table =  $('#myTable').DataTable()
    let rowIdx = table.row($(this).parents('tr')).index();
    let id = e.target.parentNode.parentNode.parentNode.querySelector('.sorting_1').textContent
    console.log(id, rowIdx)
    deleteRole(id, rowIdx)

});
const deleteRole = (id,index)=>{
    swal({
        title: "Cảnh báo",
        text: "Bạn có chắc chắn là muốn xóa quyền này?",
        buttons: ["Hủy bỏ", "Đồng ý"],
    }).then((willDelete) => {
        if (willDelete) {
            loading.style.display = 'block'

            $.ajax({
                statusCode: {
                    401: function() {
                        swal("Bạn không có quyền thực hiện chức năng này.!", {});
                        loading.style.display = 'none'

                    }
                },
                url: "/api/role?action=delete_role",
                method: "POST",
                data:{
                    id
                },
                success: res =>{
                    let table =  $('#myTable').DataTable()
                    let dataRow = table.row(index).data()
                    table.row(index).remove().draw();
                    swal("Xóa thành công", {});
                    let table2 = document.querySelector("#body_table_users")
                    for (var i = 0; i < table2.rows.length; i++) {
                        if (table2.rows[i].cells[5].textContent === dataRow.name) {
                            table2.rows[i].cells[5].textContent = "NORMAL";
                        }
                    }
                    let selectRole = document.querySelector(".addRole option[value='"+dataRow.id+"'] ")
                    selectRole.remove()
                    loading.style.display = 'none'

                },
                error: err=>{

                }
            })


        }
    });
}

var style = document.createElement('style');
style.setAttribute("id","multiselect_dropdown_styles");


function MultiselectDropdown(options){
    var config={
        search:true,
        height:'15rem',
        placeholder:'Select',
        txtSelected:'Selected',
        txtAll:'All',
        txtRemove: 'Remove',
        txtSearch:'Search',
        ...options
    };
    function newEl(tag,attrs){
        var e=document.createElement(tag);
        if(attrs!==undefined) Object.keys(attrs).forEach(k=>{
            if(k==='class') { Array.isArray(attrs[k]) ? attrs[k].forEach(o=>o!==''?e.classList.add(o):0) : (attrs[k]!==''?e.classList.add(attrs[k]):0)}
            else if(k==='style'){
                Object.keys(attrs[k]).forEach(ks=>{
                    e.style[ks]=attrs[k][ks];
                });
            }
            else if(k==='text'){attrs[k]===''?e.innerHTML='&nbsp;':e.innerText=attrs[k]}
            else e[k]=attrs[k];
        });
        return e;
    }

const closeModalRole = ()=>{
    let modal =     document.querySelector('#exampleModalCenter')
    modal.classList.add('fade')
    modal.style.display = 'none'
    modal.style.opacity = 0
}
document.querySelectorAll('.closeModal').forEach(tmp=>{
    tmp.addEventListener('click',()=>{
        closeModalRole()
    })
})
    document.querySelectorAll("select[multiple]").forEach((el,k)=>{

        var div=newEl('div',{class:'multiselect-dropdown',style:{width:config.style?.width??el.clientWidth+'px',padding:config.style?.padding??''}});
        el.style.display='none';
        el.parentNode.insertBefore(div,el.nextSibling);
        var listWrap=newEl('div',{class:'multiselect-dropdown-list-wrapper'});
        var list=newEl('div',{class:'multiselect-dropdown-list',style:{height:config.height}});
        var search=newEl('input',{class:['multiselect-dropdown-search'].concat([config.searchInput?.class??'form-control']),style:{width:'100%',display:el.attributes['multiselect-search']?.value==='true'?'block':'none'},placeholder:config.txtSearch});
        listWrap.appendChild(search);
        div.appendChild(listWrap);
        listWrap.appendChild(list);

        el.loadOptions=()=>{
            list.innerHTML='';

            if(el.attributes['multiselect-select-all']?.value=='true'){
                var op=newEl('div',{class:'multiselect-dropdown-all-selector'})
                var ic=newEl('input',{type:'checkbox'});
                op.appendChild(ic);
                op.appendChild(newEl('label',{text:config.txtAll}));

                op.addEventListener('click',()=>{
                    op.classList.toggle('checked');
                    op.querySelector("input").checked=!op.querySelector("input").checked;

                    var ch=op.querySelector("input").checked;
                    list.querySelectorAll(":scope > div:not(.multiselect-dropdown-all-selector)")
                        .forEach(i=>{if(i.style.display!=='none'){i.querySelector("input").checked=ch; i.optEl.selected=ch}});

                    el.dispatchEvent(new Event('change'));
                });
                ic.addEventListener('click',(ev)=>{
                    ic.checked=!ic.checked;
                });
                el.addEventListener('change', (ev)=>{
                    let itms=Array.from(list.querySelectorAll(":scope > div:not(.multiselect-dropdown-all-selector)")).filter(e=>e.style.display!=='none')
                    let existsNotSelected=itms.find(i=>!i.querySelector("input").checked);
                    if(ic.checked && existsNotSelected) ic.checked=false;
                    else if(ic.checked==false && existsNotSelected===undefined) ic.checked=true;
                });

                list.appendChild(op);
            }

            Array.from(el.options).map(o=>{
                var op=newEl('div',{class:o.selected?'checked':'',optEl:o})
                var ic=newEl('input',{type:'checkbox',checked:o.selected});
                op.appendChild(ic);
                op.appendChild(newEl('label',{text:o.text}));

                op.addEventListener('click',()=>{
                    op.classList.toggle('checked');
                    op.querySelector("input").checked=!op.querySelector("input").checked;
                    op.optEl.selected=!!!op.optEl.selected;
                    el.dispatchEvent(new Event('change'));
                });
                ic.addEventListener('click',(ev)=>{
                    ic.checked=!ic.checked;
                });
                o.listitemEl=op;
                list.appendChild(op);
            });
            div.listEl=listWrap;

            div.refresh=()=>{
                div.querySelectorAll('span.optext, span.placeholder').forEach(t=>div.removeChild(t));
                var sels=Array.from(el.selectedOptions);
                if(sels.length>(el.attributes['multiselect-max-items']?.value??5)){
                    div.appendChild(newEl('span',{class:['optext','maxselected'],text:sels.length+' '+config.txtSelected}));
                }
                else{
                    sels.map(x=>{
                        var c=newEl('span',{class:'optext',text:x.text, srcOption: x});
                        if((el.attributes['multiselect-hide-x']?.value !== 'true'))
                            c.appendChild(newEl('span',{class:'optdel',text:'🗙',title:config.txtRemove, onclick:(ev)=>{c.srcOption.listitemEl.dispatchEvent(new Event('click'));div.refresh();ev.stopPropagation();}}));

                        div.appendChild(c);
                    });
                }
                if(0==el.selectedOptions.length) div.appendChild(newEl('span',{class:'placeholder',text:el.attributes['placeholder']?.value??config.placeholder}));
            };
            div.refresh();
        }
        el.loadOptions();

        search.addEventListener('input',()=>{
            list.querySelectorAll(":scope div:not(.multiselect-dropdown-all-selector)").forEach(d=>{
                var txt=d.querySelector("label").innerText.toUpperCase();
                d.style.display=txt.includes(search.value.toUpperCase())?'block':'none';
            });
        });

        div.addEventListener('click',()=>{
            div.listEl.style.display='block';
            search.focus();
            search.select();
        });

        document.addEventListener('click', function(event) {
            if (!div.contains(event.target)) {
                listWrap.style.display='none';
                div.refresh();
            }
        });
    });
}

document.querySelector('.insert_role').addEventListener('click',(e)=>{
    e.preventDefault()
    loading.style.display = 'block'

    let name = document.querySelector("#name_role").value
    let permissions = document.querySelector("#field2").selectedOptions
    let idPermissions = []
    for (let i = 0; i < permissions.length; i++) {
        idPermissions.push(Number(permissions[i].value))
    }
    console.log(name, idPermissions)
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
                loading.style.display = 'none'

            }
        },
        url: "/api/role?action=insert",
        method: "POST",
        data: {name, idPermissions : JSON.stringify(idPermissions)},
        success: res =>{
            let rs = JSON.parse(res)
            if(rs != 0){
                swal("Thêm nhóm quyền thành công.!", {});
                $('#myTable').DataTable().clear().destroy()
                getData()
                loading.style.display = 'none'

            }else{
                swal("Thêm nhóm quyền không thành công.!", {});
                loading.style.display = 'none'

            }
        },
        error: err=>{

        }
    })
})
