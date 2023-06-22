<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Đăng kí</title>
    <link rel="stylesheet" href="../Style.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/post_news.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" type="text/css" href="/Page/Login_Register.css">
    <style>
        .show{
            display: block !important;
        }
        .hidden{
            display: none !important;
        }
            .address{
                width: 100%;
                height: 35.81px;
                padding: 0 10px;
                border: 1px solid #bdbdbd;
                border-radius: 5px;
                margin-bottom: 10px;
            }
            .events_none{
                pointer-events: none;
                opacity: 0.7;
            }
    </style>
</head>


<body style="position: relative">
<%@include file="../Component/loading/Loading.jsp" %>
<jsp:include page="../Component/header/Header.jsp" />

<div class="container"  style="padding-top: 50px"; >
    <div class="wrapper">
        <h2 class="title_head" style="text-align: center; font-size: 40px; font-weight: bold; text-transform: uppercase; margin-bottom: 30px;">Đăng kí</h2>
        <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link " id="tab-login"  href="login" role="tab" style="text-transform: uppercase">Đăng nhập</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="tab-register"  href="register" style="text-transform: uppercase">Đăng kí</a>
            </li>
        </ul>
        <!-- Pills navs -->

        <!-- Pills content -->
        <div class="tab-content" style="margin: auto;;">
            <div class="tab-pane fade show active" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                <hr/>
                <form id="formRegister" style="width: 100%; margin: 30px 0">
                    <!-- Name input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="username">Tên đăng nhập</label>
                        <input type="text" id="username" class="form-control"/>
                    </div>
                    <!-- Full Name input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="fullname">Họ và tên</label>
                        <input type="text" id="fullname" class="form-control"/>
                    </div>
                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="email">Email</label>
                        <input type="email" id="email" class="form-control"/>
                    </div>
                    <%--                 Phone Number --%>
                    <div class="form-outline mb-4">
                        <label class="form-label" for="phone">Số điện thoại</label>
                        <input type="number" id="phone" class="form-control"/>
                    </div>
                    <div class="form-outline mb-4">
                        <label class="form-label" for="address">Địa chỉ</label>
                        <div id="address" style="display: flex;    flex-direction: column;">
                            <select class="address province">
                                <option value="0">Tỉnh</option>
                            </select>
                            <select class="address district events_none" >
                                <option value="0">Huyện</option>
                            </select>
                            <select class="address ward events_none" style="    margin-bottom: 0;">
                                <option value="0">Xã</option>
                            </select>

                        </div>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="password">Mật khẩu</label>

                        <input type="password" id="password" class="form-control" style="border: 1px solid #bdbdbd;"/>
                    </div>

                    <!-- Repeat Password input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="repeatPassword">Xác nhận mật khẩu</label>

                        <input type="password" id="repeatPassword" class="form-control" style="border: 1px solid #bdbdbd;"/>
                    </div>
                    <%@include file="../Component/Captcha/Captcha.jsp" %>

                    <br/>

                    <!-- Submit button -->
                    <button type="button" id="bt-register"  class="btn btn-primary btn-block mb-3 btn-code">Đăng ký</button>
<%--                    <div style="text-align: center">--%>
<%--                        <a class="back-home" href="/">--%>
<%--                            <i class="fa-solid fa-backward"></i>--%>
<%--                            Back To Home--%>
<%--                        </a>--%>
<%--                    </div>--%>
                    <style>

                        .btn-primary{
                            width: 40%;
                            margin-left: 50%;
                            transform: translateX(-50%);
                            padding: 5px;
                            /*background: linear-gradient(to right, #00c10c 0%, #fff200 50%, #00c10c 100%);*/
                            background: linear-gradient(to right, #007bff 0%, #9cf6e7 50%, #007bff 100%);
                            background-size: 300%, 1px;
                            border: none;
                            border-radius: 5px;
                            color: white;
                            transition: all .3s linear;
                        }

                        .btn-primary:hover{
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

</div>
<jsp:include page="../Component/footer/footer.jsp" />
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>


<script src="../javascrip/register.js"></script>

</html>