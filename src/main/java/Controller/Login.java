package Controller;

import Connect.ConnectDB;
import DAO.UserDAO;
import Model.Log;
import Model.RespJsonServlet;
import Model.User;
import Utils.HashSHA216;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/login")
public class Login extends HttpServlet {
    Map<Integer, Integer> listSpam = new HashMap();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("Page/Login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        HttpSession session = req.getSession(true);
        PrintWriter pw;
        String name = req.getParameter("username");
        String pass = HashSHA216.hash(req.getParameter("password"));
        try {
            if (UserDAO.checkLogin(name, pass)) {
                User user = UserDAO.getUserByName(name);
                saveSession(user, req);
                pw = resp.getWriter();
                Log log = new Log(Log.WARNING,user.getId() , this.getClass().getName(), "Đăng nhập" , 1);
                log.insert(ConnectDB.getConnect());
                delMap(user);
                pw.println(new RespJsonServlet("ok").json());
                pw.close();
            } else {
                if(UserDAO.checkName(name)){
                    User user = UserDAO.getUserByName(name);
                    checkSpam(user);
                }
                resp.getWriter().println(new RespJsonServlet("not ok").json());
                resp.setStatus(200);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void checkSpam(User user) throws SQLException {
        if (listSpam.containsKey(user.getId())) {
            int value = listSpam.get(user.getId());
            value++;
            listSpam.put(user.getId(), value);
            if (value >= 5) {
                Log log = new Log(Log.WARNING,-1 , this.getClass().getName(), "Spam Login lần thứ:"+value+" từ [idUser:" + user.getId() + "] ;address:" + user.getAddress(), 1);
                log.insert(ConnectDB.getConnect());
            }
        } else {
            listSpam.put(user.getId(), 1);
        }
    }
    public void delMap(User user) throws SQLException {
        if (listSpam.containsKey(user.getId())) {
            listSpam.put(user.getId(),0);
        }
    }

    public void saveSession(User user, HttpServletRequest req) {

        req.getSession().setAttribute("user", user);
        req.getSession().setMaxInactiveInterval(999999);
    }
}