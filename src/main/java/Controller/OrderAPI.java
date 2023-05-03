package Controller;

import Beans.HashSHA216;
import DAO.OderDAO;
import DAO.ProductDAO;
import DAO.UserDAO;
import Model.Oder;
import Model.OrderDetail;
import Model.RespJsonServlet;
import Model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/api/order")
public class OrderAPI extends HttpServlet {
    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        try {
            ArrayList<Oder> orders = OderDAO.getOrder();
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
        String action = req.getParameter("action");
        if(action == null){
            res.setStatus(404);
            return;
        }
        switch (action){
            case "delete" :
                try {
                    deleteOrder(req,res);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "update_address":
                try {
                    updateAddress(req,res);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "check_add_orders_details":
                int id = Integer.valueOf(req.getParameter("id_product"));
                checkOrderDetails(req,res, id);
                break;
            case "update":
                try {
                    updateOrder(req,res);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:

        }
    }

    private void updateOrder(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        long idOrder = Long.valueOf(req.getParameter("idOrder"));
        String data = req.getParameter("data");
        String address = req.getParameter("address");
        if(address != null){
            Oder order = OderDAO.getOrderById(idOrder);
            order.setAddress(address);
            OderDAO.updateById(order);
        }
        ArrayList<String[]> arrData = new ArrayList<>();
        String[] dataSplit = data.split("\\|");
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
        res.getWriter().println(new Gson().toJson(OderDAO.getOrderById(idOrder)));
    }

    private void checkOrderDetails(HttpServletRequest req, HttpServletResponse res, int id_product) throws IOException {
       int quantity =  ProductDAO.getQuantityProductById(id_product);
        res.getWriter().println(new Gson().toJson(quantity));

    }

    private void updateAddress(HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
        String id = req.getParameter("id");
        Oder order = OderDAO.getOrderById(Long.valueOf(id));
        order.setAddress(req.getParameter("address"));
        res.getWriter().println(OderDAO.updateById(order));

    }

    private void deleteOrder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        String id = req.getParameter("id");
        if(id == null){
            res.setStatus(404);
            return;
        }
        res.getWriter().println(OderDAO.deleteOderById(Long.valueOf(id)));
    }
}