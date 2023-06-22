<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
    <!-- Fontawesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" rel="stylesheet">
    <style>
        .success-message {
            color: #4CAF50;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .order-details {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .address-details i{
            font-size: 16px;
        }



        .fa-check-circle {
            color: #4CAF50;
            font-size: 80px;
        }

        .tracking-number {

        }


    </style>
</head>
<body>
<jsp:include page="../header/Header.jsp" />

<div class="container">
    <div style="display: flex; justify-content: center"><img src="../../Img/giaohang.png"/></div>
    <h1 class="success-message">Đơn hàng đã được xác nhận <i class="fas fa-check-circle" style="    font-size: 20px;
"></i></h1>
    <p class="order-details">Cảm ơn bạn đã đặt hàng của bạn. Các mặt hàng của bạn sẽ được giao sớm.</p>
    <p class="address-details"><i class="fa-sharp fa-solid fa-map"></i> Địa điểm: <%= request.getSession().getAttribute("address") %></p>
    <p class="address-details"><i class="fas fa-clock"></i> Thời gian dự kiến: <%= request.getSession().getAttribute("leadTime") %></p>
    <p class="address-details tracking-details"><i class="fa-solid fa-barcode"></i> Mã vận đơn:<span class="tracking-number">#<%= request.getSession().getAttribute("code") %></span></p>
    <p class="address-details price-details"><i class="fa-solid fa-money-bill"></i> Tổng tiền:<span class="total-number">$<%= request.getSession().getAttribute("total") %></span></p>
</div>
<br>
<br>
<br>

<jsp:include page="../footer/footer.jsp" />

</body>
</html>
