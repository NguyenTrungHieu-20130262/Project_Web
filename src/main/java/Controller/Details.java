package Controller;

import Connect.ConnectDB;
import DAO.CommentDAO;
import DAO.ProductDAO;
import Model.Comment;
import Model.Log;
import Model.Product;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/details")
public class Details extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        req.setAttribute("id", id);
        if (id == null) {
            req.getRequestDispatcher("Page/404.jsp").forward(req, res);
            return;
        }
        try {
            List<Comment> list = CommentDAO.getListComment(Integer.valueOf(id));
            req.setAttribute("listComment", list);
            Product product = ProductDAO.getProductById(Integer.valueOf(id));
            req.setAttribute("product", product);
            req.getRequestDispatcher("Page/Detail.jsp").forward(req, res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
