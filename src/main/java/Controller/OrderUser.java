package Controller;

import DAO.CompanyDAO;
import DAO.OderDAO;
import DAO.RoleDAO;
import DTO.Orders;
import DTO.Permission;
import Model.Company;
import Model.Oder;
import Model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/user/order")
public class OrderUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        try {
            ArrayList<Orders> list= OderDAO.getOrderByUser(user.getId());
            resp.getWriter().println(new Gson().toJson(list));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
