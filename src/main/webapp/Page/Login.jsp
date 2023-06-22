<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../Style.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Scripts/swiper-6.3.3/swiper-bundle.m
    <title>Login/Register</title>in.css">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/common.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/theme.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/post_news.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/node_modules/@angular/material/prebuilt-themes/indigo-pink.css">
    <link rel="stylesheet" type="text/css" href="/Page/Login_Register.css">
    <style>
        .show{
            display: block !important;
        }
        .hidden{
            display: none !important;
        }
        #loginWithGG,.fb_iframe_widget {
            min-width: 200px;
            min-height: 50px;
            padding: 10px !important;
            border: 2px solid #4b7bca !important;
            border-radius: 10px;
            margin-bottom: 20px;
            margin-right: 20px;
         }

        #loginWithGG i,.fb_iframe_widget i{
            color: #3b71ca;
            margin-right: 10px;
        }
        #loginWithGG:hover,.fb_iframe_widget:hover{
            background-color:#3b71ca;
            color: white;
            cursor: pointer;
        }
        #loginWithGG:hover i,.fb_iframe_widget:hover i{
            color: white;
        }
        #login{
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;

        }

    </style>
</head>
<body>
<jsp:include page="../Component/header/Header.jsp" />

<div class="container" style="margin-top: 50px">
    <div class="wrapper">
        <h2 class="title_head" style="text-align: center; font-size: 40px; font-weight: bold; text-transform: uppercase; margin-bottom: 30px;">Đăng nhập</h2>
        <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="tab-login"  href="login" role="tab" >Đăng nhập</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="tab-register"  href="register"
                   >Đăng kí</a>
            </li>
        </ul>
        <!-- Pills navs -->

        <!-- Pills content -->
        <div class="tab-content" style="margin: auto;">
            <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                <hr/>
                <form class="form-login" style="width: 100%; margin: 30px 0">
                    <div class="text-center mb-3">
<%--                        <p>Sign in with</p>--%>

                    </div>

                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="loginName">Email/Tên đăng nhập</label>
                        <input type="text" id="loginName" class="form-control"/>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <label class="form-label" for="loginPassword">Mật khẩu</label>
                        <input type="password" id="loginPassword" class="form-control"/>
                    </div>

                    <!-- 2 column grid layout -->
                    <div class="row mb-4">
                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- Checkbox -->
                            <div class="form-check mb-3 mb-md-0">
                                <input class="form-check-input" type="checkbox" value="" id="loginCheck" checked/>
                                <label class="form-check-label" for="loginCheck"> Nhớ mật khẩu </label>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- Simple link -->
                            <a  class="link-forgot" href="forgotPass">Quên mật khâu?</a>
                        </div>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn btn-primary btn-block mb-4 login">Đăng nhập</button>
                    <div class="text-center">
                        <div id="login">
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:3000/login/loginWithGg&response_type=code
		   &client_id=108677386257-pqkllmloi7d9f60ipgvb053sfg9eosrr.apps.googleusercontent.com&approval_prompt=force" id="loginWithGG"><i class="fa-brands fa-google"></i>Đăng nhập với google</a>
                            <fb:login-button style="display: none;"  id="loginWithFb" scope="public_profile,email" onlogin="checkLoginState();">
                            </fb:login-button>
                            <a href="" id="loginFb"><i class="fa-brands fa-facebook"></i>Đăng nhập với facebook</a>
                            <style>
                                .btn-primary{
                                    width: 40%;
                                    margin-left: 50%;
                                    transform: translateX(-50%);
                                    padding: 5px;
                                    /*background: linear-gradient(to right, #00c10c 0%, #fff200 50%, #00c10c 100%);*/
                                    background: linear-gradient(to right, #135EAC 0%, #82e1d3 50%, #135EAC 100%);
                                    background-size: 300%, 1px;
                                    border: none;
                                    border-radius: 5px;
                                    color: white;
                                    transition: all .3s linear;
                                }

                                .btn-primary:hover{
                                    /*background: linear-gradient(to left, #00c10c 0%, #fff200 50%, #00c10c 100%) right;*/
                                    background: linear-gradient(to left, #135EAC 0%, #82e1d3 50%, #135EAC 100%) right;
                                    background-size: 300%, 1px;
                                }

                                #loginFb{
                                    text-decoration: none;
                                    min-width: 200px;
                                    min-height: 50px;
                                    padding: 10px;
                                    border: 2px solid #4b7bca;
                                    border-radius: 10px;
                                    margin-bottom: 20px;
                                    margin-right: 20px;
                                    cursor: pointer;
                                    color: #007bff;
                                }

                                #loginFb:hover{
                                    color: white;
                                    background-color: #3b71ca;
                                }

                                #loginFb i{
                                    margin-right: 10px;
                                }
                            </style>
                        </div>
                    </div>
                    <!-- Register buttons -->
<%--                    <div class="text-center">--%>
<%--                        <a  href="/">--%>
<%--                            <i class="fa-solid fa-backward"></i>--%>
<%--                            Trở về trang chủ--%>
<%--                        </a>--%>
<%--                    </div>--%>
                </form>
<%--                 forgot--%>

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
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>
<script>
    // document.querySelector(".upload-item").addEventListener("click", (e) => {
    //     document.querySelector(".fileupload").click()
    // })
</script>
<script>


    $('.login').bind('click', function (e) {
        e.preventDefault()
        $.ajax({
            url: "/login",
            type: "POST",
            data: {
                "username": $("#loginName").val(),
                "password": $("#loginPassword").val(),
            },
            contentType: "application/x-www-form-urlencoded",
            success: (data) => {
                console.log(data)
                if (data['message'] == "ok") {
                    swal({
                        title: "Thành công",
                        text: "Đăng nhập thành công",

                    }).then(()=>{
                        window.location.pathname = "/"
                    })
                    setTimeout(()=>{
                        window.location.pathname = "/"
                    },500)

                } else {
                    swal({
                        title: "Thất bại",
                        text: "Vui lòng đăng nhập lại( Có thể tài khoản của bạn đã bị khóa hoặc sai thông tin)",

                    })

                }


            }
        })
    });

</script>
<script>
    const handleRegisNext=()=>{
        $(".form1").css("display", "none")
        $(".form2").css("display", "block")
    }
    const handleRegisRevert=()=>{
        $(".form1").css("display", "block")
        $(".form2").css("display", "none")
    }
    const resetForm = () => {
        $("#registerUsername").val("")
        $("#registerFullname").val("")
        $("#registerEmail ").val("")
        $("#registerSdt ").val("")
        $("#registerPassword ").val("")
        $("#registerRepeatPassword").val("")
        $("#registerAddress").val("")
    }
    const handleForm = (name, fullName, email, sdt, passRepeat, pass, imgRequest, address) => {
        if (pass == passRepeat && name && fullName && email && sdt && pass && imgRequest && address) {
            return true
        }
        return false
    }
    var imgRequest='';
    $(".fileupload").bind("change", (e) => {
        var file = document.querySelector(".fileupload").files[0];
        var reader = new FileReader();
        reader.onloadend = function() {
            imgRequest= reader.result
            $(".uploadImg").attr("src",imgRequest)
        }
        reader.readAsDataURL(file);
    })

    var code;
    var name;
    var fullName;
    var email;
    var sdt;
    var pass;
    var passRepeat;
    var address;
    $(".register").bind("click", async function (e) {
        e.preventDefault()
        var codeVl = $(".code").val()
        console.log(name)
        console.log(fullName)
            if (handleForm(name, fullName, email, sdt, passRepeat, pass, imgRequest, address)) {
                dataBody = {
                    name: name,
                    fullName: encodeURIComponent(fullName),
                    email: email,
                    phone: sdt,
                    pass: pass,
                    avatar: imgRequest,
                    code: codeVl,
                    address: encodeURIComponent(address)
            }
                $.ajax({
                    url: "/register",
                    type: "POST",
                    data: dataBody,
                    contentType: 'application/x-www-form-urlencoded',
                    success: function (data) {
                        if (data['message'] == "register success") {
                            swal({
                                title: "Thành công",
                                text: "Chúc mừng bạn đã đăng ký thành công",

                            })
                            $(".uploadImg").attr("src", "/Img/User/${name}.jpg")
                            handleRegisRevert()
                            window.location.pathname = "Login.jsp"
                            resetForm()
                        } else {
                            if (data['message'] == "code sai") {
                                swal({
                                    title: "Thất bại",
                                    text: "Vui lòng nhập lại code",

                                })
                                $(".uploadImg").attr("src", "/Img/User/${name}.jpg")
                            } else {
                                swal({
                                    title: "Thành công",
                                    text: "Chúc mừng bạn đã đăng ký thành công",

                                })
                                window.location.pathname = "Login.jsp"
                                handleRegisRevert()
                                resetForm()
                            }
                        }


                    }
                });
            } else {
                swal({
                    title: "Thất bại",
                    text: "Vui lòng nhập lại thông tin",

                })
            }


    })
    $(".btn-code").click(function (e) {
        e.preventDefault()
        swal({
            title:"",
            text:"Loading...",
            icon: "https://www.boasnotas.com/img/loading2.gif",
            customClass: 'loading',
            buttons: false,
            closeOnClickOutside: false,
            timer: 16000,
            //icon: "success"
        });
        name = $("#registerUsername").val()
        fullName = $("#registerFullname").val()
        email = $("#registerEmail ").val()
        sdt = $("#registerSdt ").val()
        address = $("#registerAddress ").val()
        pass = $("#registerPassword ").val()
        passRepeat = $("#registerRepeatPassword").val()
        fetch("/sendMail?email=" + email)
            .then((resp) => {
                return resp.json()
                console.log(1)
            })
            .then((resp)=>{
                console.log(2)
                handleRegisNext()
            })
            .catch(()=>{
                alert("Email không tồn tại")
            })
    })
    $('#btn-forgot').click((e)=>{
        e.preventDefault();
        let usernameOrEmail=$('#forgot-user').val()
        fetch(`/forgotPass?username=}`+usernameOrEmail)
            .then(()=>{
                alert("Password đã được gửi về email của bạn")
            })
            .catch(()=>{
                alert("username không tồn tại")
            })

    })
    document.querySelector("#back-login").addEventListener("click",(e)=>{
        e.preventDefault()
        document.querySelector(".form-login").classList.toggle("hidden")
        document.querySelector(".form-forgot").classList.toggle("show")
    })
    document.querySelector("#e-forgot").addEventListener("click",(e)=>{
        e.preventDefault()
        document.querySelector(".form-login").classList.add("hidden")
        document.querySelector(".form-forgot").classList.add("show")
    })
</script>
<%--Login with fb--%>
<script>
    let isLoginInitiated = false; // Flag to track login initiation

    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        if (response.status === 'connected' && !isLoginInitiated) { // Check if login initiated flag is false
            isLoginInitiated = true; // Set login initiated flag to true
            testAPI();
        } else {
            document.getElementById('status').innerHTML = 'Please log into this webpage.';
        }
    }

    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function() {
        FB.init({
            appId: '2159772147554215',
            cookie: true,
            xfbml: true,
            version: 'v16.0'
        });
        document.getElementById('loginWithFb').addEventListener('click', function() {
            checkLoginState();
            this.disabled = true; // Disable the button after it is clicked
        });
    };
    document.querySelector("#loginFb").addEventListener('click',()=>{
        FB.login((res)=>{
            statusChangeCallback(res)
        })
        // checkLoginState()
    })
    function testAPI() {
        console.log('Welcome! Fetching your information....');
        FB.api('/me', function(response) {
            console.log(response);
            $.ajax({
                url: "/login/LoginWithFb",
                type: "POST",
                data: {
                    userName: response.id
                },
                contentType: 'application/x-www-form-urlencoded',
                success: function(data) {
                    swal({
                        title: "Thành công",
                        text: "Đăng nhập thành công",
                    }).then(() => {
                        window.location.pathname = "/";
                    });
                },
                complete: function() {
                    document.getElementById('loginWithFb').disabled = false; // Enable the button after the request is complete
                }
            });
        });
    }
</script>

</html>
