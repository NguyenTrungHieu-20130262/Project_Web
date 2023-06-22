package Controller;

import Utils.JWT;
import Connect.ConnectDB;
import DAO.*;
import Model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/order")
public class OrderControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String domain = req.getRequestURL().toString();

        if(user == null) {
            res.sendRedirect(domain.replace("/order","/login"));
            return;
        }
        String token_direct = (String) req.getSession().getAttribute("token_direct");
        String tokenUrl = req.getParameter("token_direct");
        if(tokenUrl != null){
            String token = JWT.getBodyJWT(tokenUrl);

            if(token.equals(token_direct)){
                Oder oder = (Oder) req.getSession().getAttribute("order");
                req.getSession().setAttribute("address", oder.getAddress());
                req.getSession().setAttribute("code", oder.getIdTransport());
                req.getSession().setAttribute("total", oder.getTotal_price());
                req.getRequestDispatcher("Component/OrderStatus/OrderStatus.jsp").forward(req,res);
                return;
            }else{
                req.getRequestDispatcher("Page/404.jsp").forward(req,res);
                return;
            }
        }
        try {
            boolean checkSum= PaymentVNPay.checkSum(req);
            if(checkSum== true){
                String idOrder = req.getParameter("vnp_OrderInfo");
                idOrder = idOrder.replaceAll("IdOrder:","");

                String rs = req.getParameter("vnp_ResponseCode");

                if(rs.equals("00")){
                    Model.Oder oder = OderDAO.getOrderById(Long.parseLong(idOrder));
                    User infoUser = UserDAO.getUserById(user.getId());
                    int[] address = TransportAPI.getInstance().getIdAddress(infoUser.getAddress());
                    String data =TransportAPI.getInstance().registerTransport(address[1],address[2], 1630,4140,1120,1044);
                    JSONObject object = new JSONObject(data);
                    String idTransport = object.getJSONObject("Transport").getString("id");
                    long leadTime =object.getJSONObject("Transport").getLong("leadTime");
                    Date date = new Date(new Date().getTime() + leadTime);
                    oder.setLeadTime(new java.sql.Date(date.getTime()));
                    oder.setIdTransport(idTransport);
                    oder.setStatus(1);
                    OderDAO.updateById(oder);
                    int rsUpdateOrder = OderDAO.updateById(oder);
                    String vnp_Amount = req.getParameter("vnp_Amount");
                    Date currentDate = new Date();
                    Payment payment = new Payment();
                    payment.setIdOrder(oder.getId());
                    System.out.println(vnp_Amount + "---VNPPAY---- "+ TransportAPI.convertMoney(vnp_Amount,false) );
                    payment.setAmount((double) TransportAPI.convertMoney(vnp_Amount,false));
                    payment.setPaymentDate(new java.sql.Date(currentDate.getTime()));
                    payment.setType(1);
                    payment.setStatus(1);
                    int rsPayment = PaymentDAO.insertPayment(payment);
                    if(rsPayment>0){
                        Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thanh toán qua VN_Pay(Payment)",1);
                        log.insert(ConnectDB.getConnect());
                    }
                    req.getSession().removeAttribute("token");
                    CartDAO.removeCartByUser(user.getId());
                    req.getSession().setAttribute("address", oder.getAddress());

                    req.getSession().setAttribute("leadTime", new Date(new Date().getTime()+ leadTime));
                    req.getSession().setAttribute("code", oder.getIdTransport());
                    req.getSession().setAttribute("total",(double) TransportAPI.convertMoney(vnp_Amount,false));
                    req.getRequestDispatcher("Component/OrderStatus/OrderStatus.jsp").forward(req,res);
                }else{
                    req.getRequestDispatcher("Page/404.jsp").forward(req,res);
                }

            }else{
                req.getRequestDispatcher("Page/404.jsp").forward(req,res);
            }

        } catch (SQLException | JSONException e) {
//            req.getRequestDispatcher("Page/404.jsp").forward(req,res);
            throw new RuntimeException(e);
        }


    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String domain = req.getRequestURL().toString();

        if(user == null) {
            res.sendRedirect(domain.replace("/order","/login"));
            return;
        }

        int pttt = Integer.valueOf(req.getParameter("pttt"));
        if(pttt == 0){
            directPayment(req,res);
        }else{
            res.setStatus(500);
          //  paymentVNPay(req,res);
        }
    }
    private void directPayment(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        CartDAO cs = new CartDAO();
        try {
            ArrayList<Cart> carts = cs.getAllCartByUser(user.getId());
            User userNew = UserDAO.getUserById(user.getId());
            long idOrder = new Date().getTime();
            Oder order =null;
            if(carts.size() > 0){
                order = new Oder();
                order.setIdUser(userNew.getId());
                order.setAddress(userNew.getAddress());
                String note = URLDecoder.decode(req.getParameter("note"), "UTF-8");
                order.setNote(note);
                order.setStatus(1);
                order.setId(idOrder);
                OderDAO.addOrder(order);

            int totalPrice = 0;
            int h = 0;
            int w = 0;
            int l = 0;
            int w2 = 0;
            carts = cs.getAllCartByUser(user.getId());
            System.out.println(carts.size());
            for (int i = 0; i < carts.size(); i++) {
                OderDAO.addOrderDetail(new OrderDetail(idOrder, carts.get(i).getProduct().getId(), carts.get(i).getQuantity(), carts.get(i).getProduct().getPrice()));
                totalPrice += carts.get(i).getQuantity() * carts.get(i).getProduct().getPrice();
                h += (carts.get(i).getQuantity()*carts.get(i).getProduct().getHeight());
                w += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWidth());
                l += (carts.get(i).getQuantity()*carts.get(i).getProduct().getLength());
                w2 += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWeight());
            }

            int[] address = TransportAPI.getInstance().getIdAddress(userNew.getAddress());
            String data =TransportAPI.getInstance().registerTransport(address[1], address[2],h,w,l,w2);
            if(data.contains("400 Bad Request")){
                String idTransport = "apiLoi";
                order.setIdTransport(idTransport);
                double money = 0;
                order.setTotal_price(TransportAPI.convertToUSD(money) + totalPrice);
                Payment payment = new Payment();
                payment.setIdOrder(order.getId());
                payment.setAmount(Double.valueOf(TransportAPI.convertToUSD(money) + totalPrice));
                payment.setPaymentDate(new java.sql.Date(new Date().getTime()));
                payment.setType(0);
                payment.setStatus(0);
                Date date = new Date(new Date().getTime() + new Random().nextInt(300) * 2000);
                order.setLeadTime(new java.sql.Date(date.getTime()));
                OderDAO.updateById(order);
                int rsPayment = PaymentDAO.insertPayment(payment);
                if(rsPayment>0){
                    Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thanh toán trực tiếp(Payment)",1);
                    log.insert(ConnectDB.getConnect());
                }
                CartDAO.removeCartByUser(user.getId());
                String domain = req.getRequestURL().toString();
                long dateTime = new Date().getTime();
                req.getSession().setAttribute("leadTime", date.getTime());
                req.getSession().setAttribute("order", order);

                String token = JWT.createJWT(dateTime+"",3);
                DateFormat formatter = new SimpleDateFormat("dd-M-yyyy hh:mm:ss");
                System.out.println(formatter.format(new Date(new Date().getTime() + 1682467199)));
                req.getSession().setAttribute("token_direct", dateTime + "");
                res.sendRedirect(domain +"?token_direct="+token);

                return;
            }
            JSONObject object = new JSONObject();
            String idTransport = object.getJSONObject("Transport").getString("id");
            order.setIdTransport(idTransport);
            double money =Double.parseDouble(object.getJSONObject("Transport").getString("fee"));
            order.setTotal_price(TransportAPI.convertToUSD(money) + totalPrice);
            Payment payment = new Payment();
            payment.setIdOrder(order.getId());
            payment.setAmount(Double.valueOf(TransportAPI.convertToUSD(money) + totalPrice));
            payment.setPaymentDate(new java.sql.Date(new Date().getTime()));
            payment.setType(0);
            payment.setStatus(0);
            long leadTime =object.getJSONObject("Transport").getLong("leadTime");
            Date date = new Date(new Date().getTime() + leadTime);
            order.setLeadTime(new java.sql.Date(date.getTime()));
            OderDAO.updateById(order);
            int rsPayment = PaymentDAO.insertPayment(payment);
                if(rsPayment>0){
                    Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thanh toán trực tiếp(Payment)",1);
                    log.insert(ConnectDB.getConnect());
                }
            CartDAO.removeCartByUser(user.getId());
            String domain = req.getRequestURL().toString();
            long dateTime = new Date().getTime();
            req.getSession().setAttribute("leadTime", new Date(new Date().getTime()+ leadTime));
            req.getSession().setAttribute("order", order);

            String token = JWT.createJWT(dateTime+"",3);
            DateFormat formatter = new SimpleDateFormat("dd-M-yyyy hh:mm:ss");
            System.out.println(formatter.format(new Date(new Date().getTime() + 1682467199)));
            req.getSession().setAttribute("token_direct", dateTime + "");
            res.sendRedirect(domain +"?token_direct="+token);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }
    private void paymentVNPay(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String domain = req.getRequestURL().toString();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        CartDAO cs = new CartDAO();
        try {
            ArrayList<Cart> carts = cs.getAllCartByUser(user.getId());
            User userNew = UserDAO.getUserById(user.getId());
            long idOrder = new Date().getTime();
            Oder oder = null;
            if(carts.size() > 0){
                 oder = new Oder();
                oder.setIdUser(userNew.getId());
                oder.setAddress(userNew.getAddress());
                String note = URLDecoder.decode(req.getParameter("note"), "UTF-8");
                oder.setNote(note);
                oder.setStatus(0);
                oder.setId(idOrder);
                OderDAO.addOrder(oder);

            }
            int totalPrice = 0;
            int h = 0;
            int w = 0;
            int l = 0;
            int w2 = 0;
            carts = cs.getAllCartByUser(user.getId());
            System.out.println(carts.size());
            for (int i = 0; i < carts.size(); i++) {
                OderDAO.addOrderDetail(new OrderDetail(idOrder, carts.get(i).getProduct().getId(), carts.get(i).getQuantity(), carts.get(i).getProduct().getPrice()));
                totalPrice += carts.get(i).getQuantity() * carts.get(i).getProduct().getPrice();
                h += (carts.get(i).getQuantity()*carts.get(i).getProduct().getHeight());
                w += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWidth());
                l += (carts.get(i).getQuantity()*carts.get(i).getProduct().getLength());
                w2 += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWeight());
            }
            int[] address = TransportAPI.getInstance().getIdAddress(userNew.getAddress());
            int money = TransportAPI.getInstance().calculateFee(address[1], address[2],h,w,l,w2);
            System.out.println(totalPrice + "--------------------------" + money);

            oder.setTotal_price(Double.valueOf(money + totalPrice));
            System.out.println(oder.getTotal_price() + "--------------------------" );

            OderDAO.updateById(oder);
            String[] resPayment = PaymentVNPay.createPayment(req,money + totalPrice,userNew.getEmail(),"IdOrder:" + idOrder, domain);
            String linkPayment = resPayment[0];
            res.sendRedirect( linkPayment);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    private void createOrder(ArrayList<Cart> carts){

    }
}
