package DAO;

        import Connect.ConnectDB;
        import Model.Comment;
        import Model.Oder;
        import Model.Payment;
        import Model.User;

        import java.io.UnsupportedEncodingException;
        import java.sql.*;
        import java.util.ArrayList;
        import java.util.List;

public class PaymentDAO {
    public static int insertPayment(Payment payment) throws SQLException {
        String sqlUpdate = "INSERT INTO payment ( id_order,type_payment,amount,payment_date,status) values(?,?,?,?, ?)";
        Connection conn = ConnectDB.getConnect();
        PreparedStatement pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setLong(1, payment.getIdOrder());
        pstmt.setInt(2, payment.getType());
        pstmt.setDouble(3, payment.getAmount());
        pstmt.setDate(4, payment.getPaymentDate());
        pstmt.setInt(5, payment.getStatus());
        return pstmt.executeUpdate();
    }
    public static int deletePaymentByIdOrder(long id) throws SQLException {
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("DELETE from `payment` where id_order=?");
        stmt.setLong(1,id);
        int rs= stmt.executeUpdate();
        return rs;
    }
    public static Payment getPaymentByIdOrder(long id) throws SQLException {
        ArrayList<Oder> oders = new ArrayList<>();
        Connection c= ConnectDB.getConnect();
        PreparedStatement stmt = c.prepareStatement("select * from `payment` where id_order =? ");
        stmt.setLong(1,id);
        ResultSet rs= stmt.executeQuery();

        while (rs.next()){
            return new Payment(rs.getInt(1), rs.getLong(2),rs.getInt(3), rs.getFloat(4), rs.getDate(5), rs.getInt(6));
        }

        return null;
    }

}
