package Controller;

import DAO.CompanyDAO;
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
@WebServlet("/company")
public class CompanyControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ArrayList<Company> list= CompanyDAO.getAllCompany();
            resp.getWriter().println(new Gson().toJson(list));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
