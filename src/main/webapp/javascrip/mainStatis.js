let dataProductOut = dataProduct.filter(tmp=> tmp.quantity ===0)
const toUSD = (money)=>{
    return money.toLocaleString('en-US', { style: 'currency', currency: 'USD' });

}
const initTableProductOut = ()=>{
    $('#myTable').DataTable({
        data: dataProductOut,
        columns: [
            { data: "id" },
            { data: "name" },
            { data: "images" ,"render": function (data, type, row, meta) {
                    let image = data[0]
                    return `<img width="160px"  src="${image}" />`;
                }},

            { data: "price", "render": function (data, type, row, meta) {
                    return toUSD(data);
                }},
            { data: "createAt" },
        ],
        buttons: [
            'excel', 'pdf'
        ]
    });
}
initTableProductOut()