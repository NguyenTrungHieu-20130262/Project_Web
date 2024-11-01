package Controller;

import Connect.ConnectDB;
import Model.Log;
import Utils.HashSHA216;
import Utils.JWT;
import Utils.SendEmail;
import DAO.UserDAO;
import Model.Role;
import Model.User;
import Model.VerifyRecaptcha;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/register")

public class Register extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("http://" + req.getHeader("host") + "/verifyAccount?token=");
        req.getRequestDispatcher("Page/Register.jsp").forward(req, res);

    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        if (!VerifyRecaptcha.verify(URLDecoder.decode(req.getParameter("captcha"), "UTF-8"))) {
            res.setStatus(401);
            res.getWriter().write("Captcha Error");
            return;
        }
        Map<String, String[]> params = req.getParameterMap();
        Map<String, String> data = new HashMap<>();
        for (Map.Entry<String, String[]> entry : params.entrySet()) {
            if (entry.getKey().trim().equals("username")) {
                try {
                    if (UserDAO.checkByUsername(URLDecoder.decode(entry.getValue()[0], "UTF-8"))) {
                        res.setStatus(401);
                        res.getWriter().write("Username already exists");
                        return;
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }

            }
            if (entry.getKey().trim().equals("email")) {
                try {
                    if (UserDAO.checkByEmail(URLDecoder.decode(entry.getValue()[0], "UTF-8"))) {
                        res.setStatus(401);
                        res.getWriter().write("Email already exists");
                        return;
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
            data.put(entry.getKey().trim(), URLDecoder.decode(entry.getValue()[0], "UTF-8"));
        }
        System.out.println("sdsds " + req.getParameter("address"));
        User user = null;
        user = new User(data.get("username"), HashSHA216.hash(data.get("password")), data.get("fullname"), data.get("email"), data.get("phone"), "", data.get("address"),new Role(0),0,0);
        try {
            int rs= UserDAO.insertUser(user);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String tokenUser = JWT.createJWT(user.getUserName(),6);
        SendEmail.getInstance().sendTokenVerify(user.getEmail(), "http://" + req.getHeader("host") + "/verifyAccount?token=" + tokenUser);
        Log log = new Log(Log.ALERT, user.getId(), this.getClass().getName(), "Đăng kí tài khoản: [userName:"+data.get("username")+"]", 1);
        try {
            log.insert(ConnectDB.getConnect());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.getSession().setAttribute("verifyAccount_" + user.getUserName(), user);
        req.getSession().setMaxInactiveInterval(JWT.TIMEOUT * 60);

        res.getWriter().write(1);
    }

}
