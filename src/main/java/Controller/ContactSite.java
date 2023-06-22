package Controller;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "contact", value = "/contact")
public class ContactSite extends HttpServlet {

    @Override

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       req.getRequestDispatcher("Page/Contact.jsp").forward(req,res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }

    }
