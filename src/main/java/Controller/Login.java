package Controller;

import Utils.HashSHA216;
import DAO.UserDAO;
import Model.RespJsonServlet;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("Page/Login.jsp").forward(req,res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        HttpSession session=req.getSession(true);
        PrintWriter pw;
        String name= req.getParameter("username");
        String pass= HashSHA216.hash(req.getParameter("password"));

        try {
            if(UserDAO.checkLogin(name,pass)){
                User user= UserDAO.getUserByName(name);
                saveSession(user,req);
                pw=resp.getWriter();
                pw.println(new RespJsonServlet("ok").json());
                pw.close();
            }else {
                resp.getWriter().println(new RespJsonServlet("not ok").json());
                resp.setStatus(200);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    public void saveSession(User user, HttpServletRequest req){

        req.getSession().setAttribute("user",user);
        req.getSession().setMaxInactiveInterval(999999);
    }
}