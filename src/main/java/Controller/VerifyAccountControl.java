package Controller;

import Utils.JWT;
import DAO.UserDAO;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet(name = "verifyAccount", value = "/verifyAccount")

public class VerifyAccountControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType( "text/html" );
        res.setCharacterEncoding("UTF-8");
        String body = "";
        try{
            body = JWT.getBodyJWT(req.getParameter("token"));
        }catch (Exception e){
            req.getRequestDispatcher("Component/VerifyAccount/VerifyAccountError.jsp").forward(req,res);
            return;
        }
        User user = (User) req.getSession().getAttribute("verifyAccount_" + body.trim());
        if(user == null){
            req.getRequestDispatcher("Component/VerifyAccount/VerifyAccountError.jsp").forward(req,res);
            return;
        }
        int rs = 0;
        try {

            if(UserDAO.updateStatus(user.getUserName(), 1) == 1){
                rs = 1;
                req.getSession().removeAttribute("verifyAccount_" + body.trim());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if(rs ==1 ){
            req.getRequestDispatcher("Component/VerifyAccount/VerifyAccount.jsp").forward(req,res);
            req.getSession().removeAttribute("verifyAccount_" + body.trim());

        }else{
            req.getRequestDispatcher("Component/VerifyAccount/VerifyAccountError.jsp").forward(req,res);
            req.getSession().removeAttribute("verifyAccount_" + body.trim());

        }

    }
}
