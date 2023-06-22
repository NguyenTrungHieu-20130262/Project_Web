<%@ page import="Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<% User user = (User) request.getAttribute("userInfo") ;%>
<% String url = (String)request.getAttribute("url");%>
<aside class="app-sidebar">
    <div class="app-sidebar__user"><img style="width: 100px; height: 100px" class="app-sidebar__user-avatar" src="<%=user.getAvatar()!=null?user.getAvatar():url+"/Img/User/hideImage.png"%>" width="50px"
                                        alt="User Image">
        <div>
            <p class="app-sidebar__user-name"><b><%=user.getFullName()%>
            </b></p>
            <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
        </div>
    </div>
    <hr>
    <ul class="app-menu">
        <li><a class="app-menu__item " href="admin?page=index"><i class='app-menu__icon bx bx-tachometer'></i><span
                class="app-menu__label">Bảng điều khiển</span></a></li>
        <li><a class="app-menu__item" href="admin?page=post"><i
                class='app-menu__icon bx bx-cart-alt'></i>
            <span class="app-menu__label">POST Bán Hàng</span></a></li>
        <li><a class="app-menu__item " href="admin?page=userManagement"><i class='app-menu__icon bx bx-id-card'></i>
            <span class="app-menu__label">Quản lý tài khoản</span></a></li>
        <li><a class="app-menu__item" href="admin?page=userstatistic"><i class='app-menu__icon bx bx-task'></i><span
                class="app-menu__label">Thống kê tài khoản</span></a></li>
        <li><a class="app-menu__item" href="admin?page=productManagement"><i
                class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
        </li>
        <li><a class="app-menu__item" href="admin?page=productstaticstics"><i
                class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Thống kê sản phẩm</span></a>
        </li>
        <li><a class="app-menu__item" href="admin?page=oderManagement"><i class='app-menu__icon bx bx-package'></i><span
                class="app-menu__label">Quản lý đơn hàng</span></a></li>
        <li><a class="app-menu__item" href="admin?page=orderStatistics"><i class='app-menu__icon bx bx-stats'></i><span
                class="app-menu__label">Thống kê đơn hàng</span></a></li>
        <li><a class="app-menu__item" href="admin?page=role"><i class='app-menu__icon bx bxs-user-check'></i><span
                class="app-menu__label">Phân quyền</span></a></li>
        <li><a class="app-menu__item" href="admin?page=logstatistic"><i class='app-menu__icon bx bxs-bug'></i><span
                class="app-menu__label">Thống kê Log</span></a></li>
    </ul>
</aside>
</body>
<script !src="">
    var indexItem = parseInt('${param.page}')-1;
    document.querySelectorAll(".app-menu__item")[indexItem].classList.add("haha");

</script>
</html>
