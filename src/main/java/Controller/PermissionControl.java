package Controller;

import DAO.CompanyDAO;
import DAO.RoleDAO;
import DTO.Permission;
import Model.Company;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/api/permission")
public class PermissionControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ArrayList<Permission> list= RoleDAO.getPermission();
            resp.getWriter().println(new Gson().toJson(list));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
