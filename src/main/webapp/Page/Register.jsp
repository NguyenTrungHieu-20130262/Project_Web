<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Login/Register</title>
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


<div class="container"  style="padding-top: 50px"; >
    <div class="wrapper">
        <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link " id="tab-login"  href="login" role="tab" >Login</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="tab-register"  href="register"
                >Register</a>
            </li>
        </ul>
        <!-- Pills navs -->

        <!-- Pills content -->
        <div class="tab-content" style="margin: auto;;">
            <div class="tab-pane fade show active" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                <form id="formRegister">
                    <p class="text-center">Register</p>
                    <!-- Name input -->
                    <div class="form-outline mb-4">
                        <input type="text" id="username" class="form-control"/>
                        <label class="form-label" for="username">Username</label>
                    </div>
                    <!-- Full Name input -->
                    <div class="form-outline mb-4">
                        <input type="text" id="fullname" class="form-control"/>
                        <label class="form-label" for="fullname">Fullname</label>
                    </div>
                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input type="email" id="email" class="form-control"/>
                        <label class="form-label" for="email">Email</label>
                    </div>
                    <%--                 Phone Number --%>
                    <div class="form-outline mb-4">
                        <input type="number" id="phone" class="form-control"/>
                        <label class="form-label" for="phone">Phone Number</label>
                    </div>
                    <div class="form-outline mb-4">
                        <label class="form-label" for="address">Address</label>
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
                        <input type="password" id="password" class="form-control" style="border: 1px solid #bdbdbd;"/>
                        <label class="form-label" for="password">Password</label>
                    </div>

                    <!-- Repeat Password input -->
                    <div class="form-outline mb-4">
                        <input type="password" id="repeatPassword" class="form-control" style="border: 1px solid #bdbdbd;"/>
                        <label class="form-label" for="repeatPassword">Repeat password</label>
                    </div>
                    <%@include file="../Component/Captcha/Captcha.jsp" %>

                    <br/>

                    <!-- Submit button -->
                    <button type="button" id="bt-register"  class="btn btn-primary btn-block mb-3 btn-code">Đăng ký</button>
                    <div style="text-align: center">
                        <a class="back-home" href="/">
                            <i class="fa-solid fa-backward"></i>
                            Back To Home
                        </a>
                    </div>

                </form>



            </div>

        </div>
        <!-- Pills content -->

    </div>

</div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>


<script src="../javascrip/register.js"></script>

</html>