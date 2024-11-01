<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Danh sách nhân viên | Quản trị Admin</title>
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- or -->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Scripts/swiper-6.3.3/swiper-bundle.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/common.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/theme.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/post_news.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/node_modules/@angular/material/prebuilt-themes/indigo-pink.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
    <style>
        .fileupload {
            display: none;
        }

        .inp:focus {
            border: 1px solid #56A1EE;
        }

        .group-bt.two-bt .btn-send {
            float: right;
            background: #4DB848;
        }

        .control-last {
            display: flex;
            align-items: center;
        }

        .imgContainer {
            width: 180px;
            height: 134px;
            margin-right: 10px;
        }

        .imgContainer > img {
            width: 100%;
            height: 100%;
            border-radius: 4px;
            border: none;
            overflow: hidden;
        }

        .list-thumb-gallery {
            display: flex !important;
            align-items: center;
            flex-wrap: wrap;
        }


    </style>

</head>

<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->
<header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <%@ include file="./header.jsp" %>
</header>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<jsp:include page="SideBar.jsp">
    <jsp:param name="page" value="2"/>
</jsp:include>
<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Post Sản phẩm</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="#"><b>Nhập sản phẩm file excel</b></a></li>

                </ul>
                <label style="padding: 10px;border-radius:10px;cursor: pointer;color: #008c04;
    background: #a2ecb5 ;font-size: 20px;font-weight: bold;text-align: center" for="importFile">
                    <span>Chọn file</span>
                    <input style="display: none" type="file" id="importFile" accept=".xlsx, .xls">
                </label>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">

        </div>
    </div>

    <div class="container">
        <form class="editForm ng-valid ng-dirty ng-touched" novalidate="">

            <div class="new-form-post form-upload container postnews">
                <div class="gr-heading-post"><h2 class="heading step1"> HÌNH ẢNH <span class="note-heading"><i
                        class="icon-dot"></i>0/25 - Bạn có thể đăng tối đa 25 ảnh</span></h2><span
                        class="status-per per1"></span></div>
                <ul class="list-note">
                    <li><i class="icon-ok"></i><span>Đăng ít nhất 03 hình để tin rao hiệu quả hơn.</span></li>
                    <li><i class="icon-ok"></i><span>Ảnh đầu tiên sẽ là ảnh đại diện cho tin của bạn.</span>
                    </li>
                </ul>

                <div class="upload">
                    <div style="text-align: center" class="swiper-container">
                        <ul class="list-thumb-gallery  default-theme" id="uploadimage"><input style="display: none"
                                                                                              multiple=""
                                                                                              class="fileupload input-hidden"
                                                                                              type="file">
                            <li class="upload-item working-upload-item add"><a class="add-img"><i
                                    class="icon-plus"></i><span class="txt-add">Nhấn vào đây để chọn ảnh</span></a>
                            </li>
                        </ul>

                        <div class="swiper-scrollbar"></div>
                    </div>
                </div>


            </div>
        </form>

        <%--      make--%>
        <%@include file="/Page/Admin/doc/PostStatus/make/index.jsp" %>
        <%--      tiltle--%>
        <%@include file="/Page/Admin/doc/PostStatus/titlencontent/index.jsp" %>
        <div class="group-bt two-bt" id="btn-postListing">
            <a href="" class="btn-send" id="btn-send">Hoàn tất</a><!----></div>
    </div>


    </div>

</main>
<%@include file="/Component/loading/Loading.jsp" %>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!--===============================================================================================-->
<script src="jsadmin/popper.min.js"></script>
<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<!--===============================================================================================-->
<script src="jsadmin/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="jsadmin/main.js"></script>
<!--===============================================================================================-->
<script src="jsadmin/plugins/pace.min.js"></script>
<!--===============================================================================================-->
<script type="text/javascript" src="jsadmin/plugins/chart.js"></script>
<script type="text/javascript" src="https://unpkg.com/xlsx@0.15.1/dist/xlsx.full.min.js"></script>

<!--===============================================================================================-->
<script type="text/javascript">
    var data = {
        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
        datasets: [{
            label: "Dữ liệu đầu tiên",
            fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
            strokeColor: "rgb(255, 212, 59)",
            pointColor: "rgb(255, 212, 59)",
            pointStrokeColor: "rgb(255, 212, 59)",
            pointHighlightFill: "rgb(255, 212, 59)",
            pointHighlightStroke: "rgb(255, 212, 59)",
            data: [20, 59, 90, 51, 56, 100]
        },
            {
                label: "Dữ liệu kế tiếp",
                fillColor: "rgba(9, 109, 239, 0.651)  ",
                pointColor: "rgb(9, 109, 239)",
                strokeColor: "rgb(9, 109, 239)",
                pointStrokeColor: "rgb(9, 109, 239)",
                pointHighlightFill: "rgb(9, 109, 239)",
                pointHighlightStroke: "rgb(9, 109, 239)",
                data: [48, 48, 49, 39, 86, 10]
            }
        ]
    };
</script>
<script type="text/javascript">
    //Thời Gian
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
</script>
<%--uploadfile--%>
<script>
    document.querySelector(".btn-send").addEventListener("click", (e) => {
        e.preventDefault();
    })
    document.querySelector(".upload-item").addEventListener("click", (e) => {
        document.querySelector(".fileupload").click()
    })

</script>


<script>
    document.querySelector(".btn-send").addEventListener("click", (e) => {
        e.preventDefault();
    })
    var handleItemImg = (e) => {
        var item = e.target.value;
        console.log(item)
        var id = item.getAttribute("id")
        $("#contain" + id).remove();
    }

    var imgRequest = '';
    var listImg = ""
    var count = 0;
    $(".fileupload").bind("change", (e) => {
        var file = document.querySelector(".fileupload").files[0];
        var reader = new FileReader();
        reader.onloadend = function () {
            imgRequest = reader.result
            listImg += reader.result + "||"
            let html = `<div id="contain\${count}" class="imgContainer" style="position: relative">
                  <img id="img\${count}" class="uploadImg" src="\${imgRequest}" alt="Vui lòng chọn ảnh">
                  <i id="\${count}" onClick="()=>{console.log(123)}" style="width: 20px;height: 20px; position: absolute; top: 10px;right: 20px;cursor: pointer; color:red " class="fa-solid fa-trash"></i>
                  <i id="\${count}" onClick="(e)=>handleItemImg(e)" style="width: 20px;height: 20px;position: absolute ;top: 10px;right: 50px; cursor: pointer; color:red" class="fa-solid fa-pen"></i>
                </div>`
            console.log(html)
            $('#uploadimage').append(html)
            count++;
        }
        reader.readAsDataURL(file);
    })
    const getYear = () => {
        let year;
        $(".list-year span").each(function () {
            $(this).each(function (index) {
                if ($(this)[0].querySelector("input").checked) {
                    year = $(this)[0].querySelector("label").textContent
                }
            })

        });
        return year;

    }
    const loading = document.getElementById("loading");
    const getStatus = () => {
        let arr = []
        $(".status-group li").each(function () {
            $(this).each(function (index) {
                if ($(this)[0].querySelector("input").checked) {
                    arr.push($(this)[0].querySelector("input").getAttribute("value"))
                }
            })

        });
        return arr
    }
    const delForm = () => {
        $("#Price").val("")
        $("#body").val("")
        $("#quantity").val("")
        $("input[name='height']").val("")
        $("input[name='length']").val("")
        $("input[name='width']").val("")
        $("input[name='weight']").val("")
        $("#tilte123").val("")
        $("#content").val("")
    }

    $("#btn-send").click(function (e) {
        e.preventDefault();
        const arr = getStatus()
        const formData = new FormData();
        formData.append("nameCompany", $('.form-select option:selected').text());
        formData.append("title", $("#tilte123").val());
        formData.append("content", $("#content").val());
        formData.append("images", listImg);
        formData.append("yearofmanufacture", getYear() || new Date().getFullYear());
        formData.append("made", arr[0]);
        formData.append("gear", arr[1]);
        formData.append("fuel", arr[2]);
        formData.append("status", arr[3]);
        formData.append("price", $("#Price").val());
        formData.append("body", $("#body").val());
        formData.append("quantity", $("#quantity").val());
        formData.append("height", $("input[name='height']").val());
        formData.append("length", $("input[name='length']").val());
        formData.append("width", $("input[name='width']").val());
        formData.append("weight", $("input[name='weight']").val());

        if (
            formData.get("nameCompany") &&
            formData.get("title") &&
            formData.get("content") &&
            formData.get("images") &&
            formData.get("yearofmanufacture") &&
            formData.get("made") &&
            formData.get("gear") &&
            formData.get("fuel") &&
            formData.get("status") &&
            formData.get("price") &&
            formData.get("body") &&
            formData.get("quantity") &&
            formData.get("height") &&
            formData.get("length") &&
            formData.get("width") &&
            formData.get("weight")
        ) {
            loading.style.display = "block";

            $.ajax({
                url: "/postProduct",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    delForm();
                    swal({
                        title: "Thành công",
                        text: "Thêm sản phẩm thành công",
                    }).then(() => {
                        loading.style.display = "none";
                    });
                }
            });
        } else {
            swal({
                title: 'Lỗi ',
                text: 'Thông tin không chính xác',
                content: "form",
                buttons: {
                    cancel: "Cancel",
                }
            }).then((value) => {
                loading.style.display = "none";
            });
        }
    });
    // import File Exel
    document.getElementById('importFile').addEventListener('change', handleImportFile);

    function handleImportFile(event) {
        const file = event.target.files[0];
        const fileReader = new FileReader();
        fileReader.onload = async function (e) {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, {type: 'array'});
            const worksheet = workbook.Sheets[workbook.SheetNames[0]];
            const fields = [];
            const fileInputs = [];

            for (let i = 1; ; i++) {
                const cellA = worksheet["A" + i];
                if (!cellA || !cellA.v) {
                    break;
                }
                const row = {};
                for (let j = 0; j < 15; j++) {
                    const columnName = String.fromCharCode(65 + j);
                    const cell = worksheet[columnName + "" + i];
                    const value = cell ? cell.v : '';
                    if (columnName === "O") {
                        const filePaths = value.split("||");
                        const arr=[]
                        for (const tmp of filePaths) {
                            arr.push(tmp)
                        }
                        row[columnName] = arr;
                        console.log(arr)
                    } else {
                        row[columnName] = value;
                    }
                }
                fields.push(row);
            }
            const formDataExcel = new FormData();
            formDataExcel.append('fields', JSON.stringify(fields));

            // Gửi fileInputs trong FormData chính
            fileInputs.forEach((fileInput, index) => {
                const files = fileInput.files;
                for (let i = 0; i < files.length; i++) {
                    formDataExcel.append("file_" + index + "_" + i, files[i]);
                }
            });

            importProduct(formDataExcel);
        };

        fileReader.readAsArrayBuffer(file);
    }


    const importProduct = (data) => {
        loading.style.display = "block";
        $.ajax({
            url: "/postProductExcel",
            type: "POST",
            data: data,
            processData: false,
            contentType: false,
            success: function (data) {
                swal({
                    title: "Thành công",
                    text: "Thêm sản phẩm thành công",
                }).then(() => {
                    loading.style.display = "none";
                });
            }
        });
    };


</script>
<%--post product--%>

</html>