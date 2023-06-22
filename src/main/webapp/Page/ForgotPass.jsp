<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login/Register</title>
    <link rel="stylesheet" href="../Style.css">
    <link rel="stylesheet"
          href="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/css/dist/mdb5/standard/core.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Scripts/swiper-6.3.3/swiper-bundle.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/common.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/theme.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/post_news.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/node_modules/@angular/material/prebuilt-themes/indigo-pink.css">
    <link rel="stylesheet" type="text/css" href="/Page/Login_Register.css">
    <style>
        .show {
            display: block !important;
        }

        .hidden {
            display: none !important;
        }
    </style>
</head>
<body>
<jsp:include page="../Component/header/Header.jsp" />
<div class="container" style="width: 100%; margin-top: 50px; ">
    <div class="wrapper">
        <h2 class="title_head">Quên mật khẩu</h2>
        <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link " id="tab-login" href="login" role="tab">Đăng nhập</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="tab-register" href="register">Đăng kí</a>
            </li>
        </ul>
        <!-- Pills navs -->

        <!-- Pills content -->
        <div class="tab-content" style="margin: 50px auto;">
            <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login" style=" justify-content: center;">
                <form class="form-forgot" style="width: 100%;">

                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input type="text" id="emailName" class="form-control"/>
                        <label id="forgot-user" class="form-label" for="emailName">Tên đăng nhập</label>
                    </div>

                    <button id="btn-forgot" type="submit" class="btn btn-primary btn-block mb-4 login">Lấy mã xác nhận
                    </button>
                    <style>
                        .title_head{
                            text-align: center;
                            font-size: 40px;
                            font-weight: bold;
                            text-transform: uppercase;
                            margin-bottom: 30px;
                        }
                        .wrapper ul li a{
                            font-size: 28px;
                            font-weight: bold;
                        }

                        .wrapper ul li a:hover{
                            background-color: #007bff;
                        }
                        #btn-forgot{
                            width: 30%;
                            margin-left: 50%;
                            transform: translateX(-50%);
                            padding: 6px 20px;
                            /*background: linear-gradient(to right, #00c10c 0%, #fff200 50%, #00c10c 100%);*/
                            background: linear-gradient(to right, #007bff 0%, #9cf6e7 50%, #007bff 100%);
                            background-size: 300%, 1px;
                            border: none;
                            border-radius: 5px;
                            color: white;
                            transition: all .3s linear;
                        }

                        #btn-forgot:hover{
                            /*background: linear-gradient(to left, #00c10c 0%, #fff200 50%, #00c10c 100%) right;*/
                            background: linear-gradient(to left, #007bff 0%, #9cf6e7 50%, #007bff 100%) right;
                            background-size: 300%, 1px;
                        }
                    </style>

                </form>
            </div>
        </div>
        <!-- Pills content -->

    </div>
    <%@include file="../Component/loading/Loading.jsp" %>

</div>
<jsp:include page="../Component/footer/footer.jsp" />
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript"
        src="https://mdbcdn.b-cdn.net/wp-content/themes/mdbootstrap4/docs-app/js/dist/mdb5/standard/core.min.js"></script>
<script>
    $('#btn-forgot').click((e) => {
        e.preventDefault();
        let usernameOrEmail = $('#emailName').val()
        const loading = document.getElementById("loading");
        loading.style.display="block"
        fetch(`/forgotPass`, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({
                type: "confirmAccount",
                username: usernameOrEmail
            })
        })
            .then((response) => {
                if (response.ok) {
                    loading.style.display="none"
                    swal({
                        title: "Thành công",
                        text: "Vui lòng kiểm tra email để xác thực và đổi mật khẩu",
                    });
                } else {
                    throw new Error(response.statusText);
                }
            })
            .catch((error) => {
                loading.style.display="none"
                swal({
                    title: "Thất bại",
                    text: "Tài khoản không tồn tại",
                });
            });

    })
    document.querySelector("#back-login").addEventListener("click", (e) => {
        e.preventDefault()
        document.querySelector(".form-login").classList.toggle("hidden")
        document.querySelector(".form-forgot").classList.toggle("show")
    })
    document.querySelector("#e-forgot").addEventListener("click", (e) => {
        e.preventDefault()
        document.querySelector(".form-login").classList.add("hidden")
        document.querySelector(".form-forgot").classList.add("show")
    })
</script>
</html>
