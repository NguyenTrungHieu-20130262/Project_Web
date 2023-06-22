<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Product" %>
<%@ page import="DAO.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style>
        <%@include file="home.css"%>
    </style>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://staticfile.oto.com.vn/dist/web/styles/theme.min.css.gz?v=638029584077979519">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://staticfile.oto.com.vn/dist/web/styles/logo-car.min.css.gz?v=638032818151165956">
    <link rel="stylesheet" as="style"
          href="https://staticfile.oto.com.vn/dist/web/styles/slide-brand.min.css.gz?v=638032818151165956">
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>

</head>
<body>
<jsp:include page="/Component/header/Header.jsp"/>
<style>
    /*Slide Show Begin*/
    #slideShow {
        overflow: hidden;
    }

    #slideShow .mySlides {
        margin: 0 12vw;
        width: 1400px;
        height: 600px;
    }


    @keyframes scale-display {
        0% {
            opacity: 0;
            transform: scale(0.9);
        }
        100% {
            opacity: 1;
            transform: scale(1);
        }
    }

    #slideShow .dotList {
        position: absolute;
        bottom: 20px;
        left: 50%;
    }

    #slideShow .dotList .dot {
        font-size: 8px;
        padding: 0 5px;
        background-color: #b7abab;
        border-radius: 50px;
        margin: 0 auto;
    }

    /*Slide Show End*/
    /*Content Main Page Begin*/
    #content {
        padding-top: 24px;
    }

    #content .container .products-new .products-trend{
        margin-bottom: 70px;
    }
    /*Product Content Begin*/
    #content .product-title {
        margin: 20px 0;
        display: flex;
        justify-content: space-between;
    }

    #content .product-title .section-title {
        font-size: 20px;
        padding: 10px 0;
        text-transform: uppercase;
        border-bottom: 3px solid #135EAC;
        border-radius: 2px;
        position: relative;
    }

    #content .product-title .more-product {
        margin: 10px 0;
        background: #006fc9;
        color: #ffffff;
        font-size: 15px;
        font-weight: 600;
        padding: 5px 10px;
        border-radius: 50px;
        text-decoration: none;
    }

    #content .section-title i {
        color: #fa8c16;
        margin-right: 10px;
    }

    #content .products {
        display: grid;
        grid-gap: 1rem;
        grid-template-columns: repeat(4, 1fr);
    }

    #content .product-item {
        border: 1px solid #e5e5e5;
        border-radius: 10px;

    }

    #content .product-item a {
        text-decoration: none;
    }

    #content .product-item .product-image {
        width: 256px;
        height: 180px;
        margin: 5px 8px;
        border-radius: 10px;
    }

    #content .product-item .product-type {
        font-size: 15px;
        font-weight: bold;
        opacity: .7;
        margin-top: 5px;
        margin-left: 10px;
    }

    #content .product-item .product-star .number-of-stars {
        color: #fff200;
        font-size: 20px;
    }

    #content .product-item .product-name {
        font-size: 16px;
        color: #135EAC;
        margin-bottom: 10px;
        margin-left: 10px;
    }

    #content .product-item .product-price {
        display: flex;
        justify-content: space-evenly;
        font-weight: 700;
        font-size: 18px;
        margin-top: 10px;
    }

    #content .product-item .product-old-price {
        color: #b5b5b5;
    }

    #content .product-item .product-choose {
        margin: 10px 0 20px 0px;
        visibility: hidden;
        padding: 0 20px;
        transform: translateY(20px);
        opacity: 0;
        transition: all .25s linear;

    }

    #content .product-item:hover .product-choose {
        visibility: visible;
        transform: translateY(0);
        opacity: 1;
    }

    #content .product-item .product-choose > button {
        width: 100%;
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

    #content .product-item .product-choose > button:hover {
        /*background: linear-gradient(to left, #00c10c 0%, #fff200 50%, #00c10c 100%) right;*/
        background: linear-gradient(to left, #135EAC 0%, #82e1d3 50%, #135EAC 100%) right;
        background-size: 300%, 1px;

    }

    #content .product-item .product-choose .detail {
        margin-left: 0px;
    }

    #content .product-item .product-choose .detail a {
        color: #ffffff;
    }

    #content .product-item .product-choose .add-to-cart i,
    #content .product-item .product-choose .detail i {
        margin: 0 5px;
    }
    /*Product Content End*/
    /*Content Main Page End*/
</style>
<div id="main">
    <!--    Begin SlideShow-->
    <div id="slideShow">
        <div class="position-relative">
            <img class="mySlides" src="Img/slide%201.jpg" alt="">
            <img class="mySlides" src="Img/slide%202.jpg" alt="">
            <img class="mySlides" src="Img/slide%203.png" alt="">
            <div class="dotList">
                <span class="dot" onclick="currentDiv(1)"></span>
                <span class="dot" onclick="currentDiv(2)"></span>
                <span class="dot" onclick="currentDiv(3)"></span>
            </div>
        </div>
    </div>
</div>
<!--    End SlideShow-->
<!--    Begin Content-->
<div id="content">
    <div class="container">
        <div class="products-new">
            <div class="product-title">
                <h3 class="section-title"><i class="fa-solid fa-bolt"></i>Sản Phẩm Mới</h3>
                <a class="more-product" href="/product">Xem thêm</a>
            </div>
            <span class="heading_divider"></span>
            <div class="products">
                <%  ProductDAO productDAO = new ProductDAO();
                    ArrayList<Model.Product> newProducts = productDAO.getNewProducts();
                    for (Product p: newProducts) {
                %>
                <div class="product-item">
                    <a href="details?id=<%= p.getId()%>">
                        <img class="product-image" src="<%= p.getImages().get(0).toString()%>" alt="">
                    </a>
                    <p class="product-type"><%= p.getVendo().getName()%></p>
                    <a href="details?id=<%= p.getId()%>"><p class="product-name"><%= p.getName()%></p></a>
                    <div class="product-star text-center">
                            <span class="number-of-stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </span>
                    </div>
                    <div class="product-price">
                        <del class="product-old-price">80.000<span class="currency">USD</span></del>
                        <span class="product-new-price"><%= p.getPrice()%><span class="currency">USD</span></span>
                    </div>
                    <div class="product-choose">
                        <button class="add-to-cart" onclick="addToCart(<%= p.getId()%>)">
                            <i class="fa-solid fa-cart-plus"></i>Thêm Vào Giỏ
                        </button>
                    </div>
                </div>
                <%}%>
        </div>
        <div class="products-trend">
            <div class="product-title d-flex justify-content-between">
                <h3 class="section-title mb-0"><i class="fa-solid fa-arrow-trend-up"></i>Sản Phẩm Thịnh Hành</h3>
                <a class="more-product" href="/product">Xem thêm</a>
            </div>
            <div class="products">
                <%
                    ArrayList<Model.Product> trendProducts = productDAO.getTrendProducts();
                    for (Product p: trendProducts) {
                %>
                <div class="product-item">
                    <a href="details?id=<%= p.getId()%>">
                        <img class="product-image" src="<%= p.getImages().get(0).toString()%>" alt="">
                    </a>
                    <p class="product-type"><%= p.getVendo().getName()%></p>
                    <a href="details?id=<%= p.getId()%>"><p class="product-name"><%= p.getName()%></p></a>
                    <div class="product-star text-center">
                            <span class="number-of-stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </span>
                    </div>
                    <div class="product-price">
                        <del class="product-old-price">80.000<span class="currency">USD</span></del>
                        <span class="product-new-price"><%= p.getPrice()%><span class="currency">USD</span></span>
                    </div>
                    <div class="product-choose">
                        <button class="add-to-cart" onclick="addToCart(<%= p.getId()%>)">
                            <i class="fa-solid fa-cart-plus"></i>Thêm Vào Giỏ
                        </button>
                    </div>
                </div>
                <%}%>

        </div>
    </div>
</div>
<div class="box-tab-home ui-tabs ui-corner-all ui-widget ui-widget-content" id="tabs">
    <div class="container" id="box-home">
        <div class="menu-tab">
            <ul class="">
                <li><a href="/Page/Product.jsp" data-id="carnew"><h2>Mua xe mới</h2></a></li>
                <li><a href="/Page/Product.jsp" data-id="carold"><h2>Tìm xe cũ</h2></a></li>
                <li><a href="/Page/PostStatus/Img" data-id="buycar"><h2>Đăng tin ngay</h2></a></li>
            </ul>
        </div>
        <div class="slide-selling-brand"><h2 class="heading">Hãng xe bán chạy nhất</h2>
            <div class="box-list-slide" id="makeBestSaleCar">
                <button class="btn-button btn-prev swiper-button-disabled"
                        data-gtm-vis-first-on-screen-13008071_911="1533"
                        data-gtm-vis-total-visible-time-13008071_911="200" data-gtm-vis-has-fired-13008071_911="1"><i
                        class="fa-solid fa-circle-chevron-left"></i>
                    <button class="btn-button btn-next" data-gtm-vis-recent-on-screen-13008071_911="1534"
                            data-gtm-vis-first-on-screen-13008071_911="1534"
                            data-gtm-vis-total-visible-time-13008071_911="10000"
                            data-gtm-vis-has-fired-13008071_911="1"><i
                            class="fa-solid fa-circle-chevron-right"></i></button>
                    <div class="list-slide brandall-car swiper-container swiper-container-horizontal">
                        <div class="slide swiper-wrapper">
                            <div class="item i-toyota swiper-slide swiper-slide-active" style="width: 190px;"><a

                            <%--                                    Gọi Api--%>
                                    href="#"> <span
                                    data-gtm-vis-recent-on-screen-13008071_909="1419"
                                    data-gtm-vis-first-on-screen-13008071_909="1419"
                                    data-gtm-vis-total-visible-time-13008071_909="100"
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3> Toyota</h3> </span>
                            </a></div>
                            <div class="item i-hyundai swiper-slide swiper-slide-next" style="width: 190px;">
                                <a
                                        href="#"> <span
                                        data-gtm-vis-has-fired-13008071_909="1"> <h3>Hyundai</h3> </span> </a>
                            </div>
                            <div class="item i-vinfast swiper-slide" style="width: 190px;"><a
                                    href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Vinfast</h3> </span> </a></div>
                            <div class="item i-kia swiper-slide" style="width: 190px;"><a href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>KIA</h3> </span> </a></div>
                            <div class="item i-ford swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Ford</h3> </span> </a></div>
                            <div class="item i-mazda swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Mazda</h3> </span> </a></div>
                            <div class="item i-honda swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Honda</h3> </span> </a></div>
                            <div class="item i-mitsubishi swiper-slide" style="width: 190px;"><a
                                    href="#"> <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Mitsubishi</h3> </span>
                            </a></div>
                            <div class="item i-peugeot swiper-slide" style="width: 190px;"><a
                                    href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Peugeot</h3> </span> </a></div>
                            <div class="item i-mercedes-benz swiper-slide" style="width: 190px;"><a
                                    href="#"> </span>
                                <span
                                        data-gtm-vis-has-fired-13008071_909="1"> <h3>Hyundai</h3> </span> </a></div>
                            <div class="item i-vinfast swiper-slide" style="width: 190px;"><a
                                    href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Vinfast</h3> </span> </a></div>
                            <div class="item i-kia swiper-slide" style="width: 190px;"><a href="./Filter.jsp"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>KIA</h3> </span> </a></div>
                            <div class="item i-ford swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Ford</h3> </span> </a></div>
                            <div class="item i-mazda swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Mazda</h3> </span> </a></div>
                            <div class="item i-honda swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Honda</h3> </span> </a></div>
                            <div class="item i-mitsubishi swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Mitsubishi</h3> </span>
                            </a></div>
                            <div class="item i-peugeot swiper-slide" style="width: 190px;"><a
                                    href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Peugeot</h3> </span> </a></div>
                            <div class="item i-mercedes-benz swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Mercedes</h3> </span>
                            </a></div>
                            <div class="item i-lexus swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Lexus</h3> </span> </a></div>
                            <div class="item i-suzuki swiper-slide" style="width: 190px;"><a href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Suzuki</h3> </span> </a></div>
                            <div class="item i-bmw swiper-slide" style="width: 190px;"><a href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>BMW</h3> </span> </a></div>
                            <div class="item i-nissan swiper-slide" style="width: 190px;"><a href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Nissan</h3> </span> </a></div>
                            <div class="item i-audi swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Audi</h3> </span> </a></div>
                            <div class="item i-porsche swiper-slide" style="width: 190px;"><a
                                    href="#">
                                <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Porsche</h3> </span> </a></div>
                            <div class="item i-landrover swiper-slide" style="width: 190px;"><a
                                    href="#"> <span data-gtm-vis-has-fired-13008071_909="1"> <h3>Landrover</h3> </span>
                            </a></div>
                            <div class="item i-mini swiper-slide" style="width: 190px;"><a
                                    href="#"> <span
                                    data-gtm-vis-has-fired-13008071_909="1"> <h3>Mini</h3> </span> </a></div>
                        </div>
                    </div>
            </div>
            <div class="content-tab" id="content-tab" data-gtm-vis-recent-on-screen-13008071_367="876"
                 data-gtm-vis-first-on-screen-13008071_367="876" data-gtm-vis-total-visible-time-13008071_367="100"
                 data-gtm-vis-has-fired-13008071_367="1">
                <div id="carnew" class="content-box"><h2 class="heading">Tin rao mới nhất</h2>
                    <div class="list-item-car">
                        <div class="row">
                            <%--                        ForProduct--%>
                            <%@include file="/Component/Item/Home/Car.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <jsp:include page="/Component/footer/footer.jsp"/>
</body>
<script>
    // slide show and auto slide show
    let slideIndex = 1;
    showDivs(slideIndex);
    carousel();

    function currentDiv(n) {
        slideIndex = n;
        showDivs(slideIndex);
    }

    function showDivs(n) {
        let x = document.getElementsByClassName('mySlides');
        let dots = document.getElementsByClassName('dot');
        if (n > x.length) {
            slideIndex = 1;
        }
        if (n < 1) {
            slideIndex = x.length;
        }
        for (let i = 0; i < x.length; i++) {
            x[i].style.display = "none";
            dots[i].style.background = "";
            dots[i].style.padding = "0 5px";


        }
        x[slideIndex - 1].style.display = "block";
        x[slideIndex - 1].style.animation = "scale-display .5s";
        dots[slideIndex - 1].style.background = "#0f9d58";
    }

    // Auto next slide
    function carousel() {
        let x = document.getElementsByClassName("mySlides");
        let dots = document.getElementsByClassName('dot');
        for (let i = 0; i < x.length; i++) {
            x[i].style.display = "none";
            dots[i].style.background = "";
            dots[i].style.padding = "0 5px";
        }
        if (slideIndex > x.length) {
            slideIndex = 1
        }
        ;x[slideIndex - 1].style.display = "block";
        x[slideIndex - 1].style.animation = "scale-display .7s";
        dots[slideIndex - 1].style.background = "#0f9d58";
        setTimeout(carousel, 3000); // Change image every 2 seconds
        slideIndex++;
    }
    const addToCart = (id)=>{
        $.ajax({
            url: "/cart?action=addtocart&idpost="+id,
            type: 'POST',
            success: function(res) {
                console.log(res)
                console.log(typeof  res)
                if(res =='1' || res =='0'){
                    if(res !='1'){
                        swal("Sản phẩm đã hết", {
                            buttons: false,
                            timer: 500,
                        });
                    }else{
                        console.log(res)
                        swal("Đã thêm sản phẩm vào giỏ hàng", {
                            buttons: false,
                            timer: 500,
                        });
                    }
                }else{
                    window.location = '/login'
                }





            }
        });
        console.log(id)


    }
</script>
<script src="/jsadmin/bootstrap.min.js"></script>
<script src="/EventJs/Swipper.js">
</script>

</html>
