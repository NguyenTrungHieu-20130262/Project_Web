package Controller;
import Model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

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
            if (user.getRole().getId() == 3) {
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
