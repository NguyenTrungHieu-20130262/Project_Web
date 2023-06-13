package Controller;

import Beans.JWT;
import Connect.ConnectDB;
import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.Company;
import Model.Log;
import Model.Product;
import Model.User;
import Security.Authorizeds;
import Upload.UploadImage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/postProduct")
public class PostProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(Authorizeds.authorizeds(req,Authorizeds.PRODUCT_INSERT)){


        String pathRoot = (this.getServletContext().getRealPath("/"));
        resp.setContentType("application/json");
        try {
            String title = URLDecoder.decode(req.getParameter("title"), "UTF-8");
            String content = URLDecoder.decode(req.getParameter("content"), "UTF-8");
            String images = req.getParameter("images");
            Company idCompany = CompanyDAO.getIdByName(req.getParameter("nameCompany"));
            int year = Integer.parseInt(req.getParameter("yearofmanufacture"));
            User user = (User) req.getSession().getAttribute("user");
            String token = JWT.createJWT(String.valueOf(user.getId()), 365);
            ArrayList<String> listimgs = UploadImage.uploadAllFile(images, pathRoot, "post" + token, "Product");
            String fuel = URLDecoder.decode(req.getParameter("fuel"), "UTF-8");
            Float price = Float.parseFloat(req.getParameter("price"));
            String body = req.getParameter("body");
            int quantity = Integer.valueOf(req.getParameter("quantity"));
            int height = Integer.valueOf(req.getParameter("height"));
            int length = Integer.valueOf(req.getParameter("length"));
            int width = Integer.valueOf(req.getParameter("width"));
            int weight = Integer.valueOf(req.getParameter("weight"));
            Product pro = new Product(0,idCompany, title, content, body,year, fuel, price,null,listimgs,height, length, width, weight   );
            int rs = ProductDAO.insertProduct(user.getId(),pro, quantity);
            Log log=new Log(Log.INFO, user.getId(),this.getClass().getName(),"Thêm sản phẩm(Product)",1);
            log.insert(ConnectDB.getConnect());
            resp.sendError(200);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        }else{
            resp.setStatus(401);
        }
    }
}
