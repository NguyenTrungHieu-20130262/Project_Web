package Controller;


import Connect.ConnectDB;
import DAO.CartDAO;
import DAO.ProductDAO;
import DAO.UserDAO;
import Model.Cart;
import Model.Log;
import Model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;


@WebServlet(name = "CartControl", value = "/cart")
public class CartControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
        String param = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userName = user.getId();
        if (param != null) {
            if (param.equals("listcart")) {
                getList(request, response, userName);
                return;
            }
        }
        request.getRequestDispatcher("Page/Cart.jsp").forward(request, response);
    }

    private void getList(HttpServletRequest request, HttpServletResponse response, int user) throws IOException {
        ArrayList<Cart> carts = new ArrayList<>();

        try {
            CartDAO cs = new CartDAO();
            carts = cs.getAllCartByUser(user);
            for (int i = 0; i < carts.size(); i++) {
                Cart cart = carts.get(i);
                int quantityProduct = ProductDAO.getQuantityProduct(cart.getProduct().getId());
                System.out.println(quantityProduct + "-----");
                if (quantityProduct == 0) {
                    cart.setStatus(1);
                } else {
                    if (cart.getQuantity() > quantityProduct) {
                        cart.setStatus(2);
                    } else if (cart.getQuantity() == quantityProduct) {
                        cart.setStatus(4);
                    } else if (cart.getQuantity() <= 1) {
                        cart.setStatus(3);
                    } else {
                        cart.setStatus(0);
                    }
                }
                CartDAO.updateCartById(cart);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        response.getWriter().write(new Gson().toJson(carts));
    }

    protected void setQuantity(HttpServletRequest request, HttpServletResponse response, String action) throws ServletException, IOException, SQLException {
        int idCart = Integer.valueOf(request.getParameter("idCart"));
        Cart cart = CartDAO.getCartById(idCart);
        CartDAO.updateCartById(cart);
        try {
            if (action.equals("decrease")) {
                cart.setQuantity(cart.getQuantity() - 1);
                int quantityProduct = ProductDAO.getQuantityProduct(cart.getProduct().getId());
                if (quantityProduct == 0) {
                    cart.setStatus(1);
                } else {
                    if (cart.getQuantity() > quantityProduct) {
                        cart.setStatus(2);
                    } else if (cart.getQuantity() == quantityProduct) {
                        cart.setStatus(4);
                    } else if (cart.getQuantity() < 1) {
                        cart.setQuantity(cart.getQuantity() + 1);
                        cart.setStatus(3);
                    } else {
                        cart.setStatus(0);

                    }


                }


            } else {
                cart.setQuantity(cart.getQuantity() + 1);
                int quantityProduct = ProductDAO.getQuantityProduct(cart.getProduct().getId());
                if (quantityProduct == 0) {
                    cart.setStatus(1);
                } else {
                    if (cart.getQuantity() > quantityProduct) {

                        cart.setStatus(2);
                    } else if (cart.getQuantity() == quantityProduct) {
                        cart.setStatus(4);
                    } else if (cart.getQuantity() < 1) {
                        cart.setQuantity(cart.getQuantity() + 1);
                        cart.setStatus(3);
                    } else {
                        cart.setStatus(0);

                    }


                }

                CartDAO.updateCartById(cart);
            }

            cart = CartDAO.updateQuantityCartById(cart.getId(), cart.getQuantity());

            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(cart));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void removeCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int idCart = Integer.valueOf(request.getParameter("idCart"));
        try {
            int rs = CartDAO.removeCartById(idCart);
            System.out.println(rs);
            Gson gson = new Gson();

            response.getWriter().write(gson.toJson(rs));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        User user = (User) request.getSession().getAttribute("user");
        Log log = new Log(0, user.getId(), this.getClass().getName(), 1);
        String action = request.getParameter("action");
        if (action == null) {

        } else {
            if (action.equals("decrease") || action.equals("increase")) {
                try {
                    setQuantity(request, response, action);
                    log.setLevel(Log.ALERT);
                    log.setContent("Thay đổi số lượng sản phẩm(Cart)");
                    log.insert(ConnectDB.getConnect());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if (action.equals("addtocart")) {
                try {
                    addToCart(request, response);
                    log.setLevel(Log.ALERT);
                    log.setContent("Thêm sản phẩm vào giỏ hàng(Cart)");
                    log.insert(ConnectDB.getConnect());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if (action.equals("remove")) {
                try {
                    removeCart(request, response);
                    log.setLevel(Log.WARNING);
                    log.setContent("Xóa sản phẩm ra khỏi giỏ hàng(Cart)");
                    log.insert(ConnectDB.getConnect());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        }

    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");


        String id = request.getParameter("idpost");
        int userId = UserDAO.getUserIdByUsename(user.getUserName());
        System.out.println(id + "||" + userId);
        if (id != null && userId != -1) {
            Cart cart = CartDAO.getCart(userId, Integer.valueOf(id));

            if (cart != null) {
                cart.setQuantity(cart.getQuantity() + 1);
                int quantityProduct = ProductDAO.getQuantityProduct(Integer.valueOf(id));
                System.out.println(quantityProduct + "-----");
                if (quantityProduct == 0) {
                    cart.setStatus(1);
                } else {
                    if (cart.getQuantity() > quantityProduct) {

                        cart.setStatus(2);
                    } else if (cart.getQuantity() == quantityProduct) {
                        cart.setStatus(4);
                    } else if (cart.getQuantity() < 1) {
                        cart.setQuantity(cart.getQuantity() + 1);
                        cart.setStatus(3);
                    } else {
                        cart.setStatus(0);

                    }


                }

                CartDAO.updateCartById(cart);
                response.getWriter().write(new Gson().toJson(1));
                return;

            } else {

                int quantityProduct = ProductDAO.getQuantityProduct(Integer.valueOf(id));
                System.out.println(quantityProduct);

                if (quantityProduct > 0) {
                    CartDAO.addToCart(userId, Integer.valueOf(id));

                    response.getWriter().write(new Gson().toJson(1));
                    return;
                } else {
                    response.getWriter().write(new Gson().toJson(0));

                }


            }
        } else {
            response.getWriter().write(new Gson().toJson(0));
            return;
        }
    }
}
