package Controller;
import Connect.ConnectDB;
import Model.Log;
import Model.User;
import Security.Authorizeds;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter("/admin")
public class FilterAdmin implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        User user = (User) req.getSession().getAttribute("user");
        if (user != null) {
            if (Authorizeds.authorizeds(req, Authorizeds.ADMIN_PAGE)) {
                chain.doFilter(request, response);
            } else {
                request.getRequestDispatcher("Page/404.jsp").forward(request, response);
            }
        } else{
            request.getRequestDispatcher("Page/404.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
