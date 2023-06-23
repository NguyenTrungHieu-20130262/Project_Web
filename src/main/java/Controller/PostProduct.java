package Controller;

import Utils.JWT;
import Connect.ConnectDB;
import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.*;
import Model.Product;
import Security.Authorizeds;
import Upload.UploadImage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 50, // 2MB
        maxFileSize = 1024 * 1024 * 50,      // 50MB
        maxRequestSize = 1024 * 1024 * 100)  // 100MB
@WebServlet("/postProduct")
public class PostProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(Authorizeds.authorizeds(req,Authorizeds.PRODUCT_INSERT)){
        String pathRoot = (this.getServletContext().getRealPath("/"));
        resp.setContentType("application/json");
        try {
            String title = req.getParameter("title");
            String content = (req.getParameter("content"));
            String images = req.getParameter("images");
            Company idCompany = CompanyDAO.getIdByName(req.getParameter("nameCompany"));
            int year = Integer.valueOf((req.getParameter("yearofmanufacture")).trim());
            User user = (User) req.getSession().getAttribute("user");
            String token = JWT.createJWT(String.valueOf(user.getId()), 365);
            ArrayList<String> listimgs = UploadImage.uploadAllFile(images, pathRoot, "post" + token, "Product");
            String fuel = (req.getParameter("fuel"));
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
            resp.getWriter().println(new RespJsonServlet("oke").json());
            resp.setStatus(200);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        }else{
            resp.setStatus(401);
        }
    }
}
