package Controller;

import Connect.ConnectDB;
import DAO.CompanyDAO;
import DAO.ProductDAO;
import Model.Log;
import Model.User;
import Upload.UploadImage;
import com.google.gson.Gson;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

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
    private static final int RECORDS_PER_PAGE = 10;


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
        if(action != null && action.equals("products")){
            getProducts(req,res);
            return;
        }
        if(action != null && action.equals("filter")){
            try {
                filterProductAndPage(req,res);
            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
            return;
        }
        int totalRecords = ProductDAO.countProduct();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
        req.getSession().setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("Page/Product.jsp").forward(req, res);
    }
    private  void getProducts(HttpServletRequest req, HttpServletResponse res) throws IOException {
        int currentPage = req.getParameter("page") != null ? Integer.valueOf(req.getParameter("page")) : 1;
        int offset = (currentPage - 1) * RECORDS_PER_PAGE;
        ArrayList<Model.Product> products = ProductDAO.getProductsWithOffset(offset, RECORDS_PER_PAGE);
        res.getWriter().write(new Gson().toJson(products));

    }
    private void filterProduct(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException {

            ArrayList<Model.Product> products = ProductDAO.filterProduct(req);
            int totalRecords = ProductDAO.countProductByFilter(req);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        JSONObject objRes = new JSONObject();
            objRes.put("data", new Gson().toJson(products));
            objRes.put("totalPages", totalPages);


        res.getWriter().println(objRes);

    }
    private void filterProductAndPage(HttpServletRequest req, HttpServletResponse res) throws IOException, JSONException {
        int currentPage = req.getParameter("page") != null ? Integer.valueOf(req.getParameter("page")) : 1;
        if(req.getParameter("page") == null){
            int totalRecords = ProductDAO.countProductByFilter(req);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
            ArrayList<Model.Product> products = ProductDAO.filterProductAndPage(0,RECORDS_PER_PAGE,req);
            JSONObject objRes = new JSONObject();
            objRes.put("data", new Gson().toJson(products));
            objRes.put("totalPages", totalPages);
            res.getWriter().println(objRes);
            return;
        }
        int offset = (currentPage - 1) * RECORDS_PER_PAGE;
        ArrayList<Model.Product> products = ProductDAO.filterProductAndPage(offset,RECORDS_PER_PAGE,req);
        res.getWriter().println(new Gson().toJson(products));

    }
    protected void getListProduct(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        ArrayList<Model.Product> products = ProductDAO.getProduct();
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
                    System.out.println(19823);
                    res.setStatus(200);
                }else {
                    res.setStatus(401);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPut(req, resp);
    }
}
