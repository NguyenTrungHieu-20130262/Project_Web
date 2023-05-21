var dataMain = []
const getData = ()=>{
    $.ajax({
        statusCode: {
            401: function() {
                swal("Bạn không có quyền thực hiện chức năng này.!", {});
            }
        },
        url: "/api/role",
        method: "GET",
        success: res =>{
            dataMain = JSON.parse(res)
            initTable(dataMain)

        },
        error: err=>{

        }
    })
}
const initTable = (data)=>{
    $('#myTable').DataTable({
        data: data,
        columns: [
            { data: "id" },
            { data: "name" },
            {data: 'arrPermission',"render": function (data, type, row, meta) {
                    let elms = `<div>`
                    data.map(tmp=>{
                        elms +=`<span class="">${tmp.name}</span>`
                    })
                    data.map(tmp=>{
                        elms +=`<span class="">${tmp.name}</span>`
                    })
                    elms += '</div>'
                    return elms
                }},
            {data:"","render": function (data, type, row, meta) {

                        return `
                                <button class="btn btn-success">Chi tiết</button>
                                <button class="btn btn-success">Cập nhập</button>
                                <button class="btn btn-danger">Xóa</button>`;


                }}
        ],
        buttons: [
            'excel', 'pdf'
        ]
    });

}
getData()