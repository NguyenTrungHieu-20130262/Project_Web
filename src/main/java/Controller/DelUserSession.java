package Controller;


import Connect.ConnectDB;
import Model.Log;
import Model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/session/del")
public class DelUserSession extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().invalidate();
        User user=(User)request.getSession().getAttribute("user");
        if(user!=null){
            Log log = new Log(Log.ALERT, user.getId(), this.getClass().getName(), "Đăng xuất", 1);
            try {
                log.insert(ConnectDB.getConnect());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        response.sendRedirect("/");
    }
}
