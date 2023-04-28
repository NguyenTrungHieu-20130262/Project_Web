package Controller;

import DAO.*;
import Model.*;
import Model.Oder;
import Model.Product;

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
        ArrayList<Oder> oders = OderDAO.getOrderOut();
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
            List<Role> listRole = RoleDAO.getAllRole();
            System.out.println(listRole.size());
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
        req.getSession().setAttribute("listCompany", list);
        req.getRequestDispatcher("/Page/Admin/doc/table-data-product.jsp").forward(req, res);
    }

    protected void oderPage(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("Oder");

        ArrayList<Oder> oders = null;
        try {
            oders = OderDAO.getOrder();
            req.setAttribute("oders", oders);
            req.getRequestDispatcher("/Page/Admin/doc/table-data-oder.jsp").forward(req, res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

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
        Cookie[] cookies = req.getCookies();
        String action = req.getParameter("action");
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
        String page = req.getParameter("page");
        try {
            User u = UserDAO.getUserByName(user.getUserName());
            req.setAttribute("avatar", u.getAvatar());
            switch (page.toLowerCase().trim()) {
                case "post":
                    postPage(req, res);
                    break;
                case "usermanagement":
                    userPage(req, res);
                    break;
                case "userstatistic":
                    getAllUser(req, res);
                    break;
                case "productmanagement":
                    productPage(req, res);
                    break;
                case "odermanagement":
                    oderPage(req, res);
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
                if (tmp.getStatus()  == 1) {
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
        System.out.println(map.get("sizeAllUser").size());
        req.setAttribute("map",map);
        req.getRequestDispatcher("/Page/Admin/doc/thong-ke-tai-khoan.jsp").forward(req,resp);
    }

    public void addMap(Map<String, List<User>> map, User tmp) {
        if (tmp.getRole() == 0) {
            if (!map.containsKey("customersAccount")) {
                List<User> list = new ArrayList<>();
                list.add(tmp);
                map.put("customersAccount", list);

            } else {
                map.get("customersAccount").add(tmp);
            }

        } else {
            if (tmp.getRole() == 1) {
                if (!map.containsKey("employeesAccount")) {
                    List<User> list = new ArrayList<>();
                    list.add(tmp);
                    map.put("employeesAccount", list);

                } else {
                    map.get("employeesAccount").add(tmp);
                }

            } else {
                if (tmp.getRole() == 2) {
                    if (!map.containsKey("managesAccount")) {
                        List<User> list = new ArrayList<>();
                        list.add(tmp);
                        map.put("managesAccount", list);

                    } else {
                        map.get("managesAccount").add(tmp);
                    }

                } else {
                    if (tmp.getRole() == 3) {
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

