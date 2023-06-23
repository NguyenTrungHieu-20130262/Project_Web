package Controller;

import Connect.ConnectDB;
import DAO.UserDAO;
import Model.Log;
import Model.User;
import Security.Authorizeds;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user")
public class UserControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (req.getParameter("choose").equals("changeStatus")) {
            if(!Authorizeds.authorizeds(req, Authorizeds.USER_DEL)){
                resp.setStatus(401);
                return;
            }
            changeStatus(req, resp, user);

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
        User user = (User) req.getSession().getAttribute("user");
        if(Authorizeds.authorizeds(req, Authorizeds.USER_UPDATE)){
            updateUser(req, resp, user);
        }else{
            resp.setStatus(401);
        }
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
        data.put("address", user.getAddress());
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

    public void changeStatus(HttpServletRequest req, HttpServletResponse resp, User user) {
        int id = Integer.parseInt(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));
        try {
            if (UserDAO.changeStatus(id,status) > 0) {
                Log log = new Log(Log.WARNING, user.getId(), this.getClass().getName(), "Chỉnh sửa user(Admin)", 1);
                log.insert(ConnectDB.getConnect());
                resp.setStatus(200);
            } else {
                resp.setStatus(400);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUser(HttpServletRequest req, HttpServletResponse resp, User user) {
        resp.setContentType("application/json");
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int phone = Integer.parseInt(req.getParameter("phone"));
        String address = req.getParameter("address");
        try {
            JSONObject jsonObject = new JSONObject();
            if (UserDAO.updateUserAdmin(id, name, phone,address) > 0) {
                Log log = new Log(Log.WARNING, user.getId(), this.getClass().getName(), "Chỉnh sửa user(Admin)", 1);
                log.insert(ConnectDB.getConnect());
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
