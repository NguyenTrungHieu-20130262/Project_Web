<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Title</title>
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Scripts/swiper-6.3.3/swiper-bundle.min.css">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/common.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/Styles/v2.0/theme.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/post_news.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/member/Styles/web/postnew-quick.css?v=638035266443576953">
    <link rel="stylesheet" href="https://oto.com.vn/node_modules/@angular/material/prebuilt-themes/indigo-pink.css">
    <style>
        <%@include file="index.css"%>
    </style>
</head>
<body>
<form class="editForm ng-pristine ng-invalid ng-touched" novalidate="">
    <div class="container postnews make-form">
        <div class="gr-heading-post">
            <h2 class="heading">Thông tin xe</h2>
            <span class="status-per per2"></span>
        </div>
        <div class="control mt-20" style="margin-top: 20px">
            <label class="lbl-form">Hãng xe</label>
            <select class="form-select" aria-label="Default select example">
                <c:forEach items="${listCompany}" var="item">
                    <option class="${item.id}">${item.name}</option>
                </c:forEach>
            </select>
            <mat-autocomplete class="mat-autocomplete">
            </mat-autocomplete>
        </div>
        <div class="control year">
            <label class="lbl-form">Năm sản xuất</label>
            <div class="list-year">
                <!---->
            </div>
            <div class="clear">
                Hiển thị thêm
            </div>
        </div>
        <div class="control">
            <label class="lbl-form sm-lh">Kích thước</label>
            <ul class="status-group listkt">
                <li>
                    <div class="main_kt">
                        <label>Height(cm)</label>
                        <input class="select_kt" name="height" />
                    </div>
                </li>
                <li>
                    <div class="main_kt">
                        <label>Length(cm)</label>
                        <input class="select_kt" name="length" />
                    </div>
                </li>
                <li>
                    <div class="main_kt">
                        <label>Width(cm)</label>
                        <input class="select_kt" name="width" />
                    </div>
                </li>
                <li>
                    <div class="main_kt">
                        <label>Weight(gram)</label>
                        <input class="select_kt" name="weight" />
                    </div>
                </li>
            </ul>
        </div>
        <div class="control">
            <label class="lbl-form sm-lh">Hộp số</label>
            <ul class="status-group status-group-small">
                <li>
                    <input class="hide" id="transmission1" name="transmission" value="0" type="radio" />
                    <label class="free-label" for="transmission1">Số tay</label>
                </li>
                <li>
                    <input class="hide" id="transmission2" name="transmission" value="1" type="radio" />
                    <label class="free-label" for="transmission2">Số tự động</label>
                </li>
            </ul>
        </div>
        <div class="control">
            <label class="lbl-form sm-lh">Nhiên liệu</label>
            <ul class="status-group group-three">
                <li>
                    <input class="hide" id="fuelType1" name="fuelType" value="Xăng" type="radio" />
                    <label class="free-label" for="fuelType1">Xăng</label>
                </li>
                <li>
                    <input class="hide" id="fuelType4" name="fuelType" value="Dầu" type="radio" />
                    <label class="free-label" for="fuelType4">Dầu</label>
                </li>
            </ul>
            <!---->
        </div>
        <!---->
        <div class="control">
            <label class="lbl-form sm-lh">Tình trạng</label>
            <ul class="status-group">
                <li>
                    <input class="hide" id="old" name="radio2" value="1" type="radio" />
                    <label class="free-label" for="old">Đã qua sử dụng</label>
                </li>
                <li>
                    <input class="hide" id="new" name="radio2" value="0" type="radio" />
                    <label class="free-label" for="new">Mới</label>
                </li>
            </ul>
            <!---->
        </div>
        <!---->
        <div class="control">
            <label class="lbl-form" for="">Giá bán</label>
            <div class="my-input-container">
                <input class="inp ng-pristine ng-invalid error ng-touched" formcontrolname="Price" id="Price" maxlength="12"
                       placeholder="Nhập giá bán của xe (Đơn vị: triệu VNĐ)" style="width: 100%;" type="text" />
                <!---->
                <span class="tmpPrice" style="visibility: hidden;"></span>
            </div>
            <!---->
            <div class="control">
                <label class="lbl-form" for="">Số lượng</label>
                <div class="my-input-container">
                    <input class="inp ng-pristine ng-invalid error ng-touched" formcontrolname="Price" id="quantity" maxlength="12"
                           placeholder="Số lượng" style="width: 100%;" type="text" />
                    <!---->
                    <span class="tmpPrice" style="visibility: hidden;"></span>
                </div>
                <div class="control">
                    <label class="lbl-form">Kiểu dáng</label>
                    <div class="my-input-container">
                        <input class="inp ng-pristine ng-invalid error ng-touched" formcontrolname="Price" id="body" maxlength="12"
                               placeholder="Nhập kiểu dáng xe" style="width: 100%;" type="text" />
                        <!---->
                        <span class="tmpPrice" style="visibility: hidden;"></span>
                    </div>
                    <!---->
                    <div class="txt-right">
                        <!---->
                        <div class="msg-error">
                            <span style="display: none" class="txt">Vui lòng nhập giá xe đúng định dạng</span>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    </div>
</form>
<script src="javascrip/index.js"></script>
</body>
</html>
