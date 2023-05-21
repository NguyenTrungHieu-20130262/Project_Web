package DAO;

import Connect.ConnectDB;
import DTO.Orders;
import Model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

public class OderDAO {
    static Statement statement = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    public static long addOrder(Oder oder) throws SQLException {
        Connection c = ConnectDB.getConnect();

        PreparedStatement stmt = c.prepareStatement("INSERT INTO `order` (id,idUser ,address_order, note, total_price, idTransport, status) VALUES ( ?,?, ?,?,?,?,?)");
        stmt.setLong(1, oder.getId());
        stmt.setInt(2, oder.getIdUser());
        stmt.setString(3, oder.getAddress());
        stmt.setString(4, oder.getNote());
        stmt.setDouble(5, oder.getTotal_price());
        stmt.setString(6, oder.getIdTransport());
        stmt.setInt(7, oder.getStatus());

        System.out.println(oder.toString());
        int resultSet = stmt.executeUpdate();
        System.out.println(resultSet);

        if(resultSet == 1){
            return 1;
        }

        return -1;
    }

    public static int addOrderDetail(OrderDetail orderDetail) throws SQLException {
        ArrayList<Cart> carts = new ArrayList<>();
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("INSERT INTO `orderdetail` (idOrder , idProduct,quantity, price) VALUES ( ?, ?,?,?)");
        stmt.setLong(1, orderDetail.getIdOrder());
        stmt.setInt(2, orderDetail.getIdProduct());
        stmt.setInt(3, orderDetail.getQuantity());
        stmt.setDouble(4, orderDetail.getPrice());
        int resultSet = stmt.executeUpdate();

        return resultSet;
    }
    public static ArrayList getOrderDTO() throws SQLException {
        ArrayList<Oder> oders = new ArrayList<>();
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from `order`");
        ResultSet rs= stmt.executeQuery();
        while (rs.next()){
            Orders oder = new Orders(rs.getLong(1),rs.getInt(2),rs.getString(3),rs.getString(4),  rs.getDate(5), rs.getString(6),rs.getInt(7),rs.getDouble(8), rs.getDate(9));
            User user = UserDAO.getUserById(rs.getInt(2));
            oder.setUser(user);
            oder.setOrderDetail(getAllOrderDetails(rs.getLong(1)));
            Payment payment =  PaymentDAO.getPaymentByIdOrder(rs.getLong(1));
            oder.setPayment(payment);
            oders.add(oder);
        }

        return oders;
    }
    public static ArrayList<Oder> getOrder() throws SQLException {
        ArrayList<Oder> oders = new ArrayList<>();
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from `order`");
        ResultSet rs= stmt.executeQuery();
        while (rs.next()){
            Oder oder = new Oder(rs.getLong(1),rs.getInt(2),rs.getString(3),rs.getString(4),  rs.getDate(5), rs.getString(6),rs.getInt(7),rs.getDouble(8), rs.getDate(9));
            User user = UserDAO.getUserById(rs.getInt(2));
            oder.setUser(user);
            oder.setOrderDetail(getAllOrderDetails(rs.getLong(1)));
            oders.add(oder);
        }

        return oders;
    }
    public static Oder getOrderById(long idOder) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from `order` where id =?");
        stmt.setLong(1, idOder);
        ResultSet rs= stmt.executeQuery();
        while (rs.next()){
            Oder oder = new Oder(rs.getLong(1),rs.getInt(2),rs.getString(3),rs.getString(4),  rs.getDate(5), rs.getString(6),rs.getInt(7),rs.getDouble(8), rs.getDate(9));
            User user = UserDAO.getUserById(rs.getInt(2));
            oder.setUser(user);
            oder.setOrderDetail(getAllOrderDetails(rs.getLong(1)));
            return  oder;
        }

        return null;
    }

    public static int deleteOderById(long id) throws SQLException {
        PaymentDAO.deletePaymentByIdOrder(id);
        deleteOderDetailsById(id);
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("DELETE from `order` where id=?");
        stmt.setLong(1,id);
        int rs= stmt.executeUpdate();
        return rs;
    }
    public static ArrayList<OrderDetail> getAllOrderDetails(long id) throws SQLException {
        ArrayList<OrderDetail> result = new ArrayList<>();
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("SELECT * from `orderdetail` where idOrder=?");
        stmt.setLong(1,id);
        ResultSet rs= stmt.executeQuery();
        while (rs.next()){
            OrderDetail od = new OrderDetail(rs.getLong(1), rs.getInt(2), rs.getInt(3),rs.getDouble(4));
            Product product = ProductDAO.getProductById(rs.getInt(2));
            od.setProduct(product);
            result.add(od);
        }
        return result;
    }
        public static int deleteOderDetailsById(long id) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("DELETE from `orderdetail` where idOrder=?");
        stmt.setLong(1,id);
        int rs= stmt.executeUpdate();

        return rs;
    }
    public static int deleteOderDetailsById(long id, int idProduct) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("DELETE from `orderdetail` where idOrder=? AND idProduct = ?");
        stmt.setLong(1,id);
        stmt.setInt(2,idProduct);

        int rs= stmt.executeUpdate();

        return rs;
    }
    public static int updateById(Oder order) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE `order` set idUser = ?, address_order = ?, idTransport  = ?, note = ?, status =?, total_price = ?, leadTime =? where id=?");
        stmt.setInt(1,order.getIdUser());
        stmt.setString(2,order.getAddress());
        stmt.setString(3,order.getIdTransport());
        stmt.setString(4,order.getNote());
        stmt.setInt(5,order.getStatus());
        stmt.setDouble(6,order.getTotal_price());
        stmt.setDate(7,order.getLeadTime());
        stmt.setLong(8,order.getId());
        int rs= stmt.executeUpdate();
        return rs;
    }
    public static int updateOrderDetailById(OrderDetail order) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("UPDATE `orderdetail` set quantity  = ? where  idOrder = ? AND idProduct = ?");
        stmt.setInt(1,order.getQuantity());
        stmt.setLong(2,order.getIdOrder());
        stmt.setInt(3,order.getIdProduct());

        int rs= stmt.executeUpdate();
        return rs;
    }
    public static int getCountOrder() throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select count(*) from `order`");
        ResultSet rs=stmt.executeQuery();
        rs.next();
        int countRow=rs.getInt(1);
        System.out.println(countRow);
        return countRow;
    }
    public static int getCountOrderOut() throws SQLException {
        Connection c = ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select count(*) from  `order` where status=2");
        ResultSet rs=stmt.executeQuery();
        rs.next();
        int countRow=rs.getInt(1);
        System.out.println(countRow);
        return countRow;
    }
    public static ArrayList<Oder> getOrderByUser(int user) throws SQLException {
        ArrayList<Oder> oders = new ArrayList<>();
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from `order` where userId=?");
        stmt.setInt(1,user);
        ResultSet rs= stmt.executeQuery();

        while (rs.next()){
            oders.add(new Oder(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getString(4),  rs.getDate(5), rs.getString(6),rs.getInt(7),rs.getDouble(8), rs.getDate(9)));
        }

        return oders;
    }

    public static void main(String[] args) throws SQLException {
        ArrayList<String> arr = new ArrayList<>();
        arr.add("USER");
        arr.add("CART");
        arr.add("ORDER");
        arr.add("PRODUCT");
        arr.add("COMMENT");
        arr.add("LOG");

        for(int i = 1 ; i < 26; i++){
            Connection c = ConnectDB.getConnect();
            PreparedStatement stmt = c.prepareStatement("INSERT INTO `role_permission` VALUES ( ?,?)");
            stmt.setInt(1, 4);
            stmt.setInt(2, i);
            int resultSet = stmt.executeUpdate();
            System.out.println(resultSet);
        }
    }
}
