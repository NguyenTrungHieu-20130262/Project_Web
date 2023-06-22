package Controller;

import DAO.UserDAO;
import Model.RespJsonServlet;
import Model.Role;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login/LoginWithFb")
public class LoginWithFb extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username=req.getParameter("userName");
        System.out.println(123);
        try {
            User user=null;
            if(UserDAO.getUserByName(username)!=null){
                user=UserDAO.getUserByName(username);
                req.getSession().setAttribute("user",user);
            }else {
                user=new User(username, null,null,null,null,null,null,new Role(0),1,1);
                UserDAO.insertUser(user);
                req.getSession().setAttribute("user",user);
            }
            System.out.println(user);
            String contextPath = req.getContextPath();
            saveSession(user,req);
            resp.getWriter().write(new RespJsonServlet("ok").json());
            resp.setStatus(200);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    public void saveSession(User user, HttpServletRequest req){
        req.getSession().setAttribute("user",user);
    }
}
