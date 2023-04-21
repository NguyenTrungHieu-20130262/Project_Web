package Controller;

import DAO.UserDAO;
import Model.User;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user")
public class UserControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("choose").equals("delUser")) {
            delUser(req, resp);
        } else {
            if (req.getParameter("choose").equals("getInfoUser")) {
                try {
                    getInfoUser(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                } catch (JSONException e) {
                    throw new RuntimeException(e);
                }
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        updateUser(req, resp);
    }

    public void getInfoUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, JSONException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(req.getParameter("id"));
        User user = UserDAO.getUserById(id);
        JSONObject data = new JSONObject();
        data.put("id", user.getId());
        data.put("fullName", user.getFullName());
        data.put("role", user.getNameRole());
        data.put("phone", user.getPhone());
        data.put("email", user.getEmail());
        if (user.getStatus() == 1) {
            data.put("status", "Hoạt động");
        } else {
            data.put("status", "Đã khóa");
        }

        if (user != null) {
            resp.getWriter().write(data.toString());
            resp.setStatus(200);
        } else {
            resp.setStatus(400);
        }
    }

    public void delUser(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            if (UserDAO.delUSer(id) > 0) {
                resp.setStatus(200);
            } else {
                resp.setStatus(400);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUser(HttpServletRequest req, HttpServletResponse resp) {
        resp.setContentType("application/json");
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int phone = Integer.parseInt(req.getParameter("phone"));
        int role = Integer.parseInt(req.getParameter("role"));
        try {
            JSONObject jsonObject = new JSONObject();
            if (UserDAO.updateUserAdmin(id, name, phone, role) > 0) {
                jsonObject.put("status", "ok");
                resp.getWriter().println(jsonObject);
                resp.setStatus(200);
            } else {
                jsonObject.put("status", "not ok");
                resp.getWriter().println(jsonObject);
                resp.setStatus(400);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }
}
