package DAO;

import Connect.ConnectDB;
import Model.Cart;
import Model.Product;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.*;
import java.util.ArrayList;

public class CartDAO {

    public static  ArrayList<Cart> getAllCartByUser(int idUser) throws SQLException {
        ArrayList<Cart> carts = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT idUser, idProduct, quantity, createAt, status, id FROM cart where cart.idUser = ? ");
        stmt.setInt(1,idUser);
        ResultSet resultSet = stmt.executeQuery();
        ProductDAO ps = new ProductDAO();
        while (resultSet.next()) {
            Cart cart = new Cart();
            cart.setIdUser(resultSet.getInt(1));
            Product post = ps.getProductById(resultSet.getInt(2));
            cart.setId( resultSet.getInt(6));
            cart.setProduct(post);
            cart.setQuantity( resultSet.getInt(3));
            cart.setCreateAt( resultSet.getDate(4));
            cart.setStatus(resultSet.getInt(5));
            carts.add(cart);
        }
        return carts;
    }
    public static  Cart getCartById(int idCart) throws SQLException {
        ArrayList<Cart> carts = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT idUser, idProduct, quantity, createAt, status, id FROM cart where cart.id = ? ");
        stmt.setInt(1,idCart);
        ResultSet resultSet = stmt.executeQuery();
        ProductDAO ps = new ProductDAO();
        while (resultSet.next()) {
            Cart cart = new Cart();
            cart.setIdUser(resultSet.getInt(1));
            Product post = ps.getProductById(resultSet.getInt(2));
            cart.setProduct(post);
            cart.setQuantity( resultSet.getInt(3));
            cart.setCreateAt( resultSet.getDate(4));
            cart.setStatus( resultSet.getInt(5));
            cart.setId( resultSet.getInt(6));

            return cart;

        }
        return null;
    }
    private boolean checkQuantity(int idCart) throws SQLException {
        boolean rs = true;
        Cart cart = CartDAO.getCartById(idCart);
        int idProduct = cart.getProduct().getId();

        return rs;
    }

    public static Cart getCart(int idUser, int idPost) throws SQLException {

        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT * FROM cart where cart.idUser = ? and cart.idProduct = ? ");
        stmt.setInt(1,idUser);
        stmt.setInt(2,idPost);
        ResultSet resultSet = stmt.executeQuery();
        ProductDAO ps = new ProductDAO();
        Cart cart = null;
        while (resultSet.next()) {
            cart = new Cart();
            cart.setId(resultSet.getInt(1));
            cart.setIdUser(resultSet.getInt(2));
            Product product = ps.getProductById(resultSet.getInt(3));
            cart.setProduct(product);
            cart.setQuantity( resultSet.getInt(4));


        }
        return cart;
    }
    public static Cart updateCartById(Cart cart) throws SQLException {
        System.out.println(cart.toString());
        String sqlUpdate = "UPDATE cart "
                + "SET idUser = ? , idProduct = ?, quantity = ?, status = ? "
                + "WHERE id = ?";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, cart.getIdUser());
        pstmt.setInt(2, cart.getProduct().getId());
        pstmt.setInt(3, cart.getQuantity());
        pstmt.setInt(4, cart.getStatus());
        pstmt.setInt(5, cart.getId());
        int rowAffected = pstmt.executeUpdate();
        if(rowAffected == 1){
            return getCartById(cart.getId());

        }else{
            return null;
        }
    }
    public static Cart updateQuantityCartById(int id, int quantity) throws SQLException{
        String sqlUpdate = "UPDATE cart "
                + "SET quantity = ? "
                + "WHERE id = ?";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, quantity);
        pstmt.setInt(2, id);
        int rowAffected = pstmt.executeUpdate();
        return getCartById(id);
    }
    public static int removeCartById(int idCart) throws SQLException {
        String sqlUpdate = "DELETE FROM cart "
                + "WHERE id = ?";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, idCart);
        int rowAffected = pstmt.executeUpdate();
        return rowAffected;
    }
    public static int removeCartByUser(int idUser) throws SQLException {
        String sqlUpdate = "DELETE FROM cart "
                + "WHERE idUser = ?";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, idUser);
        int rowAffected = pstmt.executeUpdate();
        return rowAffected;
    }
    public static int removeCart( int idPost) throws SQLException {
        String sqlUpdate = "DELETE FROM cart "
                + "WHERE username = ?";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, idPost);
        int rowAffected = pstmt.executeUpdate();
        return rowAffected;
    }

    public static int addToCart(int idUser, int idProduct) throws SQLException {
        String sqlUpdate = "INSERT INTO cart (idUser, idProduct, quantity, status) values(?,?, 1, 0)";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, idUser);
        pstmt.setInt(2, idProduct);
        int rowAffected = pstmt.executeUpdate();
        return rowAffected;

    }
    public static void main(String[] args) throws UnsupportedEncodingException {
        System.out.println(URLDecoder.decode("Ng%E1%BB%8Dc%20Huy", "UTF-8"));
    }
}
