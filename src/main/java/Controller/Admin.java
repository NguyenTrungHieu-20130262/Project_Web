package Controller;

import DAO.*;
import DTO.RoleDTO;
import Model.Product;
import Model.*;
import Security.Authorizeds;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class Admin extends HttpServlet {
    protected void indexPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        setShowProfile(req);
        int countUser = UserDAO.getCountUser();
        int countProduct = ProductDAO.getCountProduct();
        int countPOut = ProductDAO.getCountPOut();
        int countOrder = OderDAO.getCountOrder();
        int countOrderOut = OderDAO.getCountOrderOut();
        float getPriceRevenue = ProductDAO.getPriceRevenue();

        req.setAttribute("countUser", countUser);
        req.setAttribute("countProduct", countProduct);
        req.setAttribute("countPOut", countPOut);
        req.setAttribute("countOrder", countOrder);
        req.setAttribute("countOrderOut", countOrderOut);
        req.setAttribute("getPriceRevenue", getPriceRevenue);
        ArrayList<Product> products = ProductDAO.getProduct();
        req.setAttribute("products", products);
        ArrayList<Oder> oders = OderDAO.getOrder();
        req.setAttribute("oders", oders);
        req.getRequestDispatcher("/Page/Admin/doc/quan-ly-bao-cao.jsp").forward(req, res);
        res.setStatus(200);
    }

    protected void postPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        ArrayList<Company> list = null;
        try {
            list = CompanyDAO.getAllCompany();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.getSession().setAttribute("listCompany", list);
        req.getRequestDispatcher("/Page/Admin/doc/index.jsp").forward(req, res);
        res.setStatus(200);
    }

    protected void userPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        setShowProfile(req);
        try {
            List<User> listUser = UserDAO.getAllUser();
            List<RoleDTO> listRole = RoleDAO.getAllRole();
            req.setAttribute("listUser", listUser);
            req.setAttribute("listRole", listRole);
            req.getRequestDispatcher("/Page/Admin/doc/table-data-table.jsp").forward(req, res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void productPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        ArrayList<Product> products = ProductDAO.getProduct();
        req.setAttribute("products", products);
        ArrayList<Company> list = null;
        try {
            list = CompanyDAO.getAllCompany();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(list);
        req.getSession().setAttribute("listCompany", list);
        req.getRequestDispatcher("/Page/Admin/doc/table-data-product.jsp").forward(req, res);
    }

    protected void productStatics(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/Page/Admin/doc/product_statistics.jsp").forward(req, res);}
    protected void logPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        List<Log> list = LogDAO.getAllLog();
        Map<String, List<Log>> map = new HashMap<>();

        map.put("logs", list);
        for (Log tmp : list) {
            addLogIntoMap(map, tmp);

        }
        req.setAttribute("map", map);
        req.getRequestDispatcher("/Page/Admin/doc/thong-ke-log.jsp").forward(req, resp);
    }

    public void addLogIntoMap(Map<String, List<Log>> map, Log tmp) {
        if (tmp.getLevel() == 0) {
            if (!map.containsKey("Info")) {
                List<Log> array = new ArrayList<>();
                array.add(tmp);
                map.put("Info", array);

            } else {
                map.get("Info").add(tmp);
            }

        } else {
            if (tmp.getStatus() == 1) {
                if (!map.containsKey("Alert")) {
                    List<Log> array = new ArrayList<>();
                    array.add(tmp);
                    map.put("Alert", array);

                } else {
                    map.get("Alert").add(tmp);
                }
            } else {
                if (tmp.getStatus() == 2) {
                    if (!map.containsKey("Warning")) {
                        List<Log> array = new ArrayList<>();
                        array.add(tmp);
                        map.put("Warning", array);

                    } else {
                        map.get("Warning").add(tmp);
                    }
                } else {
                    if (tmp.getStatus() == 3) {
                        if (!map.containsKey("Danger")) {
                            List<Log> array = new ArrayList<>();
                            array.add(tmp);
                            map.put("Danger", array);

                        } else {
                            map.get("Danger").add(tmp);
                        }
                    }
                }
            }
        }
    }

    protected void oderPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        ArrayList<Oder> oders = null;
        try {
            oders = OderDAO.getOrder();
            req.setAttribute("oders", oders);
            req.getRequestDispatcher("/Page/Admin/doc/table-data-oder.jsp").forward(req, res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    protected void oderStatis(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
            req.getRequestDispatcher("/Page/Admin/doc/order_statistics.jsp").forward(req, res);
    }
    protected void rolePage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/Page/Admin/doc/role.jsp").forward(req, res);
    }
    protected void setShowProfile(HttpServletRequest req) {
        String username = "";
        String img = "";
        Cookie[] cookies = req.getCookies();
        for (Cookie tmp : cookies) {
            if (tmp.getName().equals("user")) {
                username = tmp.getValue();
            } else {
                if (tmp.getName().equals("imgUser")) {
                    img = tmp.getValue();
                }
            }
        }
        req.getSession().setAttribute("username", username);
        req.getSession().setAttribute("img", img);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");
        res.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("userInfo", user);
        String id = req.getParameter("id");
        if (action != null && action.equalsIgnoreCase("editproduct")) {
            Product product = ProductDAO.getProductById(Integer.valueOf(id));
            req.setAttribute("product", product);
            ArrayList<Company> list = null;
            try {
                list = CompanyDAO.getAllCompany();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.getSession().setAttribute("listCompany", list);
            req.getRequestDispatcher("/Page/Admin/doc/form-edit-product.jsp").forward(req, res);

        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html;charset=UTF-8");
        res.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("userInfo", user);
        String hostname = req.getServerName();
        int port = req.getServerPort();
        String url = "http://" + hostname + ":" + port;
        System.out.println(url);
        req.setAttribute("url", url);
        String page = req.getParameter("page");
        try {
            User u = UserDAO.getUserByName(user.getUserName());
            req.setAttribute("avatar", u.getAvatar());
            switch (page.toLowerCase().trim()) {
                case "post":
                    postPage(req, res);
                    break;
                case "usermanagement":
                    if(Authorizeds.authorizeds(req, Authorizeds.USER_VIEW))
                        userPage(req, res);
                    else res.setStatus(401);

                    break;
                case "userstatistic":
                    if(Authorizeds.authorizeds(req, Authorizeds.USER_VIEW))
                        getAllUser(req, res);
                    else res.setStatus(401);

                    break;
                case "role":
                    if(Authorizeds.authorizeds(req, Authorizeds.ROLE_VIEW))
                        rolePage(req, res);
                    else res.setStatus(401);

                    break;
                case "productmanagement":
                    if(Authorizeds.authorizeds(req, Authorizeds.PRODUCT_VIEW))
                        productPage(req, res);
                    else res.setStatus(401);
                    break;
                case "productstaticstics":
                    productStatics(req, res);
                    break;
                case "odermanagement":
                    if(Authorizeds.authorizeds(req, Authorizeds.ORDER_VIEW))
                    oderPage(req, res);
                    else res.setStatus(401);

                    break;
                case "orderstatistics":
                    if(Authorizeds.authorizeds(req, Authorizeds.ORDER_VIEW))
                        oderStatis(req, res);
                    else res.setStatus(401);

                    break;
                case "logmanagement":
                    logPage(req, res);
                    break;


                default:
                    indexPage(req, res);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void getAllUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<User> list = UserDAO.getAllUser();
        Map<String, List<User>> map = new HashMap<>();
        map.put("sizeAllUser", list);
        for (User tmp : list) {
            if (tmp.getStatus() == 0) {
                if (!map.containsKey("blockAccount")) {
                    List<User> array = new ArrayList<>();
                    array.add(tmp);
                    map.put("blockAccount", array);

                } else {
                    map.get("blockAccount").add(tmp);
                }
                addMap(map, tmp);

            } else {
                if (tmp.getStatus() == 1) {
                    if (!map.containsKey("activeAccount")) {
                        List<User> array = new ArrayList<>();
                        array.add(tmp);
                        map.put("activeAccount", array);

                    } else {
                        map.get("activeAccount").add(tmp);
                    }
                    addMap(map, tmp);
                }
            }

        }
        req.setAttribute("map", map);
        req.getRequestDispatcher("/Page/Admin/doc/thong-ke-tai-khoan.jsp").forward(req, resp);
    }

    public void addMap(Map<String, List<User>> map, User tmp) {
        System.out.println(142);
        System.out.println(tmp.getRole().getId());
        if (tmp.getRole().getId() == 0) {
            if (!map.containsKey("customersAccount")) {
                List<User> list = new ArrayList<>();
                list.add(tmp);
                map.put("customersAccount", list);

            } else {
                map.get("customersAccount").add(tmp);
            }

        } else {
            if (tmp.getRole().getId() == 5) {
                if (!map.containsKey("employeesAccount")) {
                    List<User> list = new ArrayList<>();
                    list.add(tmp);
                    map.put("employeesAccount", list);

                } else {
                    map.get("employeesAccount").add(tmp);
                }

            } else {
                if (tmp.getRole().getId() == 4) {
                    if (!map.containsKey("managesAccount")) {
                        List<User> list = new ArrayList<>();
                        list.add(tmp);
                        map.put("managesAccount", list);

                    } else {
                        map.get("managesAccount").add(tmp);
                    }

                } else {
                    if (tmp.getRole().getId() == 3) {
                        if (!map.containsKey("adminsAccount")) {
                            List<User> list = new ArrayList<>();
                            list.add(tmp);
                            map.put("adminsAccount", list);

                        } else {
                            map.get("adminsAccount").add(tmp);
                        }
                    }
                }
            }
        }
    }
}

