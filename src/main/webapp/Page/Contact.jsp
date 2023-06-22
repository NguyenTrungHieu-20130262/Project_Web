<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 6/22/2023
  Time: 3:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liên hệ</title>
  <style>
    <%@include file="contact.css" %>
  </style>
</head>
<body>
<jsp:include page="../Component/header/Header.jsp" />
<div id="content">
  <!--Contact area start-->
  <div class="contact_area">
    <div class="container">
      <div class="row">
        <div class="col-lg-6 col-md-12">
          <div class="contact_message">
            <h3>Liên hệ với chúng tôi</h3>
            <p>Nếu bạn có bất cứ vấn đề hoặc thắc mắc nào có thể phản hồi với chúng tôi qua các cách
              thức liên lạc bên dưới.</p>
            <p>Hoặc có thể điền vào biểu mẫu bên cạnh để mô tả sơ lược về vấn đề mà bạn gặp phải.</p>
            <ul>
              <li><i class="fa-solid fa-location-dot"></i> Địa chỉ liên hệ: Tầng 29 Tòa Keangnam Landmark, KĐT mới Cầu Giấy, Phường Mễ Trì, Quận Nam Từ Liêm, TP. Hà Nội.
              </li>
              <li><i class="fa-solid fa-envelope"></i> Email nhận phản hồi: 20130254@st.hcmuaf.edu.vn
              </li>
              <li><i class="fa fa-phone"></i> Số điện thoại liên lạc: 0852995378</li>
            </ul>
          </div>
        </div>
        <div class="col-lg-6 col-md-12">
          <div class="contact_message form">
            <h3>Mô tả vấn đề của bạn</h3>
            <form id="contact-form" method="POST">
              <p>
                <label> Họ và tên (bắt buộc)</label>
                <input name="name" placeholder="Họ và tên*" type="text">
              </p>
              <p>
                <label> Địa chỉ email (bắt buộc)</label>
                <input name="email" placeholder="Địa chỉ email*" type="email">
              </p>
              <p>
                <label> Số điện thoại</label>
                <input name="subject" placeholder="Số điện thoại" type="text">
              </p>
              <div class="contact_textarea">
                <label> Mô tả vấn đề (bắt buộc)</label>
                <textarea placeholder="Mô tả*" name="message" class="form-control2"></textarea>
              </div>
              <div class="button_holder">
                <button type="submit"> Gửi</button>
              </div>
              <p class="form-messege"></p>
            </form>

          </div>
        </div>
      </div>
    </div>
  </div>
  <!--Contact area end-->

  <!--Map Location Begin-->
  <div class="map">
    <div class="map_location">
      <h3>Vị trí trên bản đồ:</h3>
      <iframe class="gmap_iframe" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?width=600&amp;height=400&amp;hl=en&amp;q=Keangnam Landmark&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe>

    </div>
  <!--Map Location End-->
</div>
<jsp:include page="../Component/footer/footer.jsp" />
</body>
</html>
