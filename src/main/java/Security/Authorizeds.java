package Security;

import Model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Authorizeds{
    public final static  int USER_INSERT = 1;
    public final static int USER_UPDATE = 2;
    public final static int USER_DEL = 3;
    public final static int USER_VIEW = 5;
    public final static  int ORDER_INSERT = 11;
    public final static int ORDER_UPDATE = 12;
    public final static int ORDER_DEL = 13;
    public final static int ORDER_VIEW = 15;
    public final static  int PRODUCT_INSERT = 16;
    public final static int PRODUCT_UPDATE = 17;
    public final static int PRODUCT_DEL = 18;
    public final static int PRODUCT_VIEW = 20;
    public final static  int LOG_INSERT = 26;
    public final static int LOG_UPDATE = 27;
    public final static int LOG_DEL = 28;
    public final static int LOG_VIEW = 30;
    public final static int ADMIN_PAGE = 31;
    public final static int ROLE_VIEW = 32;
    public final static int ROLE_UPDATE = 33;
    public final static int ROLE_DELETE = 34;
    public final static int ROLE_INSERT = 35;

    public static boolean authorizeds(HttpServletRequest req, int permission){
        User user = (User) req.getSession().getAttribute("user");
        if(user != null){
            for(int tmp:user.getRole().getArrPermission()){
               if(tmp == permission) return true;
            }

        }
        return false;
    }
}