package Controller;

import Connect.ConnectDB;
import DAO.CartDAO;
import DAO.TransportAPI;
import Model.Cart;
import Model.Log;
import Model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/api/address")
public class AddressAPI extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        if(req.getParameter("type").equals("province")){
            getProvince(req,res);
        }
        if(req.getParameter("type").equals("district")){
            getDistrict(req,res);

        }
        if(req.getParameter("type").equals("ward")){
            getWard(req,res);

        }
        if(req.getParameter("type").equals("fee")){
            calculateFee(req,res);

        }
    }

    private void calculateFee (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        String domain = req.getRequestURL().toString();

        if(user == null) {
            req.getRequestDispatcher("../Page/Login.jsp").forward(req,res);
            return;
        }
        ArrayList<Cart> carts = new ArrayList<>();
        CartDAO cs = new CartDAO();
        try {
            int h = 0;
            int w = 0;
            int l = 0;
            int w2 = 0;
            carts = cs.getAllCartByUser(user.getId());
            Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Select all cart by user",1);
            log.insert(ConnectDB.getConnect());
            for (int i = 0; i < carts.size(); i++) {
                System.out.println(carts.get(i).toString());
                h += (carts.get(i).getQuantity()*carts.get(i).getProduct().getHeight());
                w += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWidth());
                l += (carts.get(i).getQuantity()*carts.get(i).getProduct().getLength());
                w2 += (carts.get(i).getQuantity()*carts.get(i).getProduct().getWeight());
            }
            int money = TransportAPI.getInstance().calculateFee(2270, 231013,h,w,l,w2);
            res.getWriter().println(new Gson().toJson(money));

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    private void getProvince(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.getWriter().println(new Gson().toJson(TransportAPI.getInstance().getProvince()));
    }
    private void getDistrict(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int idProvince = Integer.valueOf(req.getParameter("idProvince"));
        res.getWriter().println(new Gson().toJson(TransportAPI.getInstance().getDistrict(idProvince)));
    }
    private void getWard(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int idDistrict = Integer.valueOf(req.getParameter("idDistrict"));
        res.getWriter().println(new Gson().toJson(TransportAPI.getInstance().getWard(idDistrict)));
    }
    protected void doPost (HttpServletRequest req, HttpServletResponse res){

    }
}
