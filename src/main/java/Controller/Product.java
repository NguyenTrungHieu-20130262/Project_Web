package Controller;

import Connect.ConnectDB;
import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.Log;
import Model.User;
import Upload.UploadImage;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/product")
public class Product extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        String action = req.getParameter("action");
        if(action != null && action.equals("getlistproduct")){
            try {
                getListProduct(req,res);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return;
        }

        req.getRequestDispatcher("Page/Product.jsp").forward(req, res);
    }
    protected void getListProduct(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        ArrayList<Model.Product> products = ProductDAO.getProduct();
        for(Model.Product tmp :products ){
            System.out.println(tmp.toString());

//            tmp.setContent(URLEncoder.encode(tmp.getContent(), StandardCharsets.UTF_8));
//            tmp.setName(tmp.getName());
//            tmp.setFuel(tmp.getFuel());
        }
        res.getWriter().write(new Gson().toJson(products));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String pathRoot=(this.getServletContext().getRealPath("/"));
        User user=(User)req.getSession().getAttribute("user");
        if(action != null && action.equals("delete")){
            try {
                int rs =  ProductDAO.deleteProduct(Integer.valueOf(req.getParameter("id")));
                if(rs>0){
                    Log log=new Log(Log.WARNING, user.getId(),this.getClass().getName(),"Xóa sản phẩm(Admin)",1);
                    log.insert(ConnectDB.getConnect());
                }
                res.getWriter().write(new Gson().toJson(rs));
                return;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        }
        String idUpdate = req.getParameter("editProduct");

        if(idUpdate != null ){
            req.setCharacterEncoding("UTF-8");
            res.setContentType("text/html;charset=UTF-8");
            res.setCharacterEncoding("UTF-8");
            int status=Integer.valueOf(req.getParameter("status"));
            String title=URLDecoder.decode(req.getParameter("title"), "UTF-8");
            String content=URLDecoder.decode(req.getParameter("content"), "UTF-8");
            String images=req.getParameter("images");
            int idCompany= 0;
            try {
                idCompany = CompanyDAO.getIdByName(req.getParameter("nameCompany")).getId();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            int year=Integer.parseInt(req.getParameter("yearofmanufacture"));
            if(images !=null){
                ArrayList<String> listimgs= UploadImage.uploadAllFile(images,pathRoot,"post"+String.valueOf(idCompany),"Product");
                String rsImg="";
                for (String tmp : listimgs) {
                    rsImg+=tmp+"||";
                }
                System.out.println(rsImg);
            }

            int gear=Integer.valueOf(req.getParameter("gear"));
            String fuel= URLDecoder.decode(req.getParameter("fuel"), "UTF-8");
            Float price=Float.parseFloat(req.getParameter("price"));
            String body=req.getParameter("body");
            String made = URLDecoder.decode(req.getParameter("made"), "UTF-8");
            int quantity = Integer.valueOf(req.getParameter("quantity"));
            int id = Integer.valueOf(idUpdate);
            int rs = 0;
            try {
                rs = ProductDAO.updateProduct(id, title, content, body, made, gear, idCompany, year, status, fuel, price, quantity);
                if(rs>0){
                    Log log=new Log(Log.WARNING, user.getId(),this.getClass().getName(),"Chỉnh sửa Product(Admin)",1);
                    log.insert(ConnectDB.getConnect());
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            res.getWriter().write(new Gson().toJson(rs));
                return;
        }

    }

}
