package Security;

import Model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReLoginFillter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        User user = (User) req.getSession().getAttribute("user");
        if(user != null){
            for (String tmp:ReLogin.arrReLogin) {
                if(tmp.equals(user.getUserName())){
                    ReLogin.arrReLogin.remove(tmp);
                    res.setStatus(401);
                    req.getSession().removeAttribute("user");
                    res.sendRedirect("/login");
                    return;
                }
            }
        }
        chain.doFilter(request, response);

    }
    @Override
    public void destroy() {

    }
}