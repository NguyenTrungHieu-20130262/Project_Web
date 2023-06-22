<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet"
          href="https://staticfile.oto.com.vn/dist/web/styles/listtinrao.min.css.gz?v=638031797131449271">
    <link rel="stylesheet" href="https://staticfile.oto.com.vn/dist/web/styles/theme.min.css.gz?v=638031797131449271">
    <link rel="stylesheet"
          href="https://staticfile.oto.com.vn/dist/web/styles/listtinrao.min.css.gz?v=638031797131449271">
    <link rel="stylesheet" href="https://staticfile.oto.com.vn/dist/web/styles/fillte.min.css.gz?v=638031797131449271">
    <link rel="stylesheet" href="https://staticfile.oto.com.vn/dist/web/styles/footer.min.css.gz?v=638031797131449271">
    <link rel="stylesheet"
          href="https://staticfile.oto.com.vn/dist/web/styles/css-boxright.min.css.gz?v=638031797131449271">
    <style>
        <%@include file="./header.css" %>
    </style>
</head>
<body>
<div class="header-fix header-footer-container" id="header-container">
    <div class="header">
        <div class="header-top">
            <div class="container">
                <div class="left-head"> Hotline: 09793459242</div>
                <div class="head-right" style="height: 100%">

                    <div class="noti" id="auto_save"><a rel="nofollow" id="showautosaved" href="cart"
                                                        title="Xe đã lưu"><i class="fa-solid fa-cart-shopping"></i></a>
                        <span
                                id="countproduct" class=""></span>
                        <div id="box-show-noti" class="scroll-list box-show-noti hide"></div>
                    </div>
                    <%--                    hậu--%>
                    <div class="box-login-acc" id="login">
                        <span style="margin-right: 15px">
        <a href="login" rel="nofollow" id="dangky">Đăng ký/ Đăng nhập
        </a>
    </span>
                        <div style="display: none" id="profile">
                            <a href="/profile"><i class="fa-solid fa-user"></i><span class="name_user"
                                                                                     style="margin-left: 10px"></span></a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="navi navi-fix menu-v2">
            <div class="container"><a class="logo" href="/">
            </a>
                <ul class="menu-top">
                    <li><a style="cursor: pointer" onclick="home()" data-key="/"><h2>Trang chủ</h2></a>

                    <li><a href="product" data-key="/mua-ban-xe"><h2>Sản phẩm</h2></a>
                    <li><a href="contact" data-key="/bang-gia-xe-o-to"><h2>Liên hệ</h2></a>

                    </li>

                    </li>

                    <li id="checkIsAdmin"><a href="/admin?page=index"><h2>Admin</h2></a>

                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="../EventJs/HeaderActive.js">
</script>
<script>
    var Login_Res = document.querySelector("#login>span")
    var account = document.querySelector("#account")
    var profile = document.querySelector("#profile")
    const home = () => {
        window.location.pathname = "/"
    }
    const checkToActive=()=>{
        if(window.location.pathname=="/"){
            document.querySelectorAll(".menu-top > li> a")[0].classList.add("active")

        }else {
            if(window.location.pathname=="/product"){
                document.querySelectorAll(".menu-top > li> a")[1].classList.add("active")
            }else {
                document.querySelectorAll(".menu-top > li> a")[2].classList.add("active")
            }
        }
    }
    checkToActive();
    const findCookieByname = (name) => {
        const cookies = document.cookie.split("; ")
        for (const i in cookies) {
            if ((cookies[i].split("=")[0]) == name) {
                return cookies[i].split("=")[1]
            }
        }

    }

    function del_cookie(name) {
        document.cookie = name +
            '=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
    }

    const checkAccountExist = () => {
        console.log("get User")
        $.ajax({
            type: "Get",
            url: "/check/UserIsExist",
            contentType: "application/x-www-form-urlencoded",
            success: function (data) {
                console.log(data)
                if (data.includes("not ok")) {

                } else {
                    document.querySelector(".name_user").textContent = JSON.parse(data).name
                    Login_Res.classList.add("hidden")
                    profile.classList.add("show")
                }
            }
        });
    }
    checkAccountExist()
</script>
</html>

