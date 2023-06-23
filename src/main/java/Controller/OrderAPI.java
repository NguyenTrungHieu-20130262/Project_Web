package Controller;

import Connect.ConnectDB;
import DAO.OderDAO;
import DAO.ProductDAO;
import DTO.Orders;
import Model.Log;
import Model.Oder;
import Model.OrderDetail;
import Model.User;
import Security.Authorizeds;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/api/order")
public class OrderAPI extends HttpServlet {
    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        try {
            ArrayList<Orders> orders = OderDAO.getOrderDTO();
            res.getWriter().println(new Gson().toJson(orders));
            return;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        User user=(User)req.getSession().getAttribute("user");
        String action = req.getParameter("action");
        if(action == null){
            res.setStatus(404);
            return;
        }
        switch (action){
            case "delete" :
                if(Authorizeds.authorizeds(req, Authorizeds.ORDER_DEL))
                try {
                    deleteOrder(req,res,user);

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                else{
                    res.setStatus(401);
                }
                break;
            case "update_address":
                try {
                    updateAddress(req,res,user);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "check_add_orders_details":
                int id = Integer.valueOf(req.getParameter("id_product"));
                checkOrderDetails(req,res, id);
                break;
            case "update":
                if(Authorizeds.authorizeds(req, Authorizeds.ORDER_UPDATE))
                    try {
                    updateOrder(req,res,user);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                else res.setStatus(401);
                break;
            default:

        }
    }

    private void updateOrder(HttpServletRequest req, HttpServletResponse res,User user) throws SQLException, IOException {
        long idOrder = Long.valueOf(req.getParameter("idOrder"));
        String data = req.getParameter("data");
        String address = req.getParameter("address");
        String status = req.getParameter("status");
        Oder orderUpdate = OderDAO.getOrderById(idOrder);

        if(address != null){
            orderUpdate.setAddress(address);
        }
        if(status != null){
            orderUpdate.setStatus(Integer.valueOf(status));
        }
        if(address != null || status != null)
            OderDAO.updateById(orderUpdate);

        ArrayList<String[]> arrData = new ArrayList<>();
        String[] dataSplit;
        if(data != null)
            dataSplit = data.split("\\|");
        else
            dataSplit= new String[0];
        for (String tmp : dataSplit){
            arrData.add(tmp.split("-"));
        }
        for (String[] tmp : arrData){
            if(tmp[tmp.length- 1 ].equals("add")){
                double price = ProductDAO.getProductById(Integer.valueOf(tmp[0])).getPrice();
                OderDAO.addOrderDetail(new OrderDetail(idOrder,Integer.valueOf(tmp[0]), Integer.valueOf(tmp[1]), price));
            }
            if(tmp[tmp.length- 1 ].equals("update")){
                OderDAO.updateOrderDetailById(new OrderDetail(idOrder,Integer.valueOf(tmp[0]), Integer.valueOf(tmp[1]), 0));
            }
            if(tmp[tmp.length- 1 ].equals("delete")){
                OderDAO.deleteOderDetailsById(idOrder,Integer.valueOf(tmp[0]));
            }
            }
        ArrayList<OrderDetail> listOrderDetails = OderDAO.getAllOrderDetails(idOrder);
        double total = 0;
        for (OrderDetail tmp : listOrderDetails){
            total += tmp.getPrice() * tmp.getQuantity();
        }
        Oder order = OderDAO.getOrderById(idOrder);
        order.setTotal_price(total);
        OderDAO.updateById(order);
        Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thay đổi thông tin đơn hàng: [id= "+idOrder+"]",1);
        log.insert(ConnectDB.getConnect());
        res.getWriter().println(new Gson().toJson(OderDAO.getOrderById(idOrder)));
    }

    private void checkOrderDetails(HttpServletRequest req, HttpServletResponse res, int id_product) throws IOException {
       int quantity =  ProductDAO.getQuantityProductById(id_product);
        res.getWriter().println(new Gson().toJson(quantity));

    }

    private void updateAddress(HttpServletRequest req, HttpServletResponse res,User user) throws IOException, SQLException {
        String id = req.getParameter("id");
        Oder order = OderDAO.getOrderById(Long.valueOf(id));
        order.setAddress(req.getParameter("address"));
        Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thay đổi địa chỉ đơn hàng: [id= "+id+"]",1);
        log.insert(ConnectDB.getConnect());
        res.getWriter().println(OderDAO.updateById(order));

    }

    private void deleteOrder(HttpServletRequest req, HttpServletResponse res,User user) throws ServletException, IOException, SQLException {
        String id = req.getParameter("id");
        if(id == null){
            res.setStatus(404);
            return;
        }
        Log log=new Log(Log.WARNING, user.getId(),this.getClass().getName(),"Xóa đơn hàng: [id=  "+id+"]",1);
        log.insert(ConnectDB.getConnect());
        res.getWriter().println(OderDAO.deleteOderById(Long.valueOf(id)));
    }
}