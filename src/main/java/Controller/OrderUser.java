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
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

@WebServlet("/user/order")
public class OrderUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        try {
            ArrayList<Orders> list= OderDAO.getOrderDTO(user.getId());
            resp.getWriter().println(new Gson().toJson(list));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
            String action = req.getParameter("action");
            if(action != null){
                switch (action){
                    case "cancel":
                        try {
                            cancelOrder(req,res);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }

                        break;
                    default:

                }
            }

    }

    private void cancelOrder(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        ArrayList<Orders> list= OderDAO.getOrderDTO(user.getId());
        String idOder = req.getParameter("id");
        for (Orders tmp: list) {
            if(tmp.getId() == Long.valueOf(idOder)){
                Date dateTransport = tmp.getLeadTime();
                Date dateNow = new Date();
                if (dateTransport.getTime() < dateNow.getTime()) {
                    res.getWriter().println(-1);
                    return;
                } else{
                    tmp.setStatus(0);
                    int rs = OderDAO.updateById(tmp);
                    if(rs == 1){
                        res.getWriter().println(1);
                        return;
                    }
                    res.getWriter().println(0);
                }

                return;
            }
        }
    }
}
