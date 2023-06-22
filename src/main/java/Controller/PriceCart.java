package Controller;


import Model.VerifyRecaptcha;
import Security.Authorizeds;
import Security.ReLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "pricecar", value = "/pricecar")
public class PriceCart extends HttpServlet {

    @Override

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if(Authorizeds.authorizeds(req,Authorizeds.LOG_INSERT) == false){
            res.setStatus(403);
            return;
        }
        ReLogin.arrReLogin.add("ngochuyk8");
        String gRecaptchaResponse = req
                .getParameter("g-recaptcha-response");
        VerifyRecaptcha.verify(gRecaptchaResponse);
       req.getRequestDispatcher("Component/Captcha/Captcha.jsp").forward(req,res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String gRecaptchaResponse = req
                .getParameter("g-recaptcha-response");
        VerifyRecaptcha.verify(gRecaptchaResponse);

    }

    }
