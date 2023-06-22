package Controller;

import Utils.JWT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "verifyForgotAccount", value = "/verifyForgotAccount")
public class VerifyForgotAccount extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String token=JWT.getBodyJWT(req.getParameter("token"));
            String[] tokens = token.split("\\|");
            String ipAddress = tokens[0];
            int idUser = Integer.parseInt(tokens[1]);
            if(req.getRemoteAddr().equals(ipAddress)){
                req.setAttribute("idUser",idUser);
                req.getRequestDispatcher("Component/VerifyForgotAccount/VerifyAccount.jsp").forward(req, resp);
            } else {

            }
        }catch (Exception e){
            resp.sendRedirect("Component/VerifyForgotAccount/VerifyAccountError.jsp");
        }
    }
}
